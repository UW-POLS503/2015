SHELL = bash
R = Rscript
WEBDIR = web
LECTURE_DIR = lectures
HANDOUTS_DIR = handouts
LAB_DIR = labs
HW_DIR = hw

PAGES_DIR = $(WEBDIR)/pages
POSTS_DIR = $(WEBDIR)/posts

all : build

lectures: data
	make -C lectures
	-mkdir $(WEBDIR)/files/lectures
	-cp $(wildcard $(LECTURE_DIR)/*_handout.pdf) $(WEBDIR)/files/lectures/

handouts:
	make -C handouts
	-mkdir $(WEBDIR)/files/handouts
	-cp $(wildcard $(HANDOUTS_DIR)/*.pdf) $(WEBDIR)/files/handouts/

labs: data
	make -C labs
	-mkdir $(WEBDIR)/files/labs
	-cp $(LAB_DIR)/*.Rmd $(LAB_DIR)/*.html $(WEBDIR)/files/labs/

hw: data
	make -C hw
	-mkdir $(WEBDIR)/files/hw
	-cp $(HW_DIR)/*.html $(HW_DIR)/*.Rmd $(HW_DIR)/*.R  $(WEBDIR)/files/hw

web: data labs

build: data lectures hw labs web
	cd $(WEBDIR); source venv/bin/activate; nikola build

deploy: build
	cd $(WEBDIR); source venv/bin/activate; nikola github_deploy

data: data/gapminder.csv

data/gapminder.csv: data/gapminder.R
	cd data && $(R) $(notdir $^)

.PHONY: lectures build build-deploy labs hw web data handouts
