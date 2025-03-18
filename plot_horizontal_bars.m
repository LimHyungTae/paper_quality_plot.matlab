%% Initialize
clc
close all;
clear all;



%% Colors
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
color_grad = [color_grad ; 
    %[0.3804, 0.1804, 0.2157];
    %[0.0, 0.4549, 0.8941];
    [0.9059, 0.4706, 0.0902];
    [0.84, 0.15, 0.16]];

%% DeepLabv3
figure('Position', [500, 50, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 77.0;
y = [baseline 2.39; baseline 1.22; baseline 1.15]; 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0    0.2980    0.4275];
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
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([76.5 79.5]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'DeepLabV3 [18]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

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

print(gcf, "imgs/horizontal_bar_w_deeplabv3.png",'-dpng','-r300');
print -depsc 'imgs/horizontal_bar_w_deeplabv3.eps'

%% HRNet
figure('Position', [500, 550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 76.2;
y = [baseline 3.14; baseline 2.26; baseline 2.14]; 

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
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([75.5 79.5]);
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

print(gcf, "imgs/horizontal_bar_w_hrnet.png",'-dpng','-r300');
print -depsc 'imgs/horizontal_bar_w_hrnet.eps'

%% OCRNet
figure('Position', [500, 1050, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 79.2;
y = [baseline 1.17; baseline 1.01; baseline-0.33 0.33]; 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.26670 0.1647 0.0353]; %[0.8314    0.6275    0.0902];
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
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([78.75 80.5]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'OCRNet [30]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

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

print(gcf, "imgs/horizontal_bar_w_ocrnet.png",'-dpng','-r300');
print -depsc 'imgs/horizontal_bar_w_ocrnet.eps'

%% UperNet
figure('Position', [500, 1550, 1200, 450]);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
common_fontsize = 32;
baseline = 75.2;
y = [baseline 1.01; baseline 0.79; baseline 0.61]; 

% Create a horizontal stacked bar chart
b = barh(y,'stacked', 'BarWidth', 0.8);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
baseline_color = [0.0353 0.26670 0.0353];
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
xlabel("mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", 28);
xlim([75.0 76.25]);
% --- Add legend for each FPS color ---
hold on;
legend_labels = {'UperNet [22]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'}; % Legend labels

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

print(gcf, "imgs/horizontal_bar_w_upernet.png",'-dpng','-r300');
print -depsc 'imgs/horizontal_bar_w_upernet.eps'
