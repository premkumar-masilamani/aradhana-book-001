# ==============================================================================
# Makefile for "What Not To Do When There Is A Murder In Town"
# Builds standard reflowable EPUB 3 and print-ready PDF
# ==============================================================================

OUTPUT       := output
SRC          := src
METADATA     := $(SRC)/metadata.yaml
FRONTMATTER  := $(SRC)/frontmatter/acknowledgments.md
CHAPTERS     := $(sort $(wildcard $(SRC)/chapters/*.md))
BACKMATTER   := $(SRC)/backmatter/about-the-author.md $(SRC)/backmatter/back-cover.md
CSS          := styles/style.css
FRONT_COVER  := $(SRC)/assets/front-cover.png
BACK_COVER   := $(SRC)/assets/back-cover.png
PDF_TEMPLATE := templates/pdf-template.typst
PDF_INPUTS   := $(METADATA) $(FRONTMATTER) $(CHAPTERS) $(SRC)/backmatter/about-the-author.md

.PHONY: all epub pdf clean check-quotes help

all: epub pdf

epub: $(OUTPUT)/book.epub

$(OUTPUT)/book.epub: $(METADATA) $(FRONTMATTER) $(CHAPTERS) $(BACKMATTER) $(CSS) $(FRONT_COVER) $(BACK_COVER)
	@mkdir -p $(OUTPUT)
	pandoc $(METADATA) $(FRONTMATTER) $(CHAPTERS) $(BACKMATTER) \
		-o $(OUTPUT)/book.epub \
		-t epub3 \
		--split-level=1 \
		--epub-cover-image=$(FRONT_COVER) \
		--css=$(CSS) \
		--resource-path=$(SRC):$(SRC)/assets
	@echo "EPUB successfully built: $(OUTPUT)/book.epub"

pdf: $(OUTPUT)/book.pdf

$(OUTPUT)/book.pdf: $(PDF_TEMPLATE) $(PDF_INPUTS) $(FRONT_COVER) $(BACK_COVER)
	@mkdir -p $(OUTPUT)
	pandoc $(PDF_INPUTS) \
		--template=$(PDF_TEMPLATE) \
		--pdf-engine=typst \
		-o $(OUTPUT)/book.pdf
	@echo "Printable A4 PDF successfully built: $(OUTPUT)/book.pdf"

check-quotes:
	@python3 scripts/check_quotes.py

clean:
	rm -rf $(OUTPUT)

help:
	@echo "Available targets:"
	@echo "  make all          - Build both EPUB 3 ebook and printable A4 PDF"
	@echo "  make epub         - Build EPUB 3 ebook"
	@echo "  make pdf          - Build printable A4 PDF (requires Typst)"
	@echo "  make check-quotes - Verify straight quotes across all markdown files"
	@echo "  make clean        - Remove build output"
