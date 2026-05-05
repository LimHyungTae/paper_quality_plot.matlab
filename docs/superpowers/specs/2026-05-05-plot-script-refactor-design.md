# Plot script refactor design

**Date:** 2026-05-05
**Status:** Approved (pending implementation plan)

## Goal

Reorganize every `plot_*.m` figure script in this repository so that input data, drawing parameters, plotting code, and saving are clearly separated within each file. Apply MATLAB conventions consistently. Rename files for distinctiveness and category-level alphabetical grouping.

The reorg is **structural only** — generated figures must stay visually identical. No content (numbers, colors, sizes, layouts) changes.

## Scope

**In scope:** all `plot_*.m` plotting scripts (24 files).

**Out of scope:**
- Utility / data-prep files: `calcCDF.m`, `calcModelAidedOutput.m`, `linspecer.m`, `multiple_boxplot_time.m`, `parseCSV.m`, `parseRawCSV.m`, `RMSE.m`, `template.m`
- `.asv` autosave files — leave untouched (MATLAB regenerates these)
- Subdirectories: `materials/`, `scripts/`, `statannots/`, `imgs/`
- Output filenames inside `imgs/` — keep exactly as-is (existing collisions accepted)
- Combining figures into subplots, or any other content/layout changes

## Constraints

The user's hard constraint: **code organization only**. Do not introduce changes that could break a working script. In particular:
- Do not rename plot variables unless fixing an obvious typo (e.g., `ticksFontSIze` → `ticksFontSize`)
- Do not modify plot commands, color values, font sizes, axis limits, legend strings, or figure positions
- Do not delete commented-out alternative blocks that read as intentional options (e.g., commented legend strings, alternate xtick lists, alternate plot styles). Commented-out save calls related to the dropped EPS format (e.g., `% print -depsc 'foo.eps'`) **are** removed as dead code.
- Do not consolidate `set(groot, ...)` calls if they vary across figures within the same file
- Do not change saved output filenames in `imgs/`
- Do not introduce shared helpers or library files; each script remains self-contained

## File rename mapping

Pattern: `<category>_<distinctive>.m`. Same-category files sort together. Side benefit: `pdf_*.m` and `cdf_*.m` no longer shadow MATLAB Stats Toolbox functions.

| Old | New | Content |
|---|---|---|
| `plot_linegraph1.m` | `linegraph_caros.m` | caros flight data (rotor / pitch / orient / pos vs. time) |
| `plot_linegraph2.m` | `linegraph_erasor_ground.m` | ERASOR ground threshold 4-panel |
| `plot_linegraph3.m` | `linegraph_biou_pxthr.m` | B-mIoU vs. pixel threshold (HRNet + SOTA) |
| `plot_linegraph4.m` | `linegraph_biou_masking.m` | masking-ratio dummy/draft |
| `plot_linegraph5.m` | `linegraph_vggt.m` | VGGT ATE / Acc / Compl / Chamfer |
| `plot_linegraph6.m` | `linegraph_hydra_pr.m` | Hydra2.0 PR-curve (Hydra/Khronos/CRISP/SlideSLAM) |
| `plot_linegraph7.m` | `linegraph_hydra_sam3d.m` | Hydra2.0 PR-curve (SAM3D variants) |
| `plot_barplot.m` | `barplot_gpf_precision.m` | GPF vs. R-GPF precision |
| `plot_barplot_avg_computation_time.m` | `barplot_quatro_runtime.m` | Quatro vs. Quatro++ runtime |
| `plot_barplot_maxclique_num.m` | `barplot_maxclique.m` | max-clique inlier counts |
| `plot_barplot_success_rate.m` | `barplot_success_rate.m` | (unchanged stem; prefix dropped) |
| `plot_boxplot2.m` | `boxplot_runtime.m` | RANSAC / FGR / TEASER / SONNY timing |
| `plot_boxplots.m` | `boxplot_aoa_ssa.m` | AOA / SSA error |
| `plot_cdf.m` | `cdf_angles.m` | alpha/beta CDF (RNN/GRU/LSTM) |
| `plot_cdf2.m` | `cdf_chamfer.m` | chamfer-distance CDF |
| `plot_pdf.m` | `pdf_erasor_scan_ratio.m` | ERASOR scan-ratio PDF |
| `plot_horizontal_bars.m` | `horizontal_bars_deeplabv3.m` | DeepLabv3 baseline |
| `plot_horizontal_bars2.m` | `horizontal_bars_hrnet.m` | HRNet baseline (4 px thresholds) |
| `plot_pr_curve.m` | `prcurve_hydra.m` | precision-recall + F1-vs-threshold |
| `plot_scatter_w_heatmap.m` | `scatter_heatmap_weights.m` | TIMS weights heatmap |
| `plot_tilelayout.m` | `tilelayout_pasga.m` | PaSGA ring/sector ablation |
| `plot_time_stacked.m` | `area_xavier_time.m` | Xavier per-stage time (uses `area`) |
| `plot_trajectory.m` | `trajectory_3d_utm.m` | 3D UTM trajectory |
| `plot_trajectory_w_airbornej.m` | `trajectory_vbr.m` | VBR dataset trajectories |

Rename uses `git mv` to preserve history.

## Output filenames

**Unchanged** for every file. Existing collisions stay:
- `linegraph_biou_pxthr.m` and `linegraph_biou_masking.m` both still write to `imgs/biou_line_graph.{png,pdf}`
- `linegraph_hydra_sam3d.m` and `linegraph_hydra_pr.m` both still write to `imgs/hydra2_0_{precision,recall,f1}.{png,pdf}`

The user accepts these collisions. The whichever-runs-last semantics already match current behavior.

## Standard file template

```matlab
%% Initialize
clc; close all; clearvars;
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
% ... any other one-time global setup

%% Input data
% raw experimental numbers go here, no plotting calls
x          = [...];
hrnet      = [...];
% ...

%% Drawing parameters
% --- Sizes ---
imgWidth  = 500;
imgHeight = 500;
lw        = 3.0;
ms        = 20;

% --- Fonts ---
fontTitle = 19;
fontAxis  = 25;
fontLgd   = 23;
fontTicks = 22;

% --- Colors ---
colorBase  = [0.165 0.035 0.267];
colorsSota = [0.372 0.718 0.361
              0.945 0.926 0.784
              0.522 0.671 0.812];

%% Plot
fig = figure('Position', [200, 10, imgWidth, imgHeight]);
% ... drawing logic; references variables defined above only

%% Save
exportgraphics(gcf, 'imgs/<name>.png', 'Resolution', 300);
exportgraphics(gcf, 'imgs/<name>.pdf', 'ContentType', 'vector');
```

### Multi-figure files (Option C: keep N sections)

Files with multiple independent figures (e.g., `horizontal_bars_hrnet.m` with 4 px thresholds, `linegraph_caros.m` with 4 panels, `linegraph_vggt.m` with 4 metrics, `prcurve_hydra.m` with PR + F1) keep one shared `%% Initialize` at the top, then each figure has its own `%% Input data (<label>)`, `%% Drawing parameters (<label>)`, `%% Plot (<label>)`, `%% Save (<label>)` block. Duplication is accepted in exchange for per-section copy-pasteability.

## MATLAB convention upgrades

These are the only behavioral changes, all explicitly approved by the user:

1. `clear all` / `clear` → `clearvars` (faster; doesn't flush MEX/Java caches)
2. All `print(gcf, ..., '-dpng', '-r300')` and `print -depsc ...` and `saveas(gcf, ..., 'png')` → `exportgraphics(gcf, ..., 'Resolution', 300)` for PNG and `exportgraphics(gcf, ..., 'ContentType', 'vector')` for PDF
3. EPS output dropped — PNG (300 dpi) + PDF (vector) only
4. Reason for #2: `print` has been observed to occasionally emit corrupted bitmap PNGs; `exportgraphics` is the modern (R2020a+) MATLAB API and handles fonts and vector content more reliably


## Comments policy

- `%% <Section>` headers for cell-mode navigation
- `% --- Sizes / Fonts / Colors ---` group headers inside `%% Drawing parameters`
- One-line explanatory comment only when the WHY is non-obvious (e.g., why dummy `nan` patches are needed for legend handles)
- No "what" comments restating self-evident MATLAB API calls
- Existing intentional comment-outs (alternative legends, alternate axis settings) are preserved verbatim

## Implementation order

1. Commit this spec
2. Refactor the three biou-related files first as the canonical pattern reference:
   - `plot_horizontal_bars2.m` → `horizontal_bars_hrnet.m`
   - `plot_linegraph3.m` → `linegraph_biou_pxthr.m`
   - `plot_linegraph4.m` → `linegraph_biou_masking.m`
3. User reviews the three reference files
4. Apply the same template to the remaining ~21 files
5. `git mv` for renames preserves history
6. Verify: every renamed script still runs end-to-end and emits the same image filenames
