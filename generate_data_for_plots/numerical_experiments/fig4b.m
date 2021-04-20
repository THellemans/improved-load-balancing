%% Fig 4b
clear variables

d_iter=[2 5 10 15 20]; lambdas=linspace(0.3,0.999,200);
SCV=10; f=1/10;
threshold=2;
Bsize=30; tol=10^(-10);
TdLambda=zeros(length(d_iter), length(lambdas));

for i=1:length(d_iter)
    d=d_iter(i)
    for j=1:length(lambdas)
        lambda=lambdas(j);
        [TdLambda(i, j)] = nr_of_ties(lambda, d, Bsize, SCV, f, tol);
    end
end
save('../../data/fig4b.mat', 'TdLambda', 'lambdas')