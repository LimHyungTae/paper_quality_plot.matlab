%% CDF
clc
close all;
clear all;

%% Color parameter
num_objects = 4; 
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);

%% Load output file
% Mesh objects
fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__mesh_objects__ALIGNED_ROBOTS/dists_for_precision.txt', 'r');
precision_data_mesh_objects = textscan(fileID, '%s %s %f %f');
fclose(fileID);

fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__mesh_objects__ALIGNED_ROBOTS/dists_for_recall.txt', 'r');
recall_data_mesh_objects = textscan(fileID, '%s %s %f %f');
fclose(fileID);

% Khronos
fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__khronos__ALIGNED_ROBOTS/dists_for_precision.txt', 'r');
precision_data_khronos = textscan(fileID, '%s %s %f %f');
fclose(fileID);

fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__khronos__ALIGNED_ROBOTS/dists_for_recall.txt', 'r');
recall_data_khronos = textscan(fileID, '%s %s %f %f');
fclose(fileID);

% CRISP w/o Verification
fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp_wo_cert__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
precision_data_crisp_wo_verif = textscan(fileID, '%s %s %f %f %f %f');
fclose(fileID);

fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp_wo_cert__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
recall_data_crisp_wo_verif = textscan(fileID, '%s %s %f %f');
fclose(fileID);

% CRISP
fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp_wo_cert__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
precision_data_crisp = textscan(fileID, '%s %s %f %f %f %f');
fclose(fileID);

fileID = fopen('/home/shapelim/multi_ws/src/hydra_multi_system/hydra_multi_evaluation/scripts/results/0804_w_gt_w_plants/uhumans2__crisp__ALIGNED_ROBOTS/chamfer_distances.txt', 'r');
recall_data_crisp = textscan(fileID, '%s %s %f %f');
fclose(fileID);


disp("Loading data complete!");
%% Plot parameters;
MAX_RANGE = 0.5; 
INTERVAL = 100;   
linewidth = 2.5;
markerSize = 15; 
LegendFontSize = 20;
ticksFontSIze = 20;
XLabelFontSize = 20;  YLabelFontSize = 20;

%% === Threshold linspace ===
thresholds = linspace(0, MAX_RANGE, INTERVAL + 1);

%% === Compute PR Curves ===
[prec_mesh, rec_mesh] = compute_precision_recall( ...
    precision_data_mesh_objects{4}, recall_data_mesh_objects{4}, thresholds);
[prec_khronos, rec_khronos] = compute_precision_recall( ...
    precision_data_khronos{4}, recall_data_khronos{4}, thresholds);
[prec_crisp_wo, rec_crisp_wo] = compute_precision_recall( ...
    precision_data_crisp_wo_verif{4}, recall_data_crisp_wo_verif{4}, thresholds);
[prec_crisp, rec_crisp] = compute_precision_recall( ...
    precision_data_crisp{4}, recall_data_crisp{4}, thresholds);

%% === Plot PR Curve ===
figure("name", "Precision-Recall", 'Position', [50, 50, 500, 500]);
set(gca, 'LooseInset', max(get(gca, 'TightInset'), 0.02));
set(gca, 'FontSize', ticksFontSIze);
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');

plot(rec_mesh, prec_mesh, '-.^', 'Color', LineColors(3, :), ...
    'MarkerSize', markerSize, 'LineWidth', linewidth, 'MarkerIndices', 1:8:length(thresholds));
hold on;
plot(rec_khronos, prec_khronos, '--d', 'Color', LineColors(1, :), ...
    'MarkerSize', markerSize, 'LineWidth', linewidth, 'MarkerIndices', 1:8:length(thresholds));
plot(rec_crisp_wo, prec_crisp_wo, '-s', 'Color', LineColors(4, :), ...
    'MarkerSize', markerSize, 'LineWidth', linewidth, 'MarkerIndices', 1:8:length(thresholds));
plot(rec_crisp, prec_crisp, '-o', 'Color', LineColors(2, :), ...
    'MarkerSize', markerSize, 'LineWidth', linewidth, 'MarkerIndices', 1:8:length(thresholds));

lgd = legend({'Hydra','Khronos', 'Ours w/o Cert.', 'Ours'}, ...
    'Location', 'southwest', 'NumColumns', 1, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;

xlabel('Recall', 'FontSize', XLabelFontSize, 'Interpreter', 'latex');
ylabel('Precision', 'FontSize', YLabelFontSize, 'Interpreter', 'latex');

% 저장 경로가 없으면 생성
if ~exist('imgs', 'dir')
    mkdir('imgs');
end

print(gcf, "imgs/precision_recall_curve.png", '-dpng', '-r300');
exportgraphics(gcf, 'imgs/precision_recall_curve.pdf', 'ContentType', 'vector');

%% === Compute F1 scores (per threshold) ===
epsv = 1e-12;
f1_mesh     = 2 .* (prec_mesh .* rec_mesh)       ./ (prec_mesh + rec_mesh + epsv);
f1_khronos  = 2 .* (prec_khronos .* rec_khronos) ./ (prec_khronos + rec_khronos + epsv);
f1_crisp_wo = 2 .* (prec_crisp_wo .* rec_crisp_wo) ./ (prec_crisp_wo + rec_crisp_wo + epsv);
f1_crisp    = 2 .* (prec_crisp .* rec_crisp)     ./ (prec_crisp + rec_crisp + epsv);

% 각 방법의 최대 F1과 해당 지점(Recall, Precision, threshold) 추출
[bestF1_mesh,     i_mesh]     = max(f1_mesh);     th_mesh     = thresholds(i_mesh);
[bestF1_khronos,  i_khronos]  = max(f1_khronos);  th_khronos  = thresholds(i_khronos);
[bestF1_crisp_wo, i_crisp_wo] = max(f1_crisp_wo); th_crisp_wo = thresholds(i_crisp_wo);
[bestF1_crisp,    i_crisp]    = max(f1_crisp);    th_crisp    = thresholds(i_crisp);

% 최대 F1 지점에 강조 마커 추가 (선택)
plot(rec_mesh(i_mesh),         prec_mesh(i_mesh),         'p', 'MarkerSize', markerSize+2, 'LineWidth', linewidth, 'Color', LineColors(3,:));
plot(rec_khronos(i_khronos),   prec_khronos(i_khronos),   'p', 'MarkerSize', markerSize+2, 'LineWidth', linewidth, 'Color', LineColors(1,:));
plot(rec_crisp_wo(i_crisp_wo), prec_crisp_wo(i_crisp_wo), 'p', 'MarkerSize', markerSize+2, 'LineWidth', linewidth, 'Color', LineColors(4,:));
plot(rec_crisp(i_crisp),       prec_crisp(i_crisp),       'p', 'MarkerSize', markerSize+2, 'LineWidth', linewidth, 'Color', LineColors(2,:));

% F1을 포함한 범례로 교체
lgd = legend({ ...
    sprintf('Hydra (F1=%.3f @ th=%.3g)',     bestF1_mesh,     th_mesh), ...
    sprintf('Khronos (F1=%.3f @ th=%.3g)',   bestF1_khronos,  th_khronos), ...
    sprintf('Ours w/o Cert. (F1=%.3f @ th=%.3g)', bestF1_crisp_wo, th_crisp_wo), ...
    sprintf('Ours (F1=%.3f @ th=%.3g)',      bestF1_crisp,    th_crisp) ...
}, 'Location','southwest','NumColumns',1,'fontsize',LegendFontSize);
lgd.Interpreter = 'latex';

figure("name","F1 vs Threshold",'Position',[580, 50, 500, 500]);
set(gca,'FontSize',ticksFontSIze);
plot(thresholds, f1_mesh,     '-.^','LineWidth',linewidth); hold on;
plot(thresholds, f1_khronos,  '--d','LineWidth',linewidth);
plot(thresholds, f1_crisp_wo, '-s','LineWidth',linewidth);
plot(thresholds, f1_crisp,    '-o','LineWidth',linewidth);
grid on; xlabel('Threshold','Interpreter','latex','FontSize',XLabelFontSize);
ylabel('F1','Interpreter','latex','FontSize',YLabelFontSize);
legend({'Hydra','Khronos','Ours w/o Cert.','Ours'},'Location','southwest','fontsize',LegendFontSize,'Interpreter','latex');

if ~exist('imgs','dir'); mkdir('imgs'); end
print(gcf,"imgs/f1_vs_threshold.png",'-dpng','-r300');
exportgraphics(gcf,'imgs/f1_vs_threshold.pdf','ContentType','vector');

%%
% 찾고 싶은 threshold 값
target_th = 0.1;

% thresholds 벡터에서 target_th와 가장 가까운 인덱스
[~, idx] = min(abs(thresholds - target_th));

% 해당 인덱스의 F1 값 출력
f1_at_01_mesh     = f1_mesh(idx);
f1_at_01_khronos  = f1_khronos(idx);
f1_at_01_crisp_wo = f1_crisp_wo(idx);
f1_at_01_crisp    = f1_crisp(idx);

fprintf('Hydra    F1 at t=0.1: %.4f\n', f1_at_01_mesh);
fprintf('Khronos  F1 at t=0.1: %.4f\n', f1_at_01_khronos);
fprintf('Ours w/o Cert. F1 at t=0.1: %.4f\n', f1_at_01_crisp_wo);
fprintf('Ours     F1 at t=0.1: %.4f\n', f1_at_01_crisp);

%% === Precision-Recall 함수 정의 ===
function [precisions, recalls] = compute_precision_recall(dist_pred, dist_gt, thresholds)
    N_pred = length(dist_pred);
    N_gt = length(dist_gt);
    precisions = zeros(size(thresholds));
    recalls = zeros(size(thresholds));

    for i = 1:length(thresholds)
        t = thresholds(i);
        precisions(i) = sum(dist_pred <= t) / N_pred;
        recalls(i)    = sum(dist_gt <= t) / N_gt;
    end
end