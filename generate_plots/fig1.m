%% Figure 1a
load('../data/fig1a.mat')

x=1:200; y=errors; legend_entries={"SQ($5$)-RTB", "SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)",  "LAS($5$)",  "LAS($5$)-QTB",  "RE($5, 2$)",  "LEW($5$)"};
legend_loc="northeast"; xLab='$n$'; yLab='$\|\pi^{(n)}-\pi^{(n-1)}\|_1$'; xLim=[0,30]; yLim=[10^(-13), 1];
filename='../figures/fig1a.pdf'; logplot=true; dist_points=1;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, dist_points);

%% Figure 1b
load('../data/fig1b.mat')

x=1:200; y=errors; legend_entries={"$d=2$", "$d=3$",  "$d=4$",  "$d=5$",  "$d=6$",  "$d=7$",  "$d=8$"};
legend_loc="northeast"; xLab='$n$'; yLab='$\|\pi^{(n)}-\pi^{(n-1)}\|_1$'; xLim=[0,60]; yLim=[10^(-13), 1];
filename='../figures/fig1b.pdf'; logplot=true; dist_points=1;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, dist_points);