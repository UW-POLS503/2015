RSCRIPT = Rscript
LABS_RMD = $(wildcard *.Rmd)
LABS_HTML = $(LABS_RMD:%.Rmd=%.html)

all: build

build: data

labs: $(LABS_HTML) data

data: gapminder.csv

gapminder.csv: gapminder.R
	$(RSCRIPT) $^

%.html: %.Rmd
	$(RSCRIPT) -e 'rmarkdown::render("$^", output_file="$@", runtime="static")'
