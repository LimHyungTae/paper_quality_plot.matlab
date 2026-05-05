%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

%% Input data (precision)
% === Data from tables (tolerance 0.1 ~ 0.5) ===
tolerance = 10:5:50;

% SAM3D w/o RMCC
prec_sam3d_wo = [ ...
0.0000
0.0833
0.1667
0.2222
0.2778
0.3611
0.5000
0.6389
0.6944
];

% SAM3D
prec_sam3d = [ ...
0.0000
0.0189
0.0566
0.1321
0.1321
0.1887
0.2453
0.3208
0.4151
];

% CRISP w/o RMCC
prec_crisp_wo = [0.2881 0.4661 0.5678 0.6525 0.6780 0.7119 0.7373 0.7712 0.7881];

% CRISP
prec_crisp = [0.3708 0.6067 0.7416 0.8315 0.8539 0.8764 0.8876 0.9326 0.9551];

% SlideSLAM†
% prec_slide_dag = [0.0000 0.1765 0.1765 0.2353 0.4118 0.4706 0.7647 0.7941 0.7941];

%% Drawing parameters (precision)
linewidth = 3;
markerSize = 20;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 32;
YLabelFontSize = 28;

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (precision)
figure('Name','Precision','Position',[50 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

%plot(tolerance, prec_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, prec_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_sam3d_wo,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
hold on;
plot(tolerance, prec_sam3d,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_crisp_wo,'-s','Color',LineColors(6,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_crisp,'-o','Color',LineColors(5,:),'MarkerSize',markerSize,'LineWidth',linewidth);

xlabel('Normalized threshold $\kappa$ [\%]','FontSize',XLabelFontSize,'Interpreter','latex');
ylabel('Precision\,($\uparrow$)','FontSize',YLabelFontSize,'Interpreter','latex');
legend({'SAM3D w/o RMCC','SAM3D','CRISP w/o RMCC','CRISP'}, ...
    'Location','southeast','FontSize',LegendFontSize);
grid on; box on;
set(gca, 'FontSize', ticksFontSize);

%% Save (precision)
exportgraphics(gcf, "imgs/hydra2_0_precision.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/hydra2_0_precision.pdf', 'ContentType', 'vector');

%% Input data (recall)
% === Data from tables (tolerance 0.1 ~ 0.5) ===
tolerance = 10:5:50;

% SAM3D w/o RMCC
rec_sam3d_wo = [ ...
0.0341
0.0795
0.1250
0.1591
0.1932
0.2727
0.3295
0.3523
0.3523
];

% SAM3D
rec_sam3d = [ ...
0.0227
0.0455
0.0795
0.1136
0.1364
0.2273
0.3182
0.3295
0.4318
];

% CRISP w/o RMCC
rec_crisp_wo  = [0.2841 0.4659 0.5455 0.6023 0.6136 0.6477 0.6477 0.6705 0.6818];

% CRISP
rec_crisp  = [0.2727 0.4545 0.5341 0.5909 0.6023 0.6364 0.6364 0.6591 0.6705];

% SlideSLAM†
% rec_slide_dag  = [0.0000 0.0635 0.0635 0.0952 0.1270 0.1429 0.2222 0.2222 0.2222];

%% Drawing parameters (recall)
linewidth = 3;
markerSize = 20;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 32;
YLabelFontSize = 28;

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (recall)
figure('Name','Recall','Position',[550 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

%plot(tolerance, rec_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, rec_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, rec_sam3d_wo,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
hold on;
plot(tolerance, rec_sam3d,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, rec_crisp_wo,'-s','Color',LineColors(6,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, rec_crisp,'-o','Color',LineColors(5,:),'MarkerSize',markerSize,'LineWidth',linewidth);

xlabel('Normalized threshold $\kappa$ [\%]','FontSize',XLabelFontSize,'Interpreter','latex');
ylabel('Recall\,($\uparrow$)','FontSize',YLabelFontSize,'Interpreter','latex');
%legend({'SlideSLAM','Hydra','Khronos','Ours w/o RMCC','Ours'}, ...
%    'Location','southeast','FontSize',LegendFontSize);
grid on; box on;
set(gca, 'FontSize', ticksFontSize);
ylim([0, 0.70])
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7])

%% Save (recall)
exportgraphics(gcf, "imgs/hydra2_0_recall.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/hydra2_0_recall.pdf', 'ContentType', 'vector');

%% Input data (f1)
% === Data from tables (tolerance 0.1 ~ 0.5) ===
tolerance = 10:5:50;

% SAM3D w/o RMCC
f1_sam3d_wo = [ ...
0.0000
0.0814
0.1429
0.1854
0.2279
0.3108
0.3973
0.4541
0.4674
];

% SAM3D
f1_sam3d = [ ...
0.0000
0.0267
0.0661
0.1222
0.1342
0.2062
0.2770
0.3251
0.4233
];

% CRISP w/o RMCC
f1_crisp_wo   = [0.2861 0.4660 0.5564 0.6264 0.6442 0.6783 0.6896 0.7173 0.7311];

% CRISP
f1_crisp   = [0.3143 0.5197 0.6210 0.6908 0.7064 0.7373 0.7413 0.7723 0.7878];

% SlideSLAM†
% f1_slide_dag   = [0      0.0934 0.0934 0.1356 0.1941 0.2192 0.3444 0.3473 0.3473];

%% Drawing parameters (f1)
linewidth = 3;
markerSize = 20;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 32;
YLabelFontSize = 28;

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

%% Plot (f1)
figure('Name','F1 Score','Position',[1390 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

%plot(tolerance, f1_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, f1_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_sam3d_wo,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
hold on;
plot(tolerance, f1_sam3d,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_crisp_wo,'-s','Color',LineColors(6,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_crisp,'-o','Color',LineColors(5,:),'MarkerSize',markerSize,'LineWidth',linewidth);

xlabel('Normalized threshold $\kappa$ [\%]','FontSize',XLabelFontSize,'Interpreter','latex');
ylabel('F1 Score\,($\uparrow$)','FontSize',YLabelFontSize,'Interpreter','latex');
%legend({'SlideSLAM','Hydra','Khronos','Ours w/o RMCC','Ours'}, ...
%    'Location','southeast','FontSize',LegendFontSize);
grid on;  box on;
set(gca, 'FontSize', ticksFontSize);

%% Save (f1)
exportgraphics(gcf, "imgs/hydra2_0_f1.png", 'Resolution', 300);
exportgraphics(gcf, 'imgs/hydra2_0_f1.pdf', 'ContentType', 'vector');
