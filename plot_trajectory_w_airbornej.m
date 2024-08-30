clc
close all;
clear all;

%% Parse 3D position
file_path = 'materials/vbr_traj/campus_train0_gt.txt';

data = readmatrix(file_path, 'FileType', 'text');

x = data(:, 2);
y = data(:, 3);
z = data(:, 4);
z = z + linspace(0, 100, length(z))';

%% Plot parameters
linewidth = 2;
markersize = 12;
LegendFontSize = 15;
NLabelFontSize = 14;  ELabelFontSize = 14;  UpLabelFontSize = 14;

%% Colorization - 3D Plot
figure("Name", '3D Trajectory')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');

% ---- Note that if the trajectory is too long, it doesn't work!!! ---- 
p=plot3(x, y, z,  'LineWidth', linewidth);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
data_size = size(x);
n = data_size(1);
drawnow
cd = [uint8(jet(n)*255) uint8(ones(n,1))].'; %'
set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)

hold on;

%% Add markers
num_objects = 2; 
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);
plot3(x(1), y(1), z(1),"s", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(1, :), 'MarkerEdgeColor', LineColors(1, :));
plot3(x(end), y(end), z(end),"^", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(2, :), 'MarkerEdgeColor', LineColors(2, :));
axis equal;
grid on;
legend({'Start','End'},'Location','northeast', 'FontSize', LegendFontSize, "Interpreter", 'latex');
xlabel('North [m]', 'fontsize', NLabelFontSize, "Interpreter", 'latex');
ylabel('East [m]', 'fontsize', ELabelFontSize, "Interpreter", 'latex');
zlabel('Up [m]', 'fontsize', UpLabelFontSize, "Interpreter", 'latex');
xtickformat('%,4.4g');
ytickformat('%,4.4g');
saveas(gcf, 'imgs/campus_train0_gt.png');
% print -depsc 'imgs/campus_train0_gt.eps'




