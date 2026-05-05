<div align="center">
    <h1>paper_quality_plot.matlab</h1>
    <a href="https://www.mathworks.com/products/matlab.html"><img src="https://img.shields.io/badge/MATLAB-0076A8?logo=mathworks&logoColor=white" /></a>
    <br />
    <br />
    <p><strong><em>The actual MATLAB plotting code Hyungtae Lim has used across his published papers.</em></strong></p>
    <p>All materials are from <a href="http://urobot.kaist.ac.kr/">Urban Robotics Lab.</a> @KAIST &nbsp;·&nbsp; Author: Hyungtae Lim (shapelim@kaist.ac.kr)</p>
    <p><strong>(01.09.25)</strong> I have now given up on sticking solely to MATLAB (still prefer MATLAB though). <a href="https://github.com/garrettj403/SciencePlots">SciencePlots</a> is truly an excellent tool.</p>
</div>

---

# Introduction

This repositoy contains 

* how to use linespecer for beautiful matlab graph

https://kr.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-colormap

* how to set legend interpreter as latex

* the method for removing unnecessary white space

* the method for changing the default tick fonts to the latex version

* tilelayout (Only applicable on latest version Matlab)

* thousand seperator 

All outputs are located in `imgs` folder.

---
# Must be added for the Paper-quality Figures

:point_right: Add `set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))` below the figure declaration line.

:point_right: Add `set(groot, 'defaultAxesTickLabelInterpreter','latex');` below the figure declaration line.

:point_right: Add `ytickformat('%,4.4g');` after **plot( ) command** (optional).

The template is available on [here](template.m)

---

# When it comes to saving figures in eps...

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


---

## Generated Figures

*Click on image titles to view the corresponding MATLAB script*

| Fgr Success Rate | Navigation Trajectory | Ransac10K Success Rate |
| :---: | :---: | :---: |
| ![Fgr Success Rate](./imgs/FGR_success_rate.png) | ![Navigation Trajectory](./imgs/Navigation_trajectory.png) | ![Ransac10K Success Rate](./imgs/RANSAC10K_success_rate.png) |
| [FGR_success_rate](barplot_success_rate.m) | [Navigation_trajectory](trajectory_3d_utm.m) | [RANSAC10K_success_rate](barplot_success_rate.m) |

| Successrate1 Quatro Pp | Successrate2 Quatro Pp | Teaser Success Rate |
| :---: | :---: | :---: |
| ![Successrate1 Quatro Pp](./imgs/SuccessRate1_quatro_pp.png) | ![Successrate2 Quatro Pp](./imgs/SuccessRate2_quatro_pp.png) | ![Teaser Success Rate](./imgs/TEASER_success_rate.png) |
| [SuccessRate1_quatro_pp](barplot_success_rate.m) | [SuccessRate2_quatro_pp](barplot_success_rate.m) | [TEASER_success_rate](barplot_success_rate.m) |

| Average Computational Time V2 I7 | Average Computational Time V2 I9 | Biou Horizontal Bar W Hrnet |
| :---: | :---: | :---: |
| ![Average Computational Time V2 I7](./imgs/average_computational_time_v2_i7.png) | ![Average Computational Time V2 I9](./imgs/average_computational_time_v2_i9.png) | ![Biou Horizontal Bar W Hrnet](./imgs/biou_horizontal_bar_w_hrnet.eps) |
| [average_computational_time_v2_i7](barplot_quatro_runtime.m) | [average_computational_time_v2_i9](barplot_quatro_runtime.m) | [biou_horizontal_bar_w_hrnet](horizontal_bars_hrnet.m) |

| Biou Horizontal Bar W Hrnet | Biou Horizontal Bar W Hrnet 10Px | Biou Horizontal Bar W Hrnet 10Px |
| :---: | :---: | :---: |
| ![Biou Horizontal Bar W Hrnet](./imgs/biou_horizontal_bar_w_hrnet.png) | ![Biou Horizontal Bar W Hrnet 10Px](./imgs/biou_horizontal_bar_w_hrnet_10px.eps) | ![Biou Horizontal Bar W Hrnet 10Px](./imgs/biou_horizontal_bar_w_hrnet_10px.png) |
| [biou_horizontal_bar_w_hrnet](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_10px](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_10px](horizontal_bars_hrnet.m) |

| Biou Horizontal Bar W Hrnet 20Px | Biou Horizontal Bar W Hrnet 20Px | Biou Horizontal Bar W Hrnet 3Px |
| :---: | :---: | :---: |
| ![Biou Horizontal Bar W Hrnet 20Px](./imgs/biou_horizontal_bar_w_hrnet_20px.eps) | ![Biou Horizontal Bar W Hrnet 20Px](./imgs/biou_horizontal_bar_w_hrnet_20px.png) | ![Biou Horizontal Bar W Hrnet 3Px](./imgs/biou_horizontal_bar_w_hrnet_3px.eps) |
| [biou_horizontal_bar_w_hrnet_20px](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_20px](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_3px](horizontal_bars_hrnet.m) |

| Biou Horizontal Bar W Hrnet 3Px | Biou Horizontal Bar W Hrnet 7Px | Biou Horizontal Bar W Hrnet 7Px |
| :---: | :---: | :---: |
| ![Biou Horizontal Bar W Hrnet 3Px](./imgs/biou_horizontal_bar_w_hrnet_3px.png) | ![Biou Horizontal Bar W Hrnet 7Px](./imgs/biou_horizontal_bar_w_hrnet_7px.eps) | ![Biou Horizontal Bar W Hrnet 7Px](./imgs/biou_horizontal_bar_w_hrnet_7px.png) |
| [biou_horizontal_bar_w_hrnet_3px](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_7px](horizontal_bars_hrnet.m) | [biou_horizontal_bar_w_hrnet_7px](horizontal_bars_hrnet.m) |

| Biou Line Graph | Biou Line Graph | Box Plot2 R300 |
| :---: | :---: | :---: |
| ![Biou Line Graph](./imgs/biou_line_graph.eps) | ![Biou Line Graph](./imgs/biou_line_graph.png) | ![Box Plot2 R300](./imgs/box_plot2_r300.png) |
| [biou_line_graph](linegraph_biou_pxthr.m) | [biou_line_graph](linegraph_biou_pxthr.m) | [box_plot2_r300](boxplot_runtime.m) |

| Boxplot1 | Boxplot2 | Campus Train0 Gt |
| :---: | :---: | :---: |
| ![Boxplot1](./imgs/boxplot1.png) | ![Boxplot2](./imgs/boxplot2.png) | ![Campus Train0 Gt](./imgs/campus_train0_gt.eps) |
| [boxplot1](boxplot_aoa_ssa.m) | [boxplot2](boxplot_aoa_ssa.m) | [campus_train0_gt](trajectory_vbr.m) |

| Campus Train0 Gt | Campus Train1 Gt 2D | Campus Train1 Gt 2D |
| :---: | :---: | :---: |
| ![Campus Train0 Gt](./imgs/campus_train0_gt.png) | ![Campus Train1 Gt 2D](./imgs/campus_train1_gt_2D.eps) | ![Campus Train1 Gt 2D](./imgs/campus_train1_gt_2D.png) |
| [campus_train0_gt](trajectory_vbr.m) | [campus_train1_gt_2D](trajectory_vbr.m) | [campus_train1_gt_2D](trajectory_vbr.m) |

| Caros Orientation | Caros Pitch Alpha | Caros Position |
| :---: | :---: | :---: |
| ![Caros Orientation](./imgs/caros_orientation.png) | ![Caros Pitch Alpha](./imgs/caros_pitch_alpha.png) | ![Caros Position](./imgs/caros_position.png) |
| [caros_orientation](linegraph_caros.m) | [caros_pitch_alpha](linegraph_caros.m) | [caros_position](linegraph_caros.m) |

| Caros Rotor Speed | Caros Tile Output | Cdf For Chamfer Distance |
| :---: | :---: | :---: |
| ![Caros Rotor Speed](./imgs/caros_rotor_speed.png) | ![Caros Tile Output](./imgs/caros_tile_output.png) | ![Cdf For Chamfer Distance](./imgs/cdf_for_chamfer_distance.pdf) |
| [caros_rotor_speed](linegraph_caros.m) | [caros_tile_output](linegraph_caros.m) | [cdf_for_chamfer_distance](cdf_chamfer.m) |

| Cdf For Chamfer Distance | Cdf For Chamfer Distance Class13 | Cdf For Chamfer Distance Class13 |
| :---: | :---: | :---: |
| ![Cdf For Chamfer Distance](./imgs/cdf_for_chamfer_distance.png) | ![Cdf For Chamfer Distance Class13](./imgs/cdf_for_chamfer_distance_class13.pdf) | ![Cdf For Chamfer Distance Class13](./imgs/cdf_for_chamfer_distance_class13.png) |
| [cdf_for_chamfer_distance](cdf_chamfer.m) | [cdf_for_chamfer_distance_class13](cdf_chamfer.m) | [cdf_for_chamfer_distance_class13](cdf_chamfer.m) |

| Cdf For Chamfer Distance Class18 | Cdf For Chamfer Distance Class18 | Cdf For Chamfer Distance Class5 |
| :---: | :---: | :---: |
| ![Cdf For Chamfer Distance Class18](./imgs/cdf_for_chamfer_distance_class18.pdf) | ![Cdf For Chamfer Distance Class18](./imgs/cdf_for_chamfer_distance_class18.png) | ![Cdf For Chamfer Distance Class5](./imgs/cdf_for_chamfer_distance_class5.pdf) |
| [cdf_for_chamfer_distance_class18](cdf_chamfer.m) | [cdf_for_chamfer_distance_class18](cdf_chamfer.m) | [cdf_for_chamfer_distance_class5](cdf_chamfer.m) |

| Cdf For Chamfer Distance Class5 | Cdf For Chamfer Distance Class7 | Cdf For Chamfer Distance Class7 |
| :---: | :---: | :---: |
| ![Cdf For Chamfer Distance Class5](./imgs/cdf_for_chamfer_distance_class5.png) | ![Cdf For Chamfer Distance Class7](./imgs/cdf_for_chamfer_distance_class7.pdf) | ![Cdf For Chamfer Distance Class7](./imgs/cdf_for_chamfer_distance_class7.png) |
| [cdf_for_chamfer_distance_class5](cdf_chamfer.m) | [cdf_for_chamfer_distance_class7](cdf_chamfer.m) | [cdf_for_chamfer_distance_class7](cdf_chamfer.m) |

| Ciampino Train0 Gt | Ciampino Train0 Gt | Ciampino Train0 Gt 2D |
| :---: | :---: | :---: |
| ![Ciampino Train0 Gt](./imgs/ciampino_train0_gt.eps) | ![Ciampino Train0 Gt](./imgs/ciampino_train0_gt.png) | ![Ciampino Train0 Gt 2D](./imgs/ciampino_train0_gt_2D.eps) |
| [ciampino_train0_gt](trajectory_vbr.m) | [ciampino_train0_gt](trajectory_vbr.m) | [ciampino_train0_gt_2D](trajectory_vbr.m) |

| Ciampino Train0 Gt 2D | Ciampino Train1 Gt | Ciampino Train1 Gt |
| :---: | :---: | :---: |
| ![Ciampino Train0 Gt 2D](./imgs/ciampino_train0_gt_2D.png) | ![Ciampino Train1 Gt](./imgs/ciampino_train1_gt.eps) | ![Ciampino Train1 Gt](./imgs/ciampino_train1_gt.png) |
| [ciampino_train0_gt_2D](trajectory_vbr.m) | [ciampino_train1_gt](trajectory_vbr.m) | [ciampino_train1_gt](trajectory_vbr.m) |

| Ciampino Train1 Gt 2D | Ciampino Train1 Gt 2D | Colosseo Train0 Gt |
| :---: | :---: | :---: |
| ![Ciampino Train1 Gt 2D](./imgs/ciampino_train1_gt_2D.eps) | ![Ciampino Train1 Gt 2D](./imgs/ciampino_train1_gt_2D.png) | ![Colosseo Train0 Gt](./imgs/colosseo_train0_gt.eps) |
| [ciampino_train1_gt_2D](trajectory_vbr.m) | [ciampino_train1_gt_2D](trajectory_vbr.m) | [colosseo_train0_gt](trajectory_vbr.m) |

| Colosseo Train0 Gt | Colosseo Train0 Gt 2D | Colosseo Train0 Gt 2D |
| :---: | :---: | :---: |
| ![Colosseo Train0 Gt](./imgs/colosseo_train0_gt.png) | ![Colosseo Train0 Gt 2D](./imgs/colosseo_train0_gt_2D.eps) | ![Colosseo Train0 Gt 2D](./imgs/colosseo_train0_gt_2D.png) |
| [colosseo_train0_gt](trajectory_vbr.m) | [colosseo_train0_gt_2D](trajectory_vbr.m) | [colosseo_train0_gt_2D](trajectory_vbr.m) |

| Diag Train0 Gt | Diag Train0 Gt | Diag Train0 Gt 2D |
| :---: | :---: | :---: |
| ![Diag Train0 Gt](./imgs/diag_train0_gt.eps) | ![Diag Train0 Gt](./imgs/diag_train0_gt.png) | ![Diag Train0 Gt 2D](./imgs/diag_train0_gt_2D.eps) |
| [diag_train0_gt](trajectory_vbr.m) | [diag_train0_gt](trajectory_vbr.m) | [diag_train0_gt_2D](trajectory_vbr.m) |

| Diag Train0 Gt 2D | Erasor Ground Percentage | Erasor Ground Preservation |
| :---: | :---: | :---: |
| ![Diag Train0 Gt 2D](./imgs/diag_train0_gt_2D.png) | ![Erasor Ground Percentage](./imgs/erasor_ground_percentage.png) | ![Erasor Ground Preservation](./imgs/erasor_ground_preservation.png) |
| [diag_train0_gt_2D](trajectory_vbr.m) | [erasor_ground_percentage](linegraph_erasor_ground.m) | [erasor_ground_preservation](linegraph_erasor_ground.m) |

| Erasor Ground Rejection | Erasor Ground Rel | Erasor Pdf Diff Percentage |
| :---: | :---: | :---: |
| ![Erasor Ground Rejection](./imgs/erasor_ground_rejection.png) | ![Erasor Ground Rel](./imgs/erasor_ground_rel.png) | ![Erasor Pdf Diff Percentage](./imgs/erasor_pdf_diff_percentage.png) |
| [erasor_ground_rejection](linegraph_erasor_ground.m) | [erasor_ground_rel](linegraph_erasor_ground.m) | [erasor_pdf_diff_percentage](pdf_erasor_scan_ratio.m) |

| F1 Vs Threshold | F1 Vs Threshold | Final Tilelayout |
| :---: | :---: | :---: |
| ![F1 Vs Threshold](./imgs/f1_vs_threshold.pdf) | ![F1 Vs Threshold](./imgs/f1_vs_threshold.png) | ![Final Tilelayout](./imgs/final_tilelayout.png) |
| [f1_vs_threshold](prcurve_hydra.m) | [f1_vs_threshold](prcurve_hydra.m) | [final_tilelayout](tilelayout_pasga.m) |

| Ground Bar Plot V2 | Ground Bar Plot V2 | Horizontal Bar W Deeplabv3 |
| :---: | :---: | :---: |
| ![Ground Bar Plot V2](./imgs/ground_bar_plot_v2.eps) | ![Ground Bar Plot V2](./imgs/ground_bar_plot_v2.png) | ![Horizontal Bar W Deeplabv3](./imgs/horizontal_bar_w_deeplabv3.eps) |
| [ground_bar_plot_v2](barplot_gpf_precision.m) | [ground_bar_plot_v2](barplot_gpf_precision.m) | [horizontal_bar_w_deeplabv3](horizontal_bars_deeplabv3.m) |

| Horizontal Bar W Deeplabv3 | Horizontal Bar W Hrnet | Horizontal Bar W Hrnet |
| :---: | :---: | :---: |
| ![Horizontal Bar W Deeplabv3](./imgs/horizontal_bar_w_deeplabv3.png) | ![Horizontal Bar W Hrnet](./imgs/horizontal_bar_w_hrnet.eps) | ![Horizontal Bar W Hrnet](./imgs/horizontal_bar_w_hrnet.png) |
| [horizontal_bar_w_deeplabv3](horizontal_bars_deeplabv3.m) | [horizontal_bar_w_hrnet](horizontal_bars_deeplabv3.m) | [horizontal_bar_w_hrnet](horizontal_bars_deeplabv3.m) |

| Horizontal Bar W Ocrnet | Horizontal Bar W Ocrnet | Horizontal Bar W Upernet |
| :---: | :---: | :---: |
| ![Horizontal Bar W Ocrnet](./imgs/horizontal_bar_w_ocrnet.eps) | ![Horizontal Bar W Ocrnet](./imgs/horizontal_bar_w_ocrnet.png) | ![Horizontal Bar W Upernet](./imgs/horizontal_bar_w_upernet.eps) |
| [horizontal_bar_w_ocrnet](horizontal_bars_deeplabv3.m) | [horizontal_bar_w_ocrnet](horizontal_bars_deeplabv3.m) | [horizontal_bar_w_upernet](horizontal_bars_deeplabv3.m) |

| Horizontal Bar W Upernet | Hydra2 0 F1 | Hydra2 0 F1 |
| :---: | :---: | :---: |
| ![Horizontal Bar W Upernet](./imgs/horizontal_bar_w_upernet.png) | ![Hydra2 0 F1](./imgs/hydra2_0_f1.pdf) | ![Hydra2 0 F1](./imgs/hydra2_0_f1.png) |
| [horizontal_bar_w_upernet](horizontal_bars_deeplabv3.m) | [hydra2_0_f1](linegraph_hydra_pr.m) | [hydra2_0_f1](linegraph_hydra_pr.m) |

| Hydra2 0 Precision | Hydra2 0 Precision | Hydra2 0 Recall |
| :---: | :---: | :---: |
| ![Hydra2 0 Precision](./imgs/hydra2_0_precision.pdf) | ![Hydra2 0 Precision](./imgs/hydra2_0_precision.png) | ![Hydra2 0 Recall](./imgs/hydra2_0_recall.pdf) |
| [hydra2_0_precision](linegraph_hydra_pr.m) | [hydra2_0_precision](linegraph_hydra_pr.m) | [hydra2_0_recall](linegraph_hydra_pr.m) |

| Hydra2 0 Recall | Num Mc | Num Rot Inlier |
| :---: | :---: | :---: |
| ![Hydra2 0 Recall](./imgs/hydra2_0_recall.png) | ![Num Mc](./imgs/num_MC.png) | ![Num Rot Inlier](./imgs/num_rot_inlier.png) |
| [hydra2_0_recall](linegraph_hydra_pr.m) | [num_MC](barplot_maxclique.m) | [num_rot_inlier](barplot_maxclique.m) |

| Num Trans Inlier | Pincio Train0 Gt | Pincio Train0 Gt |
| :---: | :---: | :---: |
| ![Num Trans Inlier](./imgs/num_trans_inlier.png) | ![Pincio Train0 Gt](./imgs/pincio_train0_gt.eps) | ![Pincio Train0 Gt](./imgs/pincio_train0_gt.png) |
| [num_trans_inlier](barplot_maxclique.m) | [pincio_train0_gt](trajectory_vbr.m) | [pincio_train0_gt](trajectory_vbr.m) |

| Pincio Train0 Gt 2D | Pincio Train0 Gt 2D | Precision Recall Curve |
| :---: | :---: | :---: |
| ![Pincio Train0 Gt 2D](./imgs/pincio_train0_gt_2D.eps) | ![Pincio Train0 Gt 2D](./imgs/pincio_train0_gt_2D.png) | ![Precision Recall Curve](./imgs/precision_recall_curve.pdf) |
| [pincio_train0_gt_2D](trajectory_vbr.m) | [pincio_train0_gt_2D](trajectory_vbr.m) | [precision_recall_curve](prcurve_hydra.m) |

| Precision Recall Curve | Spagna Train0 Gt | Spagna Train0 Gt |
| :---: | :---: | :---: |
| ![Precision Recall Curve](./imgs/precision_recall_curve.png) | ![Spagna Train0 Gt](./imgs/spagna_train0_gt.eps) | ![Spagna Train0 Gt](./imgs/spagna_train0_gt.png) |
| [precision_recall_curve](prcurve_hydra.m) | [spagna_train0_gt](trajectory_vbr.m) | [spagna_train0_gt](trajectory_vbr.m) |

| Spagna Train0 Gt 2D | Spagna Train0 Gt 2D | Template |
| :---: | :---: | :---: |
| ![Spagna Train0 Gt 2D](./imgs/spagna_train0_gt_2D.eps) | ![Spagna Train0 Gt 2D](./imgs/spagna_train0_gt_2D.png) | ![Template](./imgs/template.png) |
| [spagna_train0_gt_2D](trajectory_vbr.m) | [spagna_train0_gt_2D](trajectory_vbr.m) | template |

| Time Stacked | Time Stacked | Tims Rotation V30 |
| :---: | :---: | :---: |
| ![Time Stacked](./imgs/time_stacked.eps) | ![Time Stacked](./imgs/time_stacked.png) | ![Tims Rotation V30](./imgs/tims_rotation_v30.png) |
| [time_stacked](area_xavier_time.m) | [time_stacked](area_xavier_time.m) | [tims_rotation_v30](scatter_heatmap_weights.m) |

| Total Cdf Alpha | Total Cdf Alpha | Total Cdf Beta |
| :---: | :---: | :---: |
| ![Total Cdf Alpha](./imgs/total_cdf_alpha.eps) | ![Total Cdf Alpha](./imgs/total_cdf_alpha.png) | ![Total Cdf Beta](./imgs/total_cdf_beta.png) |
| [total_cdf_alpha](cdf_angles.m) | [total_cdf_alpha](cdf_angles.m) | [total_cdf_beta](cdf_angles.m) |

| Vggt Accuracy | Vggt Accuracy | Vggt Ate |
| :---: | :---: | :---: |
| ![Vggt Accuracy](./imgs/vggt_accuracy.eps) | ![Vggt Accuracy](./imgs/vggt_accuracy.png) | ![Vggt Ate](./imgs/vggt_ate.eps) |
| [vggt_accuracy](linegraph_vggt.m) | [vggt_accuracy](linegraph_vggt.m) | [vggt_ate](linegraph_vggt.m) |

| Vggt Ate | Vggt Chamfer | Vggt Chamfer |
| :---: | :---: | :---: |
| ![Vggt Ate](./imgs/vggt_ate.png) | ![Vggt Chamfer](./imgs/vggt_chamfer.eps) | ![Vggt Chamfer](./imgs/vggt_chamfer.png) |
| [vggt_ate](linegraph_vggt.m) | [vggt_chamfer](linegraph_vggt.m) | [vggt_chamfer](linegraph_vggt.m) |

| Vggt Completion | Vggt Completion |  |
| :---: | :---: |  |
| ![Vggt Completion](./imgs/vggt_completion.eps) | ![Vggt Completion](./imgs/vggt_completion.png) |  |
| [vggt_completion](linegraph_vggt.m) | [vggt_completion](linegraph_vggt.m) |  |


# Description

## [Plot cdf](cdf_angles.m)

Note that the effect of the linespecer which is illustrated as: 

### Before using linespecer

![cdf_alpha_before](./imgs/total_cdf_alpha_before.png)

![cdf_beta_before](./imgs/total_cdf_beta_before.png)

### After using linespecer

![cdf_alpha](./imgs/total_cdf_alpha.png)

![cdf_beta](./imgs/total_cdf_beta.png)

**linespecer is more beautiful!** It allows the figures to be more clean and improves readability.

So, I strongly recommend utilizing `linespecer`!

Please refer to the `% --- Colors ---` block in `cdf_angles.m`  :) 

## [Plot pdf](pdf_erasor_scan_ratio.m)

![pdf](./imgs/erasor_pdf_diff_percentage.png)

Note that the built-in pdf function of matlab does not work sometimes. My method is better!

## [Plot 3D colormap trajectory](trajectory_3d_utm.m)

![pdf](./imgs/Navigation_trajectory.png)

The trajectory is colored with respect to sequence length.

However, if the trajectory is too long, then it may be not applicable.

## [Plot scatter w/ heatmap](scatter_heatmap_weights.m)

![scatter_heatmap_weights](imgs/tims_rotation_v30.png)

## [Line graph: caros](linegraph_caros.m)

![caros_tile_output1](imgs/caros_rotor_speed.png)

![caros_tile_output2](imgs/caros_pitch_alpha.png)

![caros_tile_output3](imgs/caros_orientation.png)

![caros_tile_output4](imgs/caros_position.png)

## [Line graph: ERASOR ground](linegraph_erasor_ground.m)

![line1](./imgs/erasor_ground_percentage.png)

![line2](./imgs/erasor_ground_rejection.png)

## [Plot boxplots (improved)](boxplot_runtime.m)

Note that [multiple_boxplot_time.m](multiple_boxplot_time.m) function is required

![boxplot2](./imgs/box_plot2_r300.png)

## [Plot boxplots](boxplot_aoa_ssa.m)

![boxplot1](./imgs/boxplot1.png)

**ToDo.** Set the fonts of ticks as Times New Roman

## [Plot barplot](barplot_gpf_precision.m)

Only available on **R2020a**.

![barplot](./imgs/ground_bar_plot_v2.png)

## [Tilelayout](tilelayout_pasga.m)

Only available on **R2020a**.

**ToDo.** Set the fonts of ticks as Times New Roman

![tilelayout](./imgs/final_tilelayout.png)

## [Stacked time plot](area_xavier_time.m)

![area_xavier_time](./imgs/time_stacked.png)
