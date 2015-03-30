R = Rscript
LATEXMK = latexmk
LATEXMK_OPTS = -use-make -xelatex -pdf

LECTURE_RNW = $(wildcard Lecture-*.Rnw)
LECTURE_RNW_MD = $(LECTURE_RNW:%.Rnw=%.md)
LECTURE_RNW_PDF = $(LECTURE_RNW:%.Rnw=%.pdf)
LECTURE_RNW_TEX = $(LECTURE_RNW:%.Rnw=%.tex)

INPUTS = includes.tex CSSScolors.sty beamerthemePOLSLIII.sty

all : $(LECTURE_PDF) $(LECTURE_RNW_PDF)


Lecture-%.tex : Lecture-%.Rnw
	$(R) -e 'knitr::knit("$<",output="$@")'

Lecture-%.pdf : Lecture-%.tex $(INPUTS)
	$(LATEXMK) $(LATEXMK_OPTS) $<

clean :
	-rm -rf *.aux *.bcf *.log *.snm *.out *.nav *.toc *.vrb *-options.tex *~ *.fls

.PHONY: clean all

.PRECIOUS: $(LECTURE_RNW_TEX)
