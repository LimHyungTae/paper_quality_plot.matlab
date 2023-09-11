%gicp = load("errors.mat");
% mean(e_rot_deg_per_m)
% mean(e_trans_perc)

%% Set parameters & Data processing
clc; clear all; close all;
alg = "SONNY";
target = "5";
seq = "00";
% target_path = "/home/beom/Downloads/MATLAB/src_kitti_loop_degeneracy_v2/";
target_path = "/home/beom/Downloads/MATLAB/For_BarPlot/";
sub_path = "/10_to_12";
%%
%%%%%%%%%%%%%%%%%%%
t_thr = 2.0;
r_thr = 10.0;
%%%%%%%%%%%%%%%%%%%
t_s_list= [];
q_s_list= [];

s_lists = [];

t_degen_s_list= [];
q_degen_s_list= [];
degen_s_lists = [];
degen_ground_s_lists = [];

RANSAC_lists =[];
FGR_lists =[];
TEASER_lists =[];
Quatro_lists =[];
%%
rs=[];
fs = [];
ts = [];
qs = [];
rgs = [];
fgs = [];
tgs = [];
qgs = [];

for seq = ["00", "02", "05", "06", "07", "08"]  % ,"09"]
    %f_path = target_path + seq + sub_path + "/FGR_5_abs_errors.txt"; 
    %t_path = target_path + seq + sub_path + "/TEASER_5_abs_errors.txt"; 
    %q_path = target_path + seq + sub_path + "/SONNY_5_abs_errors.txt";
    
    f_path = target_path + "FGR/" + seq + sub_path + "/FGR_abs_errors.txt"; 
    t_path = target_path + "TEASER++/" + seq + sub_path + "/TEASER_abs_errors.txt"; 
    q_path = target_path + "Quatro/" + seq + sub_path + "/Quatro_abs_errors.txt"; 
    r_path = target_path + "RANSAC/" + seq + sub_path + "/RANSAC_abs_errors.txt"; 
    
    qg_path = target_path + "Quatro_GroundRemoval/" + seq + sub_path + "/Quatro-plusplus_abs_errors.txt"; 
    fg_path = target_path + "FGR_GroundRemoval/" + seq + sub_path + "/FGR_abs_errors.txt"; 
    tg_path = target_path + "TEASER++_GroundRemoval/" + seq + sub_path + "/TEASER_abs_errors.txt"; 
    rg_path = target_path + "RANSAC_GroundRemoval/" + seq + sub_path + "/RANSAC_abs_errors.txt"; 

    f = load(f_path);
    t = load(t_path);
    q = load(q_path);
    r = load(r_path);
    
    fg = load(fg_path);
    tg = load(tg_path);
    qg = load(qg_path);
    rg = load(rg_path);
    
    f(isnan(f)) = 0;
    t(isnan(t)) = 0;
    q(isnan(q)) = 0;
    r(isnan(r)) =0;
    
    fg(isnan(fg)) = 0;
    tg(isnan(tg)) = 0;
    qg(isnan(qg)) = 0;
    rg(isnan(rg)) =0;
    
    % txt = seq + sprintf(' | %.2f vs %.2f\n',  mean(t(1:end, 5:6)), std(t(1:end, 5:6)), mean(q(1:end, 5:6)), std(q(1:end, 5:6)));
    
    fs = [fs; f(1:end, 5:6)];
    ts = [ts; t(1:end, 5:6)];
    qs = [qs; q(1:end, 5:6)];
    rs = [rs; r(1:end, 5:6)];
    
    fgs = [fgs; fg(1:end, 5:6)];
    tgs = [tgs; tg(1:end, 5:6)];
    qgs = [qgs; qg(1:end, 5:6)];
    rgs = [rgs; rg(1:end, 5:6)];
    
%     disp(txt);
%     t = t(, 1:end);
%     q = q(, 1:end);
    
    % DATA:
    % src idx, tgt idx, ts_gt, rot_gt, ts_error, rot_error, num. max cliques,
    % Inliers among m.c., Quasi Inliers among m.c., rot inliers, final inliers 
    
    t_succ = get_success_rate(t, t_thr, r_thr);
    tg_succ = get_success_rate(tg, t_thr, r_thr);
    q_succ = get_success_rate(q, t_thr, r_thr);
    qg_succ = get_success_rate(qg, t_thr, r_thr);
    
% 02 sequence tg_succ : 90.6 -> 91.0
% 06 sequence tg_succ : 99.8 -> 99.9
    
    s_list = [t_succ, tg_succ, q_succ, qg_succ];
    s_lists = [s_lists; s_list];
    
    %% Filtered results
    % 1. num. est. rot. inliers
%     criteria_t = t(1:end, end-1);
%     criteria_q = q(1:end, end-1);
    
    % 2. num. inliers
    criteria_t = t(1:end, 8) + t(1:end, 9);
    criteria_tg = tg(1:end, 8) + tg(1:end, 9);
    criteria_q = q(1:end, 8) + q(1:end, 9);
    criteria_qg = qg(1:end, 8) + qg(1:end, 9);
    
    num_inlier_thr = 2;
%     f_degeneracy = f( (criteria_t > num_inlier_thr) & (criteria_tg > num_inlier_thr) & (criteria_q > num_inlier_thr) & (criteria_qg > num_inlier_thr) , 1:end);
%     r_degeneracy = r( (criteria_t > num_inlier_thr) & (criteria_tg > num_inlier_thr) & (criteria_q > num_inlier_thr) & (criteria_qg > num_inlier_thr) , 1:end);
%     fg_degeneracy = fg( (criteria_t > num_inlier_thr) & (criteria_tg > num_inlier_thr) & (criteria_q > num_inlier_thr) & (criteria_qg > num_inlier_thr) , 1:end);
%     rg_degeneracy = rg( (criteria_t > num_inlier_thr) & (criteria_tg > num_inlier_thr) & (criteria_q > num_inlier_thr) & (criteria_qg > num_inlier_thr) , 1:end);
%     
    f_degeneracy = f;
    r_degeneracy = r;
    fg_degeneracy = fg;
    rg_degeneracy = rg;

%     t_degeneracy = t(criteria_t > num_inlier_thr, 1:end);
%     tg_degeneracy = tg(criteria_tg > num_inlier_thr, 1:end);
%     q_degeneracy = q(criteria_q > num_inlier_thr, 1:end);
%     qg_degeneracy = qg(criteria_qg > num_inlier_thr, 1:end);

    t_degeneracy = t;
    tg_degeneracy = tg;
    q_degeneracy = q;
    qg_degeneracy = qg;
    
%     txt2 = seq + sprintf('[degen.] - mean | %.2f vs %.2f\n',  mean(t_degeneracy(1:end, 5:6)), mean(q_degeneracy(1:end, 5:6)));
%     disp(txt2);
%     txt3 = seq + sprintf('[degen.] - std | %.2f vs %.2f\n',  std(t_degeneracy(1:end, 5:6)), std(q_degeneracy(1:end, 5:6)));
%     disp(txt3);
    
    f_succ = get_success_rate(f_degeneracy, t_thr, r_thr);
    fg_succ = get_success_rate(fg_degeneracy, t_thr, r_thr);
    r_succ = get_success_rate(r_degeneracy, t_thr, r_thr);
    rg_succ = get_success_rate(rg_degeneracy, t_thr, r_thr);
    
%     fprintf('%f\n' , f_succ);
%     temp_succ = f_succ + 10.0;
    
    % remove to get filtered acc
    %t_succ = get_success_rate(t_degeneracy, t_thr, r_thr);
    %q_succ = get_success_rate(q_degeneracy, t_thr, r_thr);
    %qp_succ = get_success_rate(qp_degeneracy, t_thr, r_thr);
    
    degen_s_list = [r_succ, f_succ, t_succ, q_succ, qg_succ];
    degen_ground_s_list=[rg_succ, fg_succ, tg_succ ,qg_succ];
    
    RANSAC_list = [r_succ, rg_succ];
    FGR_list        = [f_succ, fg_succ];
    TEASER_list = [t_succ, tg_succ];
    Quatro_list   = [q_succ, qg_succ];
    
    degen_s_lists = [degen_s_lists; degen_s_list];
    degen_ground_s_lists = [degen_ground_s_lists; degen_ground_s_list];
    
    RANSAC_lists = [RANSAC_lists ; RANSAC_list];
    FGR_lists        = [FGR_lists        ; FGR_list];
    TEASER_lists = [TEASER_lists  ; TEASER_list];
    Quatro_lists   = [Quatro_lists    ; Quatro_list];

%     degen_s_lists_stack = [degen_s_lists,  degen_s_lists + 10]
    % add dimension to stack bar
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bar plot
common_fontsize = 15;

figure('Position', [300, 50, 600, 283]);
X = categorical({'\texttt{00}', '\texttt{02}', '\texttt{05}'});              % , '09'
% X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
X = reordercats(X,{'\texttt{00}', '\texttt{02}', '\texttt{05}'});           % , '09'

b = bar(X, degen_s_lists(1:3, : ),'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');

% legend({ 'RANSAC10K','FGR','TEASER++','Quatro (Ours)','Quatro++ (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');
% legend({ 'RANSAC','RASAC\_G','FGR','FGR_G','TEASER++', 'TEASER++_G','Quatro ','Quatro_G (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');

set(b(1), 'FaceColor', LineColors(3, :));
set(b(2), 'FaceColor', LineColors(7, :));
set(b(3), 'FaceColor', LineColors(6, :));
set(b(4), 'FaceColor', LineColors(5, :));
set(b(5), 'FaceColor', LineColors(1, :));

%% Modify text position 
margin_x = 0.015;
margin_y = 14.8;
upper_margin_y = 27.5;

margin = -2.5;

xtips1 = double( b(1).XEndPoints ) + margin_x;
ytips1 = double( b(1).YEndPoints - margin_y ); %+ margin;
labels1 = string(round(double(b(1).YData ), 4,'significant'));

ytips1 = ytips1+upper_margin_y;
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips2 = double( b(2).XEndPoints) + margin_x;
ytips2 = double( b(2).YEndPoints - margin_y); %+ margin;
labels2 = string(round(double( b(2).YData ), 4,'significant'));

labels2(1) = labels2(1) + ".0"; 

ytips2 = ytips2+upper_margin_y;
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips3 = double( b(3).XEndPoints )+ margin_x;
ytips3 = double( b(3).YEndPoints - margin_y); %+ margin;
labels3 = string(round(double( b(3).YData), 4,'significant'));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')


xtips4 = double( b(4).XEndPoints )+ margin_x;
ytips4 = double( b(4).YEndPoints - margin_y); %+ margin;
labels4 = string(round(double( b(4).YData), 4,'significant'));
labels4(3) = labels4(3) + ".0"; 
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips5 = double( b(5).XEndPoints )+ margin_x;
ytips5 = double( b(5).YEndPoints - margin_y); %+ margin;
labels5 = string(round(double( b(5).YData), 4,'significant'));
text(xtips5, ytips5, labels5,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

print(gcf, "SuccessRate1_quatro_pp.png",'-dpng','-r300'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
% figure('Position', [300, 50, 600, 283]);
% % 
% 
% X = categorical({'\texttt{00}', '\texttt{02}', '\texttt{05}'});              % , '09'
% % X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
% X = reordercats(X,{'\texttt{00}', '\texttt{02}', '\texttt{05}'});           % , '09'
% 
% b = bar(X, degen_s_lists(1:3, : ),'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists
% 
% linecolors = linspecer(7, 'qualitative');
% LineColors = flipud(linecolors);
% 
% yticks([0, 20, 40, 60, 80, 100]);
% ylim([0, 100]);
% 
% % set(gca, 'YScale', 'log')
% 
% set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
% set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(gca, 'FontSize', common_fontsize);
% % 
% xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
% ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');
% 
% legend({ 'RANSAC10K','FGR','TEASER++','Quatro (Ours)','Quatro++ (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');
% % legend({ 'RANSAC','RASAC\_G','FGR','FGR_G','TEASER++', 'TEASER++_G','Quatro ','Quatro_G (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');
% 
% set(b(1), 'FaceColor', LineColors(3, :));
% set(b(2), 'FaceColor', LineColors(7, :));
% set(b(3), 'FaceColor', LineColors(6, :));
% set(b(4), 'FaceColor', LineColors(5, :));
% set(b(5), 'FaceColor', LineColors(1, :));
% 
% margin_x = 0.015;
% margin_y = 14.8;
% upper_margin_y = 27.5;
% 
% margin = -2.5;
% 
% xtips1 = double( b(1).XEndPoints ) + margin_x;
% ytips1 = double( b(1).YEndPoints - margin_y ); %+ margin;
% labels1 = string(round(double(b(1).YData ), 4,'significant'));
% 
% ytips1 = ytips1+upper_margin_y;
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips2 = double( b(2).XEndPoints) + margin_x;
% ytips2 = double( b(2).YEndPoints - margin_y); %+ margin;
% labels2 = string(round(double( b(2).YData ), 4,'significant'));
% 
% labels2(1) = labels2(1) + ".0"; 
% 
% ytips2 = ytips2+upper_margin_y;
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips3 = double( b(3).XEndPoints )+ margin_x;
% ytips3 = double( b(3).YEndPoints - margin_y); %+ margin;
% labels3 = string(round(double( b(3).YData), 4,'significant'));
% text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% 
% xtips4 = double( b(4).XEndPoints )+ margin_x;
% ytips4 = double( b(4).YEndPoints - margin_y); %+ margin;
% labels4 = string(round(double( b(4).YData), 4,'significant'));
% labels4(3) = labels4(3) + ".0"; 
% text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips5 = double( b(5).XEndPoints )+ margin_x;
% ytips5 = double( b(5).YEndPoints - margin_y); %+ margin;
% labels5 = string(round(double( b(5).YData), 4,'significant'));
% text(xtips5, ytips5, labels5,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% print(gcf, "SuccessRate1.png",'-dpng','-r300'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Position', [300, 50, 600, 350]);
% 
X = categorical({'\texttt{06}', '\texttt{07}', '\texttt{08}'});              % , '09'
% X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
X = reordercats(X,{'\texttt{06}', '\texttt{07}', '\texttt{08}'});
% 
b = bar(X, degen_s_lists(4:6, : ),'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

% set(gca, 'YScale', 'log')

set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');

legend({ 'RANSAC','FGR','TEASER++','Quatro','Quatro++ (Proposed)'},'Location','southoutside', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');
% legend({ 'RANSAC','RASAC\_G'');
LineColors = flipud(linecolors);

yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

% set(gca, 'YScale', 'log')

set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');

legend({ 'RANSAC','FGR','TEASER++','Quatro','Quatro++ (Proposed)'},'Location','southoutside', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');
% legend({ 'RANSAC','RASAC\_G','FGR','FGR_G','TEASER++', 'TEASER++_G','Quatro ','Quatro_G (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');

set(b(1), 'FaceColor', LineColors(3, :));
set(b(2), 'FaceColor', LineColors(7, :));
set(b(3), 'FaceColor', LineColors(6, :));
set(b(4), 'FaceColor', LineColors(5, :));
set(b(5), 'FaceColor', LineColors(1, :));

xtips1 = double( b(1).XEndPoints ) + margin_x;
ytips1 = double( b(1).YEndPoints - margin_y ); %+ margin;
labels1 = string(round(double(b(1).YData ), 4,'significant'));
labels1(3) = labels1(3) + ".0"; 
ytips1 = ytips1+upper_margin_y;
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips2 = double( b(2).XEndPoints) + margin_x;
ytips2 = double( b(2).YEndPoints - margin_y); %+ margin;
labels2 = string(round(double( b(2).YData ), 4,'significant'));

ytips2 = ytips2+upper_margin_y;
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips3 = double( b(3).XEndPoints )+ margin_x;
ytips3 = double( b(3).YEndPoints - margin_y); %+ margin;
labels3 = string(round(double( b(3).YData), 4,'significant'));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips4 = double( b(4).XEndPoints )+ margin_x;
ytips4 = double( b(4).YEndPoints - margin_y); %+ margin;
labels4 = string(round(double( b(4).YData), 4,'significant'));
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

xtips5 = double( b(5).XEndPoints )+ margin_x;
ytips5 = double( b(5).YEndPoints - margin_y); %+ margin;
labels5 = string(round(double( b(5).YData), 4,'significant'));
labels5(1) = labels5(1) + ".0"; 
labels5(2) = labels5(2) + ".0"; 
text(xtips5, ytips5, labels5,'HorizontalAlignment','center',...
    'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

print(gcf, "SuccessRate2_quatro_pp.png",'-dpng','-r300'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = categorical({'\texttt{00}', '\texttt{02}', '\texttt{05}', '\texttt{06}', '\texttt{07}', '\texttt{08}'});              % , '09'
X = reordercats(X,{'\texttt{00}', '\texttt{02}', '\texttt{05}', '\texttt{06}', '\texttt{07}', '\texttt{08}'});           % , '09'

flip_thresh = 60;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RANSAC10K barplot

figure('Position', [300, 50, 600, 300]);
b2 = bar(X, RANSAC_lists,'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists

yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

% set(gca, 'YScale', 'log')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');
legend({'\texttt{w/o GS}','\texttt{w/ GS}'},'Location','northwest', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');
% southoutside

set(gca,'position',[0.11, 0.2, 0.87, 0.75])

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

set(b2(1), 'FaceColor', LineColors(3, :));
set(b2(2), 'FaceColor', [0.7550    0.8946    0.4722]);  %% LineColors(3, :) = [0.9550    0.8946    0.4722]

margin_x = 0.015;
margin_y = 14.8;
upper_margin_y = 24.5;

margin = -2.5;

% if the element of b2(2).YData is below 60percent, text should be located
% upper of the bar

xtips1 = double( b2(1).XEndPoints ) + margin_x;
ytips1 = double( b2(1).YEndPoints - margin_y ); %+ margin;
labels1 = string(round(double(b2(1).YData ), 4,'significant'));

xtips2 = double( b2(2).XEndPoints) + margin_x;
ytips2 = double( b2(2).YEndPoints - margin_y); %+ margin;
labels2 = string(round(double( b2(2).YData ), 4,'significant'));

labels1(6) = labels1(6) + ".0"; 
labels2(4) = labels2(4) + ".0"; 

% string(round(double( b2(1).YData +0.001 ), 4,'significant'))
% string( b2(1).YData +0.0001)

for i = 1:6
    if b2(1).YData(i) < flip_thresh
        ytips1 = ytips1+upper_margin_y;
        
        text(xtips1(i), ytips1(i), labels1(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        
        ytips1 = ytips1-upper_margin_y;
    elseif b2(1).YData(i) > flip_thresh
        text(xtips1(i), ytips1(i), labels1(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

for i = 1:6
    if b2(2).YData(i) < flip_thresh
        ytips2 = ytips2+upper_margin_y;
        text(xtips2(i), ytips2(i), labels2(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        ytips2 = ytips2-upper_margin_y;
    elseif b2(2).YData(i) > flip_thresh
        text(xtips2(i), ytips2(i), labels2(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

print(gcf, "RANSAC10K_success_rate.png",'-dpng','-r300'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FGR barplot

figure('Position', [300, 50, 600, 300]);

margin_x = 0.015;
margin_y = 14.8;
upper_margin_y = 24.5;

b3 = bar(X, FGR_lists,'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists
yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

% set(gca, 'YScale', 'log')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');
legend({'\texttt{w/o GS}','\texttt{w/ GS}'},'Location','northwest', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');

% % % set(gca,'position', [0.11, 0.3, 0.87, 0.65])
set(gca,'position',[0.11, 0.2, 0.87, 0.75])

set(b3(1), 'FaceColor', LineColors(7, :));
set(b3(2), 'FaceColor',  [0.9411, 0.4784, 0.4784]);

xtips1 = double( b3(1).XEndPoints ) + margin_x;
ytips1 = double( b3(1).YEndPoints - margin_y ); %+ margin;
labels1 = string(round(double(b3(1).YData ), 4,'significant'));

labels1(1) = labels1(1) + ".0"; 

xtips2 = double( b3(2).XEndPoints) + margin_x;
ytips2 = double( b3(2).YEndPoints - margin_y); %+ margin;
labels2 = string(round(double( b3(2).YData ), 4,'significant'));

labels2(2) = labels2(2) + ".0"; 

for i = 1:6
    if b3(1).YData(i) < flip_thresh
        ytips1 = ytips1+upper_margin_y;
        
        text(xtips1(i), ytips1(i), labels1(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        
        ytips1 = ytips1-upper_margin_y;
    elseif b3(1).YData(i) > flip_thresh
        text(xtips1(i), ytips1(i), labels1(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

for i = 1:6
    if b3(2).YData(i) < 60
        ytips2 = ytips2+upper_margin_y;
        text(xtips2(i), ytips2(i), labels2(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        ytips2 = ytips2-upper_margin_y;
    elseif b3(2).YData(i) > 60
        text(xtips2(i), ytips2(i), labels2(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

print(gcf, "FGR_success_rate.png",'-dpng','-r300'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEASER++ barplot
figure('Position', [300, 50, 600, 300]);

margin_x = 0.015;
margin_y = 14.8;
upper_margin_y = 24.5;

b4 = bar(X, TEASER_lists,'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists
yticks([0, 20, 40, 60, 80, 100]);
ylim([0, 100]);

% set(gca, 'YScale', 'log')
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(gca, 'FontSize', common_fontsize);

xlabel("Sequences", 'interpreter', 'latex', "FontSize", common_fontsize);
ylabel("Success rate [\%]", "FontSize", common_fontsize, 'interpreter', 'latex');
legend({'\texttt{w/o GS}','\texttt{w/ GS}'},'Location','southeast', 'NumColumns',3, 'fontsize', common_fontsize, 'interpreter', 'latex');

% % % set(gca,'position', [0.11, 0.3, 0.87, 0.65])
set(gca,'position',[0.11, 0.2, 0.87, 0.75])

set(b4(1), 'FaceColor', LineColors(6, :));
set(b4(2), 'FaceColor', [0.0941, 0.3447, 0.7494]);

xtips1 = double( b4(1).XEndPoints ) + margin_x;
ytips1 = double( b4(1).YEndPoints - margin_y ); %+ margin;
labels1 = string(round(double(b4(1).YData ), 4,'significant'));

xtips2 = double( b4(2).XEndPoints) + margin_x;
ytips2 = double( b4(2).YEndPoints - margin_y); %+ margin;
labels2 = string(round(double( b4(2).YData ), 4,'significant'));

labels2(3) = labels2(3) + ".0"; 

for i = 1:6
    if b4(1).YData(i) < flip_thresh
        ytips1 = ytips1+upper_margin_y;
        
        text(xtips1(i), ytips1(i), labels1(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        
        ytips1 = ytips1-upper_margin_y;
    elseif b4(1).YData(i) > flip_thresh
        text(xtips1(i), ytips1(i), labels1(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

for i = 1:6
    if b4(2).YData(i) < 60
        ytips2 = ytips2+upper_margin_y;
        text(xtips2(i), ytips2(i), labels2(i), 'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
        ytips2 = ytips2-upper_margin_y;
    elseif b4(2).YData(i) > 60
        text(xtips2(i), ytips2(i), labels2(i),'HorizontalAlignment','center',...
            'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    end
end

print(gcf, "TEASER_success_rate.png",'-dpng','-r300'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create original plot
% figure('Position', [500, 300, 800, 500]);
% fH = gcf; 
% colormap(jet(4));

% X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
% X = reordercats(X,{'00', '02', '05', '06', '07', '08'});           % , '09'

% h = (rand(3, 4));
% b = bar(X, degen_s_lists ,'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists

% lgd = legend({ 'RANSAC','FGR','TEASER++','Quatro','RASAC_G', 'FGR_G','TEASER++_G ','Quatro_G (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');

% lgd = legend({ 'RANSAC','RASAC_G','FGR','FGR_G','TEASER++', 'TEASER++_G','Quatro ','Quatro_G (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');


% yticks([0, 20, 40, 60, 80, 100]);
% ylim([10, 120]);
% yticks([95, 100]);
% set(gca, 'YScale', 'log')
% set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
% set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(gca, 'FontSize', 13);
% 
% xlabel("Sequences", 'interpreter', 'latex', "FontSize", 20);
% ylabel("Success Rate [\%]", "FontSize", 15, 'interpreter', 'latex');

% margin_x = 0.015;
% margin_y = 1.2;
% margin = -2.5;
% common_fontsize = 12;
% xtips1 = b(1).XEndPoints + margin_x;
% ytips1 = b(1).YEndPoints*margin_y; %+ margin;
% labels1 = string(round(b(1).YData, 2));
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips2 = b(2).XEndPoints + margin_x;
% ytips2 = b(2).YEndPoints*margin_y; %+ margin;
% % labels2 = string(round(b(2).YData, 2));
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips3 = b(3).XEndPoints + margin_x;
% ytips3 = b(3).YEndPoints*margin_y; %+ margin;
% labels3 = string(round(b(3).YData, 2));
% text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips4 = b(4).XEndPoints + margin_x;
% ytips4 = b(4).YEndPoints*margin_y; %+ margin;
% labels4 = string(round(b(4).YData, 2));
% text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

% PATTERN option :  '/', '\', '|', '-', '+', 'x', '.', 'c', 'w', 'k'
% color option : rkgrgb rgbcmy
% applyhatch_plusC(fH, '\\--xx++', 'rrggbbkk', [], 150, 1.5);
% applyhatch_plusC(gcf,{makehatch_plus('\',20),makehatch_plus('-',20),makehatch_plus('x',20)},'rgb',[],300);%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% Bar plot
% figure('Position', [500, 300, 800, 500]);
% % Presicion of GPF vs R-GPF
% 
% %X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
% %X = reordercats(X,{'00', '02', '05', '06', '07', '08'});           % , '09'
% 
% b = bar(X, degen_s_lists,'BarWidth', 1.0); %,'BarWidth', 1.2); %, );    % s_lists  / degen_s_lists
% 
% linecolors = linspecer(6, 'qualitative');
% LineColors = flipud(linecolors);
% set(b(1), 'FaceColor', [230.7, 48.9, 50.7]./255.0);
% set(b(2), 'FaceColor', [75, 139, 191]./255.0);
% set(b(3), 'FaceColor', [95, 183, 92]./255.0);
% set(b(4), 'FaceColor', [230.7, 0, 191]./255.0);
% 
% % b(1).FaceColor = [75, 139, 191]./255.0;
% % b(2).FaceColor = [95, 183, 192]./255.0;
% 
% % lgd = legend({'FGR','TEASER++ [27]','Quatro [n]','Quatro++ (Ours)'},'Location','southoutside', 'NumColumns',3, 'fontsize', 10, 'interpreter', 'latex');
% 
% yticks([0, 20, 40, 60, 80, 100]);
% ylim([10, 100]);
% yticks([95, 100]);
% set(gca, 'YScale', 'log')
% set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
% set(groot, 'defaultAxesTickLabelInterpreter','latex');
% set(gca, 'FontSize', 13);
% xlabel("Sequences", 'interpreter', 'latex', "FontSize", 20);
% ylabel("Success Rate [\%]", "FontSize", 15, 'interpreter', 'latex');
% 
% margin_x = 0.015;
% margin = -2.5;
% common_fontsize = 28;
% xtips1 = b(1).XEndPoints + margin_x;
% ytips1 = b(1).YEndPoints*0.85; %+ margin;
% labels1 = string(round(b(1).YData, 2));
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips2 = b(2).XEndPoints + margin_x;
% ytips2 = b(2).YEndPoints*0.85; %+ margin;
% labels2 = string(round(b(2).YData, 2));
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips3 = b(3).XEndPoints + margin_x;
% ytips3 = b(3).YEndPoints*0.85; %+ margin;
% labels3 = string(round(b(3).YData, 2));
% text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 
% xtips4 = b(4).XEndPoints + margin_x;
% ytips4 = b(4).YEndPoints*0.85; %+ margin;
% labels4 = string(round(b(4).YData, 2));
% text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
%     'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
% 

% grid on;
% saveas(gcf, "output/succ_rate.png")
% print -depsc 'output/succ_rate.eps'


function perc = get_success_rate(data, t_threshold, r_threshold)
    t_in = single(data(1:end, 5)) < single(t_threshold);
    r_in = single(data(1:end, 6)) < single(r_threshold);
    in = t_in & r_in;
    num_in = nnz(in);
    num_total = size(data, 1);
    perc = num_in / single(num_total) * 100.0;

end

