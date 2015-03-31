SHELL = bash
WEBDIR = web
LECTURES = lectures

all :build

lectures:
	make -C lectures
	cp $(wildcard $(LECTURES)/*_handout.pdf) $(WEBDIR)/files/lectures/

build: lectures
	cd $(WEBDIR); source venv/bin/activate; nikola build

deploy: lectures
	cd $(WEBDIR); source venv/bin/activate; nikola github_deploy

.PHONY: lectures build build-deploy
