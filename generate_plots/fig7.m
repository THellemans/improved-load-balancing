%% Fig 7a: No Threshold
clear variables
load('../data/fig7ab.mat')

x=SCV_iter; y=EW_rel([1 4 5 7], :); legend_entries={"SQ($5$)-RTB",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)"};
legend_loc="southeast"; xLab='$SCV$'; yLab='$E_{W, rel, P}$'; xLim=[min(SCV_iter), max(SCV_iter)]; yLim=[0, 0.5];
filename='../figures/fig7a.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);

%% Fig 7b : with thresholds
clear variables
load('../data/fig7ab.mat')

x=SCV_iter; y=EW_rel([2 3 6 7], :); legend_entries={"SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)",  "RE($5,2$)",  "LEW($5$)"};
legend_loc="southeast"; xLab='$SCV$'; yLab='$E_{W, rel, P}$'; xLim=[min(SCV_iter), max(SCV_iter)]; yLim=[0, 0.5];
filename='../figures/fig7b.pdf'; logplot=false;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot);