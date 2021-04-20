function [EW, lambdas, probs, probs2, cumProbs, FWbars, w_range, error, run] = simple_kl_PH_FWbars(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas)
% lambda : arrival rate
% d : number of servers chosen
% RepMax : Maximal d_k
% Delta : granulity
% B : max queue length
% type = 1 : SQ(d)-RTB
% type = 2 : SQ(d)-RE(T)
% type = 3 : SQ(d)-RTB
% type = 4 : LAS(d)
% type = 5 : LAS(d)-QTB
% type = 6 : JIQ(d)-RE(T)
% type = 7 : LEW(d)


EX=1;
[alpha, S, mu, ~] = hyperexponential_init(EX, SCV, f);
m=length(alpha);
Bm=m*Bsize;
run=1;

error=zeros(1,200);
FWbars=cell(1,200);
old_probs=zeros(r+1,Bm);

while true
    F=zeros(Bm,Bm*(r+1));
    Lambda=zeros(Bm,Bm*(r+1));
    Psi=zeros(Bm,Bm*(r+1));
    tmp=diag(ones(1,Bsize-1),-1);
    tmp(1)=1;
    G=kron(eye(Bsize),mu)*kron(tmp,alpha);
    for k=0:r
        F(:,k*Bm+1:(k+1)*Bm)=kron(-diag(lambdas(k+1,:))+diag(lambdas(k+1,1:Bsize-1),1),eye(m))+kron(eye(Bsize),S);
        if (k < r)
            Lambda(:,k*Bm+1:(k+1)*Bm)=expm(F(:,k*Bm+1:(k+1)*Bm)*Delta);
        else
            Lambda(:,k*Bm+1:(k+1)*Bm)=0;
        end
        Psi(:,k*Bm+1:(k+1)*Bm)=(eye(Bm)-Lambda(:,k*Bm+1:(k+1)*Bm))*(-F(:,k*Bm+1:(k+1)*Bm))^(-1);
    end
    Omega=zeros(Bm,Bm*(r+1));
    Omega(:,r*Bm+1:(r+1)*Bm)=Psi(:,r*Bm+1:(r+1)*Bm)*G;
    for k=r-1:-1:0
        Omega(:,k*Bm+1:(k+1)*Bm)=Psi(:,k*Bm+1:(k+1)*Bm)*G+Lambda(:,k*Bm+1:(k+1)*Bm)*Omega(:,(k+1)*Bm+1:(k+2)*Bm);
    end
    pi=zeros(r+1,Bm);
    pi(1,:)=stat(Omega(:,1:Bm));
    for k=0:r-1
        pi(k+2,:)=pi(k+1,:)*Lambda(:,k*Bm+1:(k+1)*Bm);
    end
    probs=zeros(r+1,Bm); % probability of queue = i and service between k*Delta and (k+1)*Delta
    for k=0:r
        probs(k+1,:)=pi(k+1,:)*Psi(:,k*Bm+1:(k+1)*Bm);
    end
    probs=probs/sum(sum(probs))*lambda;
    probs=max(probs,0);
    error(run)=sum(sum(abs(old_probs-probs)));

    [FWbars{run}, w_range, ~] = find_FbarW_from_solution(lambda,d,SCV,f,Bsize,r,probs, k_indxs, l_indxs, greater, greater_or_eq);

    if error(run) < tol || run >= 200
        if run >= 200
            disp('stopped at an error of ' + string(error(run)));
        end
        break
    end
    old_probs=probs;
    probs2=probs*kron(eye(Bsize),ones(m,1)); % Phase eruit halen
    
    [lambdas] = find_lambdas(Bsize, r, lambda, d, probs2, k_indxs, l_indxs, greater, greater_or_eq);

    run=run+1;
end

cumProbs=zeros(size(probs2));
cumProbs(end, end)=probs2(k_indxs(end), l_indxs(end));
for i=length(k_indxs)-1:(-1):1
    cumProbs(k_indxs(i), l_indxs(i))=cumProbs(k_indxs(i+1), l_indxs(i+1)) + probs2(k_indxs(i), l_indxs(i));
end
%Jdist=zeros(size(cumProbs));
%for i=1:length(k_indxs)-1
%    Jdist(i)=cumProbs(k_indxs(i), l_indxs(i))^d-cumProbs(k_indxs(i+1), l_indxs(i+1))^d;
%end

EQL=0;
for k=1:r+1
    for l=1:Bsize
        EQL=EQL+l*probs2(k,l);
    end
end
EW=EQL/lambda-1;

end