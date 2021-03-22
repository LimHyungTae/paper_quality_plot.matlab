
%% Plot parameters


imgWidthSize = 500;
imgColumnSize = 400;
lw = 2.25;
ms = 13;
numLgdCol = 1;
titleFontSize = 19;
XFontSize = 17;
YFontSize = 17;
lgdFontSize = 15;
ticksFontSIze = 13;
linecolors = linspecer(5, 'qualitative');
LineColors = flipud(linecolors);


%% Dummy data
X = [5, 10, 15];
Y = [91.4858, 93.98, 95.295;
                83.752, 91.8, 92.294;
                73.285, 80.876, 87.7305;
                84.0801, 88.406, 90.3627;
                90.624, 91.6073, 92.5634];
            
%% 
figure()
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

plot(X, Y(1,:), '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(1, :));
hold on;
plot(X, Y(2,:), '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(2, :));
plot(X, Y(3,:), '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(3, :));
plot(X, Y(4,:), '-^', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(4, :));
plot(X, Y(5,:), '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', LineColors(5, :));

set(gca, 'FontSize', ticksFontSIze);
% Two lines should be lied after plot command.
xtickformat('%,4.4g');
ytickformat('%,4.4g');
legend(["A", "B", "C", "D", "E"], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');
grid on;

xlabel("X LABEL", 'FontSize', XFontSize , "Interpreter", 'latex');
ylabel("Y LABEL", 'FontSize', YFontSize , "Interpreter", 'latex');

saveas(gcf, "imgs/template.png")
% print -depsc 'imgs/template.eps'