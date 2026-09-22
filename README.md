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
│   ├── frontmatter/             # Front matter sections
│   │   └── acknowledgments.md   # Author acknowledgments (placed before Chapter 1)
│   ├── chapters/                # Modular chapter manuscript files
│   │   ├── chapter-01.md
│   │   ├── chapter-02.md
│   │   ├── ...
│   │   └── chapter-17.md        # "Hello, England"
│   ├── backmatter/              # Publishing backmatter
│   │   ├── about-the-author.md  # Author biography
│   │   └── back-cover.md        # Dedicated back cover section for EPUB
│   └── assets/                  # High-resolution cover artwork
│       ├── front-cover.png      # Front cover artwork
│       └── back-cover.png       # Back cover artwork (barcode removed)
├── styles/
│   └── style.css                # Reflowable EPUB CSS (reader-controlled typography, ornamental breaks)
├── templates/
│   ├── pdf-template.typst           # Typst template for standard printable A4 book PDF
│   └── booklet-pdf-template.typst   # Typst template for booklet PDF (odd page starts, covers at end)
└── output/                          # Generated book outputs (EPUB / PDF)
```

---

## Prerequisites

- **[Pandoc](https://pandoc.org/)** (`>= 3.0`):
  ```bash
  brew install pandoc
  ```
- **[Typst](https://typst.app/)** (`>= 0.11`):
  ```bash
  brew install typst
  ```

---

## Building the Book

- **Build Everything (EPUB, Standard PDF & Booklet PDF)**:
  ```bash
  make
  ```
  *(or `make all`)*
  Produces all three publishing formats in `output/`:
  1. `output/Aradhana_Mystery_Novel_001.epub` (Reflowable EPUB 3 ebook)
  2. `output/Aradhana_Mystery_Novel_001.pdf` (Standard reading A4 PDF)
  3. `output/Aradhana_Mystery_Novel_001_Booklet.pdf` (Booklet print PDF with odd-page section starts and covers at end)

- **Build EPUB 3 Ebook**:
  ```bash
  make epub
  ```
  Generates `output/Aradhana_Mystery_Novel_001.epub` featuring:
  - Full-bleed front and back raster covers without black letterboxing.
  - Reader-controlled typography (line height `1.5`, flush-left conversational paragraphs).
  - Ornamental star divider (`✧ ✧ ✧`) beneath chapter titles.
  - Multi-line poem blocks with preserved line breaks.
  - Seamless reading spine (Acknowledgments flips directly into Chapter 1).

- **Build Printable PDF**:
  ```bash
  make pdf
  ```
  Generates `output/Aradhana_Mystery_Novel_001.pdf` configured for:
  - **Typography & Layout**: Set to `15.5pt` body font with generous line spacing and clean typography.
  - **Margins**: `28mm` side margins and `25mm` top/bottom margins.
  - Full-bleed edge-to-edge front and back cover pages.
  - Title page with author and copyright notice.
  - Running headers (small-caps book title) and centered page numbers.

- **Build Booklet PDF (Odd-Page Starts & Covers at End)**:
  ```bash
  make booklet
  ```
  Generates `output/Aradhana_Mystery_Novel_001_Booklet.pdf` customized for booklet duplex printing:
  - **Odd-Page Starts**: Every major section (Book Title, Acknowledgments, Chapters 1–17, and About the Author) starts strictly on odd page numbers (`1, 3, 5, 9, ...`). If a section ends on an odd page, a clean blank page is automatically inserted before the next section.
  - **Covers at the End**: The Back Cover and Front Cover (in that exact order) are placed on the final pages (`47` and `48`) to form the outer cover wrap.
  - **Clean Typography**: Running headers are automatically suppressed on blank pages and chapter opening pages, appearing only on interior continuation pages.

- **Clean Build Output**:
  ```bash
  make clean
  ```
