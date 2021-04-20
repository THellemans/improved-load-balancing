%% Fig 14a : No Threshold
clear variables
load('../data/fig14ab.mat')

x=lambdas(1:end); y=EW_rel([1 4 5 7], 1:end); legend_entries={"SQ($5$)-RTB",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 1];
filename='../figures/fig14a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 14b : with thresholds
clear variables
load('../data/fig14ab.mat')

x=lambdas(1:end); y=EW_rel([2 3 6 7], 1:end); legend_entries={"SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)",  "RE($5,2$)",  "LEW($5$)"};
legend_loc="northeast"; xLab='$\lambda$'; yLab='$E_{W, rel, P}$'; xLim=[0.3,1]; yLim=[0, 1];
filename='../figures/fig14b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 14c : plot of the conditional remaining service time for different k
clear variables
load('../data/fig14c.mat')

x=w_range; y=E_cond_w; legend_entries={"$k=1$", "$k=3$", "$k=5$", "$k=10$", "$k=15$"};
legend_loc="best"; xLab='$w$'; yLab='$E[X | X > x] - x$'; xLim=[0, 30]; yLim=[0, 22];
filename='../figures/fig14c.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);