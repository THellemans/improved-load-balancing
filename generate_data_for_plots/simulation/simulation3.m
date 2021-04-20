addpath('../../simulation_code')
addpath('../../general_functions')


%% lambda = 0.8, Bsize=40, d=10, type 3, Threshold=5, Hyperexponential jobs SCV = 15 Delta=0.1, f = 1/3 & k=5
clear variables
nruns=40;
N_iter=[10 50 100 500 1000 2000];

d=10; lambda=0.8;
SCV=15; f=1/3; EX=1;
type=3;
Delta=0.1;
RepMax=40;
Bsize=30; tol = 10^(-10);
threshold=2;
k_PH=5;
EW=zeros(1, length(N_iter)+1);

for i=1:length(N_iter)
    N=N_iter(i)
    runlen=10^7 /N;
    [~,~,EW(i)]=simulSQd_HErlang_mex(d,N,lambda,EX,SCV,f,k_PH,nruns,runlen,type,Delta,RepMax,3000,threshold);
end

[k_indxs, l_indxs, r, greater, greater_or_eq, ~] = sorted_kl_indxs(SCV, f, k_PH, type,Delta,RepMax,Bsize,threshold);
[lambdas] = init_lambda(r, Bsize);
[EW(end), ~, ~, ~, ~, ~] = simple_kl_PH(d,lambda,SCV,f,k_PH,Delta,Bsize,r,k_indxs, l_indxs, greater, greater_or_eq, tol, lambdas);

save(strcat("../../data/simulation3.mat"), "EW", "N_iter")