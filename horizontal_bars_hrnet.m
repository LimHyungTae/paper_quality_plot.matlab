%% Initialize
clc; close all; clearvars;

%% Input data (px=3)
baseline = 58.24;
y = [baseline 60.60-baseline; baseline 60.25-baseline; baseline 60.19-baseline];
xlim_    = [57.5 61.0];
titleTex = "Pixel threshold $\tau_B = 3$";
saveStem = "biou_horizontal_bar_w_hrnet_3px";

%% Drawing parameters (px=3)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=3)
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
yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
 ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
%legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle)

%% Save (px=3)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=7)
baseline = 62.65;
y = [baseline 64.96-baseline; baseline 64.56-baseline; baseline 64.51-baseline];
xlim_    = [62.0 65.5];
titleTex = "Pixel threshold $\tau_B = 7$";
saveStem = "biou_horizontal_bar_w_hrnet_7px";

%% Drawing parameters (px=7)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=7)
figure('Position', [500, 550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
 ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
% legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle)

%% Save (px=7)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=10)
baseline = 66.77;
y = [baseline 68.99-baseline; baseline 68.54-baseline; baseline 68.49-baseline];
xlim_    = [66.0 69.5];
titleTex = "Pixel threshold $\tau_B = 10$";
saveStem = "biou_horizontal_bar_w_hrnet_10px";

%% Drawing parameters (px=10)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=10)
figure('Position', [500, 1050, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
 ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
%legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle)

%% Save (px=10)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=20)
baseline = 72.92;
y = [baseline 74.93-baseline; baseline 74.41-baseline; baseline 74.40-baseline];
xlim_    = [72.5 75.5];
titleTex = "Pixel threshold $\tau_B = 20$";
saveStem = "biou_horizontal_bar_w_hrnet_20px";

%% Drawing parameters (px=20)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=20)
figure('Position', [500, 1550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
 ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);
% --- Add legend for each FPS color ---
hold on;
%legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
%legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle)

%% Save (px=20)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');
