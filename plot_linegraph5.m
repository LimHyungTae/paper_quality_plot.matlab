%% Line graph
clc
close all;
clear all;

%% data
x = [10, 25, 50];

w8_conf10 = [0.0788, 0.0628, 0.0571, 0.0599];
w16_conf10 = [0.0749, 0.0644, 0.0557, 0.0601];
w32_conf10 = [0.0678 ,  0.0603 ,   0.0463 , 0.0533];

w8_conf25 = [0.0840, 0.0667, 0.0645, 0.0656];
w16_conf25 = [0.0752, 0.0611, 0.0628, 0.0620];
w32_conf25 = [0.0671, 0.0517, 0.0584, 0.0550];

w8_conf50 = [0.0704, 0.0419, 0.1050, 0.0734];
w16_conf50 = [0.0708, 0.0409, 0.1136, 0.0773];
% w32_conf50 = [0.0895, 0.0494 , 0.1259 , 0.0876];
w32_conf50 = [0.0674, 0.0365, 0.1138, 0.0752];

w8  = [w8_conf10; w8_conf25; w8_conf50];
w16 = [w16_conf10; w16_conf25; w16_conf50];
w32 = [w32_conf10; w32_conf25; w32_conf50];
          
%% Plot parameters

% Vis param
imgWidthSize = 420;
imgColumnSize = 400;
lw = 5;
ms = 26;
numLgdCol = 1;
XFontSize = 35;
YFontSize = 35;
lgdFontSize = 23;
ticksFontSIze = 30;
linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);
LineColors = flipud(LineColors);

%% Visualization
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(AX1, 'position', [0.05 0.58 0.42 0.42])

ii = 1;
plot(x, w8(:, ii), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
hold on;
plot(x, w16(:, ii), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
plot(x, w32(:, ii), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));

set(gca, 'FontSize', ticksFontSIze);
set(gca, 'XScale', 'log');
xticks([10, 25, 50]);
%legend(["$w=8$", "$w=16$", "$w=32$"], 'NumColumns', numLgdCol, 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xlabel("Conf. thr, $\tau_\mathrm{conf}$", 'FontSize', XFontSize, "Interpreter", 'latex' );
ylabel("ATE\,$\downarrow$ [m]", 'FontSize', YFontSize, "Interpreter", 'latex' );
xlim([9, 50])

print(gcf, "imgs/vggt_ate.png",'-dpng','-r300');
print -depsc 'imgs/vggt_ate.eps'

%%%%%%%%%%%%%%%%%%%

fig = figure('Position', [200 + imgWidthSize, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

ii = 2;
plot(x, w8(:, ii), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
hold on;
plot(x, w16(:, ii), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
plot(x, w32(:, ii), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));

set(gca, 'FontSize', ticksFontSIze);
set(gca, 'XScale', 'log');
xticks([10, 25, 50]);
%legend(["$w=8$", "$w=16$", "$w=32$"], 'NumColumns', numLgdCol, 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xlabel("Conf. thr, $\tau_\mathrm{conf}$", 'FontSize', XFontSize, "Interpreter", 'latex' );
ylabel("Acc.\,$\downarrow$ [m]", 'FontSize', YFontSize, "Interpreter", 'latex' );
xlim([9, 50])

print(gcf, "imgs/vggt_accuracy.png",'-dpng','-r300');
print -depsc 'imgs/vggt_accuracy.eps'

%%%%%%%%%%%%%%%%%%%
fig = figure('Position', [200 , 80 + imgColumnSize, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

ii = 3;
plot(x, w8(:, ii), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
hold on;
plot(x, w16(:, ii), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
plot(x, w32(:, ii), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));

set(gca, 'FontSize', ticksFontSIze);
set(gca, 'XScale', 'log');
xticks([10, 25, 50]);
%legend(["$w=8$", "$w=16$", "$w=32$"], 'NumColumns', numLgdCol, 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;
xlabel("Conf. thr, $\tau_\mathrm{conf}$", 'FontSize', XFontSize, "Interpreter", 'latex' );
ylabel("Complet.\,$\downarrow$ [m]", 'FontSize', YFontSize, "Interpreter", 'latex' );
xlim([9, 50])

print(gcf, "imgs/vggt_completion.png",'-dpng','-r300');
print -depsc 'imgs/vggt_completion.eps'

%%%%%%%%%%%%%%%%%%%
fig = figure('Position', [200 + imgWidthSize, 80 + imgColumnSize, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

ii = 4;
plot(x, w8(:, ii), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
hold on;
plot(x, w16(:, ii), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
plot(x, w32(:, ii), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));

set(gca, 'FontSize', ticksFontSIze);
set(gca, 'XScale', 'log');
xticks([10, 25, 50]);
legend(["$w=8$", "$w=16$", "$w=32$"], 'NumColumns', numLgdCol, 'FontSize', lgdFontSize, 'interpreter','latex', 'Location', 'northwest');
grid on;
xlabel("Conf. thr, $\tau_\mathrm{conf}$", 'FontSize', XFontSize, "Interpreter", 'latex' );
ylabel("Chamfer\,$\downarrow$ [m]", 'FontSize', YFontSize, "Interpreter", 'latex' );
xlim([9, 50])

print(gcf, "imgs/vggt_chamfer.png",'-dpng','-r300');
print -depsc 'imgs/vggt_chamfer.eps'