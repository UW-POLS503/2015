RSCRIPT = Rscript
HW_RMD = $(wildcard hw*.Rmd)
HW_HTML = $(HW_RMD:%.Rmd=%.html)

all: build

build: $(HW_HTML)

%.html: %.Rmd
	$(RSCRIPT) -e 'rmarkdown::render("$^", output_file="$@", runtime="static")'

.PHONY: all build
