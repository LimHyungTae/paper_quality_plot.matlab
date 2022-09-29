clc; clear all; close all;
%% YOU CAN ADJUST THE BELOW PARAMETER
iter = 0;

%%

abs_path = "materials/weight";

rot_path = abs_path + "/0176_SONNY_rot.txt";
weights_path = abs_path + "/0176_SONNY_weights.txt";
tims_tgt_path = abs_path + "/0176_tims_dst.txt";
tims_src_path = abs_path + "/0176_tims_src.txt";

rot_iter = load(rot_path);
tgt = load(tims_tgt_path);
src = load(tims_src_path);
weights = load(weights_path);

%%
if iter == 0
    width_ = 500;
    rot = eye(2);
else
    width_ = 400;
    rot = eye(2);
    rot(1, 1) = rot_iter(iter, 1);
    rot(1, 2) = rot_iter(iter, 2);
    rot(2, 1) = rot_iter(iter, 3);
    rot(2, 2) = rot_iter(iter, 4);
end

figure('Position', [100, 100, width_, 400])
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02));
set(groot, 'defaultAxesTickLabelInterpreter','latex');



src_xy = rot * (src(1:end, 1:2)')
src_xy = src_xy';
tgt_x = tgt(1:end, 1);
src_x = src_xy(1:end, 1);
tgt_y = tgt(1:end, 2);
src_y = src_xy(1:end, 2);

num_ticks = 100;
cd = [(jet(num_ticks))].';
min_w = 0;
max_w = max(weights, [], 'all');

if iter == 0
    weights_for_iter = ones(1, size(weights, 2));
else
    weights_for_iter = weights(iter, 1:end);
end
mz = 400;

idx = 1;
for w_ = weights_for_iter
    color_idx = round(((w_ - min_w) / (max_w - min_w)) * num_ticks);
    color_idx = min(max(1, color_idx), 100);
    target_color = cd(1:end, color_idx)
    scatter(src_x(idx), src_y(idx), mz, 'filled', 'v', 'MarkerEdgeColor','k', 'MarkerFaceColor',target_color);
    hold on;
    scatter(tgt_x(idx), tgt_y(idx), mz, 'filled', '^', 'MarkerEdgeColor','k', 'MarkerFaceColor', target_color);
    idx = idx + 1;
end

if iter == 1
%     text(-34, 22,'$w^{(1)}_k\simeq0$', 'Interpreter','latex', 'FontSize', 45)
    plot([-10, 8, 8, -10, -10], [-12, -12, 12, 12, -12], 'r--', 'LineWidth', 4);
    
elseif iter == 3
    text(-19, 19,'$\hat{w}^{(3)}_k\rightarrow0$', 'Interpreter','latex', 'FontSize', 25)
    plot([-10, 8, 8, -10, -10], [-12, -12, 12, 12, -12], 'r--', 'LineWidth', 4);
end
% plot correspondence
num_pt = size(src, 1);
for i=1:num_pt
    if iter == 0
        p = plot([tgt_x(i) src_x(i)], [tgt_y(i) src_y(i)], "k-.", "LineWidth", 4.0);
    else
        if weights(iter, i) > 0.5
            p = plot([tgt_x(i) src_x(i)], [tgt_y(i) src_y(i)], "k-.", "LineWidth", 4.0);
        end   
    end
    p.Annotation.LegendInformation.IconDisplayStyle = 'off';    
end
fs = 18
xlabel("X", 'Interpreter', 'latex', 'FontSize', fs);
xlabel("Y", 'Interpreter', 'latex', 'FontSize', fs);
if iter == 0
    colormap('jet');
    cb = colorbar();
    cb.TickLabelInterpreter = 'latex';
    ylabel(cb, 'Weight $\hat{w}_k$', 'FontSize', 30, 'interpreter','latex');
    lgdFontSize = 30;
    [~, objh] = legend("$\boldmath{\alpha}_k$", "$\boldmath{\beta}_k$", "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

    objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
    set(objhl, 'Markersize', 24); %// set marker size as desired
    % or for Patch plots 
    objhl = findobj(objh, 'type', 'patch'); % objects of legend of type patch
    set(objhl, 'Markersize', 24); % set marker size as desired
    
end


FontSize = 17;
xlabel("X", 'Interpreter', 'latex', 'FontSize', FontSize);
ylabel("Y", 'Interpreter', 'latex', 'FontSize', FontSize);
iter_title = "Iteration: " + num2str(iter);
title(iter_title , 'Interpreter', 'latex', 'FontSize', FontSize+10);
grid on;

axis equal
xlim([-40, 40]);
ylim([-40, 40]);

save_path = "imgs/tims_rotation_v3" + num2str(iter);
saveas(gcf, save_path, "png");
print -depsc 'imgs/tims_rotation_v3_0.eps'