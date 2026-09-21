# ==============================================================================
# Makefile for "What Not To Do When There Is A Murder In Town"
# Builds standard reflowable EPUB 3 and print-ready PDF
# ==============================================================================

SRC          := src
OUTPUT       := output
BOOK_NAME    := Aradhana_Mystery_Novel_001
EPUB_OUT     := $(OUTPUT)/$(BOOK_NAME).epub
PDF_OUT      := $(OUTPUT)/$(BOOK_NAME).pdf
CHAPTERS     := $(sort $(wildcard $(SRC)/chapters/*.md))
MANUSCRIPT   := $(SRC)/metadata.yaml $(SRC)/frontmatter/acknowledgments.md $(CHAPTERS) $(SRC)/backmatter/about-the-author.md
COVERS       := $(SRC)/assets/front-cover.png $(SRC)/assets/back-cover.png
CSS          := styles/style.css
PDF_TEMPLATE := templates/pdf-template.typst

.PHONY: all epub pdf check-quotes clean help

all: epub pdf

epub: $(EPUB_OUT)

$(EPUB_OUT): $(MANUSCRIPT) $(SRC)/backmatter/back-cover.md $(CSS) $(COVERS)
	@mkdir -p $(OUTPUT)
	pandoc $(MANUSCRIPT) $(SRC)/backmatter/back-cover.md \
		-t epub3 \
		--split-level=1 \
		--epub-cover-image=$(SRC)/assets/front-cover.png \
		--css=$(CSS) \
		--resource-path=$(SRC):$(SRC)/assets \
		-o $@
	@echo "Built EPUB: $@"

pdf: $(PDF_OUT)

$(PDF_OUT): $(MANUSCRIPT) $(PDF_TEMPLATE) $(COVERS)
	@mkdir -p $(OUTPUT)
	pandoc $(MANUSCRIPT) \
		--template=$(PDF_TEMPLATE) \
		--pdf-engine=typst \
		-o $@
	@echo "Built PDF:  $@"

check-quotes:
	@python3 scripts/check_quotes.py

clean:
	rm -rf $(OUTPUT)

help:
	@echo "Available targets:"
	@echo "  make all          - Build EPUB 3 ebook and printable A4 PDF"
	@echo "  make epub         - Build EPUB 3 ebook"
	@echo "  make pdf          - Build printable A4 PDF (requires Typst)"
	@echo "  make check-quotes - Verify straight quotes across all markdown files"
	@echo "  make clean        - Remove build output"
