%% Fig 9ab
clear variables

types=1:7;
d=5; lambda=0.6;
SCV=10; f_iter=linspace(0.01, 0.99);
threshold=2;
Bsize=30; tol=10^(-10);

EW=zeros(length(types), length(f_iter));

for i=1:length(types)
    type=types(i)
    if type == 2 || type == 6
        Delta=2; RepMax=2;
    else
        Delta=0.1; RepMax=40;
    end
    [EW(i, :)] = data_plot_EW(d,lambda,SCV,f_iter,type,Delta,RepMax,threshold,Bsize,tol);
end

[EW_SQ] = data_normal_SQ(d, lambda,SCV,f_iter,Bsize, length(f_iter), tol);

EW_rel=(EW_SQ-EW) ./ EW_SQ;

save('../../data/fig9ab.mat', 'EW', 'EW_SQ', 'EW_rel', 'f_iter')