SHELL = bash
WEBDIR = web
LECTURE_DIR = lectures
LAB_DIR = labs

all :build

lectures:
	make -C lectures
	-mkdir $(WEBDIR)/files/lectures
	cp $(wildcard $(LECTURE_DIR)/*_handout.pdf) $(WEBDIR)/files/lectures/

labs:
	make -C labs;
	-mkdir $(WEBDIR)/files/labs
	cp $(LAB_DIR)/*.Rmd $(LAB_DIR)/*.html $(LAB_DIR)/*.csv $(WEBDIR)/files/labs

build: lectures
	cd $(WEBDIR); source venv/bin/activate; nikola build

deploy: lectures
	cd $(WEBDIR); source venv/bin/activate; nikola github_deploy

.PHONY: lectures build build-deploy labs
