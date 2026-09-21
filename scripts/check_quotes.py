#!/usr/bin/env python3
"""Audit manuscript files to verify zero smart quotes are present."""
import glob
import sys

files = sorted(
    glob.glob("src/frontmatter/*.md") +
    glob.glob("src/chapters/*.md") +
    glob.glob("src/backmatter/*.md")
)
bad_found = False

for f in files:
    with open(f, "r", encoding="utf-8") as fh:
        text = fh.read()
    smart = [ch for ch in text if ch in "“”‘’«»"]
    if smart:
        print(f"Smart quotes detected in {f}: {smart}")
        bad_found = True

if not bad_found:
    print(f"All {len(files)} manuscript files verified: 0 smart quotes found.")
    sys.exit(0)
else:
    sys.exit(1)
