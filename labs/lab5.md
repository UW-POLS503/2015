# Lab 6 - More Regression Interpretation
Jeffrey Arnold  
Friday May 9, 2015  
This lab will use some libraries you've seen before, and one you may not have. We'll load them all now.




```r
library("MASS")
library("dplyr")
library("ggplot2")
library("broom")
```



```r
rossdata <- read.csv("http://pols503.github.io/pols_503_sp15/data/ross_2012.csv", 
  stringsAsFactors = FALSE)
```

## Regression adding coefficient

## Regression Post-estimation



## Writing Functions

This is an example of a really stupid R function that adds two to each variable.

```r
add2 <- function(x) {
  x + 2
}
```
Try it ...

This function creates a function that estimates 

Edit this function to create on that runs a regression on the rossoil dataset for a particular year. 

```r
function(yyyy) {
  filter()
}
```

```
## function(yyyy) {
##   filter()
## }
```

Something like this would work.
You *need* to have the argument have a different name than the variable in data. 

Try 


## Sources

- <http://staff.washington.edu/csjohns/503/lab5.r>
- <http://staff.washington.edu/csjohns/503/lab6.r>
