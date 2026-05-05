#!/usr/bin/env python3
"""
Auto-update README.md with images from imgs/ folder
Scans for images and creates a grid layout with links to corresponding MATLAB scripts
"""

import os
import glob
import re
from pathlib import Path
from typing import List, Dict, Tuple, Optional

def find_matlab_scripts() -> Dict[str, str]:
    """Find all MATLAB plot scripts and extract their descriptions"""
    scripts = {}

    # Plot scripts now follow `<category>_<distinctive>.m`. List the category
    # prefixes used in this repo (no `plot_` prefix anymore).
    prefixes = (
        "linegraph_", "barplot_", "boxplot_", "cdf_", "pdf_",
        "horizontal_bars_", "prcurve_", "scatter_heatmap_",
        "tilelayout_", "area_", "trajectory_",
    )
    plot_files = [
        f for f in glob.glob("*.m")
        if any(Path(f).name.startswith(p) for p in prefixes)
    ]

    for script in plot_files:
        # Extract script name without extension
        script_name = Path(script).stem
        scripts[script_name] = script

    return scripts

def get_image_info() -> List[Dict]:
    """Get all images from imgs/ folder with metadata"""
    images = []
    img_dir = Path("imgs")
    
    if not img_dir.exists():
        return images
    
    # Browser-renderable image formats only.
    # `.eps` and `.pdf` files are saved alongside but are NOT linked here —
    # browsers render them as broken images. The PNG sibling is what shows
    # in the README; the vector counterpart is still on disk for paper use.
    extensions = ['*.png', '*.jpg', '*.jpeg', '*.gif', '*.svg', '*.webp']
    
    for ext in extensions:
        for img_path in img_dir.glob(ext):
            # Skip 'before' images as they're comparison images
            if 'before' in img_path.name:
                continue
                
            images.append({
                'name': img_path.name,
                'path': str(img_path),
                'stem': img_path.stem,
                'relative_path': f"./imgs/{img_path.name}"
            })
    
    # Sort images by name for consistent ordering
    images.sort(key=lambda x: x['name'])
    return images

def find_corresponding_script(image_stem: str, scripts: Dict[str, str]) -> Optional[str]:
    """Find the MATLAB script that likely generated this image"""

    # Direct image-stem → script-name mappings (most reliable source of truth)
    direct_mappings = {
        # CDF plots
        'total_cdf_alpha': 'cdf_angles',
        'total_cdf_beta': 'cdf_angles',
        # PDF plot
        'erasor_pdf_diff_percentage': 'pdf_erasor_scan_ratio',
        # Trajectory plots
        'Navigation_trajectory': 'trajectory_3d_utm',
        'tims_rotation_v30': 'scatter_heatmap_weights',
        # caros (4 panels)
        'caros_rotor_speed': 'linegraph_caros',
        'caros_pitch_alpha': 'linegraph_caros',
        'caros_orientation': 'linegraph_caros',
        'caros_position': 'linegraph_caros',
        # ERASOR ground threshold (4 panels)
        'erasor_ground_preservation': 'linegraph_erasor_ground',
        'erasor_ground_rejection': 'linegraph_erasor_ground',
        'erasor_ground_percentage': 'linegraph_erasor_ground',
        'erasor_ground_rel': 'linegraph_erasor_ground',
        # Boxplots
        'box_plot2_r300': 'boxplot_runtime',
        'boxplot1': 'boxplot_aoa_ssa',
        'boxplot2': 'boxplot_aoa_ssa',
        # GPF bar chart
        'ground_bar_plot_v2': 'barplot_gpf_precision',
        # Tilelayout
        'final_tilelayout': 'tilelayout_pasga',
        # Stacked area
        'time_stacked': 'area_xavier_time',
        # Chamfer CDF (multi-panel)
        'cdf_for_chamfer_distance': 'cdf_chamfer',
        'cdf_for_chamfer_distance_class5': 'cdf_chamfer',
        'cdf_for_chamfer_distance_class7': 'cdf_chamfer',
        'cdf_for_chamfer_distance_class13': 'cdf_chamfer',
        'cdf_for_chamfer_distance_class18': 'cdf_chamfer',
        # Hydra 2.0 PR/recall/F1 (collision: linegraph_hydra_pr.m and
        # linegraph_hydra_sam3d.m write to the same stems; pick the active
        # one — linegraph_hydra_pr is the latest paper variant)
        'hydra2_0_precision': 'linegraph_hydra_pr',
        'hydra2_0_recall': 'linegraph_hydra_pr',
        'hydra2_0_f1': 'linegraph_hydra_pr',
        # PR curve (separate from hydra2_0_*)
        'precision_recall_curve': 'prcurve_hydra',
        'f1_vs_threshold': 'prcurve_hydra',
        # B-mIoU line graph (collision: linegraph_biou_pxthr and linegraph_biou_masking
        # both write biou_line_graph.{png,pdf}; link to pxthr as the primary)
        'biou_line_graph': 'linegraph_biou_pxthr',
        # B-mIoU horizontal bars per pixel threshold (HRNet)
        'biou_horizontal_bar_w_hrnet': 'horizontal_bars_hrnet',
        'biou_horizontal_bar_w_hrnet_3px': 'horizontal_bars_hrnet',
        'biou_horizontal_bar_w_hrnet_7px': 'horizontal_bars_hrnet',
        'biou_horizontal_bar_w_hrnet_10px': 'horizontal_bars_hrnet',
        'biou_horizontal_bar_w_hrnet_20px': 'horizontal_bars_hrnet',
        # mIoU horizontal bars per backbone (DeepLabv3 file generates 4 figures)
        'horizontal_bar_w_deeplabv3': 'horizontal_bars_deeplabv3',
        'horizontal_bar_w_hrnet': 'horizontal_bars_deeplabv3',
        'horizontal_bar_w_ocrnet': 'horizontal_bars_deeplabv3',
        'horizontal_bar_w_upernet': 'horizontal_bars_deeplabv3',
        # VGGT confidence-threshold sweep (4 panels)
        'vggt_ate': 'linegraph_vggt',
        'vggt_accuracy': 'linegraph_vggt',
        'vggt_completion': 'linegraph_vggt',
        'vggt_chamfer': 'linegraph_vggt',
        # Success-rate bars (CamelCase output stems — pattern-matcher misses these)
        'SuccessRate1_quatro_pp': 'barplot_success_rate',
        'SuccessRate2_quatro_pp': 'barplot_success_rate',
        'RANSAC10K_success_rate': 'barplot_success_rate',
        'FGR_success_rate': 'barplot_success_rate',
        'TEASER_success_rate': 'barplot_success_rate',
        # Quatro avg computational time (active + commented-alt outputs)
        'average_computational_time_v2_i7': 'barplot_quatro_runtime',
        'average_computational_time_v2_i9': 'barplot_quatro_runtime',
        # Max-clique counts (CWD-root outputs)
        'num_MC': 'barplot_maxclique',
        'num_rot_inlier': 'barplot_maxclique',
        'num_trans_inlier': 'barplot_maxclique',
    }

    # Check direct mappings first
    if image_stem in direct_mappings:
        script_name = direct_mappings[image_stem]
        if script_name in scripts:
            return scripts[script_name]

    # Pattern-based fallback: derive a key from each script name and check
    # whether the image stem contains it. Earlier prefixes are stripped so the
    # remaining `<distinctive>` portion matches the image.
    prefix_strip = (
        "linegraph_", "barplot_", "boxplot_", "cdf_", "pdf_",
        "horizontal_bars_", "prcurve_", "scatter_heatmap_",
        "tilelayout_", "area_", "trajectory_",
    )
    for script_name, script_path in scripts.items():
        script_key = script_name
        for p in prefix_strip:
            if script_key.startswith(p):
                script_key = script_key[len(p):]
                break

        # `_train` is a common substring inside VBR trajectory image stems
        if script_key == "vbr" and "_train" in image_stem and "_gt" in image_stem:
            return script_path

        if script_key and script_key in image_stem.lower():
            return script_path

    return None

def create_image_grid(images: List[Dict], scripts: Dict[str, str], cols: int = 3) -> str:
    """Create a markdown grid of images with links to scripts"""
    
    if not images:
        return "No images found in imgs/ folder.\n"
    
    markdown = "## Generated Figures\n\n"
    markdown += "*Click on image titles to view the corresponding MATLAB script*\n\n"
    
    # Create table in chunks of 'cols' columns
    for i in range(0, len(images), cols):
        chunk = images[i:i+cols]
        
        # Table header
        headers = []
        separators = []
        image_rows = []
        link_rows = []
        
        for img in chunk:
            # Create image cell
            alt_text = img['stem'].replace('_', ' ').title()
            image_cell = f"![{alt_text}]({img['relative_path']})"
            
            # Find corresponding script
            script_path = find_corresponding_script(img['stem'], scripts)
            if script_path:
                link_cell = f"[{img['stem']}]({script_path})"
            else:
                link_cell = img['stem']
            
            headers.append(alt_text)
            separators.append(":---:")
            image_rows.append(image_cell)
            link_rows.append(link_cell)
        
        # Fill remaining columns if needed
        while len(headers) < cols:
            headers.append("")
            separators.append("")
            image_rows.append("")
            link_rows.append("")
        
        # Add table to markdown
        markdown += "| " + " | ".join(headers) + " |\n"
        markdown += "| " + " | ".join(separators) + " |\n"
        markdown += "| " + " | ".join(image_rows) + " |\n"
        markdown += "| " + " | ".join(link_rows) + " |\n\n"
    
    return markdown

def read_readme_template() -> Tuple[str, str, str]:
    """Read existing README and split into header, body, and footer"""
    
    readme_path = Path("README.md")
    if not readme_path.exists():
        return "", "", ""
    
    content = readme_path.read_text(encoding='utf-8')
    
    # Find the start of the old figures section
    figures_start = content.find("## Generated Figures")
    if figures_start == -1:
        # Look for the Description section instead
        desc_start = content.find("# Description")
        if desc_start != -1:
            header = content[:desc_start]
            footer = content[desc_start:]
            return header, "", footer
        else:
            # No existing structure, keep everything as header
            return content, "", ""
    
    header = content[:figures_start]
    
    # Try to find the next major section after figures
    remaining = content[figures_start:]
    next_section = re.search(r'\n# [^#]', remaining)
    
    if next_section:
        footer = remaining[next_section.start():]
        old_figures = remaining[:next_section.start()]
    else:
        footer = ""
        old_figures = remaining
    
    return header.rstrip() + "\n\n", old_figures, footer

def update_readme():
    """Main function to update README.md"""
    
    print("🔍 Scanning for MATLAB scripts...")
    scripts = find_matlab_scripts()
    print(f"Found {len(scripts)} MATLAB scripts")
    
    print("🖼️  Scanning for images...")
    images = get_image_info()
    print(f"Found {len(images)} images")
    
    print("📝 Generating image grid...")
    new_figures_section = create_image_grid(images, scripts)
    
    print("📖 Reading existing README...")
    header, old_figures, footer = read_readme_template()
    
    # Combine parts
    new_readme = header + new_figures_section + footer
    
    # Write updated README
    readme_path = Path("README.md")
    readme_path.write_text(new_readme, encoding='utf-8')
    
    print("✅ README.md updated successfully!")
    print(f"   - Added {len(images)} images in grid format")
    print(f"   - Linked to {len([img for img in images if find_corresponding_script(img['stem'], scripts)])} MATLAB scripts")

if __name__ == "__main__":
    update_readme()