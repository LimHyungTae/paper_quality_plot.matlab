clc
close all;
clear all;

%% 3D position - UTM
load('materials/trajectory_utm.mat', 'Pn', 'Pe', 'Pd');

%% Plot parameters
linewidth = 2;
markersize = 12;
LegendFontSize = 15;
NLabelFontSize = 14;  ELabelFontSize = 14;  UpLabelFontSize = 14;

%% Colorization - 3D Plot
figure("Name", '3D Trajectory')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))

% ---- Note that if the trajectory is too long, it doesn't work!!! ---- 
p=plot3(Pn, Pe, Pd,  'LineWidth', linewidth);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
data_size = size(Pn);
n = data_size(1);
drawnow
cd = [uint8(jet(n)*255) uint8(ones(n,1))].'; %'
set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)

hold on;

%% Add markers
num_objects = 2; 
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);
plot3(Pn(1), Pe(1), Pd(1),"s", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(1, :), 'MarkerEdgeColor', LineColors(1, :));
plot3(Pn(end), Pe(end), Pd(end),"^", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(2, :), 'MarkerEdgeColor', LineColors(2, :));

grid on;
legend({'Start','End'},'Location','northeast', 'FontSize', LegendFontSize);
xlabel('North [m]', 'fontsize', NLabelFontSize, "Interpreter", 'latex');
ylabel('East [m]', 'fontsize', ELabelFontSize, "Interpreter", 'latex');
zlabel('Up [m]', 'fontsize', UpLabelFontSize, "Interpreter", 'latex');

saveas(gcf, 'imgs/Navigation_trajectory.png');
% print -depsc 'imgs/Navigation_trajectory.eps'




