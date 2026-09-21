# What Not To Do When There Is A Murder In Town

A young adult murder mystery novel by **Aradhana Premkumar**.

---

## Project Structure

This repository follows industry-standard digital publishing and manuscript conventions:

```text
.
├── Makefile                     # Build pipeline for EPUB and PDF
├── README.md                    # Project documentation
├── .gitignore                   # Ignores build artifacts and OS caches
├── src/
│   ├── metadata.yaml            # Dublin Core book metadata (title, author, rights, genre)
│   ├── chapters/                # Modular chapter manuscript files
│   │   ├── chapter-01.md
│   │   ├── chapter-02.md
│   │   ├── ...
│   │   └── chapter-17.md        # "Hello, England"
│   ├── backmatter/              # Standard publishing backmatter
│   │   ├── acknowledgments.md   # Acknowledgments section
│   │   ├── about-the-author.md  # Author biography
│   │   └── back-cover.md        # Full-page SVG back cover wrapper
│   ├── frontmatter/             # Front matter sections
│   │   └── front-cover.md       # Front cover wrapper
│   └── assets/                  # Artwork and vector overlays
│       ├── front-cover.png      # High-res front cover artwork
│       ├── back-cover.png       # High-res back cover artwork (barcode removed)
│       ├── front-cover-overlay.svg # Transparent SVG title overlay
│       └── back-cover-overlay.svg  # Transparent SVG blurb overlay
├── styles/
│   └── style.css                # Reflowable EPUB CSS (reader-controlled typography)
├── scripts/
│   └── check_quotes.py          # Linter to verify straight quotes across manuscript
└── output/                      # Generated ebooks (EPUB / PDF)
```

---

## Prerequisites

- [Pandoc](https://pandoc.org/) (`>= 3.0`):
  ```bash
  brew install pandoc
  ```
- Python 3 (standard on macOS)
- (Optional for PDF print export) XeLaTeX / TeX Live

---

## Building the Book

- **Build EPUB 3 Ebook**:
  ```bash
  make epub
  ```
  Generates `output/book.epub` with:
  - True full-page front and back covers (SVG viewport matching reader screens).
  - Reader-controlled typography (no hardcoded font or size).
  - Clean table of contents and chapter navigation.

- **Verify Quotes**:
  ```bash
  make check-quotes
  ```
  Audits all chapters and backmatter to ensure 100% straight quotes.

- **Clean Build Artifacts**:
  ```bash
  make clean
  ```
