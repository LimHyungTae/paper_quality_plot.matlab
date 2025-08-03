%% Initialize
clc
close all;
clear all;

%% BIoU for HRNet
% Vis param
imgWidthSize = 500;
imgColumnSize = 500;
lw = 3.0;
ms = 20;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 20;
YFontSize = 20;
lgdFontSize = 18;
ticksFontSIze = 18;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);

%% Visualization
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(AX1, 'position', [0.05 0.58 0.42 0.42])
x = [2.5, 5.0, 7.5, 10];
baseline1 = [72.92 66.77 62.65 58.24 ];
baseline2 = [74.40 68.49 64.51 60.19];
ours = [74.93 68.99 64.96 60.60];

baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [0.3718    0.7176    0.3612;
              0.9451    0.9255    0.7843;  
              0.5216    0.6706    0.8118]; 


% plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color);
% hold on;
% plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :));
% plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :));
% plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :));
% set(gca, 'FontSize', ticksFontSIze);
% 
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');


h2 = plot(x, baseline1, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :), 'MarkerFaceColor', sota_colors(3, :), 'DisplayName', 'Baseline 1');
hold on;
h3 = plot(x, baseline2, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :), 'MarkerFaceColor', sota_colors(2, :),'DisplayName', 'Baseline 2');
h4 = plot(x, ours, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :), 'MarkerFaceColor', sota_colors(1, :), 'DisplayName', 'Ours');
set(gca, 'FontSize', ticksFontSIze);

legend([h2, h3, h4], 'NumColumns', numLgdCol, 'Location', 'southwest', ...
    'FontSize', lgdFontSize, 'Interpreter', 'latex');
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

% set(gca, 'XScale', 'log');
grid on;
xlabel("Scene graph masking ratio [\%]", 'FontSize', XFontSize, 'interpreter','latex');
ylabel("Dummy performance (TBU)", 'FontSize', YFontSize, 'interpreter','latex');

print(gcf, "imgs/biou_line_graph.png",'-dpng','-r300');
print -depsc 'imgs/biou_line_graph.eps'

