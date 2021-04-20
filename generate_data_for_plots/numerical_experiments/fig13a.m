%% Fig 13a
clear variables

types=[2, 3, 6, 7];
d=5; lambdas=linspace(0.3,0.995);
SCV=10; f=1/2;
[alpha, S, mu, p] = hyperexponential_init(1, SCV, f);
EX1=1./mu(1);
threshold=2*EX1;
Bsize=30; tol=10^(-10);

EW=zeros(length(types), length(lambdas));

for i=1:length(types)
    type=types(i)
    if type == 2 || type == 6
        Delta=threshold; RepMax=threshold;
    else
        Delta=0.1; RepMax=20;
    end
    [EW(i, :)] = data_plot_EW(d,lambdas,SCV,f,type,Delta,RepMax,threshold,Bsize,tol);
end

[EW_SQ] = data_normal_SQ(d, lambdas,SCV,f,Bsize, length(lambdas), tol);

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig13a.mat', 'EW', 'EW_SQ', 'EW_rel', 'lambdas')