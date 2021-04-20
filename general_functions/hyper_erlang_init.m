function [alpha, A, mu, p] = hyper_erlang_init(EX, SCV, f, k)
%

tildeSCV = 2*(SCV+1)/(1/k+1) - 1;
[~, ~, mu, p] = hyperexponential_init(EX, tildeSCV, f);
alpha = zeros(1, 2*k);
alpha(1) = p; alpha(k+1) = 1-p;
A = zeros(2*k);
for i=1:k
    A(i, i) = - k * mu(1);
    if i < k
        A(i, i+1) = k * mu(1);
    end
end
for i=k+1:2*k
    A(i,i) = - k * mu(2);
    if i < 2*k
        A(i, i+1) = k * mu(2);
    end
end
mu=-A*ones(length(alpha),1);

end