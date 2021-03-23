%% Tilelayout example
clc; close; clear;
set(groot, 'defaultAxesTickLabelInterpreter','latex');

load materials/tilelayout.mat

%%
Models = {'32/108';'24/72';"16/54";'16/54';'16/54';'16/54'; '16/54'; '16/54'};
ytick_label_ = [0:10:100];
% rings = {'$\mathrm{N_{r}}$','32', '24', '16', '16', '16', '16', '16', '16'};
% xtickLabels = [rings];

rings = {'\itN_{r}'        , ' 32', ' 24', ' 16', ' 16', ' 16', ' 16', ' 16', ' 16'};
sects = {'\itN_{\theta}'   , '108',' 72', ' 54', ' 54', ' 54', ' 54', ' 54', ' 54'};
thrds = {'\it\theta_{\tau}', '  0 '  ,'  0' , '  0' ,' 15' , ' 30', ' 45', ' 60', ' 75'};
xtickArray= [rings; sects; thrds];
xtickLabels = strtrim(sprintf('%s\\newline%s\\newline%s\n', xtickArray{:}));
xtick_label_fontsize = 25;
figure('Position', [10, 10, 1600, 800])
t1 = tiledlayout(2,2);
t1.Padding = 'compact';


p_plot = nexttile;
filledErrorbarPLot(Ms', [num_analysis_p(:,1); thd_analysis_p(2:end,1)], [num_analysis_p(:,2); thd_analysis_p(2:end,2)]) 
set(gca,'TickLabelInterpreter','tex')
set(gca,'XTick',[0,Ms], 'XTickLabel',xtickLabels, 'FontSize', xtick_label_fontsize)
grid on
ylabel("Precision [\%]", "FontSize", 35, "Interpreter", 'latex')
yticks(ytick_label_)
p_plot.YLim = [40 100];

r_plot = nexttile;
filledErrorbarPLot(Ms', [num_analysis_r(:,1); thd_analysis_r(2:end,1)], [num_analysis_r(:,2); thd_analysis_r(2:end,2)])
set(gca,'TickLabelInterpreter','tex')
set(gca,'XTick',[0,Ms], 'XTickLabel',xtickLabels, 'FontSize', xtick_label_fontsize)
grid on
ylabel("Recall [\%]", "FontSize", 35, "Interpreter", 'latex')
yticks(ytick_label_)
r_plot.YLim = [80 100];

f1_plot = nexttile;
filledErrorbarPLot(Ms', [num_analysis_f(:,1); thd_analysis_f(2:end,1)], [num_analysis_f(:,2); thd_analysis_f(2:end,2)])
% ylabel("F_{1}", "FontSize", 15, "Interpreter", 'latex') 
set(gca,'TickLabelInterpreter','tex')
set(gca,'XTick',[0,Ms], 'XTickLabel',xtickLabels, 'FontSize', xtick_label_fontsize)
grid on
ylabel('$\mathrm{F_{1}}$', "FontSize", 35, "Interpreter", 'latex')
yticks([0.0 : 0.1 : 1.0])
f1_plot.YLim = [0.6 1];

a_plot = nexttile;
plots = filledErrorbarPLot(Ms', [num_analysis_a(:,1); thd_analysis_a(2:end,1)], [num_analysis_a(:,2); thd_analysis_a(2:end,2)] )
set(gca,'TickLabelInterpreter','tex')
set(gca,'XTick',[0,Ms], 'XTickLabel',xtickLabels, 'FontSize', xtick_label_fontsize)
legend(plots([1,2]),{'Mean','Stdev'}, 'Location','southeast','NumColumns',2, 'fontsize', 35, "Interpreter", 'latex')

grid on
ylabel("Accuracy [\%]", "FontSize", 35, "Interpreter", 'latex')
yticks(ytick_label_)
a_plot.YLim = [50 100];

linkaxes( [p_plot, r_plot, f1_plot, a_plot] , 'x')
p_plot.XLim = [0 (size(Ms,2)+1.0)];
saveas(gcf,'./imgs/final_tilelayout.png')



%% std_visual filled bar plot
function plots = filledErrorbarPLot(x_vector, mean_vector, std_vector)
    bar_size = 0.25;
    color = 'b';
    alpha = 0.3;
    
    hold on
    plots(1) = plot(x_vector, mean_vector,'-ko', 'LineWidth', 1.5, 'MarkerFaceColor', 'k', 'MarkerSize', 10)
    if (size(std_vector) ~= 0)
    for ii = 1:size(x_vector)
        x = x_vector(ii);
        mean = mean_vector(ii);
        std = std_vector(ii);
        
        X = [x-bar_size; x+bar_size; x+bar_size; x-bar_size];
        Y = [mean+std ; mean+std ; mean-std ; mean-std];
        plots(ii+1) = fill(X, Y, color, 'FaceAlpha', alpha,'linestyle', 'none' );
%         if ii ==1
%             hold on;
%         end
    end
    end

    plot(x_vector, mean_vector,'-ko', 'LineWidth', 3.5, 'MarkerFaceColor', 'k', 'MarkerSize', 10)
    
end
