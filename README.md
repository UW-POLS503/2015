# POLS/CS&SS 503: Advanced Quantitative Political Methodology

Course materials for POLS/CS&SS 503 -- Spring 2015 quarter at the University of Washington.

Course website is at https://jrnold.github.io/pols_503_sp15/

## Notes



## How to Create the Website

The files for the site are in the directory `web`.

This site is built using the static site generator [Nikola](http://getnikola.com/) with Python 3. 

[Install](http://getnikola.com/handbook.html#installing-nikola) the latest version of Nikola and then build the site

```console
> cd web
> nikola build
```
and serve it locally
```console
> nikola serve
```

Another way to install the dependencies to build the website is using the Python 3 [venv](https://docs.python.org/3/library/venv.html) module, which replaced the virtual environments in Python 2.
Install `venv`. In Ubuntu this can be installed with
```console
> apt-get install python3-venv
```
Then create and activate a local environment
```
> pyvenv-3.4 venv
> source venv/bin/activate
```
One the virtual environment is activated, install the dependencies with
```
pip install -r requirements.txt
```

Additionally this site requires the following (in addition to some libraries required by the python packages):

- [pandoc](http://johnmacfarlane.net/pandoc/)
- [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)

In Ubuntu, these can be installed with
```console
> apt-get install pandoc pandoc-citeproc
```


<!--  LocalWords:  nikola cd venv python3 pyvenv txt pandoc citeproc
 -->
