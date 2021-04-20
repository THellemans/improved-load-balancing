%% Fig 11b
% Fig 11b : types 1 3 4 5 7
clear variables

types=[1 3 4 5 7];
d=5; lambdas=linspace(0.3,0.995);
SCV=30; f=1/2;
threshold=2;
Bsize=30; tol=10^(-10);
Delta=0.01; RepMax=40;

EW=zeros(length(types), length(lambdas));

for i=1:length(types)
    type=types(i)
    [EW(i, :)] = data_plot_EW(d,lambdas,SCV,f,type,Delta,RepMax,threshold,Bsize,tol);
end

[EW_SQ] = data_normal_SQ(d, lambdas,SCV,f,Bsize, length(lambdas), tol);

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig11b.mat', 'EW', 'EW_SQ', 'EW_rel', 'lambdas')