function [qls_dist,mresp,mwait]=simulSQd_HEXP(d,N,lam,EX,SCV,f,nruns,runlen,type,Delta,RepMax,Bsize,threshold)
% generate C code as follows:
% xtype=coder.typeof(ones(1,40));
% codegen -args {double(0),double(0),double(0),
% double(0),double(0),double(0),double(0),double(0),double(0),double(0)}
% simulSQd_HEXP

% type = 1 : SQ(d)-RTB
% type = 2 : SQ(d)-RE(T)
% type = 3 : SQ(d)-RTB
% type = 4 : LAS(d)
% type = 5 : LAS(d)-QTB
% type = 6 : JIQ(d)-RE(T)
% type = 7 : LEW(d)

% Delta = granularity used to report service time, e.g., 0.1
% RepMax = max on reported service time

[alpha, S, mu, p] = hyperexponential_init(EX, SCV, f);
%P_exceed_RepMax=p*exp(-RepMax*mu(1))+(1-p)*exp(-RepMax*mu(2))
[b, r] = define_b(Delta, RepMax);
[k_vals, l_vals, ~, ~, ~, xi] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold, 1, p, EX1, k_PH);
%[k_vals, l_vals, ~, ~, ~, xi] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold);
xi_vals=zeros(r+1, Bsize+1);
for i=1:length(k_vals)
    k=k_vals(i); l=l_vals(i);
    xi_vals(k,l)=xi(i);
end

qls_dist=zeros(nruns,Bsize+1);
for nrun=1:nruns
    start_serv_time=zeros(1,N);
    in_phase=zeros(2,N);
    n_phase=[0 0];
    qls=zeros(1,N);
    ctime=0;
    statqls=zeros(1,Bsize+1);
    nm=0;
    octime=0;
    
    while ctime < runlen
        erate=lam*N+n_phase*mu;
        ctime=ctime+exprnd(1/erate);
        
        tmp=rand(1);
        if (tmp < lam*N/erate) % arrival
            % select d queues
            qids=ceil(rand(1,d)*N);
            % classic d-choices with/without service time tiebreaking
            if (min(qls(qids))==0) % empty queue selected
                [~,indx]=min(qls(qids));
                sel_phase=1+(rand(1)> p);
                n_phase(sel_phase)=n_phase(sel_phase)+1;
                in_phase(sel_phase,n_phase(sel_phase))=qids(indx);
                start_serv_time(qids(indx))=ctime;
            else
                k_vals=max(1,min(ones(1,d)*(r+1),ceil((ctime-start_serv_time(qids))/Delta)));
                ell_vals=qls(qids);
                xi_k_ell=zeros(size(k_vals));

                for i=1:length(k_vals)
                    xi_k_ell(i)=xi_vals(k_vals(i), ell_vals(i));
                end
                [~, indx] = min(xi_k_ell);
            end
            qls(qids(indx))=qls(qids(indx))+1;
        else
            if (tmp < (lam*N+n_phase(1)*mu(1))/erate) % service completion in phase 1
                compl_phase=1;
            else % service completion in phase 2
                compl_phase=2;
            end
            pos=ceil(rand(1)*n_phase(compl_phase));
            qid=in_phase(compl_phase,pos);
            qls(qid)=qls(qid)-1;
            in_phase(compl_phase,pos)=in_phase(compl_phase,n_phase(compl_phase));
            n_phase(compl_phase)=n_phase(compl_phase)-1;
            if (qls(qid) > 0) % start new service
                sel_phase=1+(rand(1)> p);
                n_phase(sel_phase)=n_phase(sel_phase)+1;
                in_phase(sel_phase,n_phase(sel_phase))=qid;
                start_serv_time(qid)=ctime;
            end
        end    
        if (ctime > runlen/3 && ctime-octime > N*runlen/200000)
            statqls=statqls+histcounts(qls,'BinMethod','integers','BinLimits',[0 Bsize]);
            octime=ctime;
            nm=nm+1;
        end
    end
    qls_dist(nrun,:)=statqls/(nm*N);
end
qls_dist=cumsum(sum(qls_dist)/nruns,'reverse');
mresp=(sum(qls_dist)-1)/lam;
mwait=mresp-1;
end