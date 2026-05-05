%% Initialize
clc; close all; clearvars;

%% Input data
x = [5, 7, 10, 20];
hrnet = [58.24 62.65 66.77 72.92];
multi = [60.19 64.51 68.49 74.40];
contextrast = [60.25 64.56 68.54 74.41];
contextrastpp = [60.60 64.96 68.99 74.93];

%% Drawing parameters
% --- Sizes ---
imgWidthSize = 500;
imgColumnSize = 500;
lw = 3.0;
ms = 20;
numLgdCol = 1;
% --- Fonts ---
titleFontSize = 19;
XFontSize = 25;
YFontSize = 25;
lgdFontSize = 23;
ticksFontSize = 22;
% --- Colors ---
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [0.3718    0.7176    0.3612;
              0.9451    0.9255    0.7843;
              0.5216    0.6706    0.8118];

%% Plot
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(AX1, 'position', [0.05 0.58 0.42 0.42])

% plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color);
% hold on;
% plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :));
% plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :));
% plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :));
% set(gca, 'FontSize', ticksFontSize);
%
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

h1 = plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color, 'MarkerFaceColor', baseline_color, 'DisplayName', 'HRNet [27]');
hold on;
h2 = plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :), 'MarkerFaceColor', sota_colors(3, :), 'DisplayName', 'Multi [61]');
h3 = plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :), 'MarkerFaceColor', sota_colors(2, :),'DisplayName', 'Contextrast [62]');
h4 = plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :), 'MarkerFaceColor', sota_colors(1, :), 'DisplayName', 'Contextrast++ (Ours)');
set(gca, 'FontSize', ticksFontSize);

legend([h1, h2, h3, h4], 'NumColumns', numLgdCol, 'Location', 'southeast', ...
    'FontSize', lgdFontSize, 'Interpreter', 'latex');
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

set(gca, 'XScale', 'log');
grid on;
xlabel("Pixel threshold, $\tau_B$ (pixel)", 'FontSize', XFontSize, 'interpreter','latex');
ylabel("Boundary-mIoU (\%) $\uparrow$", 'FontSize', YFontSize, 'interpreter','latex');

%% Save
exportgraphics(gcf, "imgs/biou_line_graph.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/biou_line_graph.pdf", 'ContentType', 'vector');
