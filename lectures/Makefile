R = Rscript
LATEXMK = latexmk
LATEXMK_OPTS = -use-make -quiet -xelatex -pdf -interaction=nonstopmode

LECTURE_RNW = $(wildcard Lecture_*.Rnw)
LECTURE_TEX = $(LECTURE_RNW:%.Rnw=%.tex)
LECTURE_PRESENTATIONS = $(LECTURE_TEX:%.tex=%_presentation.pdf)
LECTURE_HANDOUTS = $(LECTURE_TEX:%.tex=%_handout.pdf)

INPUTS = includes.tex CSSScolors.sty beamerthemePOLSLIII.sty init.R

all : handouts presentations

presentations: $(LECTURE_PRESENTATIONS) 

handouts: $(LECTURE_HANDOUTS)

Lecture_%.tex : Lecture_%.Rnw $(INPUTS)
	$(R) -e 'LECTURE_NUM <- "$(patsubst Lecture_%.tex,%,$@)"; knitr::knit("$<",output="$@",quiet=TRUE)'

Lecture_%_handout.pdf : Lecture_%.tex 
	@echo "\def\ishandout{1}" > $(patsubst %.pdf,%-options.tex,$@)
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(basename $@) $<

Lecture_%_presentation.pdf : Lecture_%.tex $(INPUTS)
	@echo "" > $(patsubst %.pdf,%-options.tex,$@)
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(basename $@) $<

%-code.R: %.Rnw
	$(R) -e 'library(knitr);purl("$<",output="$@")'

clean :
	-rm -rf *.aux *.bcf *.log *.snm *.out *.nav *.toc *.vrb *-options.tex *~ *.fls

clean-all: clean
	-rm $(LECTURE_TEX) $(LECTURE_PRESENTATIONS) $(LECTURE_HANDOUTS)

.PHONY: clean all

.PRECIOUS: $(LECTURE_TEX)
