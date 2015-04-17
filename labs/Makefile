RSCRIPT = Rscript
LABS_RMD = $(wildcard *.Rmd)
LABS_HTML = $(LABS_RMD:%.Rmd=%.html)

all: build

build: labs

labs: $(LABS_HTML)

%.html: %.Rmd
	$(RSCRIPT) -e 'rmarkdown::render("$^", output_file="$@", runtime="static")'

.PHONY: all build labs
