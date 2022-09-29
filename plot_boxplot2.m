clear;clc;
%% Load data
load materials/box_plot2.mat

%% Originally, cells are set as following the annotations
% ii = 1;
% src_kitti_path = "./src_kitti00_for_fig1/00/9_to_10/";
% 
% ransac_name = src_kitti_path + "RANSAC1K_5_time.txt";
% fgr_name = src_kitti_path + "FGR_5_time.txt";
% % sonny_name = src_path + "SONNY_kitti_5_time.txt";
% % teaser_name = src_path + "TEASER_kitti_5_time.txt";
% 
% sonny_name = src_path + "SONNY_5_time.txt";
% teaser_name = src_path + "TEASER_5_time.txt";
% 
% ransac = load(ransac_name);
% fgr = load(fgr_name);
% teaser = load(teaser_name);
% ours = load(sonny_name);

% ransac_t{ii} = abs(ransac);
% teaser_t{ii} = abs(teaser);
% fgr_t{ii} = abs(fgr);
% sonny_t{ii} = abs(ours);    

% ii = 2;
% src_path = "src_time_check/";
% ransac_name = src_path + "RANSAC1K_5_time.txt";
% fgr_name = src_path + "FGR_5_time.txt";
% sonny_name = src_path + "SONNY_5_time.txt";
% teaser_name = src_path + "TEASER_5_time.txt";
% 
% ransac = load(ransac_name);
% fgr = load(fgr_name);
% teaser = load(teaser_name);
% ours = load(sonny_name);
% init_idx = 10;
% ransac = sort(ransac(init_idx:end));
% fgr = sort(fgr(init_idx:end));
% teaser = sort(teaser(init_idx:end));
% ours = sort(ours(init_idx:end));
% 
% ransac_t{ii} = abs(ransac);
% teaser_t{ii} = abs(teaser);
% fgr_t{ii} = abs(fgr);
% sonny_t{ii} = abs(ours);

%% Plot

WIDTH = 1190;
HEIGHT = 380;

figure('Position', [100, 100, WIDTH, HEIGHT]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
set(groot, 'defaultAxesTickLabelInterpreter','latex');

% data format: 1 x N cells
precision=vertcat(ransac_t, fgr_t, teaser_t, sonny_t);

linecolors = linspecer(6, 'qualitative');
LineColors = flipud(linecolors);

xlab={'KITTI', 'NAVER LABS localization'};
col=[LineColors(4, :)*255, 220;
     LineColors(5, :)*255, 180; 
     LineColors(6, :)*255, 140;
     LineColors(2, :)*255, 100];
col=col/255;

multiple_boxplot_time(precision',xlab,{'RANSAC1K', 'FGR', 'TEASER++', 'Quatro (Ours)'}, col')
ylabel('Optimization Time [s]', 'interpreter','latex', 'FontSize', 18)
grid on;

print(gcf, "imgs/box_plot2_r300.png",'-dpng','-r300'); 
