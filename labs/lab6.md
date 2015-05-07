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
rossdata_raw <- read.csv("http://pols503.github.io/pols_503_sp15/data/ross_2012.csv", 
  stringsAsFactors = FALSE)
```

Clean up the code, as in [Lab 5](http://pols503.github.io/pols_503_sp15/labs/lab5.html).

<!-- Oil, minerals, income, islam, oecd, large_states, mideast, ssafrica, arabian peninsula, taxes, govt consumption, govt / gdp, military / GNP, military personnel, ethnic tensions men in industry, women in industry, men in services, women in services -->

```r
rossdata <- rossdata_raw %>% tbl_df() %>% select(cty, year, polity, 
  logoil_gdpcap2000_sup_Q_1, logGDPcap, oecd) %>% rename(oil = logoil_gdpcap2000_sup_Q_1, 
  log_gdp_cap = logGDPcap)
```


## Regression 

regime on GDP per cap, oil, oecd

## Logarithms with 0


```r
# illustrating the dangers of add a small amount
rossdata <- rossdata %>% mutate(oil_mod1 = rossdata$oil + 1e-04, 
  oil_mod2 = rossdata$oil + 0.001, oil_mod3 = rossdata$oil + 
    0.01)

model <- lm(polity ~ log_gdp_cap + log(oil_mod1) + oecd, data = rossdata)
model2 <- lm(polity ~ log_gdp_cap + log(oil_mod2) + oecd, data = rossdata)
model3 <- lm(polity ~ log_gdp_cap + log(oil_mod3) + oecd, data = rossdata)
```



## Regression Post-estimation

using `plot` after lmfit. The default R.

Look at what is in `augment`. 

- Plot residuals against y
- Plot residuals against each X

See also: **car** functions

- Added Variable Plot: `avPLot`
- Component Residual Plot: `crPlot`; CERES Plot for non-linearity

### Residual Analysis





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


## Sources

- Oil data from : 
- <http://staff.washington.edu/csjohns/503/lab5.r>
- <http://staff.washington.edu/csjohns/503/lab6.r>
