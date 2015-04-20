SHELL = bash
R = Rscript
WEBDIR = web
LECTURE_DIR = lectures
LAB_DIR = labs
HW_DIR = hw

PAGES_DIR = $(WEBDIR)/pages
PAGES_RMD_FILES = $(wildcard $(PAGES_DIR)/*.Rmd)
PAGES_MD_FILES = $(PAGES_RMD_FILES:%.Rmd=%.md)
POSTS_DIR = $(WEBDIR)/posts
POSTS_RMD_FILES = $(wildcard $(POSTS_DIR)/*.Rmd)
POSTS_MD_FILES = $(POSTS_RMD_FILES:%.Rmd=%.md)

all : build

lectures: data
	make -C lectures
	-mkdir $(WEBDIR)/files/lectures
	-cp $(wildcard $(LECTURE_DIR)/*_handout.pdf) $(WEBDIR)/files/lectures/

labs: data
	make -C labs
	-mkdir $(WEBDIR)/files/labs
	-cp $(LAB_DIR)/*.Rmd $(LAB_DIR)/*.html $(WEBDIR)/files/labs

hw: data
	make -C hw
	-mkdir $(WEBDIR)/files/hw
	-cp $(HW_DIR)/hw*.html $(WEBDIR)/files/hw

web: $(PAGES_MD_FILES) $(POSTS_MD_FILES) data labs

web/pages/%.md: web/pages/%.Rmd
	cd $(dir $^) && $(R) -e 'knitr::knit("$(notdir $^)")'

web/posts/%.md: web/posts/%.Rmd
	cd $(dir $^) && $(R) -e 'knitr::knit("$(notdir $^)")'

build: data lectures hw labs web
	cd $(WEBDIR); source venv/bin/activate; nikola build

deploy: build
	cd $(WEBDIR); source venv/bin/activate; nikola github_deploy

data: data/gapminder.csv

data/gapminder.csv: data/gapminder.R
	cd data && $(R) $(notdir $^)

.PHONY: lectures build build-deploy labs hw web data
