addpath('../../general_functions')

%% Fig 10ab
types=1:8;
d=5;
lambda=0.8;
SCV=10; f=1/2;
Bsize=30;
tol=10^(-10); threshold=2;

FbarW_iter=cell(1,8);

for type = types
    type
    if type == 2 || type == 6 || type == 8
        Delta=2; RepMax=2;
    else
        Delta=0.1; RepMax=40;
    end
    [k_indxs, l_indxs, r, greater, greater_or_eq, xi] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold);
    [lambdas] = init_lambda(r, Bsize);
    [EW, FbarW_iter{type}, w_range, lambdas] =...
        find_FbarW(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);
end

save('../../data/fig10ab.mat', 'FbarW_iter', 'w_range')