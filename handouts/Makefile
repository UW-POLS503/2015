RSCRIPT = Rscript
HANDOUTS_RMD = $(wildcard *.Rmd)
HANDOUTS_PDF = $(HANDOUTS_RMD:%.Rmd=%.pdf)

all: build

build: handouts

handouts: $(HANDOUTS_PDF)

%.pdf: %.Rmd
	$(RSCRIPT) -e 'rmarkdown::render("$^", output_file="$@", runtime="static")'

clean:
	-rm -f $(wildcard *_cache) $(wildcard *_files)

.PHONY: all build handouts clean

