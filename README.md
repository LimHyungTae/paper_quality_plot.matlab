# paper_quality_plot.matlab

All materials are from [Urban Robotics Lab.](http://urobot.kaist.ac.kr/) @KAIST

Original author: Hyungtae Lim (shapelim@kaist.ac.kr)

Advisers: Giseop Kim (paulgkim@kaist.ac.kr), Byeongho YU (bhyu@kaist.ac.kr) 

**(01.09.25)** I think using [ThesisPlots](https://github.com/garrettj403/ThesisPlots) on Pyhon would work as well.

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
print(gcf, "SET_YOUR_FINENAME.png",'-dpng','-r200'); 
```

KOR) Matlab에서 원래 eps로 저장하면 자동으로 그림이 vector format으로 변경되어야 하는데, 그렇지 않은 경우가 있습니다.

그럴 경우에는 아래와 같이 dpi를 조정하여 png로 논문에 넣을 수 밖에 없습니다.


```
% gcf: figure object
% -r${NUM}: The larger, the higher resolution
print(gcf, "SET_YOUR_FINENAME.png",'-dpng','-r200'); 
```


---

# Description

## [Plot cdf](plot_cdf.m)

Note that the effect of the linespecer which is illustrated as: 

### Before using linespecer

![cdf_alpha_before](./imgs/total_cdf_alpha_before.png)

![cdf_beta_before](./imgs/total_cdf_beta_before.png)

### After using linespecer

![cdf_alpha](./imgs/total_cdf_alpha.png)

![cdf_beta](./imgs/total_cdf_beta.png)

**linespecer is more beautiful!** It allows the figures to be more clean and improves readability.

So, I strongly recommend utilizing `linespecer`!

Please refer to the line 7 to 9 and 124 to 133 in `plot_cdf.m`  :) 

## [Plot pdf](plot_pdf.m)

![pdf](./imgs/erasor_pdf_diff_percentage.png)

Note that the built-in pdf function of matlab does not work sometimes. My method is better!

## [Plot 3D colormap trajectory](plot_trajectory.m)

![pdf](./imgs/Navigation_trajectory.png)

The trajectory is colored with respect to sequence length.

However, if the trajectory is too long, then it may be not applicable.

## [Plot scatter w/ heatmap](plot_scatter_w_heatmap.m)

![plot_scatter_w_heatmap](imgs/tims_rotation_v30.png)

## [Line graph1](plot_linegraph1.m)

![caros_tile_output1](imgs/caros_rotor_speed.png)

![caros_tile_output2](imgs/caros_pitch_alpha.png)

![caros_tile_output3](imgs/caros_orientation.png)

![caros_tile_output4](imgs/caros_position.png)

## [Line graph2](plot_linegraph2.m)

![line1](./imgs/erasor_ground_percentage.png)

![line2](./imgs/erasor_ground_rejection.png)

## [Plot boxplots (improved)](plot_boxplot2.m)

Note that [multiple_boxplot_time.m](multiple_boxplot_time.m) function is required

![boxplot2](./imgs/box_plot2_r300.png)

## [Plot boxplots](plot_boxplots.m)

![boxplot1](./imgs/boxplot1.png)

**ToDo.** Set the fonts of ticks as Times New Roman

## [Plot barplot](plot_barplot.m)

Only available on **R2020a**.

![barplot](./imgs/ground_bar_plot_v2.png)

## [Tilelayout](plot_tilelayout.m)

Only available on **R2020a**.

**ToDo.** Set the fonts of ticks as Times New Roman

![tilelayout](./imgs/final_tilelayout.png)

## [Stacked time plot](plot_time_stacked.m)

![plot_time_stacked](./imgs/time_stacked.png)
