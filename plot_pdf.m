clc
close all;
clear all;

%% Visualization of pdf
load('materials/pdf.mat', 'dyn', 'stat');
linecolors = linspecer(2, 'qualitative');
LineColors = flipud(linecolors);

figure('Position', [500, 300, 600, 360]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');
ms = 11;
[pd,xd] = hist(dyn.diff_percentage); plot(xd,pd/sum(pd), '-o', "MarkerSize", ms, 'LineWidth', 2.25, "Color", LineColors(1,:)); %PDF
hold on;
[ps,xs] = hist(stat.diff_percentage); plot(xs,ps/sum(ps), '-s', "MarkerSize", 12, 'LineWidth', 2.25, "Color", [19/255.0, 126/255.0, 153/255.0]); %PDF
lgd = legend({'Either bin contains dynamic points','Both bins consist only of static points'},'Location','northeast','NumColumns',1, 'fontsize', 11, "Interpreter", 'latex');

grid on; 
xticks([0, 0.1, 0.2, 0.3, 0.4 ,0.5, 0.6, 0.7, 0.8, 0.9, 1.0]);
xlabel('Scan ratio', "FontSize", 15, "Interpreter", 'latex')
ylabel('Percentage [\%]', "FontSize", 15, "Interpreter", 'latex')

saveas(gcf, "imgs/erasor_pdf_diff_percentage.png")
% print -depsc 'imgs/erasor_pdf_diff_percentage.eps'




