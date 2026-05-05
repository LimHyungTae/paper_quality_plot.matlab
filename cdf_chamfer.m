%% Initialize
clc; close all; clearvars;

%% Color parameter
num_objects = 4;
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);

%% Previous test
% fileID = fopen('/media/shapelim/UX9804/uHumans2_cloud/0730_w_gt_w_labels_to_skip/uhumans2__mesh_objects__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% mesh_objects = textscan(fileID, '%s %s %f %f %f %f');
% fclose(fileID);
%
% fileID = fopen('/media/shapelim/UX9804/uHumans2_cloud/0730_w_gt_w_labels_to_skip/uhumans2__khronos__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% khronos = textscan(fileID, '%s %s %f %f %f %f');
% fclose(fileID);
%
% fileID = fopen('/media/shapelim/UX9804/uHumans2_cloud/0730_w_gt_w_labels_to_skip/uhumans2__crisp__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% crisp = textscan(fileID, '%s %s %f %f %f %f');
% fclose(fileID);

%% Load output file
% v1
% fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__mesh_objects__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% mesh_objects = textscan(fileID, '%s %s %f %f %f %f');
% fclose(fileID);
%
% fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__khronos__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% khronos = textscan(fileID, '%s %s %f %f %f %f');
% fclose(fileID);
%
% fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp_wo_cert__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% crisp_wo_certifier = textscan(fileID, '%s %s %f %f %f %f %f %f %f');
% fclose(fileID);
%
% fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp_wo_cert__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
% crisp = textscan(fileID, '%s %s %f %f %f %f %f %f %f');
% fclose(fileID);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen('/media/shapelim/UX9804/objectra_uHumans2_cloud/0813_w_gt_w_updated_bins/uhumans2__mesh_objects__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
mesh_objects = textscan(fileID, '%s %s %d %f %f %f %f %f');
fclose(fileID);

fileID = fopen('/media/shapelim/UX9804/objectra_uHumans2_cloud/0813_w_gt_w_updated_bins/uhumans2__khronos__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
khronos = textscan(fileID, '%s %s %d %f %f %f %f %f');
fclose(fileID);

fileID = fopen('/media/shapelim/UX9804/objectra_uHumans2_cloud/0813_w_gt_w_updated_bins/uhumans2__crisp_P41O3_wo_cert___ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
crisp_wo_certifier = textscan(fileID, '%s %s %d %f %f %f %f %f %f %f');
fclose(fileID);

fileID = fopen('/media/shapelim/UX9804/objectra_uHumans2_cloud/0813_w_gt_w_updated_bins/uhumans2__crisp_P41O3_wo_cert___ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
crisp = textscan(fileID, '%s %s %d %f %f %f %f %f %f %f');
fclose(fileID);

disp("Loading data complete!");

%% Input data (total)
% Uses mesh_objects, khronos, crisp_wo_certifier, crisp loaded above.

%% Drawing parameters (total)
MAX_RANGE = 0.5;
INTERVAL = 100;
lindwidth = 2.5;
markerSize = 15;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;
precision_thr = 0.21;
IMAGE_WIDTH = 500;
IMAGE_HEIGHT = 450;

%% Plot (total)
%% Draw cdf of chamfer distance:
figure("name", "Total", 'Position', [50, 50, IMAGE_WIDTH, IMAGE_HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(gca, 'FontSize', 25);
set(groot, 'defaultAxesTickLabelInterpreter','latex');



gap = MAX_RANGE / INTERVAL;
x_linspace = 0:gap:MAX_RANGE;
mesh_objects_cum = calcCDF(mesh_objects{4}, MAX_RANGE, INTERVAL) * 100;
khronos_cum = calcCDF(khronos{4}, MAX_RANGE, INTERVAL) * 100;
crisp_wo_certifier_cum = calcCDF(crisp_wo_certifier{4}, MAX_RANGE, INTERVAL) * 100;
crisp_w_filtering = crisp{4}(crisp_wo_certifier{10} > precision_thr);
crisp_cum = calcCDF(crisp_w_filtering, MAX_RANGE, INTERVAL) * 100;

crisp_w_filtering_b_iou = crisp{7}(crisp_wo_certifier{10} > precision_thr);
crisp_w_filtering_v_iou = crisp{8}(crisp_wo_certifier{10} > precision_thr);

disp("For all classes:");
fprintf("Hydra:         B-IoU = %.3f, v-IoU = %.3f\n", mean(mesh_objects{7}), mean(mesh_objects{8}));
fprintf("Khronos:       B-IoU = %.3f, v-IoU = %.3f\n", mean(khronos{7}), mean(khronos{8}));
fprintf("Ours w/o RMCC:B-IoU = %.3f, v-IoU = %.3f\n", mean(crisp_wo_certifier{7}), mean(crisp_wo_certifier{8}));
fprintf("Ours:          B-IoU = %.3f, v-IoU = %.3f\n", mean(crisp_w_filtering_b_iou), mean(crisp_w_filtering_v_iou));

plot(x_linspace, mesh_objects_cum, '-.^', 'Color', LineColors(3, :), "MarkerSize", markerSize, ...
    'LineWidth', lindwidth, 'MarkerIndices',1:8:length(x_linspace));
hold on;
plot(x_linspace, khronos_cum, '--d', 'Color',  LineColors(1, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:8:length(x_linspace));
plot(x_linspace, crisp_wo_certifier_cum,'-s', 'Color', LineColors(4, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:8:length(x_linspace));
plot(x_linspace, crisp_cum, '-o', 'Color', LineColors(2, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:8:length(x_linspace));
lgd = legend({'Hydra','Khronos', 'Ours w/o RMCC', 'Ours'},'Location','southeast','NumColumns',1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;
set(gca, 'FontSize', ticksFontSize);

xlabel('Chamfer distance [m$^2$]', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", YLabelFontSize, "Interpreter", 'latex')

%% Save (total)
exportgraphics(gcf, "imgs/cdf_for_chamfer_distance.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/cdf_for_chamfer_distance.pdf', 'ContentType', 'vector');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class-wise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Input data (class5)
% Uses mesh_objects, khronos, crisp_wo_certifier, crisp loaded above.

%% Drawing parameters (class5)
MAX_RANGE = 0.5;
INTERVAL = 100;
lindwidth = 2.5;
markerSize = 15;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;
precision_thr = 0.21;
IMAGE_WIDTH = 500;
IMAGE_HEIGHT = 450;

%% Plot (class5)
%% Class 5
figure("name", "Class 5 (Chair)", 'Position', [50, 700, IMAGE_WIDTH, IMAGE_HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% Update this label
target_class_label = 5;
num_objects_in_gt = 33; % manually checked

gap = MAX_RANGE / num_objects_in_gt;
x_linspace = 0:gap:MAX_RANGE;

selected_mesh_objects = mesh_objects{4}(mesh_objects{3} == target_class_label);
selected_khronos = khronos{4}(khronos{3} == target_class_label);
selected_crisp_wo_cert = crisp_wo_certifier{4}(crisp_wo_certifier{3} == target_class_label);
selected_crisp = crisp{4}(crisp{3} == target_class_label & crisp_wo_certifier{10} > precision_thr);
disp(['# of valid node in class 5: ']);
size(selected_crisp)

mesh_objects_cum = calcCDF(selected_mesh_objects, MAX_RANGE, num_objects_in_gt) * 100;
khronos_cum = calcCDF(selected_khronos, MAX_RANGE, num_objects_in_gt) * 100;
crisp_wo_certifier_cum = calcCDF(selected_crisp_wo_cert, MAX_RANGE, num_objects_in_gt) * 100;
crisp_cum = calcCDF(selected_crisp, MAX_RANGE, num_objects_in_gt) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_b_iou = mesh_objects{7}(mesh_objects{3} == target_class_label);
m_v_iou = mesh_objects{8}(mesh_objects{3} == target_class_label);
k_b_iou = khronos{7}(khronos{3} == target_class_label);
k_v_iou = khronos{8}(khronos{3} == target_class_label);
c_b_iou = crisp_wo_certifier{7}(crisp_wo_certifier{3} == target_class_label);
c_v_iou = crisp_wo_certifier{8}(crisp_wo_certifier{3} == target_class_label);
c_w_filtering_b_iou = crisp{7}(crisp{3} == target_class_label & crisp{10} > precision_thr);
c_w_filtering_v_iou = crisp{8}(crisp{3} == target_class_label & crisp{10} > precision_thr);
disp("For class:" + target_class_label);
fprintf("Hydra:         B-IoU = %.3f, v-IoU = %.3f\n", mean(m_b_iou), mean(m_v_iou));
fprintf("Khronos:       B-IoU = %.3f, v-IoU = %.3f\n", mean(k_b_iou), mean(k_v_iou));
fprintf("Ours w/o RMCC:B-IoU = %.3f, v-IoU = %.3f\n", mean(c_b_iou), mean(c_v_iou));
fprintf("Ours:          B-IoU = %.3f, v-IoU = %.3f\n", mean(c_w_filtering_b_iou), mean(c_w_filtering_v_iou));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x_linspace, mesh_objects_cum, '-.^', 'Color', LineColors(3, :), "MarkerSize", markerSize, ...
    'LineWidth', lindwidth, 'MarkerIndices',1:3:length(x_linspace));
hold on;
plot(x_linspace, khronos_cum, '--d', 'Color',  LineColors(1, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:3:length(x_linspace));
plot(x_linspace, crisp_wo_certifier_cum,'-s', 'Color', LineColors(4, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:3:length(x_linspace));
plot(x_linspace, crisp_cum, '-o', 'Color', LineColors(2, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:3:length(x_linspace));
lgd = legend({'Hydra','Khronos', 'Ours w/o RMCC', 'Ours'},'Location','southeast','NumColumns',1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;
set(gca, 'FontSize', ticksFontSize);

xlabel('Chamfer distance [m$^2$]', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", YLabelFontSize, "Interpreter", 'latex')

%% Save (class5)
exportgraphics(gcf, "imgs/cdf_for_chamfer_distance_class5.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/cdf_for_chamfer_distance_class5.pdf', 'ContentType', 'vector');

%% Input data (class7)
% Uses mesh_objects, khronos, crisp_wo_certifier, crisp loaded above.

%% Drawing parameters (class7)
MAX_RANGE = 0.5;
INTERVAL = 100;
lindwidth = 2.5;
markerSize = 15;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;
precision_thr = 0.21;
IMAGE_WIDTH = 500;
IMAGE_HEIGHT = 450;

%% Plot (class7)
%% Class 7
figure("name", "Class 7 (Couch)", 'Position', [700, 700, IMAGE_WIDTH, IMAGE_HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% Update this label
target_class_label = 7;
num_objects_in_gt = 19; % manually checked

gap = MAX_RANGE / num_objects_in_gt;
x_linspace = 0:gap:MAX_RANGE;

selected_mesh_objects = mesh_objects{4}(mesh_objects{3} == target_class_label);
selected_khronos = khronos{4}(khronos{3} == target_class_label);
selected_crisp_wo_cert = crisp_wo_certifier{4}(crisp_wo_certifier{3} == target_class_label);
selected_crisp = crisp{4}(crisp{3} == target_class_label & crisp_wo_certifier{10} > precision_thr);
disp(['# of valid node in class 7: ']);
size(selected_crisp)

mesh_objects_cum = calcCDF(selected_mesh_objects, MAX_RANGE, num_objects_in_gt) * 100;
khronos_cum = calcCDF(selected_khronos, MAX_RANGE, num_objects_in_gt) * 100;
crisp_wo_certifier_cum = calcCDF(selected_crisp_wo_cert, MAX_RANGE, num_objects_in_gt) * 100;
crisp_cum = calcCDF(selected_crisp, MAX_RANGE, num_objects_in_gt) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_b_iou = mesh_objects{7}(mesh_objects{3} == target_class_label);
m_v_iou = mesh_objects{8}(mesh_objects{3} == target_class_label);
k_b_iou = khronos{7}(khronos{3} == target_class_label);
k_v_iou = khronos{8}(khronos{3} == target_class_label);
c_b_iou = crisp_wo_certifier{7}(crisp_wo_certifier{3} == target_class_label);
c_v_iou = crisp_wo_certifier{8}(crisp_wo_certifier{3} == target_class_label);
c_w_filtering_b_iou = crisp{7}(crisp{3} == target_class_label & crisp{10} > precision_thr);
c_w_filtering_v_iou = crisp{8}(crisp{3} == target_class_label & crisp{10} > precision_thr);
disp("For class:" + target_class_label);
fprintf("Hydra:         B-IoU = %.3f, v-IoU = %.3f\n", mean(m_b_iou), mean(m_v_iou));
fprintf("Khronos:       B-IoU = %.3f, v-IoU = %.3f\n", mean(k_b_iou), mean(k_v_iou));
fprintf("Ours w/o RMCC:B-IoU = %.3f, v-IoU = %.3f\n", mean(c_b_iou), mean(c_v_iou));
fprintf("Ours:          B-IoU = %.3f, v-IoU = %.3f\n", mean(c_w_filtering_b_iou), mean(c_w_filtering_v_iou));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x_linspace, mesh_objects_cum, '-.^', 'Color', LineColors(3, :), "MarkerSize", markerSize, ...
    'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
hold on;
plot(x_linspace, khronos_cum, '--d', 'Color',  LineColors(1, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
plot(x_linspace, crisp_wo_certifier_cum, '-s', 'Color', LineColors(4, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
plot(x_linspace, crisp_cum, '-o', 'Color', LineColors(2, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
lgd = legend({'Hydra','Khronos', 'Ours w/o RMCC', 'Ours'},'Location','southeast','NumColumns',1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;
set(gca, 'FontSize', ticksFontSize);

xlabel('Chamfer distance [m$^2$]', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", YLabelFontSize, "Interpreter", 'latex')

%% Save (class7)
exportgraphics(gcf, "imgs/cdf_for_chamfer_distance_class7.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/cdf_for_chamfer_distance_class7.pdf', 'ContentType', 'vector');

%% Input data (class13)
% Uses mesh_objects, khronos, crisp_wo_certifier, crisp loaded above.

%% Drawing parameters (class13)
MAX_RANGE = 0.5;
INTERVAL = 100;
lindwidth = 2.5;
markerSize = 15;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;
precision_thr = 0.21;
IMAGE_WIDTH = 500;
IMAGE_HEIGHT = 450;

%% Plot (class13)
%% Class 13
figure("name", "Class 13 (plant)", 'Position', [50, 1500, IMAGE_WIDTH, IMAGE_HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% Update this label
target_class_label = 13;
num_objects_in_gt = 12; % manually checked

gap = MAX_RANGE / num_objects_in_gt;
x_linspace = 0:gap:MAX_RANGE;

selected_mesh_objects = mesh_objects{4}(mesh_objects{3} == target_class_label);
selected_khronos = khronos{4}(khronos{3} == target_class_label);
selected_crisp_wo_cert = crisp_wo_certifier{4}(crisp_wo_certifier{3} == target_class_label);
selected_crisp = crisp{4}(crisp{3} == target_class_label & crisp_wo_certifier{10} > precision_thr);
disp(['# of valid node in class 13: ']);
size(selected_crisp)

mesh_objects_cum = calcCDF(selected_mesh_objects, MAX_RANGE, num_objects_in_gt) * 100;
khronos_cum = calcCDF(selected_khronos, MAX_RANGE, num_objects_in_gt) * 100;
crisp_wo_certifier_cum = calcCDF(selected_crisp_wo_cert, MAX_RANGE, num_objects_in_gt) * 100;
crisp_cum = calcCDF(selected_crisp, MAX_RANGE, num_objects_in_gt) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_b_iou = mesh_objects{7}(mesh_objects{3} == target_class_label);
m_v_iou = mesh_objects{8}(mesh_objects{3} == target_class_label);
k_b_iou = khronos{7}(khronos{3} == target_class_label);
k_v_iou = khronos{8}(khronos{3} == target_class_label);
c_b_iou = crisp_wo_certifier{7}(crisp_wo_certifier{3} == target_class_label);
c_v_iou = crisp_wo_certifier{8}(crisp_wo_certifier{3} == target_class_label);
c_w_filtering_b_iou = crisp{7}(crisp{3} == target_class_label & crisp{10} > precision_thr);
c_w_filtering_v_iou = crisp{8}(crisp{3} == target_class_label & crisp{10} > precision_thr);
disp("For class:" + target_class_label);
fprintf("Hydra:         B-IoU = %.3f, v-IoU = %.3f\n", mean(m_b_iou), mean(m_v_iou));
fprintf("Khronos:       B-IoU = %.3f, v-IoU = %.3f\n", mean(k_b_iou), mean(k_v_iou));
fprintf("Ours w/o RMCC:B-IoU = %.3f, v-IoU = %.3f\n", mean(c_b_iou), mean(c_v_iou));
fprintf("Ours:          B-IoU = %.3f, v-IoU = %.3f\n", mean(c_w_filtering_b_iou), mean(c_w_filtering_v_iou));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x_linspace, mesh_objects_cum, '-.^', 'Color', LineColors(3, :), "MarkerSize", markerSize, ...
    'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
hold on;
plot(x_linspace, khronos_cum, '--d', 'Color',  LineColors(1, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
plot(x_linspace, crisp_wo_certifier_cum,'-s', 'Color', LineColors(4, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
plot(x_linspace, crisp_cum, '-o', 'Color', LineColors(2, :), "MarkerSize", markerSize, 'LineWidth', lindwidth, 'MarkerIndices',1:2:length(x_linspace));
lgd = legend({'Hydra','Khronos', 'Ours w/o RMCC', 'Ours'},'Location','southeast','NumColumns',1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;
set(gca, 'FontSize', ticksFontSize);

xlabel('Chamfer distance [m$^2$]', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", YLabelFontSize, "Interpreter", 'latex')

%% Save (class13)
exportgraphics(gcf, "imgs/cdf_for_chamfer_distance_class13.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/cdf_for_chamfer_distance_class13.pdf', 'ContentType', 'vector');


%% Input data (class18)
% Uses mesh_objects, khronos, crisp_wo_certifier, crisp loaded above.

%% Drawing parameters (class18)
MAX_RANGE = 0.5;
INTERVAL = 100;
lindwidth = 2.5;
markerSize = 15;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;
precision_thr = 0.21;
IMAGE_WIDTH = 500;
IMAGE_HEIGHT = 450;

%% Plot (class18)
%% Class 18
figure("name", "Class 18 (bin)", 'Position', [700, 1500, IMAGE_WIDTH, IMAGE_HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
% Update this label
target_class_label = 18;
num_objects_in_gt = 31;

gap = MAX_RANGE / num_objects_in_gt;
x_linspace = 0:gap:MAX_RANGE;

selected_mesh_objects = mesh_objects{4}(mesh_objects{3} == target_class_label);
selected_khronos = khronos{4}(khronos{3} == target_class_label);
selected_crisp_wo_cert = crisp_wo_certifier{4}(crisp_wo_certifier{3} == target_class_label);
selected_crisp = crisp{4}(crisp{3} == target_class_label & crisp_wo_certifier{10} > precision_thr);
disp(['# of valid node in class 18: ']);
size(selected_crisp)

mesh_objects_cum = calcCDF(selected_mesh_objects, MAX_RANGE, num_objects_in_gt) * 100;
khronos_cum = calcCDF(selected_khronos, MAX_RANGE, num_objects_in_gt) * 100;
crisp_wo_certifier_cum = calcCDF(selected_crisp_wo_cert, MAX_RANGE, num_objects_in_gt) * 100;
crisp_cum = calcCDF(selected_crisp, MAX_RANGE, num_objects_in_gt) * 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_b_iou = mesh_objects{7}(mesh_objects{3} == target_class_label);
m_v_iou = mesh_objects{8}(mesh_objects{3} == target_class_label);
k_b_iou = khronos{7}(khronos{3} == target_class_label);
k_v_iou = khronos{8}(khronos{3} == target_class_label);
c_b_iou = crisp_wo_certifier{7}(crisp_wo_certifier{3} == target_class_label);
c_v_iou = crisp_wo_certifier{8}(crisp_wo_certifier{3} == target_class_label);
c_w_filtering_b_iou = crisp{7}(crisp{3} == target_class_label & crisp{10} > precision_thr);
c_w_filtering_v_iou = crisp{8}(crisp{3} == target_class_label & crisp{10} > precision_thr);
disp("For class:" + target_class_label);
fprintf("Hydra:         B-IoU = %.3f, v-IoU = %.3f\n", mean(m_b_iou), mean(m_v_iou));
fprintf("Khronos:       B-IoU = %.3f, v-IoU = %.3f\n", mean(k_b_iou), mean(k_v_iou));
fprintf("Ours w/o RMCC:B-IoU = %.3f, v-IoU = %.3f\n", mean(c_b_iou), mean(c_v_iou));
fprintf("Ours:          B-IoU = %.3f, v-IoU = %.3f\n", mean(c_w_filtering_b_iou), mean(c_w_filtering_v_iou));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x_linspace, mesh_objects_cum, '-.^', 'Color', LineColors(3, :), "MarkerSize", markerSize, ...
    'LineWidth', lindwidth, 'MarkerIndices',1:3:length(x_linspace));
hold on;
plot(x_linspace, khronos_cum, '--d', 'Color',  LineColors(1, :), ...
    "MarkerSize", markerSize, 'LineWidth', lindwidth, ...
    'MarkerIndices',1:3:length(x_linspace));
plot(x_linspace, crisp_wo_certifier_cum,'-s', 'Color', LineColors(4, :), ...
    "MarkerSize", markerSize, 'LineWidth', lindwidth, ...
    'MarkerIndices',1:3:length(x_linspace));
plot(x_linspace, crisp_cum, '-o', 'Color', LineColors(2, :), ...
    "MarkerSize", markerSize, 'LineWidth', lindwidth, ...
    'MarkerIndices',1:3:length(x_linspace));

lgd = legend({'Hydra','Khronos', 'Ours w/o RMCC', 'Ours'}, ...
    'Location','southeast','NumColumns',1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;
set(gca, 'FontSize', ticksFontSize);

xlabel('Chamfer distance [m$^2$]', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", YLabelFontSize, "Interpreter", 'latex')

%% Save (class18)
exportgraphics(gcf, "imgs/cdf_for_chamfer_distance_class18.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/cdf_for_chamfer_distance_class18.pdf', 'ContentType', 'vector');
