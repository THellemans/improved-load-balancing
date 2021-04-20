%% Fig 8a : No Threshold
clear variables
load('../data/fig8ab.mat')

x=lambdas(1:end); y=EW_rel([1 4 5 7], 1:end); legend_entries={"SQ($5$)-RTB",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="southwest"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 0.4];
filename='../figures/fig8a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 8b : with thresholds
clear variables
load('../data/fig8ab.mat')

x=lambdas(1:end); y=EW_rel([2 3 6 7], 1:end); legend_entries={"SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)",  "RE($5,2$)",  "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 0.4];
filename='../figures/fig8b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);