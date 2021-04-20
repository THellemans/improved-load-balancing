%% Fig 12a
clear variables
load('../data/fig12a.mat')

x=threshold_iter; y=EW_rel; legend_entries={"SQ($5$)-RE($T$)", "SQ($5$)-RTB-RE($T$)", "RE($T$)", "LEW($5$)"};
legend_loc="northeast"; xLab='$T$'; yLab='$E_{W, rel, P}$'; xLim=[0,10]; yLim=[-0.5, 0.8];
filename='../figures/fig12a.pdf'; logplot=false;

[~, ~, mu, ~] = hyperexponential_init(1, 10, 1/2);
EX1=1./mu(1);

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, ceil(length(EW_rel)/20), false, [0 2*EX1 4 6 8 10], {'0', '$2 E[X_1]$', '4', '6', '8', '10'});

%% Fig 12b_alt
clear variables
load('../data/fig12b.mat')

x=threshold_iter; y=EW_rel; legend_entries={"SQ($5$)-RE($T$)", "SQ($5$)-RTB-RE($T$)", "RE($T$)", "LEW($5$)"};
legend_loc="northeast"; xLab='$T$'; yLab='$E_{W, rel, P}$'; xLim=[0,10]; yLim=[-0.5, 0.8];
filename='../figures/fig12b.pdf'; logplot=false;

[~, ~, mu, ~] = hyperexponential_init(1, 10, 1/10);
EX1=1./mu(1);

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, ceil(length(EW_rel)/20), false, [2*EX1 4 6 8 10], {'$2 E[X_1]$', '4', '6', '8', '10'});