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
    
    # Find all plot_*.m files
    plot_files = glob.glob("plot_*.m")
    
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
    
    # Supported image formats
    extensions = ['*.png', '*.jpg', '*.jpeg', '*.eps', '*.pdf']
    
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
    
    # Direct mapping patterns
    direct_mappings = {
        'total_cdf_alpha': 'plot_cdf',
        'total_cdf_beta': 'plot_cdf', 
        'erasor_pdf_diff_percentage': 'plot_pdf',
        'Navigation_trajectory': 'plot_trajectory',
        'tims_rotation_v30': 'plot_scatter_w_heatmap',
        'caros_rotor_speed': 'plot_linegraph1',
        'caros_pitch_alpha': 'plot_linegraph1',
        'caros_orientation': 'plot_linegraph1',
        'caros_position': 'plot_linegraph1',
        'erasor_ground_percentage': 'plot_linegraph2',
        'erasor_ground_rejection': 'plot_linegraph2',
        'box_plot2_r300': 'plot_boxplot2',
        'boxplot1': 'plot_boxplots',
        'ground_bar_plot_v2': 'plot_barplot',
        'final_tilelayout': 'plot_tilelayout',
        'time_stacked': 'plot_time_stacked'
    }
    
    # Check direct mappings first
    if image_stem in direct_mappings:
        script_name = direct_mappings[image_stem]
        if script_name in scripts:
            return scripts[script_name]
    
    # Pattern-based matching
    for script_name, script_path in scripts.items():
        # Extract key words from script name
        script_key = script_name.replace('plot_', '')
        
        # Check if script key is in image name
        if script_key in image_stem.lower():
            return script_path
            
        # Check for partial matches
        if 'cdf' in script_key and 'cdf' in image_stem:
            return script_path
        if 'bar' in script_key and 'bar' in image_stem:
            return script_path
        if 'box' in script_key and 'box' in image_stem:
            return script_path
        if 'line' in script_key and any(word in image_stem for word in ['erasor', 'caros']):
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