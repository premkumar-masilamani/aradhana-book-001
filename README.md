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
│   └── pdf-template.typst       # Typst template for printable A4/A5 book PDF
├── scripts/
│   └── check_quotes.py          # Linter to verify straight quotes across manuscript
└── output/                      # Generated book outputs (EPUB / PDF)
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
- **Python 3** (standard on macOS)

---

## Building the Book

- **Build Everything (EPUB & PDF)**:
  ```bash
  make all
  ```

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
  - **A4 reading & A5 book binding**: Set to `15.5pt` body font, which scales by $70.71\%$ ($1/\sqrt{2}$) to standard novel `11.0pt` when printed in A5.
  - **Spine gutter margins**: `28mm` margins scale to `20mm` on A5, ensuring text never falls into the binding fold.
  - Full-bleed edge-to-edge front and back cover pages.
  - Title page with author and copyright notice.
  - Running headers (small-caps book title) and centered page numbers.

- **Verify Quotes**:
  ```bash
  make check-quotes
  ```
  Audits all chapters and front/back matter to ensure 100% straight quotation marks.

- **Clean Build Output**:
  ```bash
  make clean
  ```
