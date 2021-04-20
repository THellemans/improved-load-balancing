addpath('../../general_functions')
%% Fig 7ab
clear variables

types=[1, 2, 3, 4, 5, 6, 7];
d=5; lambda=0.7;
SCV_iter=linspace(1, 40); f=1/2;
threshold=2;
Bsize=30; tol=10^(-10);


EW=zeros(length(types), length(SCV_iter));

for i=1:length(types)
    type=types(i)
    if type == 2 || type == 6
        Delta=2; RepMax=2;
    else
        Delta=0.1; RepMax=40;
    end
    [EW(i, :)] = data_plot_EW(d,lambda,SCV_iter,f,type,Delta,RepMax,threshold,Bsize,tol);
end

[EW_SQ] = data_normal_SQ(d, lambda,SCV_iter,f,Bsize, length(SCV_iter), tol);

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig7ab.mat', 'EW', 'EW_SQ', 'EW_rel', 'SCV_iter')