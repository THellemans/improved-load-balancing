function [EW, FbarW, w_range, lambdas] = find_FbarW(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas)
%
% lambda : arrival rate
% d : number of servers chosen
% RepMax : Maximal d_k
% Delta : granulity
% Bsize : max queue length
% type = 1 : SQ(d)-RTB
% type = 2 : SQ(d)-RE(T)
% type = 3 : SQ(d)-RTB
% type = 4 : LAS(d)
% type = 5 : LAS(d)-QTB
% type = 6 : JIQ(d)-RE(T)
% type = 7 : LEW(d)
% type = 8 : SQ(d)

[EW, lambdas, probs, probs2, cumProbs] = simple_kl_PH(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);
[lambdas, ~, ~, v_temp, w_temp] = find_lambdas(Bsize, r, lambda, d, probs2, k_indxs, l_indxs, greater, greater_or_eq);
[alpha, S, ~, ~] = hyperexponential_init(1, SCV, f);
v=zeros(max(k_indxs), max(l_indxs)); w=zeros(size(v));
for i=1:length(k_indxs)
    k=k_indxs(i); l=l_indxs(i);
    v(k,l)=v_temp(i); w(k,l)=w_temp(i);
end

m=length(alpha);

probs_klj=zeros(r+1,Bsize,m);
for k=1:(r+1)
    for l=1:Bsize
        for j=1:m
            probs_klj(k,l,j)=probs(k, (l-1)*m+j);
        end
    end
end

Jdist=zeros(r+1, Bsize, m);
for i=1:length(k_indxs)-1
    for j=1:m
        k=k_indxs(i); l=l_indxs(i);
        for a=0:(d-1)
            Jdist(k,l,j) =Jdist(k,l,j)+d*probs_klj(k,l,j)/(a+1)*nchoosek(d-1,a)*w(k,l)^a*v(k,l)^(d-1-a);
            %Jdist(k,l,j)=Jdist(k,l,j)+d*probs_klj(k,l,j)/(a+1)*nchoosek(d-1,a)*probs2(k,l)^a*cumProbs(k2, l2)^(d-1-a);
        end
    end
end

Jdist_no_k=squeeze(sum(Jdist,1));


w_range=linspace(0,500,10^6);
dw=w_range(2)-w_range(1);
[ g, Gbar ] = hyperexponential_dist( alpha, S, w_range );
GbarXj=cell(1,2);
for j=1:m
    temp=zeros(1,m);
    temp(j)=1;
    [~, GbarXj{j}]=hyperexponential_dist(temp, S, w_range);
end

Gbar_convoluted_Xj=cell(Bsize, m);
for j=1:m
    Gbar_convoluted_Xj{1,j}=GbarXj{j};
    for l=2:Bsize
        Gbar_convoluted_Xj{l,j}=Gbar+convolution(Gbar_convoluted_Xj{l-1,j},g,dw);
        Gbar_convoluted_Xj{l,j}=min(Gbar_convoluted_Xj{l,j},1);
    end
end
FbarW=zeros(size(w_range));

for l=1:Bsize
    for j=1:m
        FbarW=FbarW+Jdist_no_k(l,j)*Gbar_convoluted_Xj{l,j};
    end
end

end