target_path = "/home/beom/DATASET/kitti_output/avg_com_time_test_02/02/10_to_12/";
qpp_path = target_path + "Quatro-plusplus_abs_errors.txt";
q_path = target_path + "Quatro_abs_errors.txt";
qpp = load(qpp_path);
q = load(q_path);

% quatro.size()
qs = [];
qpps =[];
qs = [qs; q(1:end, 1:4)];
qpps = [qpps; qpp(1:end, 1:4)];

q_m = mean(qs);
qpp_m = mean(qpps);

common_fontsize = 32;

% Position : [left bottom width height]
figure('Position', [500, 650, 1200, 500]);
% set(gca,'position',[0.11, 0.15, 0.87, 0.78])
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');

% x = ['a' 'b'];
% y = [qpp_m; q_m]
y = [0.0094 0.0059 0.1203 0.174; 0 0.0132 0.215 0.23 ]; % I7
% y = [0.0035 0.0021 0.04658 0.02607 ; 0 0.004 0.05309 0.04344]; %I9

b = barh(y,'stacked', 'BarWidth', 0.8);
% b2 = bar(X, RANSAC_lists,'BarWidth', 1.0); 

ax=gca;
ax.YAxis.FontSize = common_fontsize;

% ylabel(" ", "FontSize", common_fontsize, 'interpreter', 'latex');
legend({'Ground segmentation-','Voxelization-','FPFH-', 'Matching'},'Location','southoutside', 'NumColumns',4, 'fontsize', 36, 'interpreter', 'latex');

linecolors = linspecer(7, 'qualitative');
LineColors = flipud(linecolors);

set(b(1), 'FaceColor', LineColors(4, :));
set(b(2), 'FaceColor', LineColors(7, :));
set(b(3), 'FaceColor', LineColors(6, :));
set(b(4), 'FaceColor', LineColors(5, :));

% Set X and Y axis labels to LaTeX font
% xticklabels({'\texttt{0}', '\texttt{0.02}', '\texttt{0.04}', '\texttt{0.06}', '\texttt{0.08}', '\texttt{0.1}', '\texttt{0.12}'});
xticklabels({'\texttt{0}', '\texttt{0.05}', '\texttt{0.1}', '\texttt{0.15}', '\texttt{0.2}', '\texttt{0.25}', '\texttt{0.30}', '\texttt{0.35}', '\texttt{0.40}', '\texttt{0.45}', '\texttt{0.5}'});
yticklabels({'\texttt{w/o GS}', '\texttt{w/ GS}'});
ax = gca;
ax.YAxis.FontSize = 32;
ax.XAxis.FontSize = 25;
xlabel("Average computational time [sec]", 'interpreter', 'latex', "FontSize", 36);

% print(gcf, "legend",'-dpng','-r300');
print(gcf, "average_computational_time_v2_i7",'-dpng','-r300'); 
% print(gcf, "average_computational_time_v2_i9",'-dpng','-r300'); 
