%%
clc;
close all;
clear all;

load materials/caros/plot_data.mat
%% Params
rs = 200;
cs = 700;
fs = 14; % legend font size
positionfs = 10;
xls = 13; % x label font size
yls = 12; % y      ""
lw = 1.8; % line width
lw_rotor = 1.2; % due to many rotor
ms = 11;  % marker size

%% rotor speed
figure('Position', [0, 0, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
for i=1:6
plot(out(:,1)*10e-7-650,(-1+out(:,i+1)/1000)*1.2, 'LineWidth', lw_rotor, "Color", LineColors(i,:))
hold on
grid on 
end
legend({'${\Omega}^2_1$','$\Omega^2_2$','${\Omega}^2_3$','$\Omega^2_4$','$\Omega^2_5$','$\Omega^2_6$'}, "Interpreter", 'latex','Location','south', 'NumColumns',6, 'FontSize', fs)
hold off

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 0 1]);
ylabel('Rotor speed', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_rotor_speed.png")
% print -depsc 'imgs/caros_rotor_speed.eps'


%% pitch, alp
disp("pitch alp");
figure('Position', [0, 1.2*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
% 

plot(x2_1, y2_1, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(x2_2, y2_2, '--','LineWidth', lw, "Color", LineColors(2,:));

legend({'$\theta$','$\alpha$'}, "Interpreter", 'latex', 'FontSize', fs)

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 -inf 120]);
ylabel('Angle (deg)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_pitch_alpha.png")
% print -depsc 'imgs/caros_pitch_alpha.eps'
%% orientaion
disp("orientation");
% hold off
figure('Position', [0, 2.4*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);

plot(x3, y3_1, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(x3, y3_2, '--', 'LineWidth', lw, "Color", LineColors(2,:));
plot(x3, y3_3, '-.', 'LineWidth', lw, "Color", LineColors(3,:));

legend({'$\mathbf{x}_B$-axis angle','$\mathbf{y}_B$-axis angle','$\mathbf{z}_B$-axis angle'}, "Interpreter", 'latex', 'Location','northwest', 'FontSize', fs)

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 -inf 100]);
ylabel('Angle (deg)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_orientation.png")
% print -depsc 'imgs/caros_orientation.eps'
%% Pos
disp("pos");
% hold off
figure('Position', [0, 3.6*rs, cs, rs]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);

plot(x4, y4_1, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on

plot(x4, y4_2, '--', 'LineWidth', lw, "Color", LineColors(2,:));
plot(x4, y4_3, '-.', 'LineWidth', lw, "Color", LineColors(3,:));


legend({'$\mathbf{x}_I$','$\mathbf{y}_I$','$-\mathbf{z}_I$'}, "Interpreter", 'latex', 'FontSize', positionfs)

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 -inf inf]);
ylabel('Position (m)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_position.png")
% print -depsc 'imgs/caros_position.eps'
