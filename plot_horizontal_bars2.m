%% Initialize
clc
close all;
clear all;




%% HRNet w/ 3 pixel
figure('Position', [500, 50, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 58.24;
y = [baseline 60.60-baseline; baseline 60.25-baseline; baseline 60.19-baseline] 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [LineColors(4, :);
              0.9451    0.9255    0.7843;  
              0.5216    0.6706    0.8118]; 

set(b(1), 'FaceColor', baseline_color); 

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
 ax.YAxis.FontSize = 25;
ax.XAxis.FontSize = 25;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([57.5 61.0]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', 23, 'Interpreter', 'latex');

hold off;
title("Pixel threshold $\tau_B = 3$", 'interpreter', 'latex', "FontSize", 28)

print(gcf, "imgs/biou_horizontal_bar_w_hrnet_3px.png",'-dpng','-r300');
print -depsc 'imgs/biou_horizontal_bar_w_hrnet_3px.eps'

%% HRNet w/ 7 pixel
figure('Position', [500, 550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 62.65;
y = [baseline 64.96-baseline; baseline 64.56-baseline; baseline 64.51-baseline]

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [LineColors(4, :);
              0.9451    0.9255    0.7843;  
              0.5216    0.6706    0.8118]; 

set(b(1), 'FaceColor', baseline_color); 

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
 ax.YAxis.FontSize = 25;
ax.XAxis.FontSize = 25;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([62.0 65.5]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', 23, 'Interpreter', 'latex');

hold off;
title("Pixel threshold $\tau_B = 7$", 'interpreter', 'latex', "FontSize", 28)

print(gcf, "imgs/biou_horizontal_bar_w_hrnet_7px.png",'-dpng','-r300');
print -depsc 'imgs/biou_horizontal_bar_w_hrnet_7px.eps'

%% HRNet w/ 10 pixel
figure('Position', [500, 1050, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 66.77;
y = [baseline 68.99-baseline; baseline 68.54-baseline; baseline 68.49-baseline] 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [LineColors(4, :);
              0.9451    0.9255    0.7843;  
              0.5216    0.6706    0.8118]; 

set(b(1), 'FaceColor', baseline_color); 

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
 ax.YAxis.FontSize = 25;
ax.XAxis.FontSize = 25;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([66.0 69.5]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', 23, 'Interpreter', 'latex');

hold off;
title("Pixel threshold $\tau_B = 10$", 'interpreter', 'latex', "FontSize", 28)

print(gcf, "imgs/biou_horizontal_bar_w_hrnet_10px.png",'-dpng','-r300');
print -depsc 'imgs/biou_horizontal_bar_w_hrnet_10px.eps'

%% HRNet w/ 20 pixel
figure('Position', [500, 1550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 72.92;
y = [baseline 74.93-baseline; baseline 74.41-baseline; baseline 74.40-baseline] 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors = [LineColors(4, :);
              0.9451    0.9255    0.7843;  
              0.5216    0.6706    0.8118]; 

set(b(1), 'FaceColor', baseline_color); 

% Assign individual colors to FPS bars
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

% Set axis labels and formatting
yticklabels({'W/ Ours', 'W/ Contextrast [51]', 'W/ Multi [50]'});
 ax.YAxis.FontSize = 25;
ax.XAxis.FontSize = 25;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([72.5 75.5]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

% Create dummy bars for the legend
legend_handles = gobjects(1, length(legend_labels)); % Empty object array
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color); % Geom. bootstr.

% Create dummy patches for FPS legend colors
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :)); % Dummy patches for legend
end

% Add the legend at the bottom
legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', 23, 'Interpreter', 'latex');

hold off;
title("Pixel threshold $\tau_B = 20$", 'interpreter', 'latex', "FontSize", 28)

print(gcf, "imgs/biou_horizontal_bar_w_hrnet_20px.png",'-dpng','-r300');
print -depsc 'imgs/biou_horizontal_bar_w_hrnet_20px.eps'

