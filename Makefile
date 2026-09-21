# ==============================================================================
# Makefile for "What Not To Do When There Is A Murder In Town"
# Builds standard reflowable EPUB 3 and print-ready PDF
# ==============================================================================

OUTPUT      := output
SRC         := src
METADATA    := $(SRC)/metadata.yaml
FRONTMATTER := $(SRC)/frontmatter/acknowledgments.md
CHAPTERS    := $(sort $(wildcard $(SRC)/chapters/*.md))
BACKMATTER  := $(SRC)/backmatter/about-the-author.md $(SRC)/backmatter/back-cover.md
CSS         := styles/style.css
FRONT_COVER := $(SRC)/assets/front-cover.png
BACK_COVER  := $(SRC)/assets/back-cover.png

.PHONY: all epub pdf clean check-quotes help

all: epub

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

$(OUTPUT)/book.pdf: $(METADATA) $(SRC)/frontmatter/front-cover.md $(FRONTMATTER) $(CHAPTERS) $(BACKMATTER) $(FRONT_COVER) $(BACK_COVER)
	@mkdir -p $(OUTPUT)
	PATH="/Library/TeX/texbin:$(PATH)" pandoc $(METADATA) $(SRC)/frontmatter/front-cover.md $(FRONTMATTER) $(CHAPTERS) $(BACKMATTER) \
		-o $(OUTPUT)/book.pdf \
		--pdf-engine=xelatex \
		-V geometry:"paperwidth=148mm, paperheight=210mm, margin=20mm" \
		--top-level-division=chapter \
		--toc \
		--resource-path=$(SRC):$(SRC)/assets
	@echo "PDF successfully built: $(OUTPUT)/book.pdf"

check-quotes:
	@python3 scripts/check_quotes.py

clean:
	rm -rf $(OUTPUT)

help:
	@echo "Available targets:"
	@echo "  make epub         - Build EPUB 3 ebook"
	@echo "  make pdf          - Build A5 print PDF (requires XeLaTeX)"
	@echo "  make check-quotes - Verify straight quotes across all markdown files"
	@echo "  make clean        - Remove build output"
