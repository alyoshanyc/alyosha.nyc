#!/usr/bin/env python3
"""Regenerate _data/image_dims.yml from post `image` front matter.

Reads every post under _posts/, measures its image with sips (macOS), and
writes intrinsic pixel dimensions keyed by bare filename. The home layout
uses these for width/height attributes so the browser reserves each tile's
space before the image loads. Run after adding or replacing images.
"""
import os
import re
import subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

images = []
for root, _, files in os.walk(os.path.join(ROOT, "_posts")):
    for f in sorted(files):
        with open(os.path.join(root, f)) as fh:
            fm = fh.read().split("---")[1]
        m = re.search(r"^image:\s*(\S+)", fm, re.M)
        if m:
            images.append(m.group(1))

out = os.path.join(ROOT, "_data", "image_dims.yml")
with open(out, "w") as f:
    f.write("# Generated: intrinsic pixel dimensions per gallery image filename.\n")
    f.write("# Regenerate with scripts/generate-image-dims.py after adding images.\n")
    for img in sorted(set(images)):
        path = os.path.join(ROOT, img.lstrip("/"))
        res = subprocess.run(
            ["sips", "-g", "pixelWidth", "-g", "pixelHeight", path],
            capture_output=True, text=True,
        ).stdout
        w = re.search(r"pixelWidth: (\d+)", res)
        h = re.search(r"pixelHeight: (\d+)", res)
        if not (w and h):
            print(f"WARNING: could not measure {path}")
            continue
        f.write(f"{os.path.basename(img)}:\n  width: {w.group(1)}\n  height: {h.group(1)}\n")

print(f"Wrote {out} ({len(set(images))} images)")
