# POLS 503: Lab 3
Carolina Johnson  
April 17, 2015  


## Outline

1. Check in: Questions from Homework, other lingering confusion
2. Review: Reading in data and initial data exploration
3. Linear regression
    a. Model specification in R
    b. `lm()` object and model results
    c. (Pre)Review model interpretation
4. An aside on R fundamentals: object types
5. Returning to regression:
    d. `predict()`
    e. Plotting regression summary/expected values


```r
library("dplyr")
library("tidyr")
library("ggplot2")
library("readr")
```


## Reading in data review:

1. Download the data [iver.csv](http://pols503.github.io/pols_503_sp15/data/iver.csv)
2. Generate summary statistics for all variables in the dataset (number of observations, min, max, median, mean, standard deviation)
3. Plot the distributions of each numeric variable

This dataset is cross sectional data on industrial democracies. Containing:

--------- ----------------------------------------------------------------
`povred`  Percent of citizens lifted out of poverty by taxes and transfers
`enp`     Natural log of effective number of parties
`lnenp`   Natural log of effective number of parties
`maj`     Majoritarian election system dummy
`pr`      Proportional representation dummy
`unam`    Unanimity government dummy (Switzerland)
--------- ----------------------------------------------------------------

Source of data and model Torben Iversen and David Soskice, 2002, ``Why do some democracies redistribute more than others?'' Harvard University.



```r
iver <- read_csv("iver.csv")
```


```r
dim(iver)
```

```
## [1] 14  8
```

```r
iver
```

```
## Source: local data frame [14 x 8]
## 
##               cty elec_sys povred  enp    lnenp maj pr unam
## 1       Australia      maj  42.16 2.38 0.867100   1  0    0
## 2         Belgium       pr  78.79 7.01 1.947340   0  1    0
## 3          Canada      maj  29.90 1.69 0.524729   1  0    0
## 4         Denmark       pr  71.54 5.04 1.617410   0  1    0
## 5         Finland       pr  69.08 5.14 1.637050   0  1    0
## 6          France      maj  57.91 2.68 0.985817   1  0    0
## 7         Germany      maj  46.90 3.16 1.150570   1  0    0
## 8           Italy       pr  42.81 4.11 1.413420   0  1    0
## 9     Netherlands       pr  66.93 3.49 1.249900   0  1    0
## 10         Norway       pr  67.17 3.09 1.128170   0  1    0
## 11         Sweden       pr  64.48 3.39 1.220830   0  1    0
## 12    Switzerland     unam  13.02 5.26 1.660130   0  0    1
## 13 United Kingdom      maj  48.66 2.09 0.737164   1  0    0
## 14  United States      maj  12.10 1.95 0.667829   1  0    0
```

```r
head(iver)
```

```
## Source: local data frame [6 x 8]
## 
##         cty elec_sys povred  enp    lnenp maj pr unam
## 1 Australia      maj  42.16 2.38 0.867100   1  0    0
## 2   Belgium       pr  78.79 7.01 1.947340   0  1    0
## 3    Canada      maj  29.90 1.69 0.524729   1  0    0
## 4   Denmark       pr  71.54 5.04 1.617410   0  1    0
## 5   Finland       pr  69.08 5.14 1.637050   0  1    0
## 6    France      maj  57.91 2.68 0.985817   1  0    0
```

```r
# Summarise iver variables
iver %>%
  summarise_each(funs(mean, sd), - cty, - elec_sys)
```

```
## Source: local data frame [1 x 12]
## 
##   povred_mean enp_mean lnenp_mean  maj_mean pr_mean  unam_mean povred_sd
## 1    50.81786 3.605714   1.200533 0.4285714     0.5 0.07142857  21.18363
## Variables not shown: enp_sd (dbl), lnenp_sd (dbl), maj_sd (dbl), pr_sd
##   (dbl), unam_sd (dbl)
```

```r
mean <- summarise_each(iver, funs(mean), - cty, - elec_sys)
sd <- summarise_each(iver, funs(sd), - cty, - elec_sys)
min <- summarise_each(iver, funs(min), - cty, - elec_sys)
max <- summarise_each(iver, funs(max), - cty, - elec_sys)
median <- summarise_each(iver, funs(median), - cty, - elec_sys)
rbind(mean, sd, min, max, median) %>%
  mutate(statistic = c("mean", "sd","min", "max", "median"))
```

```
## Source: local data frame [5 x 7]
## 
##     povred      enp     lnenp       maj        pr       unam statistic
## 1 50.81786 3.605714 1.2005328 0.4285714 0.5000000 0.07142857      mean
## 2 21.18363 1.533822 0.4207742 0.5135526 0.5188745 0.26726124        sd
## 3 12.10000 1.690000 0.5247290 0.0000000 0.0000000 0.00000000       min
## 4 78.79000 7.010000 1.9473400 1.0000000 1.0000000 1.00000000       max
## 5 53.28500 3.275000 1.1857000 0.0000000 0.5000000 0.00000000    median
```

```r
# using tidyr
# Method 1: make long, then summarize over each variable
iver_long <- iver %>%
  gather(variable, value, - cty, - elec_sys)

iver_summary <- iver_long %>%
  group_by(variable) %>%
  summarise(mean = mean(value),
            median = median(value),
            min = min(value),
            max = max(value),
            sd = sd(value))

# Method 2
# See what each step is doing
iver_summary2 <- iver %>%
  summarise_each(funs(mean, sd, min, max, median), - cty, - elec_sys) %>%
  gather(variable_stat, value) %>%
  separate(variable_stat, c("variable", "stat"), sep = "_") %>%
  spread(stat, value)


povred.plot <- ggplot(iver, aes(povred)) + geom_histogram()
povred.plot
```

![](lab3_files/figure-html/unnamed-chunk-5-1.png) 

```r
enp.plot <- ggplot(iver, aes(enp)) + geom_histogram()
enp.plot
```

![](lab3_files/figure-html/unnamed-chunk-5-2.png) 

```r
lnenp.plot <- ggplot(iver, aes(lnenp)) + geom_histogram()
lnenp.plot
```

![](lab3_files/figure-html/unnamed-chunk-5-3.png) 

## Regression!

The basic command for linear regression in R is `lm()`. A call to this function takes the generic form illustrated below:

```r
res <- lm(y ~ x1 + x2 + x3, data = your.dataframe)
```

To see a summary of the regression results use `summary()`:

```r
summary(res)
```


Let's run a regression using the Iverson and Soskice data.  We save the regression as an object and then print the summary of the results:

**A simple bivariate model:**

```r
lm_bivar <- lm(povred ~ lnenp, data = iver)
summary(lm_bivar)
```

```
## 
## Call:
## lm(formula = povred ~ lnenp, data = iver)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -48.907  -4.115   8.377  11.873  18.101 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)    21.80      16.15   1.349   0.2021  
## lnenp          24.17      12.75   1.896   0.0823 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 19.34 on 12 degrees of freedom
## Multiple R-squared:  0.2305,	Adjusted R-squared:  0.1664 
## F-statistic: 3.595 on 1 and 12 DF,  p-value: 0.08229
```

*Challenge:*

* How do we interpret this output?
* What happens if you just type `lm.bivar`?

**A multivariate model:**

```r
lm_multi <- lm(povred ~ lnenp + maj + pr, data = iver)
summary(lm_multi)
```

```
## 
## Call:
## lm(formula = povred ~ lnenp + maj + pr, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -23.3843  -1.4903   0.6783   6.2687  13.9376 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)   
## (Intercept)   -31.29      26.55  -1.179  0.26588   
## lnenp          26.69      14.15   1.886  0.08867 . 
## maj            48.95      17.86   2.740  0.02082 * 
## pr             58.17      13.52   4.302  0.00156 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.37 on 10 degrees of freedom
## Multiple R-squared:  0.7378,	Adjusted R-squared:  0.6592 
## F-statistic: 9.381 on 3 and 10 DF,  p-value: 0.002964
```

You could also specify the same model using R's default treatment of categorical variables in the formula:

```r
lm_cat <- lm(povred ~ lnenp + elec_sys, data = iver)
summary(lm_cat)
```

```
## 
## Call:
## lm(formula = povred ~ lnenp + elec_sys, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -23.3843  -1.4903   0.6783   6.2687  13.9376 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)    17.658     12.686   1.392   0.1941  
## lnenp          26.693     14.154   1.886   0.0887 .
## elec_syspr      9.221     11.341   0.813   0.4351  
## elec_sysunam  -48.952     17.864  -2.740   0.0208 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.37 on 10 degrees of freedom
## Multiple R-squared:  0.7378,	Adjusted R-squared:  0.6592 
## F-statistic: 9.381 on 3 and 10 DF,  p-value: 0.002964
```


### Aside on the formula

Note: the first argument to the function is an R formula.  Formulas appear throughout many R functions, and have some special features of their syntax, some of which are illustrated below.

In `lm`, the formula is used to generate the exact $X$ matrix that will be used to estimate the model.  To see the matrix being generated internally by `lm`, add the argument `x = TRUE` to the `lm()` call:

```r
lm_cat <- lm(povred ~ lnenp + elec_sys, data = iver, x = TRUE)
lm_cat$x
```

```
##    (Intercept)    lnenp elec_syspr elec_sysunam
## 1            1 0.867100          0            0
## 2            1 1.947340          1            0
## 3            1 0.524729          0            0
## 4            1 1.617410          1            0
## 5            1 1.637050          1            0
## 6            1 0.985817          0            0
## 7            1 1.150570          0            0
## 8            1 1.413420          1            0
## 9            1 1.249900          1            0
## 10           1 1.128170          1            0
## 11           1 1.220830          1            0
## 12           1 1.660130          0            1
## 13           1 0.737164          0            0
## 14           1 0.667829          0            0
## attr(,"assign")
## [1] 0 1 2 2
## attr(,"contrasts")
## attr(,"contrasts")$elec_sys
## [1] "contr.treatment"
```

We'll look at this again in one of the more complicated model specifications below.

**A new model with multiple regressors and no constant:**

```r
lm_multi_noc <- lm(povred ~ -1 + lnenp + maj + pr + unam, data = iver)
summary(lm_multi_noc)
```

```
## 
## Call:
## lm(formula = povred ~ -1 + lnenp + maj + pr + unam, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -23.3843  -1.4903   0.6783   6.2687  13.9376 
## 
## Coefficients:
##       Estimate Std. Error t value Pr(>|t|)  
## lnenp    26.69      14.15   1.886   0.0887 .
## maj      17.66      12.69   1.392   0.1941  
## pr       26.88      21.18   1.269   0.2331  
## unam    -31.29      26.55  -1.179   0.2659  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.37 on 10 degrees of freedom
## Multiple R-squared:  0.9636,	Adjusted R-squared:  0.949 
## F-statistic: 66.13 on 4 and 10 DF,  p-value: 3.731e-07
```

**A new model with multiple regressors and an interaction:**

```r
lm_multi_interact <- lm(povred ~ lnenp * elec_sys, data = iver)
summary(lm_multi_interact)
```

```
## 
## Call:
## lm(formula = povred ~ lnenp * elec_sys, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -22.2512   0.0668   2.8531   4.7318  12.9948 
## 
## Coefficients: (1 not defined because of singularities)
##                    Estimate Std. Error t value Pr(>|t|)  
## (Intercept)           1.512     20.747   0.073   0.9435  
## lnenp                46.330     24.473   1.893   0.0909 .
## elec_syspr           39.837     33.111   1.203   0.2596  
## elec_sysunam        -65.406     24.485  -2.671   0.0256 *
## lnenp:elec_syspr    -29.554     30.023  -0.984   0.3506  
## lnenp:elec_sysunam       NA         NA      NA       NA  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.39 on 9 degrees of freedom
## Multiple R-squared:  0.7633,	Adjusted R-squared:  0.6581 
## F-statistic: 7.256 on 4 and 9 DF,  p-value: 0.006772
```

If you want to add an interaction separately from the individual variables being interacted:

```r
lm_multi_interact <- lm(povred ~ lnenp + elec_sys + lnenp:elec_sys, data = iver)
summary(lm_multi_interact)
```

```
## 
## Call:
## lm(formula = povred ~ lnenp + elec_sys + lnenp:elec_sys, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -22.2512   0.0668   2.8531   4.7318  12.9948 
## 
## Coefficients: (1 not defined because of singularities)
##                    Estimate Std. Error t value Pr(>|t|)  
## (Intercept)           1.512     20.747   0.073   0.9435  
## lnenp                46.330     24.473   1.893   0.0909 .
## elec_syspr           39.837     33.111   1.203   0.2596  
## elec_sysunam        -65.406     24.485  -2.671   0.0256 *
## lnenp:elec_syspr    -29.554     30.023  -0.984   0.3506  
## lnenp:elec_sysunam       NA         NA      NA       NA  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.39 on 9 degrees of freedom
## Multiple R-squared:  0.7633,	Adjusted R-squared:  0.6581 
## F-statistic: 7.256 on 4 and 9 DF,  p-value: 0.006772
```

Take a look at the help page for `formula`

```r
?formula
```

### Second aside on formulas

To better understand what the formula is doing, let's look at the model matrix one of the more complex formulas above generates:

```r
lm_multi_interact <- lm(povred ~ lnenp * elec_sys, data = iver, x = TRUE)
lm_multi_interact$x
```

```
##    (Intercept)    lnenp elec_syspr elec_sysunam lnenp:elec_syspr
## 1            1 0.867100          0            0          0.00000
## 2            1 1.947340          1            0          1.94734
## 3            1 0.524729          0            0          0.00000
## 4            1 1.617410          1            0          1.61741
## 5            1 1.637050          1            0          1.63705
## 6            1 0.985817          0            0          0.00000
## 7            1 1.150570          0            0          0.00000
## 8            1 1.413420          1            0          1.41342
## 9            1 1.249900          1            0          1.24990
## 10           1 1.128170          1            0          1.12817
## 11           1 1.220830          1            0          1.22083
## 12           1 1.660130          0            1          0.00000
## 13           1 0.737164          0            0          0.00000
## 14           1 0.667829          0            0          0.00000
##    lnenp:elec_sysunam
## 1             0.00000
## 2             0.00000
## 3             0.00000
## 4             0.00000
## 5             0.00000
## 6             0.00000
## 7             0.00000
## 8             0.00000
## 9             0.00000
## 10            0.00000
## 11            0.00000
## 12            1.66013
## 13            0.00000
## 14            0.00000
## attr(,"assign")
## [1] 0 1 2 2 3 3
## attr(,"contrasts")
## attr(,"contrasts")$elec_sys
## [1] "contr.treatment"
```

**A new model with multiple regressors and a transformation:**

(This transformation is just illustrating that you have the option of taking the log of a variable *inside* the formula, rather than creating a new variable prior to fitting).

```r
lm_multi_log <- lm(povred ~ log(enp) + elec_sys, data = iver)
summary(lm_multi_log)
```

```
## 
## Call:
## lm(formula = povred ~ log(enp) + elec_sys, data = iver)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -23.3843  -1.4903   0.6783   6.2687  13.9376 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)    17.658     12.686   1.392   0.1941  
## log(enp)       26.693     14.154   1.886   0.0887 .
## elec_syspr      9.221     11.341   0.813   0.4351  
## elec_sysunam  -48.952     17.864  -2.740   0.0208 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 12.37 on 10 degrees of freedom
## Multiple R-squared:  0.7378,	Adjusted R-squared:  0.6592 
## F-statistic: 9.381 on 3 and 10 DF,  p-value: 0.002964
```

You can also do other transformations such as taking the square of a variable (we'll talk more about this substantively later in the course):
To apply a mathematical function to a variable within the formula object, enclose it in `I()`.

```r
lm_multi_sq <- lm(povred ~ enp + I(enp ^ 2) + elec_sys, data = iver)
summary(lm_multi_sq)
```

```
## 
## Call:
## lm(formula = povred ~ enp + I(enp^2) + elec_sys, data = iver)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -23.196  -1.984   1.017   5.974  13.962 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)     5.414     32.075   0.169   0.8697  
## enp            17.851     18.007   0.991   0.3474  
## I(enp^2)       -1.296      1.870  -0.693   0.5058  
## elec_syspr      8.635     13.436   0.643   0.5365  
## elec_sysunam  -50.443     20.841  -2.420   0.0386 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 13.26 on 9 degrees of freedom
## Multiple R-squared:  0.7289,	Adjusted R-squared:  0.6084 
## F-statistic: 6.049 on 4 and 9 DF,  p-value: 0.01204
```

But what is this `lm()` object? Is it a data frame?

```r
is.data.frame(lm_multi)
```

```
## [1] FALSE
```
No!

## An aside on R fundamentals: Object types

R has many different types of objects, that store information in different ways and are treated differently by different functions.

Some of the most common types of objects are:

1. Vectors
2. Matrices
3. Data frames
4. Lists

(Much of this should be review if you completed the R Data Camp)

### Vectors

Vectors are collections of single values, with a length equal to the number of items in the set.

For example, here is a vector of names:

```r
persons <- c("Sarah", "Melina", "Jefferson", "Brad", "Ashley")
print(persons)
```

```
## [1] "Sarah"     "Melina"    "Jefferson" "Brad"      "Ashley"
```

And here is a vector of numbers:

```r
numbers <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
print(numbers)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```
Another way to create the same vector could have been:

```r
number_sequence <- seq(from = 1, to = 10, by = 1)
```

You can extract an item from a vector using square brackets:

```r
numbers[5]
```

```
## [1] 5
```

```r
persons[2:3]
```

```
## [1] "Melina"    "Jefferson"
```

Single variables in our data frame are *also* vectors. This is how we can do operations on them such as calculating the mean.


```r
countries <- iver$cty
countries
```

```
##  [1] "Australia"      "Belgium"        "Canada"         "Denmark"       
##  [5] "Finland"        "France"         "Germany"        "Italy"         
##  [9] "Netherlands"    "Norway"         "Sweden"         "Switzerland"   
## [13] "United Kingdom" "United States"
```

```r
countries[3:5]
```

```
## [1] "Canada"  "Denmark" "Finland"
```

```r
iver$cty[3:5]
```

```
## [1] "Canada"  "Denmark" "Finland"
```


### Matrices

Matrices are collections of equal-length vectors in row and column arrangement.  Matrices store information in a rectangular format, so look like data frames, but are less flexible as all data must be the same type (you can't mix character and numeric data, for example).  At first when you start working in R, matrices will be in use behind the scenes more than something you work with much.

As an example, see what happens when we convert our data frame into a matrix:

```r
iver_matrix <- as.matrix(iver)
iver_matrix
```

```
##       cty              elec_sys povred  enp    lnenp      maj pr  unam
##  [1,] "Australia"      "maj"    "42.16" "2.38" "0.867100" "1" "0" "0" 
##  [2,] "Belgium"        "pr"     "78.79" "7.01" "1.947340" "0" "1" "0" 
##  [3,] "Canada"         "maj"    "29.90" "1.69" "0.524729" "1" "0" "0" 
##  [4,] "Denmark"        "pr"     "71.54" "5.04" "1.617410" "0" "1" "0" 
##  [5,] "Finland"        "pr"     "69.08" "5.14" "1.637050" "0" "1" "0" 
##  [6,] "France"         "maj"    "57.91" "2.68" "0.985817" "1" "0" "0" 
##  [7,] "Germany"        "maj"    "46.90" "3.16" "1.150570" "1" "0" "0" 
##  [8,] "Italy"          "pr"     "42.81" "4.11" "1.413420" "0" "1" "0" 
##  [9,] "Netherlands"    "pr"     "66.93" "3.49" "1.249900" "0" "1" "0" 
## [10,] "Norway"         "pr"     "67.17" "3.09" "1.128170" "0" "1" "0" 
## [11,] "Sweden"         "pr"     "64.48" "3.39" "1.220830" "0" "1" "0" 
## [12,] "Switzerland"    "unam"   "13.02" "5.26" "1.660130" "0" "0" "1" 
## [13,] "United Kingdom" "maj"    "48.66" "2.09" "0.737164" "1" "0" "0" 
## [14,] "United States"  "maj"    "12.10" "1.95" "0.667829" "1" "0" "0"
```
Why is everything in quotation marks now?

You can index a matrix using square brackets, indicating first the row you want, then the column. This is the same way that you could directly extract specific values from a data frame


```r
iver_matrix[2:4, ]
```

```
##      cty       elec_sys povred  enp    lnenp      maj pr  unam
## [1,] "Belgium" "pr"     "78.79" "7.01" "1.947340" "0" "1" "0" 
## [2,] "Canada"  "maj"    "29.90" "1.69" "0.524729" "1" "0" "0" 
## [3,] "Denmark" "pr"     "71.54" "5.04" "1.617410" "0" "1" "0"
```
A blank before or after the comma indicates all rows or columns, respectively

```r
iver_matrix[8, 4]
```

```
##    enp 
## "4.11"
```

If we leave out the character vectors and convert the data frame to a matrix, then the
matrix will be numeric,

```r
as.matrix(select(iver, - cty, - elec_sys))
```

```
##       povred  enp    lnenp maj pr unam
##  [1,]  42.16 2.38 0.867100   1  0    0
##  [2,]  78.79 7.01 1.947340   0  1    0
##  [3,]  29.90 1.69 0.524729   1  0    0
##  [4,]  71.54 5.04 1.617410   0  1    0
##  [5,]  69.08 5.14 1.637050   0  1    0
##  [6,]  57.91 2.68 0.985817   1  0    0
##  [7,]  46.90 3.16 1.150570   1  0    0
##  [8,]  42.81 4.11 1.413420   0  1    0
##  [9,]  66.93 3.49 1.249900   0  1    0
## [10,]  67.17 3.09 1.128170   0  1    0
## [11,]  64.48 3.39 1.220830   0  1    0
## [12,]  13.02 5.26 1.660130   0  0    1
## [13,]  48.66 2.09 0.737164   1  0    0
## [14,]  12.10 1.95 0.667829   1  0    0
```


### Data frames

You've  seen these a lot! Now there are all kinds of tools to exploit the features of data frames, many of which you're familiar with.

For the sake of completeness, here's the equivalent "base R" way of pulling out (or indexing) a data frame to select rows or columns that meet certain criteria (you will likely see this in other code or in help files etc as you explore resources on your ow):

First, let's select all countries with a majoritarian system of government:

```r
iver[iver$maj == 1, ] # this selects all columns
```

```
## Source: local data frame [6 x 8]
## 
##              cty elec_sys povred  enp    lnenp maj pr unam
## 1      Australia      maj  42.16 2.38 0.867100   1  0    0
## 2         Canada      maj  29.90 1.69 0.524729   1  0    0
## 3         France      maj  57.91 2.68 0.985817   1  0    0
## 4        Germany      maj  46.90 3.16 1.150570   1  0    0
## 5 United Kingdom      maj  48.66 2.09 0.737164   1  0    0
## 6  United States      maj  12.10 1.95 0.667829   1  0    0
```

Next let's subset the data to all majoritarian countries but only keep the columns povred and lnenp (for example)

```r
iver[iver$maj == 1, c("povred", "lnenp")]
```

```
## Source: local data frame [6 x 2]
## 
##   povred    lnenp
## 1  42.16 0.867100
## 2  29.90 0.524729
## 3  57.91 0.985817
## 4  46.90 1.150570
## 5  48.66 0.737164
## 6  12.10 0.667829
```

```r
#let's keep the country names too!
iver[iver$maj == 1, c("cty", "povred", "lnenp")]
```

```
## Source: local data frame [6 x 3]
## 
##              cty povred    lnenp
## 1      Australia  42.16 0.867100
## 2         Canada  29.90 0.524729
## 3         France  57.91 0.985817
## 4        Germany  46.90 1.150570
## 5 United Kingdom  48.66 0.737164
## 6  United States  12.10 0.667829
```

Here's how you create a new data frame from scratch:

```r
mydata <- data.frame(variable1 = a.vector,
                     variable2 = another.vector,
                     variable3 = yet another vector)
```
An alternative function to create a data frame is `data_frame` from the **dplyr** package.
It differs from `data.frame` in a few of its defaults: by default it does not convert character vectors to factors, and it does not not rename columns.

```r
mydata <- data_frame(variable1 = a_vector,
                     variable2 = another_vector,
                     variable3 = yet_another_vector)
```

An example:

```r
mydata <- data_frame(somenumbers = seq(2, 16, by = 2),
                     somewords = rep(c("pounce", "bounce", "IPA", "crescent"),
                                     2),
                     a_number = 5,
                     is_silly = rep(c(TRUE, FALSE), each = 4))
mydata
```

```
## Source: local data frame [8 x 4]
## 
##   somenumbers somewords a_number is_silly
## 1           2    pounce        5     TRUE
## 2           4    bounce        5     TRUE
## 3           6       IPA        5     TRUE
## 4           8  crescent        5     TRUE
## 5          10    pounce        5    FALSE
## 6          12    bounce        5    FALSE
## 7          14       IPA        5    FALSE
## 8          16  crescent        5    FALSE
```

Note, vectors must be either the same length or multiples of each other's length (shorter vectors will be repeated)


```r
mydata <- data_frame(somenumber = seq(1, 50, by = 3),)
```


### Lists

Finally, another object type is the list, which can store different types of R objects (kind like a vector, but instead of values of a variable, they're objects we might want to save and come back to).  Lists are everywhere. Many of the functions we use (such as `lm()`) return lists.  data frames are even a special kind of list!

List elements have names. The easiest way to access an element of a list is to use the `$` and the name (just like looking at a variable in a data frame).

To find out what in a list us `str()` and/or `names()`

*Challenge:*

1. Use `names()` and `str()` to explore the contents of one of the lm objects you've created. (Look at the help file for `lm` for further details)
2. Extract and save as separate objects:
    a. The coefficients
    b. The residuals (what are the residuals?)
    c. The fitted values (what are the fitted values?)

To extract the coefficients,

```r
coefficients_multi <- lm_multi$coefficients
coefficients_multi
```

```
## (Intercept)       lnenp         maj          pr 
##   -31.29379    26.69296    48.95179    58.17306
```

```r
# or
coef(lm_multi)
```

```
## (Intercept)       lnenp         maj          pr 
##   -31.29379    26.69296    48.95179    58.17306
```
To extract the residuals,

```r
residuals_multi <- lm_multi$residuals
residuals_multi
```

```
##             1             2             3             4             5 
##  1.356526e+00 -6.954177e-02 -1.764578e+00  1.487267e+00 -1.496982e+00 
##             6             7             8             9            10 
##  1.393762e+01 -1.470128e+00 -2.179764e+01  6.687198e+00  1.017653e+01 
##            11            12            13            14 
##  5.013162e+00 -1.110223e-16  1.132490e+01 -2.338434e+01
```

```r
#or
resid(lm_multi)
```

```
##             1             2             3             4             5 
##  1.356526e+00 -6.954177e-02 -1.764578e+00  1.487267e+00 -1.496982e+00 
##             6             7             8             9            10 
##  1.393762e+01 -1.470128e+00 -2.179764e+01  6.687198e+00  1.017653e+01 
##            11            12            13            14 
##  5.013162e+00 -1.110223e-16  1.132490e+01 -2.338434e+01
```


```r
fitted_multi <- lm_multi$fitted.values
fitted_multi
```

```
##        1        2        3        4        5        6        7        8 
## 40.80347 78.85954 31.66458 70.05273 70.57698 43.97238 48.37013 64.60764 
##        9       10       11       12       13       14 
## 60.24280 56.99347 59.46684 13.02000 37.33510 35.48434
```

```r
#or
fitted(lm_multi)
```

```
##        1        2        3        4        5        6        7        8 
## 40.80347 78.85954 31.66458 70.05273 70.57698 43.97238 48.37013 64.60764 
##        9       10       11       12       13       14 
## 60.24280 56.99347 59.46684 13.02000 37.33510 35.48434
```

*Challenge:*

1. What important information is missing from the `lm()` list?

To extract standard errors of the estimates:

```r
se_multi <- lm_multi %>% vcov() %>% diag %>% sqrt
```
This calculates the standard errors by calculating the square root of the diagonal of the variance-covariance matrix of the parameters of the model object.  `vcov()` is an example of a function that has a specific "method" for different types of objects: it knows we have an  `lm` object and acts accordingly.

## Returning to regression

### Fitted values and predictions

hypothetical data
Another way to get the fitted values is with `predict()`:

```r
predict(lm_multi)
```

```
##        1        2        3        4        5        6        7        8 
## 40.80347 78.85954 31.66458 70.05273 70.57698 43.97238 48.37013 64.60764 
##        9       10       11       12       13       14 
## 60.24280 56.99347 59.46684 13.02000 37.33510 35.48434
```

The nice thing about predict is that it will actually let us calculate the expected values from our model for any set of real or hypothetical data with the same X variables:

Here's the general form of a call to predict, giving 95% confidence intervals:

```r
predict(object, #lm object
        newdata, # a data frame with same x vars as data, but new values
        interval = "confidence",
        level = 0.95 #the default
)
```

Let's try this with our model.

*Challenge:*

1. What would we expect the level of poverty reduction to be for a majoritarian country with 2 parties?
2. What would we expect the level of poverty reduction to be for a PR country as it goes from 1 to 5 parties?

*hint (refer to data frame info above for how to create a new dataframe for newdata argument)*

```r
predict(lm_cat, newdata = data_frame(lnenp = log(2), elec_sys = "maj"),
        interval = "confidence")
```

```
##        fit      lwr      upr
## 1 36.16016 24.19695 48.12337
```

```r
predict(lm_cat, newdata = data_frame(lnenp = log(seq(1:5)), elec_sys = "maj"),
        interval = "confidence")
```

```
##        fit       lwr      upr
## 1 17.65801 -10.60759 45.92360
## 2 36.16016  24.19695 48.12337
## 3 46.98322  32.75136 61.21509
## 4 54.66231  33.61362 75.71100
## 5 60.61867  33.36117 87.87617
```
or

```r
xnew <-  data_frame(lnenp = log(seq(1:5)), elec_sys = "maj")
predict(lm_cat, newdata = xnew, interval="confidence")
```

```
##        fit       lwr      upr
## 1 17.65801 -10.60759 45.92360
## 2 36.16016  24.19695 48.12337
## 3 46.98322  32.75136 61.21509
## 4 54.66231  33.61362 75.71100
## 5 60.61867  33.36117 87.87617
```
or

```r
data_frame(lnenp = log(seq(1:5)), elec_sys = "maj") %>%
  predict(lm_cat, newdata=., interval="confidence")
```

```
##        fit       lwr      upr
## 1 17.65801 -10.60759 45.92360
## 2 36.16016  24.19695 48.12337
## 3 46.98322  32.75136 61.21509
## 4 54.66231  33.61362 75.71100
## 5 60.61867  33.36117 87.87617
```

### Plotting regression results

Plotting regression results can be even more informative. Information dense, and more intuitive than regression tables!

To plot a regression line (not just using the `lm` smoother in ****ggplot2**2**), you can either fit a line to the observed values of X and the fitted values and CIs from `predict`, or fit a line to hypothetical data to illustrate the estimated relationship (the latter can help you to have smoother confidence intervals where you have fewer observations).

Generate a range of hypothetical values for a key variable of interest:

```r
lnenp_hyp <- seq(min(iver$lnenp), max(iver$lnenp), 0.1)
```

Calculate expected values of `povred` for each observed level of `lnenp`, setting the covariates to an fixed level, illustrating the effect of a change in `lnenp`, all else equal (for a "typical" respondent, use the mean of the covariates you are keeping fixed).  Remember to keep variable names identical to those in the model!

In order to set variable levels to their mean (to create a line that summarizes model for all countries, not just majoritarian or PR), I've gone back to using the original lm_multi model object, with the dummy variables.


```r
yhyp <- data.frame(lnenp = iver$lnenp, maj = mean(iver$maj),
                   pr = mean(iver$pr)) %>%
  predict(lm_multi, newdata = . , interval = "confidence")
```

We'll use these values of y and observed values of x to plot the regression line over a scatterplot of the observed data using **ggplot2**:

```r
plot <- ggplot(iver, aes(x = lnenp, y = povred)) +
  geom_line(aes(x = lnenp, y = yhyp[ , 1]))
plot
```

![](lab3_files/figure-html/unnamed-chunk-46-1.png) 
Now add confidence intervals,

```r
plot <- plot +
  geom_ribbon(aes(ymin = yhyp[ , 2], ymax = yhyp[ , 3]), alpha = (1 / 3))
plot
```

![](lab3_files/figure-html/unnamed-chunk-47-1.png) 
Finally, add the original data with text labels,

```r
plot + geom_text(mapping = aes(colour = elec_sys, label = cty), size = 3) +
  theme_minimal()
```

![](lab3_files/figure-html/unnamed-chunk-48-1.png) 


For interest, here's a comparison with the lines you would get if you did (as we did in lab) just set `elec_sys` to `"maj"` or `"pr"`:

```r
yhyp_maj <- data.frame(lnenp = iver$lnenp, elec_sys = "maj") %>%
  predict(lm_cat, newdata = . , interval = "confidence")
yhyp_pr <- data.frame(lnenp = iver$lnenp, elec_sys = "pr") %>%
  predict(lm_cat, newdata = . , interval = "confidence")

plot_line_compare <- plot +
  geom_line(aes(x = lnenp, y = yhyp_maj[ , 1]), colour = "red") +
  geom_line(aes(x = lnenp, y = yhyp_pr[ , 1]), colour = "green")
plot_line_compare
```

![](lab3_files/figure-html/unnamed-chunk-49-1.png) 

And compare how the different lines overlay the different countries:

```r
plot_line_compare +
  geom_text(mapping = aes(colour = elec_sys, label = cty), size = 3) +
  theme_minimal()
```

![](lab3_files/figure-html/unnamed-chunk-50-1.png) 

Another way of doing this is as follows,
Create a new data frame with different values of `lnenp` for each category of `elec_sys`.
This is easily done using the function `expand.grid`.

```r
xhyp_cat <- expand.grid(lnenp = iver$lnenp, elec_sys = unique(iver$elec_sys))
```
Then predict `y` values for each combination of `x` using the `predict` function,
and add those columns to the `x` values using `cbind`.

```r
yhyp_cat <- cbind(xhyp_cat,
									predict(lm_cat, newdata = xhyp_cat, interval = "confidence"))
```

In this format, the lines can be easily plotted in ggplot using the `elec_sys`
variable in `colour` and `fill` aesthetics to draw separate shapes for each "maj",
"pr", and "unem".

```r
ggplot() +
	geom_line(data = yhyp_cat,
						mapping = aes(x = lnenp, y = fit, ymin = lwr, ymax = upr,
													colour = elec_sys)) +
	geom_ribbon(data = yhyp_cat, 
							aes(x = lnenp, y = fit, ymin = lwr, ymax = upr,
								  fill = elec_sys),
							alpha = 0.2) +
	geom_text(data = iver, mapping = aes(x = lnenp, y = povred, label = cty,
                                       colour = elec_sys)) +
	scale_y_continuous("povred")
```

![](lab3_files/figure-html/unnamed-chunk-53-1.png) 
Because different datasets are used by different geoms,
each geom had to have a `data` and `mapping` (aesthetics) argument.


```r
cat(texreg::htmlreg(list(lm_cat),
                html.tag = FALSE,
                head.tag = FALSE,
                body.tag = FALSE,
                doctype = FALSE))
```


<table cellspacing="0" align="center" style="border: none;">
<caption align="bottom" style="margin-top:0.3em;">Statistical models</caption>
<tr>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 1</b></th>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">(Intercept)</td>
<td style="padding-right: 12px; border: none;">17.66</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(12.69)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">lnenp</td>
<td style="padding-right: 12px; border: none;">26.69</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(14.15)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">elec_syspr</td>
<td style="padding-right: 12px; border: none;">9.22</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(11.34)</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">elec_sysunam</td>
<td style="padding-right: 12px; border: none;">-48.95<sup style="vertical-align: 0px;">*</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">(17.86)</td>
</tr>
<tr>
<td style="border-top: 1px solid black;">R<sup style="vertical-align: 0px;">2</sup></td>
<td style="border-top: 1px solid black;">0.74</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Adj. R<sup style="vertical-align: 0px;">2</sup></td>
<td style="padding-right: 12px; border: none;">0.66</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Num. obs.</td>
<td style="padding-right: 12px; border: none;">14</td>
</tr>
<tr>
<td style="border-bottom: 2px solid black;">RMSE</td>
<td style="border-bottom: 2px solid black;">12.37</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;" colspan="2"><span style="font-size:0.8em"><sup style="vertical-align: 0px;">***</sup>p &lt; 0.001, <sup style="vertical-align: 0px;">**</sup>p &lt; 0.01, <sup style="vertical-align: 0px;">*</sup>p &lt; 0.05</span></td>
</tr>
</table>


```r
stargazer::stargazer(lm_cat, type = "html")
```


<table style="text-align:center"><tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="1" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>povred</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">lnenp</td><td>26.693<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(14.154)</td></tr>
<tr><td style="text-align:left"></td><td></td></tr>
<tr><td style="text-align:left">elec_syspr</td><td>9.221</td></tr>
<tr><td style="text-align:left"></td><td>(11.341)</td></tr>
<tr><td style="text-align:left"></td><td></td></tr>
<tr><td style="text-align:left">elec_sysunam</td><td>-48.952<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(17.864)</td></tr>
<tr><td style="text-align:left"></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>17.658</td></tr>
<tr><td style="text-align:left"></td><td>(12.686)</td></tr>
<tr><td style="text-align:left"></td><td></td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>14</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.738</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.659</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>12.367 (df = 10)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>9.381<sup>***</sup> (df = 3; 10)</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

