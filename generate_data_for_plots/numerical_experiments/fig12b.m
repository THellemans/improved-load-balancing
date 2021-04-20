addpath('../../general_functions')
%% Fig 12b
clear variables

types=[2, 3, 6, 7];
d=5; lambda=0.8;
SCV=10; f=1/10;
Delta=0.1; RepMax=40;
threshold_iter=linspace(0.01, 10);
Bsize=30; tol=10^(-10);

EW=zeros(length(types), length(threshold_iter));

for i=1:length(types)
    type=types(i)
    [EW(i, :)] = data_plot_EW(d,lambda,SCV,f,type,Delta,RepMax,threshold_iter,Bsize,tol);
end

[~, ER] = SQ_PH(lambda, d, Bsize, SCV, f, tol);
[EW_SQ] = ER-1;

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig12b.mat', 'EW', 'EW_SQ', 'EW_rel', 'threshold_iter')