# POLS/CS&SS 503: Advanced Quantitative Political Methodology

Course materials for POLS/CS&SS 503 -- Spring 2015 quarter at the University of Washington.

Course website is at https://jrnold.github.io/pols_503_sp15/

## Install

This site is built using the static site generator [Nikola](http://getnikola.com/) with Python 3.

[Install](http://getnikola.com/handbook.html#installing-nikola) the latest version of Nikola and then build the site

```console
> nikola build
```
and serve it locally
```console
> nikola serve
```

Another way to install the dependencies to build
Install `venv`. For Ubuntu 14.10 and python 3
```console
> apt-get install python3-venv
```
Then create and activate a local environment
```
> pyvenv-3.4 venv
> source venv/bin/activate
```
One the virtual environment is activiated, install the dependencies with
```
pip requirements.txt
```

Additionally this site requires

- [pandoc](http://johnmacfarlane.net/pandoc/)
- [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)

In Ubuntu these can be installed with
```console
> apt-get install pandoc pandoc-citeproc
```

