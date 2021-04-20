addpath('../../general_functions')
%% Fig 5a
% type SQ(d)-RTB-RE(2) : type 3
clear variables

type=3;
d_iter=[2 5 10 15 20]; lambdas=linspace(0.3,0.995, 1000);
SCV=10; f=1/2;
threshold=2;
Bsize=30; tol=10^(-10);

EW=zeros(length(d_iter), length(lambdas));
EW_SQ=zeros(size(EW));

for i=1:length(d_iter)
    d=d_iter(i)
    if type == 2 || type == 6
        Delta=2; RepMax=2;
    else
        Delta=0.1; RepMax=40;
    end
    [EW(i, :)] = data_plot_EW(d,lambdas,SCV,f,type,Delta,RepMax,threshold,Bsize,tol);
    [EW_SQ(i,:)] = data_normal_SQ(d, lambdas,SCV,f,Bsize, length(lambdas), tol);
end

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig5a.mat', 'EW', 'EW_SQ', 'EW_rel', 'lambdas')