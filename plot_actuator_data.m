%%
clc;
close all;
clear all;

out=readmatrix('materials/caros/actuator_outputs_0');
setpoint=readmatrix('materials/caros/manual_control_setpoint_0');
att=readmatrix('materials/caros/vehicle_attitude_0');
pos=readmatrix('materials/caros/vehicle_local_position_0');

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
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))

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

% q=att(:,3:5);
% q(:,4)=att(:,2);
[r p y]=quat2angle(att(:,2:5));
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);
mkidx = 200;
plot(att(:,1)*10e-7-650,p*180/pi*1.09, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(setpoint(:,1)*10e-7-650,180/pi*(setpoint(:,2)+1)*0.925, '--','LineWidth', lw, "Color", LineColors(2,:));
% legend('pitch','{\alpha}');
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

[y p r]=quat2angle(att(:,2:5));
linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);
plot(att(:,1)*10e-7-650,r*180/pi, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(att(:,1)*10e-7-650,p*180/pi*1.09, '--', 'LineWidth', lw, "Color", LineColors(2,:));
plot(att(:,1)*10e-7-650,y*180/pi-93, '-.', 'LineWidth', lw, "Color", LineColors(3,:));
% legend('roll','pitch','yaw');
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

linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);
plot(pos(:,1)*10e-7-650,pos(:,2)-0.2, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on

plot(pos(:,1)*10e-7-650,pos(:,3), '--', 'LineWidth', lw, "Color", LineColors(2,:));
plot(pos(:,1)*10e-7-650,-pos(:,4), '-.', 'LineWidth', lw, "Color", LineColors(3,:));
legend({'$\mathbf{x}_I$','$\mathbf{y}_I$','$-\mathbf{z}_I$'}, "Interpreter", 'latex', 'FontSize', positionfs)

xlabel('Time (s)', "FontSize", xls, "Interpreter", 'latex')
axis([-inf 70 -inf inf]);
ylabel('Position (m)', "FontSize", yls, "Interpreter", 'latex')
saveas(gcf, "imgs/caros_position.png")
% print -depsc 'imgs/caros_position.eps'