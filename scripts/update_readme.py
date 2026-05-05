#!/usr/bin/env python3
"""
Auto-update the Generated Figures section of README.md.

Shows ONE representative image per MATLAB plot script, grouped by category
(line graph, horizontal bar, etc.). The categorisation and the picked image
per script are hard-coded below since each script's "primary" output is a
judgement call about which figure best represents the script.

Scripts whose output collides with a sibling (e.g. linegraph_biou_pxthr.m
and linegraph_biou_masking.m both produce imgs/biou_line_graph.png) appear
once; the other sibling is documented in a small "Other variants" footnote
below the gallery.

Header (centred title block) and footer (Description section) are preserved
verbatim — only the gallery between the section heading and the next major
heading is regenerated.
"""

import os
import re
from pathlib import Path
from typing import List, Tuple

# ----------------------------------------------------------------------
# Gallery layout — edit these to update what shows up in the README
# ----------------------------------------------------------------------

# Each group: (category title, [(script_stem, primary_image_filename, display_caption), ...])
# `primary_image_filename` is relative to imgs/ and must exist.
# `display_caption` shows above the figure; keep it short — the category
# heading already provides context.
# Scripts collide on output filenames intentionally; only the primary is shown.
GROUPS: List[Tuple[str, List[Tuple[str, str, str]]]] = [
    ("Line graph", [
        ("linegraph_biou_pxthr",     "biou_line_graph.png",              "B-mIoU vs pixel threshold"),
        ("linegraph_caros",          "caros_rotor_speed.png",            "caros flight data"),
        ("linegraph_erasor_ground",  "erasor_ground_preservation.png",   "ERASOR ground threshold"),
        ("linegraph_hydra_pr",       "hydra2_0_precision.png",           "Hydra2.0 PR-curve"),
        ("linegraph_vggt",           "vggt_ate.png",                     "VGGT confidence sweep"),
    ]),
    ("Horizontal bar", [
        ("horizontal_bars_deeplabv3", "horizontal_bar_w_deeplabv3.png",          "DeepLabv3 / HRNet / OCRNet / UPerNet"),
        ("horizontal_bars_hrnet",     "biou_horizontal_bar_w_hrnet_3px.png",     "B-mIoU per pixel threshold"),
    ]),
    ("Vertical bar", [
        ("barplot_gpf_precision",    "ground_bar_plot_v2.png",                 "GPF vs R-GPF precision"),
        ("barplot_maxclique",        "num_MC.png",                             "max-clique inlier counts"),
        ("barplot_quatro_runtime",   "average_computational_time_v2_i7.png",   "Quatro runtime breakdown"),
        ("barplot_success_rate",     "SuccessRate1_quatro_pp.png",             "success rate across methods"),
    ]),
    ("Box plot", [
        ("boxplot_aoa_ssa", "boxplot1.png",         "AOA / SSA error"),
        ("boxplot_runtime", "box_plot2_r300.png",   "method runtime"),
    ]),
    ("CDF", [
        ("cdf_angles",  "total_cdf_alpha.png",            "alpha / beta angle CDFs"),
        ("cdf_chamfer", "cdf_for_chamfer_distance.png",   "Chamfer-distance CDF"),
    ]),
    ("PDF", [
        ("pdf_erasor_scan_ratio", "erasor_pdf_diff_percentage.png", "ERASOR scan-ratio"),
    ]),
    ("PR curve", [
        ("prcurve_hydra", "precision_recall_curve.png", "PR + F1-vs-threshold"),
    ]),
    ("Trajectory", [
        ("trajectory_3d_utm", "Navigation_trajectory.png", "3D UTM with colour gradient"),
        ("trajectory_vbr",    "campus_train0_gt.png",      "VBR dataset trajectories"),
    ]),
    ("Scatter with heatmap", [
        ("scatter_heatmap_weights", "tims_rotation_v30.png", "TIMS weights heatmap"),
    ]),
    ("Tilelayout", [
        ("tilelayout_pasga", "final_tilelayout.png", "PaSGA ring/sector ablation"),
    ]),
    ("Stacked area", [
        ("area_xavier_time", "time_stacked.png", "Xavier per-stage time"),
    ]),
]

# Scripts present in the repo but intentionally hidden from the gallery
# because their output collides with a sibling already shown. Listed here
# so a future reader knows where to find them.
COLLISION_NOTES: List[Tuple[str, str]] = [
    ("linegraph_biou_masking",  "linegraph_biou_pxthr"),
    ("linegraph_hydra_sam3d",   "linegraph_hydra_pr"),
]

GALLERY_HEADING = "## :art: Generated Figures"
DESCRIPTION_HEADING = "## :page_facing_up: Description"
COLS = 3


# ----------------------------------------------------------------------
# Implementation
# ----------------------------------------------------------------------

def render_group(title: str, entries: List[Tuple[str, str, str]]) -> str:
    """Render one category as a sub-heading + 3-column markdown table."""
    if not entries:
        return ""

    out = [f"### {title}", ""]
    for i in range(0, len(entries), COLS):
        chunk = entries[i:i + COLS]

        # Pad short trailing rows
        while len(chunk) < COLS:
            chunk = chunk + [("", "", "")]

        headers, seps, imgs, links = [], [], [], []
        for script_stem, image_name, caption in chunk:
            if not script_stem:
                headers.append("")
                seps.append("")
                imgs.append("")
                links.append("")
                continue

            img_path = f"./imgs/{image_name}"
            script_file = f"{script_stem}.m"

            headers.append(caption)
            seps.append(":---:")
            imgs.append(f"![{caption}]({img_path})")
            links.append(f"[`{script_file}`]({script_file})")

        out.append("| " + " | ".join(headers) + " |")
        out.append("| " + " | ".join(seps) + " |")
        out.append("| " + " | ".join(imgs) + " |")
        out.append("| " + " | ".join(links) + " |")
        out.append("")
    return "\n".join(out) + "\n"


def render_collision_notes() -> str:
    if not COLLISION_NOTES:
        return ""
    lines = ["> **Other variants (output filenames collide with siblings above):**"]
    for hidden, twin in COLLISION_NOTES:
        lines.append(f"> - [`{hidden}.m`]({hidden}.m) — same output as [`{twin}.m`]({twin}.m)")
    return "\n".join(lines) + "\n"


def build_gallery() -> str:
    out = [GALLERY_HEADING, "",
           "*Click the link under each figure to open the corresponding MATLAB script.*",
           ""]
    for title, entries in GROUPS:
        out.append(render_group(title, entries))
    out.append(render_collision_notes())
    return "\n".join(out)


def validate_inputs() -> List[str]:
    """Return a list of human-readable problems with the GROUPS table."""
    problems = []
    for _, entries in GROUPS:
        for stem, img, _ in entries:
            if not Path(f"{stem}.m").exists():
                problems.append(f"missing script: {stem}.m")
            if not Path("imgs").joinpath(img).exists():
                problems.append(f"missing image: imgs/{img}")
    return problems


def read_readme_split() -> Tuple[str, str]:
    """Split the existing README into (header, footer) around the gallery.

    The new gallery is inserted between header and footer. Footer starts at
    the Description heading (or the legacy '# Description' if still present)
    so the user-written sections survive.
    """
    text = Path("README.md").read_text(encoding="utf-8")

    # Find the gallery heading (new or legacy form)
    candidates = [GALLERY_HEADING, "## Generated Figures"]
    gallery_idx = -1
    for c in candidates:
        gallery_idx = text.find(c)
        if gallery_idx != -1:
            break
    if gallery_idx == -1:
        # No gallery yet; everything is the header
        return text.rstrip() + "\n\n", ""

    header = text[:gallery_idx].rstrip() + "\n\n"

    # Find next major heading after the gallery
    after = text[gallery_idx:]
    footer_candidates = [DESCRIPTION_HEADING, "# Description"]
    footer_idx_local = -1
    for c in footer_candidates:
        idx = after.find(c)
        if idx != -1:
            footer_idx_local = idx
            break

    if footer_idx_local == -1:
        # No section after gallery
        footer = ""
    else:
        footer = after[footer_idx_local:]

    return header, footer


def update_readme() -> None:
    print("🔍 Validating inputs...")
    problems = validate_inputs()
    for p in problems:
        print(f"  ⚠️  {p}")
    if problems:
        print("Aborting due to missing files. Update GROUPS in scripts/update_readme.py.")
        return

    print("📝 Building gallery...")
    gallery = build_gallery()

    print("📖 Splitting existing README...")
    header, footer = read_readme_split()

    new = header + gallery
    if footer:
        # Standard 70-underscore divider before the next major section
        new = new.rstrip() + "\n\n" + ("_" * 70) + "\n\n" + footer

    Path("README.md").write_text(new, encoding="utf-8")

    n_scripts = sum(len(g[1]) for g in GROUPS)
    print(f"✅ README.md updated: {n_scripts} scripts across {len(GROUPS)} categories.")


if __name__ == "__main__":
    update_readme()
