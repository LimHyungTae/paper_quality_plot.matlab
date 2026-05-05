%% Initialize
clc; close all; clearvars;

%% Input data
% 3D position - UTM
load('materials/trajectory_utm.mat', 'Pn', 'Pe', 'Pd');

%% Drawing parameters
% --- Sizes ---
linewidth = 2;
markersize = 12;
% --- Fonts ---
LegendFontSize = 15;
NLabelFontSize = 14;  ELabelFontSize = 14;  UpLabelFontSize = 14;
% --- Colors ---
num_objects = 2;
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);

%% Plot
figure("Name", '3D Trajectory')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');

% ---- Note that if the trajectory is too long, it doesn't work!!! ----
p=plot3(Pn, Pe, Pd,  'LineWidth', linewidth);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
data_size = size(Pn);
n = data_size(1);
drawnow
cd = [uint8(jet(n)*255) uint8(ones(n,1))].'; %'
set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)

hold on;

% Add markers
plot3(Pn(1), Pe(1), Pd(1),"s", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(1, :), 'MarkerEdgeColor', LineColors(1, :));
plot3(Pn(end), Pe(end), Pd(end),"^", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(2, :), 'MarkerEdgeColor', LineColors(2, :));

grid on;
legend({'Start','End'},'Location','northeast', 'FontSize', LegendFontSize, "Interpreter", 'latex');
xlabel('North [m]', 'fontsize', NLabelFontSize, "Interpreter", 'latex');
ylabel('East [m]', 'fontsize', ELabelFontSize, "Interpreter", 'latex');
zlabel('Up [m]', 'fontsize', UpLabelFontSize, "Interpreter", 'latex');
xtickformat('%,4.4g');
ytickformat('%,4.4g');

%% Save
exportgraphics(gcf, 'imgs/Navigation_trajectory.png', 'Resolution', 300);
exportgraphics(gcf, 'imgs/Navigation_trajectory.pdf', 'ContentType', 'vector');
