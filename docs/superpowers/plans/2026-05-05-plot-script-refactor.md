# Plot Script Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure all 24 `plot_*.m` figure scripts in this MATLAB repo so that input data, drawing parameters, plotting code, and saving are clearly separated, while renaming files for distinctiveness and category-level grouping. Generated figures must remain visually identical.

**Architecture:** Each script is rewritten in-place using a 5-section template (`%% Initialize` / `%% Input data` / `%% Drawing parameters` / `%% Plot` / `%% Save`). Files are renamed via `git mv` to a `<category>_<distinctive>.m` pattern. `print` and `saveas` are migrated to `exportgraphics`. EPS output is dropped; PNG (300 dpi) + PDF (vector) only. No content changes (numbers, colors, sizes, layouts stay byte-identical in intent).

**Tech Stack:** MATLAB (R2020a+ for `exportgraphics`), git (rename detection via similarity). No automated test framework exists; verification is **visual diff against pre-existing `imgs/<output>.png`**.

**Reference spec:** `docs/superpowers/specs/2026-05-05-plot-script-refactor-design.md`

---

## File Structure

After this plan completes, the repo will have these renamed files (24 total). Pre-existing utility files (`calcCDF.m`, `parseCSV.m`, `linspecer.m`, `RMSE.m`, `template.m`, `multiple_boxplot_time.m`, `calcModelAidedOutput.m`) and `.asv` autosave files are untouched. Output filenames in `imgs/` are unchanged.

| New filename | Replaces | Section count |
|---|---|---|
| `linegraph_caros.m` | `plot_linegraph1.m` | 4 figures |
| `linegraph_erasor_ground.m` | `plot_linegraph2.m` | 4 figures |
| `linegraph_biou_pxthr.m` | `plot_linegraph3.m` | 1 figure |
| `linegraph_biou_masking.m` | `plot_linegraph4.m` | 1 figure |
| `linegraph_vggt.m` | `plot_linegraph5.m` | 4 figures |
| `linegraph_hydra_sam3d.m` | `plot_linegraph6.m` | 3 figures |
| `linegraph_hydra_pr.m` | `plot_linegraph7.m` | 3 figures |
| `barplot_gpf_precision.m` | `plot_barplot.m` | 1 figure |
| `barplot_quatro_runtime.m` | `plot_barplot_avg_computation_time.m` | 1 figure |
| `barplot_maxclique.m` | `plot_barplot_maxclique_num.m` | 3 figures |
| `barplot_success_rate.m` | `plot_barplot_success_rate.m` | 5 figures |
| `boxplot_runtime.m` | `plot_boxplot2.m` | 1 figure |
| `boxplot_aoa_ssa.m` | `plot_boxplots.m` | 2 figures |
| `cdf_angles.m` | `plot_cdf.m` | many |
| `cdf_chamfer.m` | `plot_cdf2.m` | many |
| `pdf_erasor_scan_ratio.m` | `plot_pdf.m` | 1 figure |
| `horizontal_bars_deeplabv3.m` | `plot_horizontal_bars.m` | several |
| `horizontal_bars_hrnet.m` | `plot_horizontal_bars2.m` | 4 figures |
| `prcurve_hydra.m` | `plot_pr_curve.m` | 2 figures |
| `scatter_heatmap_weights.m` | `plot_scatter_w_heatmap.m` | 1 figure |
| `tilelayout_pasga.m` | `plot_tilelayout.m` | 1 tiledlayout |
| `area_xavier_time.m` | `plot_time_stacked.m` | 1 figure |
| `trajectory_3d_utm.m` | `plot_trajectory.m` | 1 figure |
| `trajectory_vbr.m` | `plot_trajectory_w_airbornej.m` | 1 figure |

---

## Standard transformation rules

These rules apply to **every** task in this plan. They encode the spec.

### Section template

```matlab
%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
% any other one-time global setup (e.g., set(groot, 'defaultLegendInterpreter','latex');)

%% Input data
% raw experimental numbers go here
% NO plotting calls in this section
% NO size/color/font parameters in this section

%% Drawing parameters
% --- Sizes ---
imgWidth  = ...;
lw        = ...;
ms        = ...;

% --- Fonts ---
fontTitle = ...;
fontAxis  = ...;
fontLgd   = ...;

% --- Colors ---
colorBase  = [...];
colorsSota = [...];

%% Plot
fig = figure('Position', [...]);
% drawing logic referencing only variables defined above

%% Save
exportgraphics(gcf, 'imgs/<existing-filename>.png', 'Resolution', 300);
exportgraphics(gcf, 'imgs/<existing-filename>.pdf', 'ContentType', 'vector');
```

### Multi-figure files

Files with N independent figures use one shared `%% Initialize` at the top, then N repetitions of `%% Input data (<label>) / %% Drawing parameters (<label>) / %% Plot (<label>) / %% Save (<label>)`. The `<label>` distinguishes sections (e.g., `px=3`, `precision`, `rotor`).

### Mandatory substitutions

Apply ALL of these to every file:

| Find | Replace with |
|---|---|
| `clear all;` (or `clear all`) | `clearvars;` |
| `clear;` (alone) | `clearvars;` |
| `print(gcf, "<path>.png", '-dpng', '-r300');` | `exportgraphics(gcf, "<path>.png", 'Resolution', 300);` |
| `print(gcf, '<path>.png', '-dpng', '-r300');` | `exportgraphics(gcf, '<path>.png', 'Resolution', 300);` |
| `print -depsc '<path>.eps'` | **DELETE** (drop EPS) |
| `print('-depsc2', '<path>.eps', '-r300');` | **DELETE** (drop EPS) |
| `% print -depsc '<path>.eps'` (commented) | **DELETE** (dead code) |
| `saveas(gcf, "<path>.png", '-dpng', '-r300');` | `exportgraphics(gcf, "<path>.png", 'Resolution', 300);` |
| `saveas(gcf, "<path>.png")` | `exportgraphics(gcf, "<path>.png", 'Resolution', 300);` |
| `saveas(gcf, "<path>.png", "png");` | `exportgraphics(gcf, "<path>.png", 'Resolution', 300);` |
| `exportgraphics(gcf, '<path>.pdf', 'ContentType', 'vector');` (already present) | keep as-is |

After EVERY existing PNG-save line, **add** a corresponding PDF-save line (unless one already exists):
```matlab
exportgraphics(gcf, "<path>.png", 'Resolution', 300);
exportgraphics(gcf, "<path>.pdf", 'ContentType', 'vector');
```
The PDF filename is the same path as PNG with extension swapped.

### Constraints (DO NOT change)

- All numeric values: data arrays, baselines, axis limits, tick values, font sizes, line widths, marker sizes, RGB colors, figure positions
- All `legend(...)` strings, `xlabel`/`ylabel`/`title` strings (and their `'Interpreter'`, `'FontSize'` arguments)
- All `plot(...)` argument lists including line-style markers (`'-o'`, `'-.^'`, etc.)
- All `set(gca, ...)` and `set(groot, ...)` calls — do not consolidate or remove
- All `xticks`, `yticks`, `xlim`, `ylim`, `xticklabels`, `yticklabels` calls
- All commented-out alternative blocks that read as intentional options (alternative legends, alternate xticks, alternate plot calls). **Exception:** EPS save lines (`% print -depsc ...`) are dead code — delete them per the table above.
- All saved output filenames inside `imgs/` (existing collisions stay)
- Variable names — except trivially obvious typos (e.g., `ticksFontSIze` → `ticksFontSize` is allowed; renaming `imgWidthSize` → `imgWidth` is **not** allowed)
- Any absolute filesystem paths (`/home/beom/...`, etc.) — keep as-is even if non-portable
- `load(...)` and `fopen(...)` arguments

### Per-file process

Per file, this is the loop:

1. Read original file end-to-end to understand its structure
2. `git mv plot_<old>.m <new>.m`
3. Edit `<new>.m` to apply the section template and the mandatory substitutions
4. Manually run the script in MATLAB (user-driven; agent cannot trigger MATLAB IDE)
5. Compare the just-generated `imgs/<output>.png` against the previous version (`git diff --stat imgs/`). Visual inspection.
6. If output is unchanged in intent, commit. If changed, investigate which substitution broke things.

The repo is already a git working tree on `main` with some uncommitted image changes. Each file refactor is one commit.

---

## Phase 1: Reference files (3 biou-related files)

These three files establish the canonical pattern. The user reviews after Phase 1 before continuing to Phase 2.

### Task 1: Refactor `plot_horizontal_bars2.m` → `horizontal_bars_hrnet.m`

**Files:**
- Modify (via rename): `plot_horizontal_bars2.m` → `horizontal_bars_hrnet.m`

**Original structure (read first):** 4 nearly identical sections (px=3 / px=7 / px=10 / px=20), each ~50 lines. Each section creates one horizontal stacked bar chart, saves PNG and EPS. Variables (`baseline`, `y`, `xlim`, title) differ per section. Drawing parameters (`linecolors`, `LineColors`, `baseline_color`, `sota_colors`, font sizes, BarWidth) are duplicated identically across all 4 sections.

**Target structure (Option C: keep 4 sections):** One shared `%% Initialize` at the top, then 4 repetitions of `%% Input data (px=N) / %% Drawing parameters (px=N) / %% Plot (px=N) / %% Save (px=N)`. Drawing parameters are NOT consolidated across sections — each section has its own copy (per spec Option C).

- [ ] **Step 1: Read original**

Run: `cat plot_horizontal_bars2.m | wc -l` (expect ~225 lines)

Then read the file end-to-end. Note that the legend block uses dummy `barh(nan, nan, ...)` and `patch(NaN, NaN, ...)` patches — these are **intentional**, do not delete.

- [ ] **Step 2: git mv**

```bash
git mv plot_horizontal_bars2.m horizontal_bars_hrnet.m
```

- [ ] **Step 3: Apply template to `horizontal_bars_hrnet.m`**

Replace the file content with this structure. Preserve every numeric value and every plot/legend/title/label call from the original.

```matlab
%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');

%% Input data (px=3)
baseline = 58.24;
y = [baseline 60.60-baseline; baseline 60.25-baseline; baseline 60.19-baseline];
xlim_   = [57.5 61.0];
titleTex = "Pixel threshold $\tau_B = 3$";
saveStem = "biou_horizontal_bar_w_hrnet_3px";

%% Drawing parameters (px=3)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=3)
figure('Position', [500, 50, 1200, 450]);
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'};

% Dummy bars + patches required so the legend renders the SOTA palette correctly
legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end
% legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle);

%% Save (px=3)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=7)
baseline = 62.65;
y = [baseline 64.96-baseline; baseline 64.56-baseline; baseline 64.51-baseline];
xlim_   = [62.0 65.5];
titleTex = "Pixel threshold $\tau_B = 7$";
saveStem = "biou_horizontal_bar_w_hrnet_7px";

%% Drawing parameters (px=7)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=7)
figure('Position', [500, 550, 1200, 450]);
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'};
legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end
% legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle);

%% Save (px=7)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=10)
baseline = 66.77;
y = [baseline 68.99-baseline; baseline 68.54-baseline; baseline 68.49-baseline];
xlim_   = [66.0 69.5];
titleTex = "Pixel threshold $\tau_B = 10$";
saveStem = "biou_horizontal_bar_w_hrnet_10px";

%% Drawing parameters (px=10)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=10)
figure('Position', [500, 1050, 1200, 450]);
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'};
legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end
% legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle);

%% Save (px=10)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');

%% Input data (px=20)
baseline = 72.92;
y = [baseline 74.93-baseline; baseline 74.41-baseline; baseline 74.40-baseline];
xlim_   = [72.5 75.5];
titleTex = "Pixel threshold $\tau_B = 20$";
saveStem = "biou_horizontal_bar_w_hrnet_20px";

%% Drawing parameters (px=20)
% --- Sizes ---
common_fontsize = 32;
barWidth        = 0.8;
% --- Fonts ---
fontXLabel = 28;
fontTitle  = 28;
fontAxis   = 25;
fontLgd    = 23;
% --- Colors ---
linecolors      = linspecer(6, 'qualitative');
LineColors      = flipud(linecolors);
baseline_color  = [0.1647    0.0353    0.26670];
sota_colors     = [LineColors(4, :);
                  0.9451    0.9255    0.7843;
                  0.5216    0.6706    0.8118];

%% Plot (px=20)
figure('Position', [500, 1550, 1200, 450]);
b = barh(y,'stacked', 'BarWidth', barWidth);

ax = gca;
ax.YAxis.FontSize = common_fontsize;

set(b(1), 'FaceColor', baseline_color);
b(2).FaceColor = 'flat';
b(2).CData = sota_colors;

yticklabels({'W/ Ours', 'W/ Contextrast [62]', 'W/ Multi [61]'});
ax.YAxis.FontSize = fontAxis;
ax.XAxis.FontSize = fontAxis;
xlabel("B-mIoU\,(\%)\,$\uparrow$ ", 'interpreter', 'latex', "FontSize", fontXLabel);
xlim(xlim_);

hold on;
% legend_labels = {'HRNet [27]$\;$', 'Multi [61]$\;$', 'Contextrast [62]$\;$', 'Contextrast++ (Ours)'};
legend_handles = gobjects(1, length(legend_labels));
legend_handles(1) = barh(nan, nan, 'FaceColor', baseline_color);
for i = 1:size(sota_colors, 1)
    legend_handles(i+1) = patch(NaN, NaN, sota_colors(4-i, :));
end
% legend(legend_handles, legend_labels, 'Location', 'southoutside', 'NumColumns', 4, 'FontSize', fontLgd, 'Interpreter', 'latex');

hold off;
title(titleTex, 'interpreter', 'latex', "FontSize", fontTitle);

%% Save (px=20)
exportgraphics(gcf, "imgs/" + saveStem + ".png", 'Resolution', 300);
exportgraphics(gcf, "imgs/" + saveStem + ".pdf", 'ContentType', 'vector');
```

**Note:** the px=20 section in the original had `legend_labels = {...}` already commented out — preserved here. The `legend_handles` line that depends on `legend_labels` is now broken in that section (variable from previous run). This bug exists in the original too — DO NOT fix it (not in scope).

- [ ] **Step 4: User runs script in MATLAB**

Open `horizontal_bars_hrnet.m` in MATLAB IDE. Press F5 (or Cmd+Enter per cell). 4 figures pop up. 4 PNG files and 4 PDF files (new — `imgs/biou_horizontal_bar_w_hrnet_*.pdf`) are written to `imgs/`.

- [ ] **Step 5: Visual diff**

Run: `git status imgs/` — expect 4 modified PNG files plus 4 new PDF files.

Open `imgs/biou_horizontal_bar_w_hrnet_3px.png` in Preview. Compare side-by-side with the previous version retrieved via:
```bash
git show HEAD:imgs/biou_horizontal_bar_w_hrnet_3px.png > /tmp/prev_3px.png
open /tmp/prev_3px.png
```
Repeat for 7px, 10px, 20px. Bar positions, colors, axis ranges, and titles must match the originals.

- [ ] **Step 6: Commit**

```bash
git add horizontal_bars_hrnet.m imgs/biou_horizontal_bar_w_hrnet_*.png imgs/biou_horizontal_bar_w_hrnet_*.pdf
git status  # confirm plot_horizontal_bars2.m is staged for deletion via the rename
git commit -m "$(cat <<'EOF'
Refactor horizontal_bars2.m → horizontal_bars_hrnet.m

Apply 5-section template (Initialize / Input data / Drawing
parameters / Plot / Save) per spec. Migrate print → exportgraphics
for PNG (300dpi) + PDF (vector). Drop EPS. clear all → clearvars.
Output filenames unchanged.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 2: Refactor `plot_linegraph3.m` → `linegraph_biou_pxthr.m`

**Files:**
- Modify (via rename): `plot_linegraph3.m` → `linegraph_biou_pxthr.m`

**Original structure:** Single figure. Plots B-mIoU vs. pixel threshold (log scale x-axis) for HRNet baseline + 3 SOTA lines. Lots of commented-out alternate plot calls (preserve them — intentional options).

- [ ] **Step 1: Read original**

```bash
cat plot_linegraph3.m
```

- [ ] **Step 2: git mv**

```bash
git mv plot_linegraph3.m linegraph_biou_pxthr.m
```

- [ ] **Step 3: Apply template**

Rewrite `linegraph_biou_pxthr.m` as:

```matlab
%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter','latex');

%% Input data
% B-mIoU values per pixel threshold for HRNet and three SOTA methods
x             = [5, 7, 10, 20];
hrnet         = [58.24 62.65 66.77 72.92];
multi         = [60.19 64.51 68.49 74.40];
contextrast   = [60.25 64.56 68.54 74.41];
contextrastpp = [60.60 64.96 68.99 74.93];

%% Drawing parameters
% --- Sizes ---
imgWidthSize  = 500;
imgColumnSize = 500;
lw            = 3.0;
ms            = 20;
numLgdCol     = 1;
% --- Fonts ---
titleFontSize = 19;
XFontSize     = 25;
YFontSize     = 25;
lgdFontSize   = 23;
ticksFontSize = 22;   % typo fix: was ticksFontSIze
% --- Colors ---
linecolors     = linspecer(5, 'qualitative');
LineColors     = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors    = [0.3718    0.7176    0.3612;
                 0.9451    0.9255    0.7843;
                 0.5216    0.6706    0.8118];

%% Plot
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))

% plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color);
% hold on;
% plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :));
% plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :));
% plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :));
% set(gca, 'FontSize', ticksFontSize);
%
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

h1 = plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color, 'MarkerFaceColor', baseline_color, 'DisplayName', 'HRNet [27]');
hold on;
h2 = plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :), 'MarkerFaceColor', sota_colors(3, :), 'DisplayName', 'Multi [61]');
h3 = plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :), 'MarkerFaceColor', sota_colors(2, :),'DisplayName', 'Contextrast [62]');
h4 = plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :), 'MarkerFaceColor', sota_colors(1, :), 'DisplayName', 'Contextrast++ (Ours)');
set(gca, 'FontSize', ticksFontSize);

legend([h1, h2, h3, h4], 'NumColumns', numLgdCol, 'Location', 'southeast', ...
    'FontSize', lgdFontSize, 'Interpreter', 'latex');
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

set(gca, 'XScale', 'log');
grid on;
xlabel("Pixel threshold, $\tau_B$ (pixel)", 'FontSize', XFontSize, 'interpreter','latex');
ylabel("Boundary-mIoU (\%) $\uparrow$", 'FontSize', YFontSize, 'interpreter','latex');

%% Save
exportgraphics(gcf, "imgs/biou_line_graph.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/biou_line_graph.pdf", 'ContentType', 'vector');
```

**Notes:**
- Typo fix: `ticksFontSIze` → `ticksFontSize` (allowed per spec)
- The `set(groot, 'defaultAxesTickLabelInterpreter','latex')` call appears once in `%% Initialize` only; the duplicate inside the original `%% Visualization` block is removed because it's identical and idempotent.
- The output filename `biou_line_graph.png` is **unchanged** (intentional — collision with `linegraph_biou_masking.m` accepted).

- [ ] **Step 4: User runs in MATLAB**

Open in MATLAB, F5. One figure pops up.

- [ ] **Step 5: Visual diff**

```bash
git show HEAD:imgs/biou_line_graph.png > /tmp/prev_biou.png
open /tmp/prev_biou.png imgs/biou_line_graph.png
```

Confirm: line markers at x = [5,7,10,20], y values match, legend shows 4 entries, log-scale x-axis.

- [ ] **Step 6: Commit**

```bash
git add linegraph_biou_pxthr.m imgs/biou_line_graph.png imgs/biou_line_graph.pdf
git commit -m "$(cat <<'EOF'
Refactor linegraph3.m → linegraph_biou_pxthr.m

Apply 5-section template per spec. Migrate to exportgraphics
(PNG + PDF). Output filename biou_line_graph.{png,pdf} unchanged
(intentional collision with linegraph_biou_masking.m accepted).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 3: Refactor `plot_linegraph4.m` → `linegraph_biou_masking.m`

**Files:**
- Modify (via rename): `plot_linegraph4.m` → `linegraph_biou_masking.m`

**Original structure:** Single figure. Draft / TBU plot — "Dummy performance (TBU)" y-axis. Plots Baseline 1 / Baseline 2 / Ours vs. scene-graph masking ratio. Same SOTA color palette as linegraph3 but no HRNet line.

- [ ] **Step 1: Read original**

```bash
cat plot_linegraph4.m
```

- [ ] **Step 2: git mv**

```bash
git mv plot_linegraph4.m linegraph_biou_masking.m
```

- [ ] **Step 3: Apply template**

Rewrite `linegraph_biou_masking.m` as:

```matlab
%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter','latex');

%% Input data
% Draft (TBU) — masking-ratio sweep on dummy y-axis
x         = [2.5, 5.0, 7.5, 10];
baseline1 = [72.92 66.77 62.65 58.24];
baseline2 = [74.40 68.49 64.51 60.19];
ours      = [74.93 68.99 64.96 60.60];

%% Drawing parameters
% --- Sizes ---
imgWidthSize  = 500;
imgColumnSize = 500;
lw            = 3.0;
ms            = 20;
numLgdCol     = 1;
% --- Fonts ---
titleFontSize = 19;
XFontSize     = 20;
YFontSize     = 20;
lgdFontSize   = 18;
ticksFontSize = 18;   % typo fix: was ticksFontSIze
% --- Colors ---
linecolors     = linspecer(5, 'qualitative');
LineColors     = flipud(linecolors);
baseline_color = [0.1647    0.0353    0.26670];
sota_colors    = [0.3718    0.7176    0.3612;
                 0.9451    0.9255    0.7843;
                 0.5216    0.6706    0.8118];

%% Plot
fig = figure('Position', [200, 10, imgWidthSize, imgColumnSize]);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))

% plot(x, hrnet, '-o', 'LineWidth', lw, 'MarkerSize', ms, 'Color', baseline_color);
% hold on;
% plot(x, multi, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :));
% plot(x, contextrast, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :));
% plot(x, contextrastpp, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :));
% set(gca, 'FontSize', ticksFontSize);
%
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

h2 = plot(x, baseline1, '-v', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(3, :), 'MarkerFaceColor', sota_colors(3, :), 'DisplayName', 'Baseline 1');
hold on;
h3 = plot(x, baseline2, '-d', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(2, :), 'MarkerFaceColor', sota_colors(2, :),'DisplayName', 'Baseline 2');
h4 = plot(x, ours, '-s', 'LineWidth', lw, 'MarkerSize', ms, 'Color', sota_colors(1, :), 'MarkerFaceColor', sota_colors(1, :), 'DisplayName', 'Ours');
set(gca, 'FontSize', ticksFontSize);

legend([h2, h3, h4], 'NumColumns', numLgdCol, 'Location', 'southwest', ...
    'FontSize', lgdFontSize, 'Interpreter', 'latex');
% legend(['HRNet [27]$\;$', 'Multi [50]$\;$', 'Contextrast [51]$\;$', 'Contextrast++ (Ours)'], 'NumColumns', numLgdCol, "Location", "southeast", 'FontSize', lgdFontSize, 'interpreter','latex');

% set(gca, 'XScale', 'log');
grid on;
xlabel("Scene graph masking ratio [\%]", 'FontSize', XFontSize, 'interpreter','latex');
ylabel("Dummy performance (TBU)", 'FontSize', YFontSize, 'interpreter','latex');

%% Save
exportgraphics(gcf, "imgs/biou_line_graph.png", 'Resolution', 300);
exportgraphics(gcf, "imgs/biou_line_graph.pdf", 'ContentType', 'vector');
```

**Notes:**
- Output filename `biou_line_graph.{png,pdf}` collides with `linegraph_biou_pxthr.m` — kept intentionally.
- Typo fix: `ticksFontSIze` → `ticksFontSize`.
- Commented-out `set(gca, 'XScale', 'log')` preserved — looks like an intentional toggle.

- [ ] **Step 4: User runs in MATLAB**

Open in MATLAB, F5. One figure pops up.

- [ ] **Step 5: Visual diff**

```bash
open imgs/biou_line_graph.png
```

Confirm: 3 lines (no HRNet baseline), x-axis ticks at [2.5, 5.0, 7.5, 10] (linear, not log), legend at southwest, "Dummy performance (TBU)" y-label.

- [ ] **Step 6: Commit**

```bash
git add linegraph_biou_masking.m imgs/biou_line_graph.png imgs/biou_line_graph.pdf
git commit -m "$(cat <<'EOF'
Refactor linegraph4.m → linegraph_biou_masking.m

Apply 5-section template per spec. Migrate to exportgraphics
(PNG + PDF). Drop EPS save. Output filename biou_line_graph
unchanged (collides with linegraph_biou_pxthr; user-accepted).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 4: User-review checkpoint

**Stop here.** Before continuing to Phase 2, the user reviews the three reference files (`horizontal_bars_hrnet.m`, `linegraph_biou_pxthr.m`, `linegraph_biou_masking.m`) and confirms the pattern is correct. Phase 2 applies the same transformation 21 more times — any pattern issues caught here save 21 fixes.

- [ ] **Step 1: Summarize for user**

Report:
- The 3 reference files renamed and refactored
- Output images visually unchanged
- 3 commits added (rename + restructure each)

- [ ] **Step 2: Wait for user confirmation**

User says "looks good, proceed" or requests pattern adjustments. If adjustments, apply them retroactively to the 3 reference files (commit fixups), then proceed.

---

## Phase 2: Remaining 21 files

Each task in Phase 2 follows the same 6-step recipe (read → git mv → apply template → user runs → visual diff → commit). To keep this plan readable, each task lists only:
- The rename
- File-specific gotchas
- Original structure summary

The transformation rules in **"Standard transformation rules"** above apply to all of them.

---

### Task 5: `plot_linegraph1.m` → `linegraph_caros.m`

**Original:** 4 figures (rotor speed / pitch & alpha / orientation / position) over time. Loads `materials/caros/plot_data.mat`. Uses `saveas(gcf, "imgs/caros_*.png")` — no resolution argument. Existing `% print -depsc 'imgs/caros_*.eps'` lines are commented (delete per substitution table).

**Outputs (unchanged):** `imgs/caros_rotor_speed.{png,pdf}`, `imgs/caros_pitch_alpha.{png,pdf}`, `imgs/caros_orientation.{png,pdf}`, `imgs/caros_position.{png,pdf}`.

**Per-section structure:** Each of the 4 figures gets `%% Input data (<rotor|pitch_alpha|orientation|position>)` / `%% Drawing parameters (<...>)` / `%% Plot (<...>)` / `%% Save (<...>)`.

**Gotcha:** The 4 figures use shared `rs`, `cs`, `fs`, `positionfs`, `xls`, `yls`, `lw`, `lw_rotor`, `ms` parameters in the original. Per spec Option C (multi-figure files duplicate within sections), each section gets its own copy of every parameter it uses. Values stay identical — copy them verbatim into each section.

**Data loading:** `load materials/caros/plot_data.mat` belongs in `%% Initialize` (one-time data load).

- [ ] Apply per-file process (read → git mv → apply template → user runs → visual diff → commit). Use the standard transformation rules above.

---

### Task 6: `plot_linegraph2.m` → `linegraph_erasor_ground.m`

**Original:** 4 figures (preservation / rejection / percentage / REL rate) over ground threshold. All inline data (no .mat load). Uses `saveas(gcf, "imgs/erasor_ground_*.png")`.

**Outputs (unchanged):** `imgs/erasor_ground_preservation.{png,pdf}`, `imgs/erasor_ground_rejection.{png,pdf}`, `imgs/erasor_ground_percentage.{png,pdf}`, `imgs/erasor_ground_rel.{png,pdf}`.

**Per-section structure:** 4 figures, each their own Input data / Drawing parameters / Plot / Save (Option C).

**Gotcha:** Drawing parameters (`imgWidthSize`, `lw`, `ms`, fonts, `LineColors`) are identical across all 4 figures in the original — duplicate verbatim into each section per spec.

- [ ] Apply per-file process.

---

### Task 7: `plot_linegraph5.m` → `linegraph_vggt.m`

**Original:** 4 figures (ATE / Accuracy / Completion / Chamfer) over confidence threshold for w8/w16/w32 windows. Uses `LineColors = flipud(LineColors)` twice — preserve. Uses `print(gcf, ..., '-dpng', '-r300')` and `print -depsc` — migrate per substitution table.

**Outputs (unchanged):** `imgs/vggt_ate.{png,pdf}`, `imgs/vggt_accuracy.{png,pdf}`, `imgs/vggt_completion.{png,pdf}`, `imgs/vggt_chamfer.{png,pdf}`.

**Per-section structure:** 4 figures × Input/Drawing params/Plot/Save.

**Gotcha:** The legend is only shown on the 4th plot (Chamfer); on the first 3 the `legend(...)` line is commented. Preserve.

- [ ] Apply per-file process.

---

### Task 8: `plot_linegraph6.m` → `linegraph_hydra_sam3d.m`

**Original:** 3 figures (Precision / Recall / F1) over normalized threshold for SAM3D and CRISP variants. Already uses `exportgraphics` for PDF + `print` for PNG. Migrate `print` → `exportgraphics` for PNG. Existing `% print -depsc` commented lines: delete.

**Outputs (unchanged):** `imgs/hydra2_0_precision.{png,pdf}`, `imgs/hydra2_0_recall.{png,pdf}`, `imgs/hydra2_0_f1.{png,pdf}`. Note: collides with linegraph_hydra_pr.m output — intentional per spec.

**Gotcha:** `clc; clear; close all;` on line 1 → split into `%% Initialize` block: `clc; close all; clearvars;`.

- [ ] Apply per-file process.

---

### Task 9: `plot_linegraph7.m` → `linegraph_hydra_pr.m`

**Original:** 3 figures (Precision / Recall / F1) for Hydra / Khronos / SlideSLAM / CRISP comparison. Uses `print` for PNG + `exportgraphics` for PDF. Migrate `print` → `exportgraphics` for PNG.

**Outputs (unchanged):** `imgs/hydra2_0_precision.{png,pdf}`, `imgs/hydra2_0_recall.{png,pdf}`, `imgs/hydra2_0_f1.{png,pdf}`.

**Gotcha:** Many commented-out alternative blocks for SlideSLAM† variant — preserve.

- [ ] Apply per-file process.

---

### Task 10: `plot_barplot.m` → `barplot_gpf_precision.m`

**Original:** 1 figure. Bar chart of GPF vs. R-GPF precision per KITTI sequence (00/01/02/05/07). Has data labels (`text(xtips, ytips, labels)`).

**Output filename gotcha:** This file currently does **not** have any save call! Need to verify by reading the full file. If no save exists, the file ends without producing an image. Behavior: user has been running it and screenshotting? Check by re-reading. **If no `print`/`saveas`/`exportgraphics`, leave it without save block** — adding one would change behavior (constraint).

- [ ] Read full file with `cat plot_barplot.m | wc -l` and grep for save commands. If none, this file gets the 4 sections (Initialize / Input data / Drawing parameters / Plot) without a `%% Save`. Document the absence in a one-line comment in `%% Initialize`: `% Note: this script does not write to disk; figure is interactive only.`
- [ ] Apply per-file process.

---

### Task 11: `plot_barplot_avg_computation_time.m` → `barplot_quatro_runtime.m`

**Original:** 1 figure. Horizontal stacked bar chart for Quatro vs. Quatro++ runtime breakdown. Loads from absolute path `/home/beom/DATASET/...` (will fail if path doesn't exist; not our concern). The actual `y` array is hardcoded after the load.

**Output:** Verify by reading. If save call exists, keep its filename unchanged.

- [ ] Apply per-file process.

---

### Task 12: `plot_barplot_maxclique_num.m` → `barplot_maxclique.m`

**Original:** 3 figures (max clique / rot inlier / trans inlier counts). Loads per-sequence data from absolute paths in a loop. Uses `print(gcf, "num_*.png", '-dpng', '-r300')` — note: paths are relative to CWD (no `imgs/` prefix). Preserve.

**Outputs (unchanged):** `num_MC.png`, `num_rot_inlier.png`, `num_trans_inlier.png` (in CWD, not `imgs/`). Add corresponding PDFs: `num_MC.pdf` etc.

- [ ] Apply per-file process.

---

### Task 13: `plot_barplot_success_rate.m` → `barplot_success_rate.m`

**Original:** Largest file in the set (~770 lines). 5 figures. Many absolute paths, lots of commented-out variant code. Saves to `SuccessRate1_quatro_pp.png`, `SuccessRate2_quatro_pp.png`, `RANSAC10K_success_rate.png`, `FGR_success_rate.png`, `TEASER_success_rate.png` — all in CWD root, no `imgs/` prefix. Preserve.

**Outputs (unchanged):** as above. Add corresponding PDFs.

**Gotcha:** This file has commented-out `% print(gcf, "SuccessRate1.png", ...)` and `% saveas(gcf, "output/succ_rate.png")` / `% print -depsc 'output/succ_rate.eps'` blocks. These are commented-out save calls (not legend/style alternatives) — per the substitution table, `% print -depsc ...` lines are dead code → delete. Other commented-out save calls: leave (they're alternate output paths, intentional toggle).

- [ ] Apply per-file process. This is the longest task — section the 5 figures clearly.

---

### Task 14: `plot_boxplot2.m` → `boxplot_runtime.m`

**Original:** 1 figure (boxplot of RANSAC/FGR/TEASER/SONNY runtimes). Loads `materials/box_plot2.mat`. Uses `print(gcf, "imgs/box_plot2_r300.png", '-dpng', '-r300')`.

**Outputs (unchanged):** `imgs/box_plot2_r300.png` + new `imgs/box_plot2_r300.pdf`.

- [ ] Apply per-file process.

---

### Task 15: `plot_boxplots.m` → `boxplot_aoa_ssa.m`

**Original:** 2 figures (AOA error boxplot / SSA error boxplot). Loads `materials/aoa_error.mat` and `materials/ssa_error.mat`. Uses `saveas(gcf, "imgs/boxplot1.png", '-dpng', '-r300')` — note: `saveas` does not accept `-dpng`/`-r300` flags so they're silently ignored in current code. Migrate to `exportgraphics(..., 'Resolution', 300)` per substitution table.

**Outputs (unchanged):** `imgs/boxplot1.{png,pdf}`, `imgs/boxplot2.{png,pdf}`.

- [ ] Apply per-file process.

---

### Task 16: `plot_cdf.m` → `cdf_angles.m`

**Original:** Multi-figure CDF script. Loads many CSV files via `parseCSV`. Plots alpha/beta angle CDFs across multiple sequences and model types (RNN/GRU/LSTM, elements/all). Several figures generated.

**Outputs (unchanged):** verify by reading full file (search for `print`/`saveas`/`exportgraphics` calls).

**Gotcha:** Heavy data-loading section. All `parseCSV` and `load` calls go in `%% Initialize` (one shared block at top), then per-figure `%% Input data` selects what to plot from loaded variables.

- [ ] Apply per-file process. Read the full file first; this is one of the longer ones.

---

### Task 17: `plot_cdf2.m` → `cdf_chamfer.m`

**Original:** CDF script for chamfer-distance precision/recall comparison across mesh_objects / khronos / CRISP variants. Loads via `fopen`/`textscan` from absolute paths. Multiple figures.

**Outputs (unchanged):** verify by reading.

- [ ] Apply per-file process.

---

### Task 18: `plot_pdf.m` → `pdf_erasor_scan_ratio.m`

**Original:** 1 figure. Histogram-based PDF of dynamic vs. static scan ratios. Loads `materials/pdf.mat`. Uses `saveas(gcf, "imgs/erasor_pdf_diff_percentage.png")` (no resolution arg).

**Outputs (unchanged):** `imgs/erasor_pdf_diff_percentage.{png,pdf}`.

- [ ] Apply per-file process.

---

### Task 19: `plot_horizontal_bars.m` → `horizontal_bars_deeplabv3.m`

**Original:** Multi-section horizontal stacked bar chart for DeepLabv3 baseline. Search for save calls to identify N figures.

**Outputs:** verify by reading. Likely follows pattern of `plot_horizontal_bars2.m`.

- [ ] Apply per-file process. Multi-figure (Option C).

---

### Task 20: `plot_pr_curve.m` → `prcurve_hydra.m`

**Original:** 2 figures (precision-recall curve + F1-vs-threshold). Already uses `print` + `exportgraphics` mix. Computes `bestF1_*` values and uses them in legend strings.

**Outputs (unchanged):** `imgs/precision_recall_curve.{png,pdf}`, `imgs/f1_vs_threshold.{png,pdf}`.

**Gotcha:** The legend strings include computed `sprintf` values (`bestF1_*`, `th_*`). These computations happen in the script body — they belong in `%% Input data` (they're derived data, not drawing parameters).

- [ ] Apply per-file process. 2 figures (Option C).

---

### Task 21: `plot_scatter_w_heatmap.m` → `scatter_heatmap_weights.m`

**Original:** 1 figure. Scatter plot of TIMS source/target with weight-based heatmap coloring. Conditional on `iter` parameter at top (`iter = 0` vs. `iter > 0`). Uses `saveas(gcf, save_path, "png")` and `print -depsc 'imgs/tims_rotation_v3_0.eps'`.

**Outputs:** `save_path` is dynamic — verify by reading what it resolves to. Likely `imgs/tims_rotation_v3_0.png`. Add corresponding PDF.

**Gotcha:** The `iter` parameter at top toggles modes. It belongs in `%% Initialize` as a tunable knob (with a comment noting it's user-adjusted).

- [ ] Apply per-file process. Read full file first.

---

### Task 22: `plot_tilelayout.m` → `tilelayout_pasga.m`

**Original:** PaSGA ablation. Uses `tiledlayout` (not `figure` per panel). Saves to `./imgs/final_tilelayout.png` via `saveas`.

**Output (unchanged):** `imgs/final_tilelayout.{png,pdf}`.

**Gotcha:** Single tiledlayout — treat as one figure. The `nexttile` calls are part of `%% Plot`.

- [ ] Apply per-file process.

---

### Task 23: `plot_time_stacked.m` → `area_xavier_time.m`

**Original:** 1 figure. Uses `area(x, Y, ...)` — stacked area chart, not stacked bar. Loads `materials/xavier_save_times.txt`. Uses `print(gcf, "imgs/time_stacked.png", '-dpng', '-r300')` and `print -depsc 'imgs/time_stacked.eps'`.

**Outputs (unchanged):** `imgs/time_stacked.{png,pdf}`.

- [ ] Apply per-file process.

---

### Task 24: `plot_trajectory.m` → `trajectory_3d_utm.m`

**Original:** 1 figure. 3D trajectory plot using `plot3` with color gradient via `set(p.Edge, 'ColorBinding','interpolated', 'ColorData', cd)`. Loads `materials/trajectory_utm.mat`.

**Outputs:** verify by reading (search for save calls).

**Gotcha:** The color-binding manipulation requires `drawnow` before it — preserve order exactly.

- [ ] Apply per-file process.

---

### Task 25: `plot_trajectory_w_airbornej.m` → `trajectory_vbr.m`

**Original:** Trajectory plot for VBR dataset. Hardcoded `file_path` near top, with several alternate paths commented (intentional toggle — preserve all). Multiple `print(gcf, "imgs/<seq>_gt.png", ...)` save calls in a conditional block.

**Outputs (unchanged):** Several `imgs/*_train*_gt.{png,pdf}` files (depending on which `file_path` is active).

**Gotcha:** Many commented-out save blocks for alternative datasets — preserve. The active save block matches the active `file_path` — preserve that pairing.

- [ ] Apply per-file process.

---

## Phase 3: Cleanup

### Task 26: Verify final state

- [ ] **Step 1: List old plot_*.m files**

```bash
ls plot_*.m 2>/dev/null
```

Expected: empty (no files match).

- [ ] **Step 2: List new files (sanity-check rename mapping)**

```bash
ls -1 *.m | grep -E '^(linegraph|barplot|boxplot|cdf|pdf|horizontal_bars|prcurve|scatter|tilelayout|area|trajectory)_' | sort
```

Expected: 24 files matching the mapping table at the top of this plan.

- [ ] **Step 3: Verify no references to old filenames remain**

```bash
git grep -l 'plot_horizontal_bars2\|plot_linegraph[1-7]\|plot_barplot\|plot_boxplot\|plot_cdf\|plot_pdf\|plot_pr_curve\|plot_scatter_w\|plot_tilelayout\|plot_time_stacked\|plot_trajectory' -- '*.m' '*.md'
```

Expected: only matches inside `docs/superpowers/specs/` and `docs/superpowers/plans/` (this plan and the spec). No matches in any `.m` file.

- [ ] **Step 4: Verify all save calls use `exportgraphics`**

```bash
git grep -E "^\s*print\s*\(\s*gcf|^\s*print\s+-depsc|^\s*saveas\s*\(" -- '*.m'
```

Expected: no matches. (Commented-out occurrences are fine — only uncommented uses of the old API are forbidden.)

- [ ] **Step 5: Verify no `clear all` remains**

```bash
git grep -E '^\s*clear\s+all\s*;?\s*$' -- '*.m'
```

Expected: no matches.

- [ ] **Step 6: Final commit (if any cleanup needed) and summary**

If any of the above checks fail, fix the offending file and commit. Then summarize:
- 24 files renamed and refactored
- Total commits added: ~25 (one per file + this verification)
- Output images visually unchanged
- All save calls use `exportgraphics`
- All `clear all` replaced with `clearvars`

---

## Notes for the executing agent

1. **MATLAB is not invokable from this environment** — visual verification depends on the user running each script in MATLAB IDE. Don't try to invoke MATLAB CLI unless the user confirms it's available.
2. **`git mv` first, then edit** — this maximizes git's chance of detecting the rename. If the edit is too aggressive and similarity drops below 50%, history is lost. Test with `git log --follow <newname>` after each rename commit.
3. **Trust the spec; don't second-guess the user's design choices** — Option C (per-section duplication) is intentional. Don't try to dedupe.
4. **Output filename collisions are intentional** — `biou_line_graph.{png,pdf}` is written by both `linegraph_biou_pxthr.m` and `linegraph_biou_masking.m`. `hydra2_0_*.{png,pdf}` is written by both `linegraph_hydra_sam3d.m` and `linegraph_hydra_pr.m`. Don't add suffixes.
5. **Absolute paths in load calls stay** — `/home/beom/...` paths exist in several files. They won't run on this machine. Don't fix them.
6. **Phase 1 is a checkpoint** — after Tasks 1-3 finish, stop and wait for user review before Phase 2.
