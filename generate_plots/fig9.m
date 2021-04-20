%% Fig 9a : No Threshold
clear variables
load('../data/fig9ab.mat')

x=f_iter; y=EW_rel([1 4 5 7], 1:end); legend_entries={"SQ($5$)-RTB",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="south"; xLab='$f$'; yLab='$E_{W, rel, P}$'; xLim=[min(f_iter), max(f_iter)]; yLim=[0, 0.7];
filename='../figures/fig9a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 9b : with thresholds
clear variables
load('../data/fig9ab.mat')

x=f_iter; y=EW_rel([2 3 6 7], 1:end); legend_entries={"SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)",  "RE($5,2$)",  "LEW($5$)"};
legend_loc="south"; xLab='$f$'; yLab='$E_{W, rel, P}$'; xLim=[min(f_iter), max(f_iter)]; yLim=[0, 0.7];
filename='../figures/fig9b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);