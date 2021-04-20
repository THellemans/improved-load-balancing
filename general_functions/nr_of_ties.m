function [TdLambda, EW] = nr_of_ties(lambda, d, qbound, SCV, f, tol)
%

[u, ER] = SQ_PH(lambda, d, qbound, SCV, f, tol);
EW=sum(u(2:end));

p=zeros(qbound,d);
for l=1:qbound
    for k=1:d
        p(l,k)=nchoosek(d,k)*(u(l)-u(l+1))^k * u(l+1)^(d-k);
    end
end
TdLambda=0;
for k=1:d
    for l=1:qbound
        TdLambda=TdLambda+k*p(l,k);
    end
end
TdLambda=TdLambda/u(1)^d;

end

