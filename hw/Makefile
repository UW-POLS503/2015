RSCRIPT = Rscript
HW_RMD = $(wildcard hw*.Rmd)
HW_HTML = $(HW_RMD:%.Rmd=%.html)
INCLUDES = before_body.html after_body.html

all: build

build: $(HW_HTML)

%.html: %.Rmd  $(INCLUDES)
	$(RSCRIPT) -e 'rmarkdown::render("$<", output_file="$@", runtime="static")'

hw3.html: hw3-functions.R

.PHONY: all build
