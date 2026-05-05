%% Initialize
clc; close all; clearvars;

%% Input data (deeplabv3)
baseline = 77.0;
y = [baseline 2.39; baseline 1.22; baseline 1.15];
xlim_   = [76.0 80.0];
saveStem = "horizontal_bar_w_deeplabv3";

%% Drawing parameters (deeplabv3)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
xaxis_size      = 25;
yaxis_size      = 22;
% --- Fonts ---
fontXLabel = 28;
fontXAxis  = 25;
fontLgd    = 23;
% --- Colors ---
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
color_grad = [color_grad ;
    %[0.3804, 0.1804, 0.2157];
    %[0.0, 0.4549, 0.8941];
    [0.9059, 0.4706, 0.0902];
    [0.84, 0.15, 0.16]];
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0    0.2980    0.4275];
sota_colors     = [LineColors(4, :);
              0.9451    0.9255    0.7843;
              0.5216    0.6706    0.8118];

%% Plot (deeplabv3)
figure('Position', [500, 50, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
ax.YAxis.FontSize = yaxis_size;
ax.XAxis.FontSize = fontXAxis;
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'DeepLabV3 [18]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'};

% Dummy bars + patches required so the legend renders the SOTA palette correctly
legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end

legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;

%% Save (deeplabv3)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (hrnet)
baseline = 76.2;
y = [baseline 3.14; baseline 2.26; baseline 2.14];
xlim_   = [75.0 80.0];
saveStem = "horizontal_bar_w_hrnet";

%% Drawing parameters (hrnet)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
xaxis_size      = 25;
yaxis_size      = 22;
% --- Fonts ---
fontXLabel = 28;
fontXAxis  = 25;
fontLgd    = 23;
% --- Colors ---
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
color_grad = [color_grad ;
    %[0.3804, 0.1804, 0.2157];
    %[0.0, 0.4549, 0.8941];
    [0.9059, 0.4706, 0.0902];
    [0.84, 0.15, 0.16]];
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
              0.9451    0.9255    0.7843;
              0.5216    0.6706    0.8118];

%% Plot (hrnet)
figure('Position', [500, 550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
ax.YAxis.FontSize = yaxis_size;
ax.XAxis.FontSize = fontXAxis;
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'};

legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end

legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;

%% Save (hrnet)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (ocrnet)
baseline = 79.2;
y = [baseline 1.17; baseline 1.01; baseline-0.33 0.33];
xlim_   = [78.5 81.0];
saveStem = "horizontal_bar_w_ocrnet";

%% Drawing parameters (ocrnet)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
xaxis_size      = 25;
yaxis_size      = 22;
% --- Fonts ---
fontXLabel = 28;
fontXAxis  = 25;
fontLgd    = 23;
% --- Colors ---
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
color_grad = [color_grad ;
    %[0.3804, 0.1804, 0.2157];
    %[0.0, 0.4549, 0.8941];
    [0.9059, 0.4706, 0.0902];
    [0.84, 0.15, 0.16]];
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.26670 0.1647 0.0353]; %[0.8314    0.6275    0.0902];
sota_colors     = [LineColors(4, :);
              0.9451    0.9255    0.7843;
              0.5216    0.6706    0.8118];

%% Plot (ocrnet)
figure('Position', [500, 1050, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
ax.YAxis.FontSize = yaxis_size;
ax.XAxis.FontSize = fontXAxis;
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'OCRNet [30]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'};

legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end

legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;

%% Save (ocrnet)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (upernet)
baseline = 75.2;
y = [baseline 1.01; baseline 0.79; baseline 0.61];
xlim_   = [75.0 76.5];
saveStem = "horizontal_bar_w_upernet";

%% Drawing parameters (upernet)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
xaxis_size      = 25;
yaxis_size      = 22;
% --- Fonts ---
fontXLabel = 28;
fontXAxis  = 25;
fontLgd    = 23;
% --- Colors ---
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
color_grad = [color_grad ;
    %[0.3804, 0.1804, 0.2157];
    %[0.0, 0.4549, 0.8941];
    [0.9059, 0.4706, 0.0902];
    [0.84, 0.15, 0.16]];
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.0353 0.26670 0.0353];
sota_colors     = [LineColors(4, :);
              0.9451    0.9255    0.7843;
              0.5216    0.6706    0.8118];

%% Plot (upernet)
figure('Position', [500, 1550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
ax.YAxis.FontSize = yaxis_size;
ax.XAxis.FontSize = fontXAxis;
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'UPerNet [22]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'};

legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end

legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;

%% Save (upernet)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');
