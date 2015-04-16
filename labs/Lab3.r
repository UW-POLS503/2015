#Lab 3: 
#Reading In Data
#Types of objects

#Exploring





# Intro regression


### 4. REGRESSION BASICS

## Generic code -- *for reference* these objects are not yet in memory**
# To run a regression
res <- lm(y ~ x1 + x2 + x3)

# If you did not attach, need to specify dataset. Can also specify many other options.

res <- lm(y~x1+x2+x3, data=data) # A dataframe containing  y, x1, x2, etc.

# To print a summary
summary(res)

# To get the coefficients
res$coefficients
# or
coef(res)

#To get residuals
res$residuals
#or
resid(res)

# To get the variance-covariance matrix of the regressors
vcov(res)

# To get the standard errors
sqrt(diag(vcov(res)))

# To get the fitted values
predict(res)

# To get expected values for a new observation or dataset
predict(res,
        newdata, # a dataframe with same x vars
        # as data, but new values
        interval = "confidence", # alternative: "prediction"
        level = 0.95
)

## REGRESSION BASICS & PLOTTING: EXAMPLE 2

#Cross sectional data on industrial democracies:
# povred    Percent of citizens lifted out of poverty by taxes and transfers
# lnenp     Natural log of effective number of parties
# maj       Majoritarian election system dummy
# pr        Proportional representation dummy
# unam      Unanimity government dummy (Switzerland)

#Source of data & plot: 
#Torben Iversen and David Soskice, 2002, “Why do some democracies redistribute more than others?” Harvard University.


rm(list=ls())

file <- "iver.csv"
data <- read.csv(file,header=TRUE)
attach(data)

head(data)

# A bivariate model
lm.result <- lm(povred~lnenp)
print(summary(lm.result))

# A new model with multiple regressors
lm.result2 <- lm(povred~lnenp+maj+pr)
print(summary(lm.result2))

# A new model with multiple regressors and no constant
lm.result3 <- lm(povred~lnenp+maj+pr+unam-1)
lm.result3 <- lm(povred~-1+lnenp+maj+pr+unam) #can also put -1 at beginning (or anywhere)
print(summary(lm.result3))

# A new model with multiple regressors and an interaction
lm.result4 <- lm(povred~lnenp+maj+pr+lnenp:maj)
print(summary(lm.result4))

# A different way to specify an interaction
lm.result5 <- lm(povred~pr+lnenp*maj)
print(summary(lm.result5))


# Look at object structure
# Difference between printing and summarying
