clc; clear; close all;

%% === Data from tables (tolerance 0.1 ~ 0.5) ===
tolerance = 10:5:50;

% Hydra
prec_hydra = [0.1264 0.2644 0.3793 0.5057 0.5747 0.5977 0.6667 0.7471 0.8161];
rec_hydra  = [0.1136 0.2159 0.3295 0.4205 0.4432 0.4545 0.5114 0.5682 0.6364];
f1_hydra   = [0.1197 0.2377 0.3527 0.4592 0.5004 0.5164 0.5788 0.6455 0.7151];

% Khronos
prec_khronos = [0.2029 0.2464 0.2754 0.3478 0.4928 0.5797 0.6812 0.7971 0.8406];
rec_khronos  = [0.1477 0.1705 0.1818 0.2159 0.3182 0.3750 0.4205 0.4659 0.5000];
f1_khronos   = [0.1710 0.2015 0.2190 0.2664 0.3867 0.4554 0.5200 0.5881 0.6270];

% CRISP w/o RMCC
prec_crisp_wo = [0.2881 0.4661 0.5678 0.6525 0.6780 0.7119 0.7373 0.7712 0.7881];
rec_crisp_wo  = [0.2841 0.4659 0.5455 0.6023 0.6136 0.6477 0.6477 0.6705 0.6818];
f1_crisp_wo   = [0.2861 0.4660 0.5564 0.6264 0.6442 0.6783 0.6896 0.7173 0.7311];

% CRISP
prec_crisp = [0.3708 0.6067 0.7416 0.8315 0.8539 0.8764 0.8876 0.9326 0.9551];
rec_crisp  = [0.2727 0.4545 0.5341 0.5909 0.6023 0.6364 0.6364 0.6591 0.6705];
f1_crisp   = [0.3143 0.5197 0.6210 0.6908 0.7064 0.7373 0.7413 0.7723 0.7878];

% SlideSLAM†
% prec_slide_dag = [0.0000 0.1765 0.1765 0.2353 0.4118 0.4706 0.7647 0.7941 0.7941];
% rec_slide_dag  = [0.0000 0.0635 0.0635 0.0952 0.1270 0.1429 0.2222 0.2222 0.2222];
% f1_slide_dag   = [0      0.0934 0.0934 0.1356 0.1941 0.2192 0.3444 0.3473 0.3473];

% SlideSLAM
prec_slide = [0.0000 0.1765 0.1765 0.2353 0.4118 0.4706 0.7647 0.7941 0.7941];
rec_slide  = [0.0000 0.0455 0.0455 0.0682 0.0909 0.1023 0.1591 0.1591 0.1591];
f1_slide   = [0      0.0723 0.0723 0.1057 0.1489 0.1680 0.2634 0.2651 0.2651];

%% === Plot style parameters ===
linewidth = 3;
markerSize = 20;
LegendFontSize = 20;
ticksFontSize = 20;
XLabelFontSize = 32;  
YLabelFontSize = 28;

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

%% === Plot Precision ===
figure('Name','Precision','Position',[50 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

plot(tolerance, prec_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, prec_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_hydra,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_khronos,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_crisp_wo,'-s','Color',LineColors(6,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, prec_crisp,'-o','Color',LineColors(5,:),'MarkerSize',markerSize,'LineWidth',linewidth);

xlabel('Normalized threshold $\kappa$ [\%]','FontSize',XLabelFontSize,'Interpreter','latex');
ylabel('Precision\,($\uparrow$)','FontSize',YLabelFontSize,'Interpreter','latex');
legend({'SlideSLAM','Hydra','Khronos','Ours w/o RMCC','Ours'}, ...
    'Location','southeast','FontSize',LegendFontSize);
grid on; box on;
set(gca, 'FontSize', ticksFontSize);

print(gcf, "imgs/hydra2_0_precision.png",'-dpng','-r300');
% print -depsc 'imgs/hydra2_0_precision.eps'
exportgraphics(gcf, 'imgs/hydra2_0_precision.pdf', 'ContentType', 'vector');

%% === Plot Recall ===
figure('Name','Recall','Position',[550 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

plot(tolerance, rec_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, rec_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, rec_hydra,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, rec_khronos,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
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
print(gcf, "imgs/hydra2_0_recall.png",'-dpng','-r300');
% print -depsc 'imgs/hydra2_0_recall.eps'
exportgraphics(gcf, 'imgs/hydra2_0_recall.pdf', 'ContentType', 'vector');

%% === Plot F1 ===
figure('Name','F1 Score','Position',[1390 50 500 500]);
set(gca,'FontSize',ticksFontSize,'LooseInset',max(get(gca,'TightInset'),0.02));

plot(tolerance, f1_slide,':h','Color',LineColors(1,:),'MarkerSize',markerSize,'LineWidth',linewidth); hold on;
% plot(tolerance, f1_slide_dag,':p','Color',LineColors(2,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_hydra,'-.^','Color',LineColors(7,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_khronos,'--d','Color',LineColors(4,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_crisp_wo,'-s','Color',LineColors(6,:),'MarkerSize',markerSize,'LineWidth',linewidth);
plot(tolerance, f1_crisp,'-o','Color',LineColors(5,:),'MarkerSize',markerSize,'LineWidth',linewidth);

xlabel('Normalized threshold $\kappa$ [\%]','FontSize',XLabelFontSize,'Interpreter','latex');
ylabel('F1 Score\,($\uparrow$)','FontSize',YLabelFontSize,'Interpreter','latex');
%legend({'SlideSLAM','Hydra','Khronos','Ours w/o RMCC','Ours'}, ...
%    'Location','southeast','FontSize',LegendFontSize);
grid on;  box on;
set(gca, 'FontSize', ticksFontSize);

print(gcf, "imgs/hydra2_0_f1.png",'-dpng','-r300');
% print -depsc 'imgs/hydra2_0_f1.eps'
exportgraphics(gcf, 'imgs/hydra2_0_f1.pdf', 'ContentType', 'vector');
