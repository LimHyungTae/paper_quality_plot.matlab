%% tilelayout 4x1
clc;
close all;
clear all;

out=readmatrix('materials/caros/actuator_outputs_0');
setpoint=readmatrix('materials/caros/manual_control_setpoint_0');
att=readmatrix('materials/caros/vehicle_attitude_0');
pos=readmatrix('materials/caros/vehicle_local_position_0');

%% Plot parameters
height = 900;
width = 700;
fs = 14; % legend font size
positionfs = 10;
xls = 13; % x label font size
yls = 12; % y      ""
lw = 1.8; % line width
lw_rotor = 1.2; % due to many rotor
ms = 11;  % marker size

%% Initialize tilelayout
t = tiledlayout(4,1,'TileSpacing','Compact');
set(gcf, 'Position',  [1000, 25, width, height])

%% Rotor speed
nexttile
disp("Drawing rotor speed...");
linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);
for i=1:6
plot(out(:,1)*10e-7-650,(-1+out(:,i+1)/1000)*1.2, 'LineWidth', lw_rotor, "Color", LineColors(i,:))
hold on
grid on 
end
legend({'${\Omega}^2_1$','$\Omega^2_2$','${\Omega}^2_3$','$\Omega^2_4$','$\Omega^2_5$','$\Omega^2_6$'}, "Interpreter", 'latex','Location','south', 'NumColumns',6, 'FontSize', fs)
hold off

xlabel('Time (s)', "FontSize", xls)
axis([-inf 70 0 1]);
ylabel('Rotor speed', "FontSize", yls)


%% pitch, alpha
disp("Drawing pitch and alpha...");
nexttile

[r p y]=quat2angle(att(:,2:5));
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);

plot(att(:,1)*10e-7-650,p*180/pi*1.09, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on
plot(setpoint(:,1)*10e-7-650,180/pi*(setpoint(:,2)+1)*0.925, '--','LineWidth', lw, "Color", LineColors(2,:));
% legend('pitch','{\alpha}');
legend({'$\theta$','$\alpha$'}, "Interpreter", 'latex', 'FontSize', fs)

xlabel('Time (s)', "FontSize", xls)
axis([-inf 70 -inf 120]);
ylabel('Angle (deg)', "FontSize", yls)

%% Orientaion
disp("Drawing orientation...");
% hold off
nexttile
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

xlabel('Time (s)', "FontSize", xls)
axis([-inf 70 -inf 100]);
ylabel('Angle (deg)', "FontSize", yls)

%% Position
disp("Drawing position...");
nexttile
linecolors = linspecer(3, 'qualitative');
LineColors = flipud(linecolors);
plot(pos(:,1)*10e-7-650,pos(:,2)-0.2, 'LineWidth', lw, "Color", LineColors(1,:));
hold on
grid on

plot(pos(:,1)*10e-7-650,pos(:,3), '--', 'LineWidth', lw, "Color", LineColors(2,:));
plot(pos(:,1)*10e-7-650,-pos(:,4), '-.', 'LineWidth', lw, "Color", LineColors(3,:));
legend({'$\mathbf{x}_I$','$\mathbf{y}_I$','$-\mathbf{z}_I$'}, "Interpreter", 'latex', 'FontSize', positionfs)

xlabel('Time (s)', "FontSize", xls)
axis([-inf 70 -inf inf]);
ylabel('Position (m)', "FontSize", yls)

saveas(gcf, "imgs/caros_tile_output.png")
% print -depsc 'imgs/caros_tile_output.eps'
