function [ g, Gbar ] = hyperexponential_dist( alpha, A, w_range )
%

p=alpha(1);
mu=-diag(A);
g=(p*(exppdf(w_range, 1/mu(1))) + (1-p) * (exppdf(w_range, 1/mu(2))));
Gbar=1-(p*(expcdf(w_range, 1/mu(1))) + (1-p) * (expcdf(w_range, 1/mu(2))));

end