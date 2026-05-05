<div align="center">
    <h1>paper_quality_plot.matlab</h1>
    <a href="https://www.mathworks.com/products/matlab.html"><img src="https://img.shields.io/badge/MATLAB-0076A8?logo=mathworks&logoColor=white" /></a>
    <br />
    <br />
    <p><strong><em>The actual MATLAB plotting code Hyungtae Lim has used across his published papers.</em></strong></p>
    <p>All materials are from <a href="http://urobot.kaist.ac.kr/">Urban Robotics Lab.</a> @KAIST &nbsp;·&nbsp; Author: Hyungtae Lim (shapelim@kaist.ac.kr)</p>
    <p><strong>(01.09.25)</strong> I have now given up on sticking solely to MATLAB (still prefer MATLAB though). <a href="https://github.com/garrettj403/SciencePlots">SciencePlots</a> is truly an excellent tool.</p>
</div>

______________________________________________________________________

## :rocket: Introduction

This repositoy contains 

* how to use linespecer for beautiful matlab graph

https://kr.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-colormap

* how to set legend interpreter as latex

* the method for removing unnecessary white space

* the method for changing the default tick fonts to the latex version

* tilelayout (Only applicable on latest version Matlab)

* thousand seperator 

All outputs are located in `imgs` folder.

______________________________________________________________________

## :hammer: Must be added for the Paper-quality Figures

:point_right: Add `set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))` below the figure declaration line.

:point_right: Add `set(groot, 'defaultAxesTickLabelInterpreter','latex');` below the figure declaration line.

:point_right: Add `ytickformat('%,4.4g');` after **plot( ) command** (optional).

The template is available on [here](template.m)

______________________________________________________________________

## :warning: When it comes to saving figures in eps...

ENG) I realized that some matlab figures (e.g., bar plot, tiles, or 3D plot) can not be saved in the vector format even though the file format is saved into `.eps`.

So, we must use below command as follows:

```
% gcf: figure object
% -r${NUM}: The larger, the higher resolution
print(gcf, "SET_YOUR_FINENAME.png",'-dpng','-r300'); 
```

KOR) Matlab에서 원래 eps로 저장하면 자동으로 그림이 vector format으로 변경되어야 하는데, 그렇지 않은 경우가 있습니다.

그럴 경우에는 아래와 같이 dpi를 조정하여 png로 논문에 넣을 수 밖에 없습니다.


```
% gcf: figure object
% -r${NUM}: The larger, the higher resolution
print(gcf, "SET_YOUR_FINENAME.png",'-dpng','-r300'); 
```

______________________________________________________________________

## :art: Generated Figures

*Click the link under each figure to open the corresponding MATLAB script.*

### Line graph

| B-mIoU vs pixel threshold | caros flight data | ERASOR ground threshold |
| :---: | :---: | :---: |
| ![B-mIoU vs pixel threshold](./imgs/biou_line_graph.png) | ![caros flight data](./imgs/caros_rotor_speed.png) | ![ERASOR ground threshold](./imgs/erasor_ground_preservation.png) |
| [`linegraph_biou_pxthr.m`](linegraph_biou_pxthr.m) | [`linegraph_caros.m`](linegraph_caros.m) | [`linegraph_erasor_ground.m`](linegraph_erasor_ground.m) |

| Hydra2.0 PR-curve | VGGT confidence sweep |  |
| :---: | :---: |  |
| ![Hydra2.0 PR-curve](./imgs/hydra2_0_precision.png) | ![VGGT confidence sweep](./imgs/vggt_ate.png) |  |
| [`linegraph_hydra_pr.m`](linegraph_hydra_pr.m) | [`linegraph_vggt.m`](linegraph_vggt.m) |  |


### Horizontal bar

| DeepLabv3 / HRNet / OCRNet / UPerNet | B-mIoU per pixel threshold |  |
| :---: | :---: |  |
| ![DeepLabv3 / HRNet / OCRNet / UPerNet](./imgs/horizontal_bar_w_deeplabv3.png) | ![B-mIoU per pixel threshold](./imgs/biou_horizontal_bar_w_hrnet_3px.png) |  |
| [`horizontal_bars_deeplabv3.m`](horizontal_bars_deeplabv3.m) | [`horizontal_bars_hrnet.m`](horizontal_bars_hrnet.m) |  |


### Vertical bar

| GPF vs R-GPF precision | max-clique inlier counts | Quatro runtime breakdown |
| :---: | :---: | :---: |
| ![GPF vs R-GPF precision](./imgs/ground_bar_plot_v2.png) | ![max-clique inlier counts](./imgs/num_MC.png) | ![Quatro runtime breakdown](./imgs/average_computational_time_v2_i7.png) |
| [`barplot_gpf_precision.m`](barplot_gpf_precision.m) | [`barplot_maxclique.m`](barplot_maxclique.m) | [`barplot_quatro_runtime.m`](barplot_quatro_runtime.m) |

| success rate across methods |  |  |
| :---: |  |  |
| ![success rate across methods](./imgs/SuccessRate1_quatro_pp.png) |  |  |
| [`barplot_success_rate.m`](barplot_success_rate.m) |  |  |


### Box plot

| AOA / SSA error | method runtime |  |
| :---: | :---: |  |
| ![AOA / SSA error](./imgs/boxplot1.png) | ![method runtime](./imgs/box_plot2_r300.png) |  |
| [`boxplot_aoa_ssa.m`](boxplot_aoa_ssa.m) | [`boxplot_runtime.m`](boxplot_runtime.m) |  |


### CDF

| alpha / beta angle CDFs | Chamfer-distance CDF |  |
| :---: | :---: |  |
| ![alpha / beta angle CDFs](./imgs/total_cdf_alpha.png) | ![Chamfer-distance CDF](./imgs/cdf_for_chamfer_distance.png) |  |
| [`cdf_angles.m`](cdf_angles.m) | [`cdf_chamfer.m`](cdf_chamfer.m) |  |


### PDF

| ERASOR scan-ratio |  |  |
| :---: |  |  |
| ![ERASOR scan-ratio](./imgs/erasor_pdf_diff_percentage.png) |  |  |
| [`pdf_erasor_scan_ratio.m`](pdf_erasor_scan_ratio.m) |  |  |


### PR curve

| PR + F1-vs-threshold |  |  |
| :---: |  |  |
| ![PR + F1-vs-threshold](./imgs/precision_recall_curve.png) |  |  |
| [`prcurve_hydra.m`](prcurve_hydra.m) |  |  |


### Trajectory

| 3D UTM with colour gradient | VBR dataset trajectories |  |
| :---: | :---: |  |
| ![3D UTM with colour gradient](./imgs/Navigation_trajectory.png) | ![VBR dataset trajectories](./imgs/campus_train0_gt.png) |  |
| [`trajectory_3d_utm.m`](trajectory_3d_utm.m) | [`trajectory_vbr.m`](trajectory_vbr.m) |  |


### Scatter with heatmap

| TIMS weights heatmap |  |  |
| :---: |  |  |
| ![TIMS weights heatmap](./imgs/tims_rotation_v30.png) |  |  |
| [`scatter_heatmap_weights.m`](scatter_heatmap_weights.m) |  |  |


### Tilelayout

| PaSGA ring/sector ablation |  |  |
| :---: |  |  |
| ![PaSGA ring/sector ablation](./imgs/final_tilelayout.png) |  |  |
| [`tilelayout_pasga.m`](tilelayout_pasga.m) |  |  |


### Stacked area

| Xavier per-stage time |  |  |
| :---: |  |  |
| ![Xavier per-stage time](./imgs/time_stacked.png) |  |  |
| [`area_xavier_time.m`](area_xavier_time.m) |  |  |


> **Other variants (output filenames collide with siblings above):**
> - [`linegraph_biou_masking.m`](linegraph_biou_masking.m) — same output as [`linegraph_biou_pxthr.m`](linegraph_biou_pxthr.m)
> - [`linegraph_hydra_sam3d.m`](linegraph_hydra_sam3d.m) — same output as [`linegraph_hydra_pr.m`](linegraph_hydra_pr.m)

______________________________________________________________________

## :page_facing_up: Description

### [Plot cdf](cdf_angles.m)

Note that the effect of the linespecer which is illustrated as: 

#### Before using linespecer

![cdf_alpha_before](./imgs/total_cdf_alpha_before.png)

![cdf_beta_before](./imgs/total_cdf_beta_before.png)

#### After using linespecer

![cdf_alpha](./imgs/total_cdf_alpha.png)

![cdf_beta](./imgs/total_cdf_beta.png)

**linespecer is more beautiful!** It allows the figures to be more clean and improves readability.

So, I strongly recommend utilizing `linespecer`!

Please refer to the `% --- Colors ---` block in `cdf_angles.m`  :) 

### [Plot pdf](pdf_erasor_scan_ratio.m)

![pdf](./imgs/erasor_pdf_diff_percentage.png)

Note that the built-in pdf function of matlab does not work sometimes. My method is better!

### [Plot 3D colormap trajectory](trajectory_3d_utm.m)

![pdf](./imgs/Navigation_trajectory.png)

The trajectory is colored with respect to sequence length.

However, if the trajectory is too long, then it may be not applicable.

### [Plot scatter w/ heatmap](scatter_heatmap_weights.m)

![scatter_heatmap_weights](imgs/tims_rotation_v30.png)

### [Line graph: caros](linegraph_caros.m)

![caros_tile_output1](imgs/caros_rotor_speed.png)

![caros_tile_output2](imgs/caros_pitch_alpha.png)

![caros_tile_output3](imgs/caros_orientation.png)

![caros_tile_output4](imgs/caros_position.png)

### [Line graph: ERASOR ground](linegraph_erasor_ground.m)

![line1](./imgs/erasor_ground_percentage.png)

![line2](./imgs/erasor_ground_rejection.png)

### [Plot boxplots (improved)](boxplot_runtime.m)

Note that [multiple_boxplot_time.m](multiple_boxplot_time.m) function is required

![boxplot2](./imgs/box_plot2_r300.png)

### [Plot boxplots](boxplot_aoa_ssa.m)

![boxplot1](./imgs/boxplot1.png)

**ToDo.** Set the fonts of ticks as Times New Roman

### [Plot barplot](barplot_gpf_precision.m)

Only available on **R2020a**.

![barplot](./imgs/ground_bar_plot_v2.png)

### [Tilelayout](tilelayout_pasga.m)

Only available on **R2020a**.

**ToDo.** Set the fonts of ticks as Times New Roman

![tilelayout](./imgs/final_tilelayout.png)

### [Stacked time plot](area_xavier_time.m)

![area_xavier_time](./imgs/time_stacked.png)
