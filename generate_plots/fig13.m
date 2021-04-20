%% Fig 13a : No Threshold
clear variables
load('../data/fig13a.mat')

x=lambdas; y=EW_rel; legend_entries={"SQ($5$)-RE($E[X_1]/f$)", "SQ($5$)-RTB-RE($E[X_1]/f$)", "RE($E[X_1]/f$)", "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3, 1]; yLim=[-0.01, 1];
filename='../figures/fig13a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 13b : No Threshold
clear variables
load('../data/fig13b.mat')

x=lambdas; y=EW_rel; legend_entries={"SQ($5$)-RE($E[X_1]/f$)", "SQ($5$)-RTB-RE($E[X_1]/f$)", "RE($E[X_1]/f$)", "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3, 1]; yLim=[-0.01, 0.4];
filename='../figures/fig13b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);