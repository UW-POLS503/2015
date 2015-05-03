---
title: "POLS/CSSS 503"
author: "Sergio Garcia-Rios - Jeff Arnold"
date: "Friday, April 24, 2015"


For this lab we will use the replication [data]( https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/17976) from [Michael Ross](http://www.sscnet.ucla.edu/polisci/faculty/ross/)'s _"The Oil Curse: How Petroleum Wealth Shapes the Development of Nations."_  

We will be exploring the relationship between oil dependency and democracy.

## Initial Setup


This lab will use some libraries you've seen before and we should load them now


```r
library(dplyr)
library(ggplot2)
library(broom)
```

## Reading in the Data

Read in the Ross data


```r
rossdata <- read.csv("http://pols503.github.io/pols_503_sp15/data/ross_2012.csv",
                     stringsAsFactors = FALSE)

head (rossdata)
glimpse(rossdata)
```

This is a pretty big data-set, we do not need all the variables let's subset our data to include only the variables we will use.

### Challenge

Create a new data-set containing only:

-  `cty`
-  `year`
-  `polity` 
-  `logoil_gdpcap2000_sup_Q_1`
-  `logGDPcap`
-  `oecd`

Call this new data-frame `data`


```r
data<-rossdata %>% 
  tbl_df() %>% 
  select(cty, year, polity, logoil_gdpcap2000_sup_Q_1, logGDPcap, oecd)
```

Note that I am putting this new data-frame in a `tbl_df`. You don't have to do it but let's try to use as much `dplyr` as possible.


## Data Management


Some of those names are too long, we should change it to something meaningful and short. This can be done easily using `dplyr` and `rename`.


```r
data<-data %>%
  rename(oil=logoil_gdpcap2000_sup_Q_1, gdp=logGDPcap)
```

This data-frame is way easier to glimpse at:

```r
glimpse(data)
```

```
## Observations: 8523
## Variables:
## $ cty    (chr) "Afghanistan", "Afghanistan", "Afghanistan", "Afghanist...
## $ year   (int) 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1...
## $ polity (dbl) 1.00, 1.00, 1.00, 1.00, 2.35, 2.35, 2.35, 2.35, 2.35, 2...
## $ oil    (dbl) NA, NA, NA, NA, NA, NA, 0.000000, 0.000000, 3.171584, 4...
## $ gdp    (dbl) NA, NA, NA, NA, NA, 4.860139, 4.848679, 4.854403, 4.865...
## $ oecd   (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
```

```r
data
```

```
## Source: local data frame [8,523 x 6]
## 
##            cty year polity      oil      gdp oecd
## 1  Afghanistan 1960   1.00       NA       NA    0
## 2  Afghanistan 1961   1.00       NA       NA    0
## 3  Afghanistan 1962   1.00       NA       NA    0
## 4  Afghanistan 1963   1.00       NA       NA    0
## 5  Afghanistan 1964   2.35       NA       NA    0
## 6  Afghanistan 1965   2.35       NA 4.860139    0
## 7  Afghanistan 1966   2.35 0.000000 4.848679    0
## 8  Afghanistan 1967   2.35 0.000000 4.854403    0
## 9  Afghanistan 1968   2.35 3.171584 4.865864    0
## 10 Afghanistan 1969   2.35 4.154883 4.858425    0
## ..         ...  ...    ...      ...      ...  ...
```

A lot of missing values here. Let's omit them and then look at a summary of the data set

```r
data<-na.omit(data)
data %>%
  summary()
```

```
##      cty                 year          polity            oil          
##  Length:5609        Min.   :1961   Min.   : 1.000   Min.   : 0.00000  
##  Class :character   1st Qu.:1975   1st Qu.: 2.350   1st Qu.: 0.00000  
##  Mode  :character   Median :1987   Median : 5.950   Median : 0.06179  
##                     Mean   :1985   Mean   : 5.953   Mean   : 2.51778  
##                     3rd Qu.:1996   3rd Qu.: 9.550   3rd Qu.: 5.06456  
##                     Max.   :2005   Max.   :10.000   Max.   :11.00076  
##       gdp              oecd       
##  Min.   : 4.035   Min.   :0.0000  
##  1st Qu.: 6.059   1st Qu.:0.0000  
##  Median : 7.283   Median :0.0000  
##  Mean   : 7.424   Mean   :0.1756  
##  3rd Qu.: 8.712   3rd Qu.:0.0000  
##  Max.   :10.908   Max.   :1.0000
```

Finally! we are ready to start data-analyzing..

## Sacatterplots


We are going to be exploring the relationship between Democracy level (polity) and other covariates.

Let's explore these relationships with plots.

### Challenge

Create a plot that explores the relationship between democracy level and at least another variable but try to include more than two covariates using different colors and shapes.

We begin simple... 

```r
ggplot(data, aes(x = gdp, y = polity)) +
  geom_point(position = position_jitter(height = .5),  size = 3) + 
  theme_bw() 
```

![](lab4_files/figure-html/unnamed-chunk-7-1.png) 

Unfortunately, a simple scatter plot makes it hard to detect any relationship. However, `ggplot2` makes it easy to add different colors and shapes which might help identify trends.


```r
ggplot(data, aes(x = gdp, y = polity, colour = oil, shape=factor(oecd))) +
  geom_point(position = position_jitter(height = .5),  size = 3) + 
  theme_bw() 
```

![](lab4_files/figure-html/unnamed-chunk-8-1.png) 


```r
ggplot(data, aes(x = gdp, y = polity, colour = factor(oecd))) +
  geom_point(aes(size=(oil)), position = position_jitter(height = .5)) + 
  theme_bw() 
```

![](lab4_files/figure-html/unnamed-chunk-9-1.png) 

It seems like the higher the GDP the more democratic countries are, except if you are a high oil producer or a non-OECD. Let's explore these relationships using a regression.


```r
model1<-lm(polity ~ oil, data=data)
summary(model1)
```

```
## 
## Call:
## lm(formula = polity ~ oil, data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -5.1436 -3.4863  0.1319  3.5112  4.5537 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  6.14361    0.05826 105.451  < 2e-16 ***
## oil         -0.07556    0.01468  -5.149 2.71e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.373 on 5607 degrees of freedom
## Multiple R-squared:  0.004706,	Adjusted R-squared:  0.004528 
## F-statistic: 26.51 on 1 and 5607 DF,  p-value: 2.711e-07
```
Let's now include controls for GDP per capita and OECD membership

```r
model2<-lm(polity ~ gdp + oil + oecd, data=data)
summary(model2)
```

```
## 
## Call:
## lm(formula = polity ~ gdp + oil + oecd, data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -7.9354 -2.2510 -0.1076  2.4055  6.1209 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -0.26692    0.22778  -1.172    0.241    
## gdp          0.86570    0.03386  25.564   <2e-16 ***
## oil         -0.23266    0.01313 -17.724   <2e-16 ***
## oecd         2.15876    0.13248  16.294   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.758 on 5605 degrees of freedom
## Multiple R-squared:  0.3349,	Adjusted R-squared:  0.3345 
## F-statistic: 940.7 on 3 and 5605 DF,  p-value: < 2.2e-16
```


-  Which has a larger impact on the level of democracy: oil dependence or OECD membership?
-  Which has a larger impact on the level of democracy: oil dependence or GDP per capital?

Recall the OECD membership clustering? Let's try an interaction


```r
model3<-lm(polity ~ gdp + oil*oecd, data=data)
summary(model3)
```

```
## 
## Call:
## lm(formula = polity ~ gdp + oil * oecd, data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -7.0258 -2.2644 -0.0124  2.2895  6.3659 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -0.43621    0.22621  -1.928   0.0539 .  
## gdp          0.90989    0.03381  26.912  < 2e-16 ***
## oil         -0.28858    0.01407 -20.515  < 2e-16 ***
## oecd         1.03588    0.16981   6.100 1.13e-09 ***
## oil:oecd     0.36751    0.03527  10.420  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.732 on 5604 degrees of freedom
## Multiple R-squared:  0.3475,	Adjusted R-squared:  0.347 
## F-statistic: 746.2 on 4 and 5604 DF,  p-value: < 2.2e-16
```

How would you interpret these results?



## Visualiazing Regression Results

`broom` has three main functions, all of which return data frames (not lists, numeric vectors, or other types of object). `glance` returns a data frame with a single row summary of the model:


```r
glance(model2)
```

```
##   r.squared adj.r.squared    sigma statistic p.value df    logLik      AIC
## 1 0.3348738     0.3345178 2.758247  940.6576       0  4 -13647.69 27305.38
##        BIC deviance df.residual
## 1 27338.54 42642.44        5605
```
`tidy` returns a data frame with a row for each coefficient estimate:

```r
tidy(model2)
```

```
##          term   estimate  std.error  statistic       p.value
## 1 (Intercept) -0.2669218 0.22777880  -1.171847  2.413085e-01
## 2         gdp  0.8656966 0.03386326  25.564478 1.925632e-136
## 3         oil -0.2326598 0.01312701 -17.723744  1.968195e-68
## 4        oecd  2.1587643 0.13248438  16.294482  2.330375e-58
```
`augment` returns the original data frame used in the model with additional columns for fitted values, the standard errors of those fitted values, residuals, etc.

```r
head(augment(model2))
```

```
##   polity      gdp      oil oecd  .fitted    .se.fit     .resid
## 1   2.35 4.848679 0.000000    0 3.930563 0.07669619 -1.5805627
## 2   2.35 4.854403 0.000000    0 3.935518 0.07654974 -1.5855183
## 3   2.35 4.865864 3.171584    0 3.207540 0.08501127 -0.8575396
## 4   2.35 4.858425 4.154883    0 2.972326 0.09169896 -0.6223259
## 5   2.35 4.854891 4.447948    0 2.901082 0.09398764 -0.5510817
## 6   2.35 4.785476 4.600730    0 2.805443 0.09720522 -0.4554436
##           .hat   .sigma      .cooksd .std.resid
## 1 0.0007731810 2.758413 6.356969e-05 -0.5732532
## 2 0.0007702310 2.758412 6.372449e-05 -0.5750497
## 3 0.0009499189 2.758470 2.299821e-05 -0.3110480
## 4 0.0011052547 2.758481 1.409718e-05 -0.2257485
## 5 0.0011611145 2.758484 1.161421e-05 -0.1999102
## 6 0.0012419747 2.758487 8.486624e-06 -0.1652233
```

How about a coefficient plot, roppeladder... etc.


```r
ggplot(tidy(model2) %>% filter(term != "(Intercept)"), 
       aes(x = term, y = estimate, 
           ymin = estimate - 2 * std.error, 
           ymax = estimate + 2 * std.error)) + 
  geom_pointrange() + 
  coord_flip()
```

![](lab4_files/figure-html/unnamed-chunk-16-1.png) 

We can also use `coefplot` 

```r
library("coefplot")
coefplot(model2, coefficients = c("oecd", "oil", "gdp"))
```

![](lab4_files/figure-html/unnamed-chunk-17-1.png) 


### Challenge
-  What is wrong with this plot?
-  Is it useful?
-  Why? Why not?

## Regression tables

Several packages (`stargazer`, `texreg`, `apsrtable`) are useful for creating publication type regression tables. `stargazer` and `texreg` are the most complete package. Both allow output to either LaTeX or HTML tables for many types of statistical models. We'll use *stargazer* here:


```r
library(stargazer)
stargazer(model1, model2, model3, type = "html")
```


<table style="text-align:center"><tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="3"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="3" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="3">polity</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">gdp</td><td></td><td>0.866<sup>***</sup></td><td>0.910<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.034)</td><td>(0.034)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">oil</td><td>-0.076<sup>***</sup></td><td>-0.233<sup>***</sup></td><td>-0.289<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.015)</td><td>(0.013)</td><td>(0.014)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">oecd</td><td></td><td>2.159<sup>***</sup></td><td>1.036<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.132)</td><td>(0.170)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">oil:oecd</td><td></td><td></td><td>0.368<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.035)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>6.144<sup>***</sup></td><td>-0.267</td><td>-0.436<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td><td>(0.228)</td><td>(0.226)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>5,609</td><td>5,609</td><td>5,609</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.005</td><td>0.335</td><td>0.348</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.005</td><td>0.335</td><td>0.347</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>3.373 (df = 5607)</td><td>2.758 (df = 5605)</td><td>2.732 (df = 5604)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>26.510<sup>***</sup> (df = 1; 5607)</td><td>940.658<sup>***</sup> (df = 3; 5605)</td><td>746.175<sup>***</sup> (df = 4; 5604)</td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="3" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>



## Predicted Values


We are going to use `predict` to get predicted values. We first have to set up a `newdata` 

```r
xnew <- list(gdp=5.9, oil=0, oecd=1)

predict(model2, newdata=xnew, interval="confidence")
```

```
##        fit      lwr      upr
## 1 6.999452 6.711659 7.287246
```

```r
xnew2 <- list(gdp=5.9, oil=0, oecd=0)

predict(model2, newdata=xnew2, interval="confidence")
```

```
##        fit      lwr      upr
## 1 4.840688 4.732938 4.948437
```

What is  this really doing?

```r
model2
```

```
## 
## Call:
## lm(formula = polity ~ gdp + oil + oecd, data = data)
## 
## Coefficients:
## (Intercept)          gdp          oil         oecd  
##     -0.2669       0.8657      -0.2327       2.1588
```

```r
names(model2)
```

```
##  [1] "coefficients"  "residuals"     "effects"       "rank"         
##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
##  [9] "xlevels"       "call"          "terms"         "model"
```

```r
pe2<-model2$coefficients
pe2
```

```
## (Intercept)         gdp         oil        oecd 
##  -0.2669218   0.8656966  -0.2326598   2.1587643
```

```r
1*pe2[1] + 5.9*pe2[2] + 0*pe2[3] + 1*pe2[4]
```

```
## (Intercept) 
##    6.999452
```

```r
1*pe2[1] + 5.9*pe2[2] + 0*pe2[3] + 0*pe2[4]
```

```
## (Intercept) 
##    4.840688
```

We can create a matrix of hypothetical data to obtain predictions for a range of values:


```r
# create a vector of hypothetical values of GDP per capita

gdp.hyp <-seq(4,11,by=1)

#create a matrix containing all hypothetical values, which are constant for the other covariates:


xnew <- list(gdp=gdp.hyp, oil=rep(0, length(gdp.hyp)), oecd=rep(1, length(gdp.hyp)))

xnew
```

```
## $gdp
## [1]  4  5  6  7  8  9 10 11
## 
## $oil
## [1] 0 0 0 0 0 0 0 0
## 
## $oecd
## [1] 1 1 1 1 1 1 1 1
```

Now we feed this new data into `predict`

```r
pred.res <- predict(model2, newdata=xnew, interval="confidence")

pred.res
```

```
##         fit       lwr       upr
## 1  5.354629  4.961562  5.747695
## 2  6.220325  5.884452  6.556198
## 3  7.086022  6.803296  7.368748
## 4  7.951718  7.715347  8.188090
## 5  8.817415  8.615865  9.018965
## 6  9.683112  9.498212  9.868011
## 7 10.548808 10.357583 10.740033
## 8 11.414505 11.195964 11.633045
```

### Ploting Predicted Values

To plot these predicted values we have to create a data frame containing both the predicted values generated by predict and the data used to generate those values 

```r
mod2_predicted <-as.data.frame(pred.res)
mod2_pred_df <- cbind(xnew, mod2_predicted)

mod2_pred_df
```

```
##   gdp oil oecd       fit       lwr       upr
## 1   4   0    1  5.354629  4.961562  5.747695
## 2   5   0    1  6.220325  5.884452  6.556198
## 3   6   0    1  7.086022  6.803296  7.368748
## 4   7   0    1  7.951718  7.715347  8.188090
## 5   8   0    1  8.817415  8.615865  9.018965
## 6   9   0    1  9.683112  9.498212  9.868011
## 7  10   0    1 10.548808 10.357583 10.740033
## 8  11   0    1 11.414505 11.195964 11.633045
```

We have now have a data-frame that can easily be taken by `ggplot`

```r
ggplot() +
  geom_line(data = mod2_pred_df, mapping = aes(x = gdp, y = fit)) +
  geom_ribbon(data = mod2_pred_df, mapping = aes(x = gdp, ymin = lwr, ymax = upr),
              alpha = 0.2)+
  ylab("Democracy")+
  theme_bw()
```

![](lab4_files/figure-html/unnamed-chunk-24-1.png) 

Now the model with the interaction.


```r
summary(model3)
```

```
## 
## Call:
## lm(formula = polity ~ gdp + oil * oecd, data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -7.0258 -2.2644 -0.0124  2.2895  6.3659 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -0.43621    0.22621  -1.928   0.0539 .  
## gdp          0.90989    0.03381  26.912  < 2e-16 ***
## oil         -0.28858    0.01407 -20.515  < 2e-16 ***
## oecd         1.03588    0.16981   6.100 1.13e-09 ***
## oil:oecd     0.36751    0.03527  10.420  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.732 on 5604 degrees of freedom
## Multiple R-squared:  0.3475,	Adjusted R-squared:  0.347 
## F-statistic: 746.2 on 4 and 5604 DF,  p-value: < 2.2e-16
```

```r
oil.hyp <- seq(0,11,by=1)

xnew1 <- list(oil=oil.hyp, gdp=rep(mean(data$gdp), length(oil.hyp)), oecd=rep(0, length(oil.hyp)))

xnew1
```

```
## $oil
##  [1]  0  1  2  3  4  5  6  7  8  9 10 11
## 
## $gdp
##  [1] 7.424049 7.424049 7.424049 7.424049 7.424049 7.424049 7.424049
##  [8] 7.424049 7.424049 7.424049 7.424049 7.424049
## 
## $oecd
##  [1] 0 0 0 0 0 0 0 0 0 0 0 0
```

```r
pred.res1 <- predict(model3, newdata=xnew1, interval="confidence")
pred.res1
```

```
##         fit      lwr      upr
## 1  6.318855 6.202172 6.435538
## 2  6.030278 5.930781 6.129776
## 3  5.741702 5.653920 5.829483
## 4  5.453125 5.369266 5.536984
## 5  5.164548 5.075779 5.253317
## 6  4.875971 4.774737 4.977206
## 7  4.587395 4.468492 4.706298
## 8  4.298818 4.159003 4.438633
## 9  4.010241 3.847516 4.172966
## 10 3.721665 3.534765 3.908564
## 11 3.433088 3.221181 3.644995
## 12 3.144511 2.907028 3.381995
```

```r
xnew2 <- list(oil=oil.hyp, gdp=rep(mean(data$gdp), length(oil.hyp)), oecd=rep(1, length(oil.hyp)))

xnew2
```

```
## $oil
##  [1]  0  1  2  3  4  5  6  7  8  9 10 11
## 
## $gdp
##  [1] 7.424049 7.424049 7.424049 7.424049 7.424049 7.424049 7.424049
##  [8] 7.424049 7.424049 7.424049 7.424049 7.424049
## 
## $oecd
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1
```

```r
pred.res2 <- predict(model3, newdata=xnew2, interval="confidence")
```

### Challenge

How would you construct this data-frame to be used with `ggplot`?


```r
mod3_predicted_1 <- as.data.frame(pred.res1)
mod3_pred_df_1  <- cbind(xnew1, mod3_predicted_1)

mod3_predicted_2 <- as.data.frame(pred.res2)
mod3_pred_df_2 <- cbind(xnew2, mod3_predicted_2)

mod3_pred_df <- bind_rows(mod3_pred_df_1,mod3_pred_df_2)

mod3_pred_df
```

```
## Source: local data frame [24 x 6]
## 
##    oil      gdp oecd      fit      lwr      upr
## 1    0 7.424049    0 6.318855 6.202172 6.435538
## 2    1 7.424049    0 6.030278 5.930781 6.129776
## 3    2 7.424049    0 5.741702 5.653920 5.829483
## 4    3 7.424049    0 5.453125 5.369266 5.536984
## 5    4 7.424049    0 5.164548 5.075779 5.253317
## 6    5 7.424049    0 4.875971 4.774737 4.977206
## 7    6 7.424049    0 4.587395 4.468492 4.706298
## 8    7 7.424049    0 4.298818 4.159003 4.438633
## 9    8 7.424049    0 4.010241 3.847516 4.172966
## 10   9 7.424049    0 3.721665 3.534765 3.908564
## .. ...      ...  ...      ...      ...      ...
```

Now we can ggplot it

```r
ggplot(mod3_pred_df, aes(x =oil , y = fit, 
                         ymin = lwr, ymax = upr)) +
  geom_line(mapping = aes(colour = factor(oecd))) +
  geom_ribbon(mapping = aes(fill = factor(oecd)), alpha = 0.7) +
  ylab("Democracy") + 
  ggtitle("Predicted values of Democracy by GDP and OECD membership")+
  scale_fill_discrete("OECD")+
  scale_colour_discrete("OECD")+
  theme_bw()
```

![](lab4_files/figure-html/unnamed-chunk-27-1.png) 

* * *

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
R code is licensed under a [BSD 2-clause](http://www.r-project.org/Licenses/BSD_2_clause) license.
