%% Fig 11a : No Threshold
clear variables
load('../data/fig11a.mat')

x=lambdas(1:end); y=EW_rel; legend_entries={"SQ($5$)-RTB", "SQ($5$)-RTB-RE($2$)",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 1];
filename='../figures/fig11a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 11b : with thresholds
clear variables
load('../data/fig11b.mat')

x=lambdas(1:end); y=EW_rel; legend_entries={"SQ($5$)-RTB", "SQ($5$)-RTB-RE($2$)",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 1];
filename='../figures/fig11b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);