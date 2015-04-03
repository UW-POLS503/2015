<!--
.. title: Frequently Asked Questions
.. slug: faq
.. date: 2015-03-26 10:30:00 UTC-07:00
-->

No questions are frequent as of yet.

## How to write a paper for this course?  {#paper}

For some advice see

- "Writing Empirical Papers: 6 Rules & 12 Recommendations", Christopher Adolph, http://faculty.washington.edu/cadolph/503/papers.pdf. Written for previous versions of this course and still applicable.
- Gary King, "Publication, Publication", http://gking.harvard.edu/files/paperspub.pdf. Advice on how to turn a class project into a publication.

## R Errors

### Warning messages with LC_CTYPE

If you are running Mac on OSX and get the warning:

```r
During startup - Warning messages:
1: Setting LC_CTYPE failed, using "C"
2: Setting LC_COLLATE failed, using "C"
3: Setting LC_TIME failed, using "C"
4: Setting LC_MESSAGES failed, using "C"
5: Setting LC_PAPER failed, using "C"
```

Run the following in R:
```r
system("defaults write org.R-project.R force.LANG en_US.UTF-8")
```

See this StackOverflow [question](http://stackoverflow.com/questions/9689104/installing-r-on-mac-warning-messages-setting-lc-ctype-failed-using-c).

