%% Set parameters
clc; clear all; close all;
target = "5";
seq = "00";
% target_path = "/home/beom/DATASET/Downloads/MATLAB/src_kitti_loop_degeneracy_v2/";
% target_path = "/home/beom/DATASET/Downloads/MATLAB/For_BarPlot/";
target_path = "/home/beom/DATASET/Quatro-Benchmark_output/dummy/mc_and_t_inliers_r_inliers_test/";

sub_path = "/10_to_12";
%%
%%%%%%%%%%%%%%%%%%%
t_thr = 2.0;
r_thr = 10.0;
%%%%%%%%%%%%%%%%%%%
%%
qp_num_maxclique_mean_list =[];
qp_num_trans_inliers_mean_list =[];
qp_num_rot_inliers_mean_list =[];

q_num_maxclique_mean_list =[];
q_num_trans_inliers_mean_list =[];
q_num_rot_inliers_mean_list =[];

for seq = ["00", "02", "05", "06", "07", "08"]  % ,"09"]
   
    q_path = target_path + seq + sub_path + "/Quatro_abs_errors.txt"; 
    qg_path = target_path  + seq + sub_path + "/Quatro-plusplus_abs_errors.txt"; 

    q = load(q_path);
    qg = load(qg_path);

    quatro_fail_case= get_quatro_fail_case(q, t_thr, r_thr);
    temp_3dim= get_quatro_plusplus_success_case(qg,q , quatro_fail_case, t_thr, r_thr);
    
    quatro_plusplus_success_case= temp_3dim( 1:end, 1:end, 1);    % 1st
    quatro_fail_case_overlapped   = temp_3dim( 1:end, 1:end, 2);     % 2nd
    
    q_num_maxclique_mean = mean(quatro_fail_case_overlapped(1:end,7));
    q_num_trans_inliers_mean = mean(quatro_fail_case_overlapped(1:end,11));
    q_num_rot_inliers_mean = mean(quatro_fail_case_overlapped(1:end,10));
    
    q_num_maxclique_mean_list = [q_num_maxclique_mean_list q_num_maxclique_mean];
    q_num_trans_inliers_mean_list = [q_num_trans_inliers_mean_list q_num_trans_inliers_mean];
    q_num_rot_inliers_mean_list = [q_num_rot_inliers_mean_list q_num_rot_inliers_mean];
    
    qp_num_maxclique_mean = mean(quatro_plusplus_success_case(1:end,7));
    qp_num_trans_inliers_mean = mean(quatro_plusplus_success_case(1:end,11));
    qp_num_rot_inliers_mean = mean(quatro_plusplus_success_case(1:end,10));
    
    qp_num_maxclique_mean_list = [qp_num_maxclique_mean_list qp_num_maxclique_mean];
    qp_num_trans_inliers_mean_list = [qp_num_trans_inliers_mean_list qp_num_trans_inliers_mean];
    qp_num_rot_inliers_mean_list = [qp_num_rot_inliers_mean_list qp_num_rot_inliers_mean];
end

%     plot_num_inlier(qp_num_maxclique_mean_list, qp_num_trans_inliers_mean_list, qp_num_rot_inliers_mean_list, "Quatro plus plus");
%     plot_num_inlier(q_num_maxclique_mean_list, q_num_trans_inliers_mean_list, q_num_rot_inliers_mean_list, "Quatro");
% plot_num_inlier2(q_num_maxclique_mean_list, q_num_trans_inliers_mean_list, q_num_rot_inliers_mean_list,qp_num_maxclique_mean_list, qp_num_trans_inliers_mean_list, qp_num_rot_inliers_mean_list);

    figure('Position', [500, 300, 800, 500]);
    
    X = categorical({'00', '02', '05', '06', '07', '08'});
    
    margin_x = 0.015;
    margin_y = 2.8;
    margin = -2.5;
    common_fontsize = 32;
    
    
    a = reshape(q_num_maxclique_mean_list, [6,1]);
    b = reshape(qp_num_maxclique_mean_list, [6,1]);
    c = reshape(q_num_trans_inliers_mean_list, [6,1]);
    d = reshape(qp_num_trans_inliers_mean_list, [6,1]);
    e = reshape(q_num_rot_inliers_mean_list, [6,1]);
    f = reshape(qp_num_rot_inliers_mean_list, [6,1]);
    
    degen_s_list1 = [a b];
    degen_s_list2 = [c d];
    degen_s_list3 = [e f ];
    
    b1 = bar(X, degen_s_list1,'BarWidth', 1.0);
    yticks([0 ,5 ,10 ,15 ,20 ,25 ,30 ,35 ,40]);
    ylim([0, 40]);
    
    set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(gca, 'FontSize', 25);
    
    xlabel("Sequences", 'interpreter', 'latex', "FontSize", 36);
    ylabel("Inlier number", "FontSize", 28, 'interpreter', 'latex');
    
    legend({ 'Max Clique', 'Max Clique with ground removal'},'Location','southoutside', 'NumColumns',3, 'fontsize', 25, 'interpreter', 'latex');

    set(b1(1), 'FaceColor', [230.7, 48.9, 50.7]./255.0);
    set(b1(2), 'FaceColor', [180.7, 28.9, 50.7]./255.0);
    
    xtips1 = double( b1(1).XEndPoints ) + margin_x;
    ytips1 = double( b1(1).YEndPoints - margin_y ); %+ margin;
    labels1 = string(round(double(b1(1).YData ), 3,'significant'));
    text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    
    xtips2 = double( b1(2).XEndPoints )+ margin_x;
    ytips2 = double( b1(2).YEndPoints - margin_y); %+ margin;

    labels2 = string(round(double( b1(2).YData), 3,'significant'));
    text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
      

    print(gcf, "num_MC.png",'-dpng','-r300'); 


    figure('Position', [500, 300, 800, 500]);
     
    b2 = bar(X, degen_s_list2,'BarWidth', 1.0);
    yticks([0 ,5 ,10 ,15 ,20 ,25 ,30 ,35 ,40]);
    ylim([0, 40]);
    
    set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(gca, 'FontSize', 25);
    
    xlabel("Sequences", 'interpreter', 'latex', "FontSize", 36);
    ylabel("Inlier number", "FontSize", 28, 'interpreter', 'latex');
    
    legend({ 'Translation Inlier', 'Translation Inlier with ground removal'},'Location','southoutside', 'NumColumns',3, 'fontsize', 25, 'interpreter', 'latex');

    set(b2(1), 'FaceColor', [95, 183, 92]./255.0);
    set(b2(2), 'FaceColor',  [95, 133, 92]./255.0);

    xtips3 = double( b2(1).XEndPoints) + margin_x;
    ytips3 = double( b2(1).YEndPoints - margin_y); %+ margin;
    labels3 = string(round(double( b2(1).YData ), 3,'significant'));
    
    for i=1:size(ytips3,2)  % 6
        if ytips3(i) < 2
            ytips3(i) = ytips3(i) + 5.4;
        end
    end  
    
    text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    
    xtips4 = double( b2(2).XEndPoints )+ margin_x;
    ytips4 = double( b2(2).YEndPoints - margin_y); %+ margin;
    labels4 = string(round(double( b2(2).YData), 3,'significant'));
    text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    
    print(gcf, "num_rot_inlier.png",'-dpng','-r300'); 

    figure('Position', [500, 300, 800, 500]);
    
    b3 = bar(X, degen_s_list3,'BarWidth', 1.0);
    yticks([0 ,5 ,10 ,15 ,20 ,25 ,30 ,35 ,40]);
    ylim([0, 40]);
    
    set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(gca, 'FontSize', 25);
    
    xlabel("Sequences", 'interpreter', 'latex', "FontSize", 36);
    ylabel("Inlier number", "FontSize", 28, 'interpreter', 'latex');
    
    legend({'Rotation Inlier', 'Rotation Inlier with ground removal'},'Location','southoutside', 'NumColumns',3, 'fontsize', 25, 'interpreter', 'latex');
        
    set(b3(1), 'FaceColor', [75, 139, 161]./255.0);
    set(b3(2), 'FaceColor',  [75, 139, 191]./255.0);

    xtips5 = double( b3(1).XEndPoints) + margin_x;
    ytips5 = double( b3(1).YEndPoints - margin_y); %+ margin;

    for i=1:size(ytips5, 2)  % 6
        if ytips5(i) < 2
            ytips5(i) = ytips5(i) + 5.4;
        end
    end    
    
    labels5 = string(round(double( b3(1).YData ), 3,'significant'));
    text(xtips5,ytips5,labels5,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
   
    xtips6 = double( b3(2).XEndPoints )+ margin_x;
    ytips6 = double( b3(2).YEndPoints - margin_y); %+ margin;
    labels6 = string(round(double( b3(2).YData), 3,'significant'));
    text(xtips6,ytips6,labels6,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    
    set(b3(4), 'FaceColor', [75, 139, 161]./255.0);
    set(b3(6), 'FaceColor', [95, 133, 92]./255.0);
    
%   legend({'Rotation Inlier with ground removal'},'Location','southoutside', 'NumColumns',3, 'fontsize', 25, 'interpreter', 'latex');

    for i=1:size(ytips3,2)  % 6
        if ytips3(i) < 2
            ytips3(i) = ytips3(i) + 5;
        end
    end    

    print(gcf, "num_trans_inlier.png",'-dpng','-r300'); 

    
function proc_data_accum = get_quatro_fail_case(data, t_threshold, r_threshold)

    %failed case
    t_fail = single(data(1:end, 5))  > single(t_threshold);
    r_fail = single(data(1:end, 6)) > single(r_threshold);
    
    fail = t_fail | r_fail;
    num_total = size(data, 1);

    proc_data_accum = [[]];
    
    for i = 1:num_total
        if fail(i) == 1
            proc_data = data(i, 1:end);     % size :(1,11)
            proc_data_accum = [ proc_data_accum;  proc_data];
        end
    end
end

function temp = get_quatro_plusplus_success_case(quatro_plusplus, quatro, q_fail_case, t_th, r_th)
    
    quatro_plusplus_succ_case = [[]];
    quatro_fail_case = [[]];
    
    for i = 1:size(q_fail_case,1)
        for j = 1:size(quatro_plusplus,1)
            if (quatro_plusplus(j,1)==q_fail_case(i,1)) && (quatro_plusplus(j,2)==q_fail_case(i,2)) &&  (quatro_plusplus(j,5)< t_th) && (quatro_plusplus(j,6)< r_th)
                
                quatro_plusplus_succ_case = [quatro_plusplus_succ_case ; quatro_plusplus(j,1:end)];
                quatro_fail_case = [quatro_fail_case ; quatro(j,1:end)];
            end
        end
    end
    
    temp = cat(3,quatro_plusplus_succ_case,  quatro_fail_case);
    
%     temp = size(quatro_plusplus)

end

function plot_num_inlier2(q_num_mc_list, q_num_ti_list, q_num_ri_list, qp_num_mc_list, qp_num_ti_list, qp_num_ri_list)
    figure('Position', [500, 300, 800, 500]);
    
    X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
%     X = reordercats(X,{'00', '02', '05', '06', '07', '08'});           % , '09'

    a = reshape(q_num_mc_list, [6,1]);
    b = reshape(qp_num_mc_list, [6,1]);
    c = reshape(q_num_ti_list, [6,1]);
    d = reshape(qp_num_ti_list, [6,1]);
    e = reshape(q_num_ri_list, [6,1]);
    f = reshape(qp_num_ri_list, [6,1]);
    
    degen_s_lists = [a b c d e f];
%     degen_s_lists = [q_num_mc_list; qp_num_mc_list; q_num_ti_list; qp_num_ti_list; q_num_ri_list; qp_num_ri_list];
    
    b = bar(X, degen_s_lists,'BarWidth', 1.0);
    yticks([0 ,5 ,10 ,15 ,20 ,25 ,30 ,35 ,40]);
    ylim([0, 40]);
    
    set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(gca, 'FontSize', 25);
    
    xlabel("Sequences", 'interpreter', 'latex', "FontSize", 36);
    ylabel("Inlier number", "FontSize", 28, 'interpreter', 'latex');
    
    legend({ 'Max Clique', 'Max Clique with ground removal','Translation Inlier', 'Translation Inlier with ground removal','Rotation Inlier', 'Rotation Inlier with ground removal'},'Location','southoutside', 'NumColumns',3, 'fontsize', 25, 'interpreter', 'latex');
    set(b(1), 'FaceColor', [230.7, 48.9, 50.7]./255.0);
    set(b(3), 'FaceColor', [75, 139, 191]./255.0);
    set(b(5), 'FaceColor', [95, 183, 92]./255.0);
    set(b(2), 'FaceColor', [180.7, 28.9, 50.7]./255.0);
    set(b(4), 'FaceColor', [75, 139, 161]./255.0);
    set(b(6), 'FaceColor', [95, 133, 92]./255.0);
    
    margin_x = 0.015;
    margin_y = 2.8;

    margin = -2.5;
    common_fontsize = 25;
    
    xtips1 = double( b(1).XEndPoints ) + margin_x;
    ytips1 = double( b(1).YEndPoints - margin_y ); %+ margin;
    labels1 = string(round(double(b(1).YData ), 3,'significant'));
    text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

    xtips2 = double( b(2).XEndPoints) + margin_x;
    ytips2 = double( b(2).YEndPoints - margin_y); %+ margin;
    labels2 = string(round(double( b(2).YData ), 3,'significant'));
    text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')
    
    xtips3 = double( b(3).XEndPoints )+ margin_x;
    ytips3 = double( b(3).YEndPoints - margin_y); %+ margin;
    for i=1:size(ytips3,2)  % 6
        if ytips3(i) < 2
            ytips3(i) = ytips3(i) + 5;
        end
    end    
    labels3 = string(round(double( b(3).YData), 3,'significant'));
    text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

    xtips4 = double( b(4).XEndPoints )+ margin_x;
    ytips4 = double( b(4).YEndPoints - margin_y); %+ margin;
    labels4 = string(round(double( b(4).YData), 3,'significant'));
    text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

    xtips5 = double( b(5).XEndPoints )+ margin_x;
    ytips5 = double( b(5).YEndPoints - margin_y); %+ margin;
    for i=1:size(ytips5,2)  % 6
        if ytips5(i) < 2
            ytips5(i) = ytips5(i) + 5;
        end
    end    
    labels5 = string(round(double( b(5).YData), 3,'significant'));
    text(xtips5,ytips5,labels5,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')

    
    xtips6 = double( b(6).XEndPoints )+ margin_x;
    ytips6 = double( b(6).YEndPoints - margin_y); %+ margin;
    labels6 = string(round(double( b(6).YData), 3,'significant'));
    text(xtips6,ytips6,labels6,'HorizontalAlignment','center',...
        'VerticalAlignment','middle', "Rotation", 90, "Color", [0, 0, 0],  "FontSize", common_fontsize, 'interpreter', 'latex')   
end

function plot_num_inlier(num_mc_list, num_ti_list, num_ri_list, title_name)
    figure('Position', [500, 300, 800, 500]);
    
    X = categorical({'00', '02', '05', '06', '07', '08'});              % , '09'
    X = reordercats(X,{'00', '02', '05', '06', '07', '08'});           % , '09'
    
    degen_s_lists = [num_mc_list; num_ti_list; num_ri_list];
    
    b = bar(X, degen_s_lists,'BarWidth', 1.0);
    yticks([0 ,5 ,10 ,15 ,20 ,25 ,30 ,35 ,40]);
    ylim([0, 40]);
    
    set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(gca, 'FontSize', 25);
    
    xlabel("Sequences", 'interpreter', 'latex', "FontSize", 36);
    ylabel("Inlier number", "FontSize", 28, 'interpreter', 'latex');
    
    legend({ 'Max Clique','Translation Inlier','Rotation Inlier'},'Location','southoutside', 'NumColumns',3, 'fontsize', 36, 'interpreter', 'latex');
    title(title_name, 'interpreter','latex');
    set(b(1), 'FaceColor', [230.7, 48.9, 50.7]./255.0);
    set(b(2), 'FaceColor', [75, 139, 191]./255.0);
    set(b(3), 'FaceColor', [95, 183, 92]./255.0);

end

