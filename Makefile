SHELL = bash
R = Rscript
WEBDIR = web
LECTURE_DIR = lectures
LAB_DIR = labs
HW_DIR = hw

WEB_RMD_FILES = $(wildcard $(WEBDIR)/pages/*.Rmd)
WEB_MD_FILES = $(WEB_RMD_FILES:%.Rmd=%.md)

all : build

lectures:
	make -C lectures
	-mkdir $(WEBDIR)/files/lectures
	cp $(wildcard $(LECTURE_DIR)/*_handout.pdf) $(WEBDIR)/files/lectures/

labs:
	make -C labs
	-mkdir $(WEBDIR)/files/labs
	cp $(LAB_DIR)/*.Rmd $(LAB_DIR)/*.html $(LAB_DIR)/*.csv $(WEBDIR)/files/labs

hw:
	make -C hw
	-mkdir $(WEBDIR)/files/hw
	cp $(HW_DIR)/hw*.html $(WEBDIR)/files/hw

web: $(WEB_MD_FILES)

web/pages/%.md: web/pages/%.Rmd
	cd web/pages && $(R) -e 'knitr::knit("$(notdir $^)", output="$(notdir $@)")'

build: lectures hw labs web
	cd $(WEBDIR); source venv/bin/activate; nikola build

deploy: build
	cd $(WEBDIR); source venv/bin/activate; nikola github_deploy

.PHONY: lectures build build-deploy labs hw web
