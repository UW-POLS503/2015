RSCRIPT = Rscript
LABS_RMD = $(wildcard *.Rmd)
LABS_HTML = $(LABS_RMD:%.Rmd=%.html)
INCLUDES = before_body.html after_body.html

all: build

build: labs

labs: $(LABS_HTML)

%.html: %.Rmd $(INCLUDES)
	$(RSCRIPT) -e 'rmarkdown::render("$<", output_file="$@", runtime="static", quiet=TRUE)'

.PHONY: all build labs
