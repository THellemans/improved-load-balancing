%% Fig 10a
clear variables
load('../data/fig10ab.mat')
y=zeros(5,length(w_range));
types = [1 4 5 7 8];
for i=1:length(types)
    type=types(i);
    y(i,:)=FbarW_iter{type};
end

x=w_range; legend_entries={"SQ($5$)-RTB",  "LAS($5$)",  "LAS($5$)-QTB",  "LEW($5$)", "SQ($5$)"};
legend_loc="northeast"; xLab='$w$'; yLab='$\bar F_W(w)$'; xLim=[0,20]; yLim=[0.4*10^(-2),0.4];
filename='../figures/fig10a.pdf'; logplot=true;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, 5000);

%% Fig 10b
clear variables
load('../data/fig10ab.mat')
y=zeros(5,length(w_range));
types = [2 3 6 7 8];
for i=1:length(types)
    type=types(i);
    y(i,:)=FbarW_iter{type};
end

x=w_range; legend_entries={"SQ($5$)-RE($2$)",  "SQ($5$)-RTB-RE($2$)", "RE($5, 2$)",  "LEW($5$)", "SQ($5$)"};
legend_loc="northeast"; xLab='$w$'; yLab='$\bar F_W(w)$'; xLim=[0,20]; yLim=[0.4*10^(-2),0.4];
filename='../figures/fig10b.pdf'; logplot=true;

make_and_save_fig(x, y, legend_entries, legend_loc, xLab, yLab, xLim, yLim, filename, logplot, 5000);