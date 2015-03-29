# Notes on the POLS 503 Spring 2014 


Some notes on the labs from Spring 2014. http://faculty.washington.edu/cadolph/index.php

## Labs

### Lab 3: More Practice with regression and plotting

1. how to re-code varaibles in R
2. examples with loops
3. simulating regression results
4. simulating the monty hall problem
5. the birthday problem

Notes:

- replace recoding with `plyr::revalue`, or manually do it with a named vector
- replace loops and simulation with `dplyr::do`. Should probably do it with a for loop and then without it

### Lab 4: Useful things, largely loops and simulation

1. More useful tools

  - Draw from the normal and uniform distribution
  - Draw a simple random sample `sample`
  - `sort`
  - `which`
  - conditionals: `if`
  - for loop: `for`

2. Examples with loops

  - run simulations to summarize a regression model - calculate confidence intervals
  - run a regression on each year, or different groups

2. simulating the monty hall problem
3. the birthday problem

Notes

- always should have an application for each thing
- a lot of loops can be replaced by use of do for the applications here
- use bootstrap to introduce loops + functions

### Lab 5: More on models and interpretation, simulation in detail

1. prediction and interpretation with interaction terms

    - rossoil data
    - predict, interaction terms
    - plot output
    - interact two continuous values

2. Interpretaion with 1st difference

    - use simulation to calculate confidence intervals

3. Interaction terms with 1st difference plot

Notes

- don't use `wireframe`. 3d plots are bad

### Lab 6: Miscellaneous, tranformation and heteroskedasticity


### Lab 6+ LaTeX workshop

Do we need LaTex? Markdown + point to tutorials? 

### Lab 8: Intro to simcf / tile

Seems fine. Should maybe make optional

### Lab 9: Intro to apply() and plyr

Probably can get by without using plyr. Since most of them are working
with data frames, dplyr probably enough.


## Homeworks

### HW 1

1. Explore a data set
2. Solve some matrix algebra problems

I think the matrix algebra problems are grunt work.

### HW 2

1. Using the sprint data

   1. create X matrix. calculate linear reg form of regression
   2. lm to run a regression
   3. plot summarizing the regression
   4. predict

2. Project checkpoint

   - identify dv
   - distribution of the data
   - challenges for least squares regression

### HW 3

Simulations for

Moving beyond the Default simulation 

Uses a custom function `mcls.r`

1. heteroskedastic
2. AR(1)
3. create their own problem

### HW 4

1. Effect of measurement error on linear regression
2. Confidence intervals: Using sprint data

    - Confidence itnervals for regression
	- logit transformation

3. Model selection using the Ross oil data

    - linear regression. expected change in regime 1
	- studentized residuals
	- log or logit transformations of varaibles
	- M-estimator
	- robust and resistant estimator
	- how much substantive difference does the finding make

It includes a note on log bound and logit bound transformations.

### HW 5

*optional* It was a time series and panel example. Drop. Unless I use a TS example.

## Data sets

- rossoil data: http://staff.washington.edu/csjohns/503/rossoildata.csv Data from oss, Michael L. 2001. "Does oil hinder democracy?" World Politics. 53 (3): 325-361.  Used in labs and
- cross sectional data on industrial democracies: Torben Iversen and David Soskice, 2002, "Why do some democracies redistribute more than others?" Harvard University.
- sprinter data. Used in lab 4
- ANES data 2000: http://staff.washington.edu/csjohns/503/nes00a.csv Used in lab 7 and 8 for logit.
- Challenger space shuttle data
- US Economic growth. per cap GDP growth rate. party of the pesident. Topic 1 http://faculty.washington.edu/cadolph/503/gdpExample.r, http://faculty.washington.edu/cadolph/503/robeymore.csv
- Cross-national data on fertility and percentage of women practicing contraception. Topic 1 http://faculty.washington.edu/cadolph/503/fertilityExample.r, http://faculty.washington.edu/cadolph/503/robeymore.csv From the **car** package, dataset `car::Robey`. Robey, B., Shea, M. A., Rutstein, O. and Morris, L. (1992) The reproductive revolution: New survey findings. Population Reports. Technical Report M-11.
- Sprinters data: Used in homeworks. Tatem et al, "Momentous sprint at the 2156 Olympics?", *Nature*, 2004.


