#!/usr/bin/env python3
"""
Auto-update the Visualization Gallery section of README.md.

The README is the storefront for this repository, so the gallery is rendered
as a compact fixed-width thumbnail grid instead of full-size markdown images.
Each card links directly to the MATLAB script that produced the preview, and
the script index below the grid keeps the complete mapping scan-friendly.

Header (centred title block) and footer notes are preserved
verbatim; only the gallery between the section heading and the next major
heading is regenerated.
"""

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
        ("linegraph_caros",          "caros_rotor_speed.png",            "Caros flight data"),
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
        ("barplot_maxclique",        "num_MC.png",                             "Max-clique inlier counts"),
        ("barplot_quatro_runtime",   "average_computational_time_v2_i7.png",   "Quatro runtime breakdown"),
        ("barplot_success_rate",     "SuccessRate1_quatro_pp.png",             "Success rate across methods"),
    ]),
    ("Box plot", [
        ("boxplot_aoa_ssa", "boxplot1.png",         "AOA / SSA error"),
        ("boxplot_runtime", "box_plot2_r300.png",   "Method runtime"),
    ]),
    ("CDF", [
        ("cdf_angles",  "total_cdf_alpha.png",            "Alpha / beta angle CDFs"),
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

GALLERY_HEADING = "## :art: Visualization Gallery"
LEGACY_GALLERY_HEADINGS = [
    GALLERY_HEADING,
    "## :art: Generated Figures",
    "## Generated Figures",
]
FOOTER_HEADING = "## :page_facing_up: Notes"
LEGACY_FOOTER_HEADINGS = [
    FOOTER_HEADING,
    "## :page_facing_up: Description",
    "# Description",
]
CARD_COLS = 4
CARD_IMG_WIDTH = 180


# ----------------------------------------------------------------------
# Implementation
# ----------------------------------------------------------------------

def flatten_groups() -> List[Tuple[str, str, str, str]]:
    """Return gallery entries as (category, script_stem, image_name, caption)."""
    entries = []
    for category, group_entries in GROUPS:
        for script_stem, image_name, caption in group_entries:
            entries.append((category, script_stem, image_name, caption))
    return entries


def render_card(category: str, script_stem: str, image_name: str, caption: str) -> str:
    img_path = f"./imgs/{image_name}"
    script_file = f"{script_stem}.m"
    return "\n".join([
        '<td width="25%" align="center" valign="top">',
        f'  <a href="{script_file}"><img src="{img_path}" alt="{caption}" width="{CARD_IMG_WIDTH}" /></a><br />',
        f"  <strong>{caption}</strong><br />",
        f"  <sub>{category}</sub><br />",
        f'  <a href="{script_file}"><code>{script_file}</code></a>',
        "</td>",
    ])


def render_gallery_grid() -> str:
    """Render all representative figures as a compact HTML thumbnail grid."""
    entries = flatten_groups()
    out = ["<table>"]
    for i in range(0, len(entries), CARD_COLS):
        out.append("<tr>")
        for category, script_stem, image_name, caption in entries[i:i + CARD_COLS]:
            out.append(render_card(category, script_stem, image_name, caption))
        out.append("</tr>")
    out.append("</table>")
    return "\n".join(out) + "\n"


def render_script_index() -> str:
    """Render a compact category-to-script map below the visual gallery."""
    out = [
        "### Script index",
        "",
        "| Type | Scripts | Representative outputs |",
        "| :--- | :--- | :--- |",
    ]
    for category, entries in GROUPS:
        scripts = "<br />".join(
            f"[`{script_stem}.m`]({script_stem}.m)"
            for script_stem, _, _ in entries
        )
        outputs = "<br />".join(
            f"[`{image_name}`](imgs/{image_name})"
            for _, image_name, _ in entries
        )
        out.append(f"| {category} | {scripts} | {outputs} |")
    return "\n".join(out) + "\n"


def render_collision_notes() -> str:
    if not COLLISION_NOTES:
        return ""
    lines = ["> **Output collisions:** these scripts intentionally write the same filenames as a primary script above."]
    for hidden, twin in COLLISION_NOTES:
        lines.append(f"> - [`{hidden}.m`]({hidden}.m) uses the same output filenames as [`{twin}.m`]({twin}.m).")
    return "\n".join(lines) + "\n"


def build_gallery() -> str:
    out = [GALLERY_HEADING, "",
           "A compact map of representative outputs in `imgs/`. Click any preview or script name to open the MATLAB source.",
           "",
           "_This section is generated by [`scripts/update_readme.py`](scripts/update_readme.py) and checked by CI._",
           ""]
    out.append(render_gallery_grid())
    out.append(render_script_index())
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
    the notes/description heading (or the legacy '# Description' if still present)
    so the user-written sections survive.
    """
    text = Path("README.md").read_text(encoding="utf-8")

    # Find the gallery heading (new or legacy form)
    gallery_idx = -1
    for c in LEGACY_GALLERY_HEADINGS:
        gallery_idx = text.find(c)
        if gallery_idx != -1:
            break
    if gallery_idx == -1:
        # No gallery yet; everything is the header
        return text.rstrip() + "\n\n", ""

    header = text[:gallery_idx].rstrip() + "\n\n"

    # Find next major heading after the gallery
    after = text[gallery_idx:]
    footer_idx_local = -1
    for c in LEGACY_FOOTER_HEADINGS:
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
