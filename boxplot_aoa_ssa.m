%% Initialize
clc; close all; clearvars;

%% Input data (AOA)
disp("Loading boxplot data... (1/2)");
load('materials/aoa_error.mat', 'aoa_errors_list', 'xlabels');

%% Drawing parameters (AOA)
mu = 5; % mu takes outlier (red cross) into account

%% Plot (AOA)
figure()
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
boxplot(aoa_errors_list, xlabels, 'Whisker', mu);
title('Error of Angle of Attack (AOA) based on sequence length', "Interpreter", 'latex');
xlabel('Sequence Length', "Interpreter", 'latex');
ylabel('Error [rad]', "Interpreter", 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');

%% Save (AOA)
exportgraphics(gcf, "imgs/boxplot1.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/boxplot1.pdf", 'ContentType', 'vector');
disp("Done (1/2)");

%% Input data (SSA)
disp("Loading boxplot data... (2/2)");
load('materials/ssa_error.mat', 'ssa_errors_list', 'xlabels');

%% Drawing parameters (SSA)
mu = 9; % mu takes outlier (red cross) into account

%% Plot (SSA)
figure()
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');
boxplot(ssa_errors_list, xlabels, 'Whisker', mu);
title('Error of Sideslip Angle (SSA) based on sequence length', "Interpreter", 'latex');
xlabel('Sequence Length', "Interpreter", 'latex');
ylabel('Error [rad]', "Interpreter", 'latex');

%% Save (SSA)
exportgraphics(gcf, "imgs/boxplot2.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/boxplot2.pdf", 'ContentType', 'vector');
disp("Done (2/2)");
