clc;
close all;
clear all;
set(groot, 'defaultAxesTickLabelInterpreter','latex'); %set(groot, 'defaultLegendInterpreter','latex');

%% Bar plot
figure('Position', [500, 300, 600, 340]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% Presicion of GPF vs R-GPF

precision_seq00 = [26.23 87.63];
precision_seq01 = [32.11 88.93];
precision_seq02 = [28.53 75.30];
precision_seq05 = [31.01 78.96];
precision_seq07 = [40.92 84.42];
X = categorical({'00','01','02','05', '07'});
X = reordercats(X,{'00','01','02','05', '07'});

y_s = [precision_seq00;precision_seq01;precision_seq02;precision_seq05;precision_seq07];
b = bar(X, y_s); %, 'Width', 1.2);
lgd = legend({'GPF [22]','R-GPF (Ours)'},'Location','southeast','NumColumns',1, 'fontsize', 11, "Interpreter", 'latex');

rot_angle = 20;
yticks([0, 20, 40, 60, 80, 100]);
ylim([0 100])
title("Precision [\%]", "FontSize", 15, "Interpreter", 'latex');
xlabel("sequence", "Interpreter", 'latex');
margin = 1.0;
xtips1 = b(1).XEndPoints - 0.05;
ytips1 = b(1).YEndPoints + margin;
labels1 = string(b(1).YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [1,1,1])
common_fontsize = 13.5;
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom', "Rotation", rot_angle, "FontSize", common_fontsize, "Interpreter", 'latex')

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints + margin;
labels2 = string(b(2).YData);
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [1,1,1])
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom', "Rotation", rot_angle,  "FontSize", common_fontsize, "Interpreter", 'latex')

% grid on; grid minor;
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);

b(1).FaceColor = LineColors(1,:);
b(2).FaceColor = LineColors(2,:);

saveas(gcf, "imgs/ground_bar_plot_v2.png")
print -depsc 'imgs/ground_bar_plot_v2.eps'


