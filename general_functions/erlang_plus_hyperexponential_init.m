function [alpha, A, mu] = erlang_plus_hyperexponential_init(q, k, SCV, f)
%

% Define the Erlang(k, alpha/k) part :
alpha=zeros(1,k+2);
alpha(1)=1;
A = zeros(k+2, k+2);
for i=1:k-1
    A(i,i)=-k/q;
    A(i,i+1)=k/q;
end
A(k,k) = -k/q;

% Define the Hexp part
EX=1;
mu_hexp=zeros(2,1);
mu_hexp(1)=(SCV+(4*f-1)+((SCV-1)*(SCV-1+8*f*(1-f)))^(1/2))/(2*EX*f*(SCV+1));
mu_hexp(2)=(SCV+(4*(1-f)-1)-((SCV-1)*(SCV-1+8*f*(1-f)))^(1/2))/(2*EX*(1-f)*(SCV+1));
p=EX*mu_hexp(1)*f;

A(k, k+1) = p*k/q; A(k, k+2) = (1-p)*k/q;
A(k+1, k+1) = -mu_hexp(1)/(1-q);
A(k+2, k+2) = -mu_hexp(2)/(1-q);
mu=-A*ones(length(A),1);

end