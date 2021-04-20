%% Fig 2a & 2b
% Fig 2a : types 1 4 5 7
% Fig 2b : types 2 3 6 7
clear variables

types=1:7;
d=5; lambdas=linspace(0.3,0.995);
SCV=10; f=1/2;
threshold=2;
Bsize=30; tol=10^(-10);

EW=zeros(length(types), length(lambdas));

for type = types
    type
    if type == 2 || type == 6
        Delta=2; RepMax=2;
    else
        Delta=0.1; RepMax=40;
    end
    [EW(type, :)] = data_plot_EW(d,lambdas,SCV,f,type,Delta,RepMax,threshold,Bsize,tol);
end

[EW_SQ] = data_normal_SQ(d, lambdas,SCV,f,Bsize, length(lambdas), tol);

EW_rel=(EW_SQ-EW) ./ EW_SQ;

%save('../../data/fig2ab.mat', 'EW', 'EW_SQ', 'EW_rel', 'lambdas')