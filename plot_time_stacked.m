clc; clear all; close all;
data = importdata("materials/xavier_save_times.txt", " ");
%%

t_preprocessing = data(1:end, 1);
t_inference = data(1:end, 2);
t_viz = data(1:end, 3) + data(1:end, 4);

t_total = t_preprocessing + t_inference + t_viz;

%% 
color_grad = [254 194 96;
        63 167 150;
        42 9 68]./255;
%%
imgWidthSize = 350;
imgColumnSize = 300;
figure('Position', [300, 50, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

time_step = 1000;
x = 1:time_step;
t_to_cpu = t_preprocessing(1:time_step, 1);
t_fm = t_inference(1:time_step, 1);
t_pose = t_viz(1:time_step, 1);

Y = [t_to_cpu t_fm t_pose];
a = area(x,Y,'EdgeAlpha',.1);
a(1).FaceColor = color_grad(1, 1:end);
a(2).FaceColor = color_grad(2, 1:end);
a(3).FaceColor = color_grad(3, 1:end);
xticks([0 250 500])
xlabel('Time step', 'FontSize', 18, "Interpreter", 'latex')
ylabel('Time [msec]', 'FontSize', 18, "Interpreter", 'latex')
set(gca, 'FontSize', 13);
legend([a(3), a(2), a(1)], {'Visualization', 'Inference', 'Preprocessing'}, ...
    'FontSize', 12, 'interpreter','latex')
% legend({'Feature extraction','Feature matching', 'Pose estimation'}, ...
%     'FontSize', 12, 'interpreter','latex')
print(gcf, "imgs/time_stacked.png",'-dpng','-r300');
print -depsc 'imgs/time_stacked.eps'