%% Figure 1a
clear variables
types=1:7;
d=5; lambda=0.8;
SCV=10; f=1/2;
threshold=2;
Bsize=30; tol=10^(-14);
errors=zeros(length(types), 200);

for type = types
    type
    if type == 2 || type == 6
        Delta=5; RepMax=10;
    else
        Delta=0.1; RepMax=40;
    end
    [k_indxs, l_indxs, r, greater, greater_or_eq] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold);
    [lambdas] = init_lambda(r, Bsize);
    [~, ~, ~, ~, ~, errors(type,:)] = simple_kl_PH(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);
end

save(strcat("../../data/plot1a.mat"), "errors", "d", "lambda", "types")

%% Figure 1b
clear variables
type=1;
d_iter=2:8; lambda=0.8;
SCV=10; f=1/2;
threshold=2;
Bsize=30; tol=10^(-14);
Delta=0.1; RepMax=40;
errors=zeros(length(d_iter), 200);

for i=1:length(d_iter)
    d=d_iter(i)
    [k_indxs, l_indxs, r, greater, greater_or_eq] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold);
    [lambdas] = init_lambda(r, Bsize);
    [~, ~, ~, ~, ~, errors(i,:)] = simple_kl_PH(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);
end

save(strcat("../../data/plot1b.mat"), "errors", "type", "lambda", "d_iter")