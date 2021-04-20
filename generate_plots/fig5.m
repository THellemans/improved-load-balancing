%% Fig 5a : SQ(d)-RTB-RE(2)
clear variables
load('../data/fig5a.mat')

x=lambdas; y=EW_rel; legend_entries={"$d=2$",  "$d=5$",  "$d=10$",  "$d=15$",  "$d=20$"};
legend_loc="west"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[-0.01, 1];
filename='../figures/fig5a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 5b : RE(2)
clear variables
load('../data/fig5b.mat')

x=lambdas; y=EW_rel; legend_entries={"$d=2$",  "$d=5$",  "$d=10$",  "$d=15$",  "$d=20$"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 1];
filename='../figures/fig5b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);