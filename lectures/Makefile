R = Rscript
LATEXMK = latexmk
LATEXMK_OPTS = -use-make -xelatex -pdf -f

LECTURE_RNW = $(wildcard Lecture_*.Rnw)
LECTURE_TEX = $(LECTURE_RNW:%.Rnw=%.tex)
LECTURE_PRESENTATIONS = $(LECTURE_TEX:%.tex=%_presentation.pdf)
LECTURE_HANDOUTS = $(LECTURE_TEX:%.tex=%_handout.pdf)

INPUTS = # includes.tex CSSScolors.sty beamerthemePOLSLIII.sty

all : $(LECTURE_PRESENTATIONS) $(LECTURE_HANDOUTS)
	@echo $(LECTURE_TEX)
	@echo $(LECTURE_PRESENTATIONS) $(LECTURE_HANDOUTS)

Lecture_%.tex : Lecture_%.Rnw
	$(R) -e 'LECTURE_NUM <- "$(patsubst Lecture_%.tex,%,$@)"; knitr::knit("$<",output="$@")'

Lecture_%_handout.pdf : Lecture_%.tex $(INPUTS)
	@echo "\def\ishandout{1}" > $(patsubst %.pdf,%-options.tex,$@)
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(basename $@) $<

Lecture_%_presentation.pdf : Lecture_%.tex $(INPUTS)
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(basename $@) $<

clean :
	-rm -rf *.aux *.bcf *.log *.snm *.out *.nav *.toc *.vrb *-options.tex *~ *.fls

clean-all: clean
	-rm $(LECTURE_TEX) $(LECTURE_PRESENTATIONS) $(LECTURE_HANDOUTS)

.PHONY: clean all

.PRECIOUS: $(LECTURE_TEX)
