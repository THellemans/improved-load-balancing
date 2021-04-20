addpath('../../simulation_code')
addpath('../../general_functions')


%% lambda = 0.9, Delta=0.5, Bsize=40, d=8, type 7, Hyperexponential jobs SCV = 15 & f = 1/3
clear variables
nruns=40;
N_iter=[10 50 100 500 1000 2000];

d=8; lambda=0.9;
SCV=15; f=1/3; EX=1;
type=7;
Delta=0.5;
RepMax=40;
Bsize=30; tol = 10^(-10);
threshold=0;
EW=zeros(1, length(N_iter)+1);

for i=1:length(N_iter)
    N=N_iter(i)
    runlen=10^7/N;
    [~,~,EW(i)]=simulSQd_HEXP_mex(d,N,lambda,EX,SCV,f,nruns,runlen,type,Delta,RepMax,2000,threshold);
end

[k_indxs, l_indxs, r, greater, greater_or_eq, ~] = sorted_kl_indxs(SCV, f,type,Delta,RepMax,Bsize,threshold);
[lambdas] = init_lambda(r, Bsize);
EW(end)=simple_kl_PH_mex(d,lambda,SCV,f,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);
save(strcat("../../data/simulation7.mat"), "EW", "N_iter")