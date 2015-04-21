<!--
.. title: R Packages Warnings and Messages when Loading
.. slug: package_loading_warnings_and_errors
.. tags: R, error messages
.. date: 2015-04-20 13:18
-->

## Warning: build under different R version

You may get a message like `Warning: package 'pkgname' was build under R version *.*.*`,
```r
library(dplyr)
```
```
## Warning: package 'dplyr' was built under R version 3.1.3
```

Usually this won't be an issue, but it could cause problems with some packages.

You can find your current version of R using
```r
sessionInfo()
```

If your current version of R is less than the one in the error message, update R.
If your current version of R is greater than the one in the error message, update the packages using,
```r
update.packages(ask = FALSE, checkBuilt = TRUE)
```
The argument `ask = FALSE` prevents R from asking you yes or no for each package. The argument `checkBuilt = TRUE` is to rebuild the package for the newest version of R even if it is the most up to date version of the package.

## Warning the following objects are masked

If you load the **plyr** and **dplyr** packages you will get several messages about objects being "masked".

```r
library("plyr")
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```
This means that the new package has object (usually functions) with names that are the same as those of earlier loaded packages.
In the above example, after loading **dplyr**, typing `filter` will use the function from the **dplyr** package and not the **base** (which is one of R's built-in packages) package. 
If you need to use the `filter` function in base R, you can refer to it explicitly with `::`. For example, `base::filter` will always use the function from the **base** package; and `dplyr::filter` will always use the function from the **dplyr** package. Note that you can refer to functions in packages using `::` without first loading the package using `library()`. This can sometimes be useful if you want to use a function from a package, but don't want to load the entire package.

## Package Startup Messages

Sometimes packages include messages that are printed on loading.
Although this is fine for interactive use in the console,
these messages are unsightly in documents and you should hide them from your knitr output either by setting `messages = FALSE` in the code chunk with the function `suppressPackageStartupMessages` (remember TAB completion is your friend).
E.g.

```r
suppressPackageStartupMessages({
library("ggplot2")
library("dplyr")
})
```





<!--  LocalWords:  'pkgname' dplyr 'dplyr' sessionInfo checkBuilt
 -->
<!--  LocalWords:  plyr knitr suppressPackageStartupMessages eval
 -->
<!--  LocalWords:  ggplot2
 -->
