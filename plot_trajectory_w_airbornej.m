clc
close all;
clear all;

%% Parse 3D position
% file_path = 'materials/vbr_traj/spagna_train0_gt.txt';
%file_path = 'materials/vbr_traj/colosseo_train0_gt.txt';
% file_path = 'materials/vbr_traj/pincio_train0_gt.txt';
file_path = 'materials/vbr_traj/diag_train0_gt.txt';
%file_path = 'materials/vbr_traj/ciampino_train0_gt.txt';

% Just for visualization
% file_path = 'materials/vbr_traj/campus_train0_gt.txt';
% file_path = 'materials/vbr_traj/campus_train1_gt.txt';
% file_path = 'materials/vbr_traj/ciampino_train1_gt.txt'; % Note, it's totally different from `ciampino_train0_gt`

file_id = fopen(file_path, 'r');

% 데이터 읽기
data = textscan(file_id, '%f %f %f %f %f %f %f %f', 'HeaderLines', 1);

% 파일 닫기
fclose(file_id);

% 각 열을 변수로 저장
timestamp = data{1};
x = data{2};
y = data{3};
z = data{1};

%% Plot parameters
linewidth3D = 36;
linewidth2D = 36;
markersize = 25;
legendFontSize = 25;
tickSize = 22;
labeleSize = 25;


%% Colorization - 3D Plot
figure("Name", '3D Trajectory')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');

% ---- Note that if the trajectory is too long, it doesn't work!!! ---- 
% p=plot3(x, y, z,  'LineWidth', linewidth, 'LineStyle', '-'); 
% p.Annotation.LegendInformation.IconDisplayStyle = 'off';
% data_size = size(x);
% n = data_size(1);
% drawnow
% cd = [uint8(jet(n)*255) uint8(ones(n,1))].'; %'
% set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)
% ---- More better representation -----
p = scatter3(x, y, z, linewidth3D, z, 'filled');
p.Annotation.LegendInformation.IconDisplayStyle = 'off';

% colormap과 colorbar 설정
colormap(jet);
caxis([min(z) max(z)]);
hold on;


% Add markers
num_objects = 2; 
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);
plot3(x(1), y(1), z(1),"s", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(1, :), 'MarkerEdgeColor', LineColors(1, :));
plot3(x(end), y(end), z(end),"^", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(2, :), 'MarkerEdgeColor', LineColors(2, :));
% axis equal;
grid on;
set(gca, 'FontSize', tickSize);
legend({'Start','End'},'Location','northeast', 'FontSize', legendFontSize, "Interpreter", 'latex');
xlabel('x [m]', 'fontsize', labeleSize, "Interpreter", 'latex');
ylabel('y [m]', 'fontsize', labeleSize, "Interpreter", 'latex');
zlabel('t [sec]', 'fontsize', labeleSize, "Interpreter", 'latex');
% zlabel('Up [m]', 'fontsize', UpLabelFontSize, "Interpreter", 'latex');
xtickformat('%,4.4g');
ytickformat('%,4.4g');
ztickformat('%,4.4g');

if strcmp(file_path, 'materials/vbr_traj/campus_train0_gt.txt')
    print(gcf, "imgs/campus_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/campus_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train1_gt.txt')
    print(gcf, "imgs/ciampino_train1_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/ciampino_train1_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train0_gt.txt')
    print(gcf, "imgs/ciampino_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/ciampino_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train1_gt.txt')
    print(gcf, "imgs/ciampino_train1_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/ciampino_train1_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/spagna_train0_gt.txt')
    print(gcf, "imgs/spagna_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/spagna_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/colosseo_train0_gt.txt')
    print(gcf, "imgs/colosseo_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/colosseo_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/pincio_train0_gt.txt')
    print(gcf, "imgs/pincio_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/pincio_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/diag_train0_gt.txt')
    print(gcf, "imgs/diag_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/diag_train0_gt.eps', '-r300');
end

%% 2D Colored Map (x, y) with z as color
figure("Name", '2D Colored Map')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', tickSize);

% Create 2D colored map
p=scatter(x, y, linewidth2D, z, 'filled');
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
% Add markers for start and end points
hold on;
plot(x(1), y(1), "s", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(1, :), 'MarkerEdgeColor', LineColors(1, :));
plot(x(end), y(end), "^", "MarkerSize", markersize, 'MarkerFaceColor', LineColors(2, :), 'MarkerEdgeColor', LineColors(2, :));

% Add colorbar and labels
colormap(jet);
caxis([min(z) max(z)]);
set(gca, 'FontSize', tickSize);
xlabel('x [m]', 'fontsize', labeleSize, "Interpreter", 'latex');
ylabel('y [m]', 'fontsize', labeleSize, "Interpreter", 'latex');
axis equal;
grid on;

if strcmp(file_path, 'materials/vbr_traj/campus_train0_gt.txt')
    legend({'Start','End'},'Location','northeast', 'FontSize', legendFontSize, "Interpreter", 'latex');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train0_gt.txt')
    legend({'Start','End'},'Location','northeast', 'FontSize', legendFontSize, "Interpreter", 'latex');
elseif strcmp(file_path, 'materials/vbr_traj/spagna_train0_gt.txt')
    legend({'Start','End'},'Location','southeast', 'FontSize', legendFontSize, "Interpreter", 'latex');
elseif strcmp(file_path, 'materials/vbr_traj/pincio_train0_gt.txt')
    legend({'Start','End'},'Location','southwest', 'FontSize', legendFontSize, "Interpreter", 'latex');
else strcmp(file_path, 'materials/vbr_traj/ciampino_train0_gt.txt')
    legend({'Start','End'},'Location','northeast', 'FontSize', legendFontSize, "Interpreter", 'latex');
end

xtickformat('%,4.4g');
ytickformat('%,4.4g');

if strcmp(file_path, 'materials/vbr_traj/campus_train0_gt.txt')
    print(gcf, "imgs/campus_train0_gt.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/campus_train0_gt.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/campus_train1_gt.txt')
    print(gcf, "imgs/campus_train1_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/campus_train1_gt_2D.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train0_gt.txt')
    print(gcf, "imgs/ciampino_train0_gt_2D.png", '-dpng', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/ciampino_train1_gt.txt')
    print(gcf, "imgs/ciampino_train1_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/ciampino_train1_gt_2D.eps', '-r300');
    print('-depsc2', 'imgs/ciampino_train0_gt_2D.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/spagna_train0_gt.txt')
    print(gcf, "imgs/spagna_train0_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/spagna_train0_gt_2D.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/colosseo_train0_gt.txt')
    print(gcf, "imgs/colosseo_train0_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/colosseo_train0_gt_2D.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/pincio_train0_gt.txt')
    print(gcf, "imgs/pincio_train0_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/pincio_train0_gt_2D.eps', '-r300');
elseif strcmp(file_path, 'materials/vbr_traj/diag_train0_gt.txt')
    print(gcf, "imgs/diag_train0_gt_2D.png", '-dpng', '-r300');
    print('-depsc2', 'imgs/diag_train0_gt_2D.eps', '-r300');
end