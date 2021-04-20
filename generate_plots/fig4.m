%% Fig 4a : f=1/2
clear variables
load('../data/fig4a.mat')

x=lambdas; y=TdLambda; legend_entries={"$d=2$",  "$d=5$",  "$d=10$",  "$d=15$",  "$d=20$"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$\mathcal{T}_{d}(\lambda)$'; xLim=[0.3,1]; yLim=[0, 15];
filename='../figures/fig4a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 4b : f=1/10
clear variables
load('../data/fig4b.mat')

x=lambdas; y=TdLambda; legend_entries={"$d=2$",  "$d=5$",  "$d=10$",  "$d=15$",  "$d=20$"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$\mathcal{T}_{d}(\lambda)$'; xLim=[0.3,1]; yLim=[0, 15];
filename='../figures/fig4b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);