%% Initialize
clc; close all; clearvars;

%% Input data (preservation)
x = [0.05, 0.15, 0.25];
% Below data are 00, 01, 02, 05, 07 in order
PR = [91.4858, 93.98, 95.295;
                83.752, 91.8, 92.294;
                73.285, 80.876, 87.7305;
                84.0801, 88.406, 90.3627;
                90.624, 91.6073, 92.5634];

%% Drawing parameters (preservation)
% Vis param
imgWidthSize = 500;
imgColumnSize = 400;
lw = 2.25;
ms = 13;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 17;
lgdFontSize = 15;
ticksFontSize = 13;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (preservation)
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(AX1, 'position', [0.05 0.58 0.42 0.42])
Y = PR;
plot(x, Y(1,:), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
hold on;
plot(x, Y(2,:), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
plot(x, Y(3,:), '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));
plot(x, Y(4,:), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(4, :));
plot(x, Y(5,:), '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(5, :));

set(gca, 'FontSize', ticksFontSize);

legend(["\texttt{00}", "\texttt{01}", "\texttt{02}", "\texttt{05}", "\texttt{07}"], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xticks([0.05, 0.15, 0.25]);
title("Preservation Rate [\%]", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel("ground threshold [m]", 'FontSize', XFontSize , "Interpreter", 'latex');

%% Save (preservation)
exportgraphics(gcf, "imgs/erasor_ground_preservation.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/erasor_ground_preservation.pdf", 'ContentType', 'vector');

%% Input data (rejection)
x = [0.05, 0.15, 0.25];
RR = [97.998, 97.081, 90.8674;
        96.075, 94.56, 88.526;
        99.7538, 99.196, 97.0076;
        98.6487, 98.248, 94.5425;
        99.271, 98.1875, 90.9375];

%% Drawing parameters (rejection)
% Vis param
imgWidthSize = 500;
imgColumnSize = 400;
lw = 2.25;
ms = 13;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 17;
lgdFontSize = 15;
ticksFontSize = 13;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (rejection)
fig = figure('Position', [200 + imgWidthSize, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
Y = RR;
plot(x, Y(1,:), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
hold on;
plot(x, Y(2,:), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
plot(x, Y(3,:), '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));
plot(x, Y(4,:), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(4, :));
plot(x, Y(5,:), '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(5, :));

set(gca, 'FontSize', ticksFontSize);

legend(["\texttt{00}", "\texttt{01}", "\texttt{02}", "\texttt{05}", "\texttt{07}"], 'NumColumns', numLgdCol, "Location", "southwest", 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xticks([0.05, 0.15, 0.25]);
title("Rejection Rate [\%]", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel("ground threshold [m]", 'FontSize', XFontSize , "Interpreter", 'latex');

%% Save (rejection)
exportgraphics(gcf, "imgs/erasor_ground_rejection.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/erasor_ground_rejection.pdf", 'ContentType', 'vector');

%% Input data (percentage)
x = [0.05, 0.15, 0.25];
percentage = [0.0235, 0.034, 0.0958;
              0.1669, 0.172, 0.38712;
              0.006047, 0.023, 0.0484;
              0.0594026, 0.068, 0.181245;
              0.0732, 0.161756, 0.649962];

%% Drawing parameters (percentage)
% Vis param
imgWidthSize = 500;
imgColumnSize = 400;
lw = 2.25;
ms = 13;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 17;
lgdFontSize = 15;
ticksFontSize = 13;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (percentage)
fig = figure('Position', [200 , 80 + imgColumnSize, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
Y = percentage;
plot(x, Y(1,:), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
hold on;
plot(x, Y(2,:), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
plot(x, Y(3,:), '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));
plot(x, Y(4,:), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(4, :));
plot(x, Y(5,:), '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(5, :));


set(gca, 'FontSize', ticksFontSize);

legend(["\texttt{00}", "\texttt{01}", "\texttt{02}", "\texttt{05}", "\texttt{07}"], 'NumColumns', numLgdCol, "Location", "northwest", 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xticks([0.05, 0.15, 0.25]);
title("$\hat{\delta}$ [\%]", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel("ground threshold [m]", 'FontSize', XFontSize , "Interpreter", 'latex');

%% Save (percentage)
exportgraphics(gcf, "imgs/erasor_ground_percentage.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/erasor_ground_percentage.pdf", 'ContentType', 'vector');

%% Input data (rel)
x = [0.05, 0.15, 0.25];
REL = [1.8830, 1.809, 1.57595;
      1.9668, 1.957, 1.7081;
      2.2696, 1.953, 1.70745;
      2.19285, 2.152, 1.8656;
      2.885, 2.56827, 2.01266];

%% Drawing parameters (rel)
% Vis param
imgWidthSize = 500;
imgColumnSize = 400;
lw = 2.25;
ms = 13;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 17;
lgdFontSize = 15;
ticksFontSize = 13;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (rel)
fig = figure('Position', [200 + imgWidthSize, 80 + imgColumnSize, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
Y = REL;
seq00 = plot(x, Y(1,:), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
hold on;
seq01 = plot(x, Y(2,:), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
seq02 = plot(x, Y(3,:), '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));
seq05 = plot(x, Y(4,:), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(4, :));
seq07 = plot(x, Y(5,:), '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(5, :));

set(gca, 'FontSize', ticksFontSize);

legend(["\texttt{00}", "\texttt{01}", "\texttt{02}", "\texttt{05}", "\texttt{07}"], 'NumColumns', numLgdCol, 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xticks([0.05, 0.15, 0.25]);
title("REL", 'FontSize', titleFontSize, 'interpreter','latex');
xlabel("ground threshold [m]", 'FontSize', XFontSize, "Interpreter", 'latex' );

%% Save (rel)
exportgraphics(gcf, "imgs/erasor_ground_rel.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/erasor_ground_rel.pdf", 'ContentType', 'vector');
