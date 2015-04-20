<!--
.. title: R warning messages involving LC_TYPE
.. slug: r-warning-messages-involving-lc_type
.. date: 2015-04-18 13:50:40 UTC-07:00
.. tags: R errors
.. category: 
.. link: 
.. description: 
.. type: text
-->

If you are running R on a Mac and get the following warning message,
```r
During startup - Warning messages:
1: Setting LC_CTYPE failed, using "C"
2: Setting LC_COLLATE failed, using "C"
3: Setting LC_TIME failed, using "C"
4: Setting LC_MESSAGES failed, using "C"
5: Setting LC_PAPER failed, using "C"
```
run this command in R,
```r
system("defaults write org.R-project.R force.LANG en_US.UTF-8")
```

See this StackOverflow [question](http://stackoverflow.com/questions/9689104/installing-r-on-mac-warning-messages-setting-lc-ctype-failed-using-c) for more information.


