#' ---
#' Title: Multiple Regression Anatomy Example
#' Author: Jeffrey B. Arnold
#' ---

#' Load libraries
library("readr")
library("ggplot2")
library("dplyr")

#' 
#' Data from Torben Iversen and David Soskice, 2002, “Why do some democracies redistribute more than others?” Harvard University.
#' Example regression from Christopher Adolph <http://faculty.washington.edu/cadolph/503/topic2.pw.pdf>
#'
iver <- read_csv("../data/iver.csv")

mod_povred <- lm(povred ~ lnenp + maj + pr, data = iver)
print(summary(mod_povred))

#'
#' To calculate multiple regression coefficient of `lnemp`
#'
#' Regress `povred` on `maj` and `pr`
mod_povred_other <- lm(povred ~ maj + pr, data = iver)
y_tilde <- residuals(mod_povred_other)

#'
#' Regress `lnemp` on `maj` and `pr`
#' 
mod_lnemp <- lm(lnenp ~ maj + pr, data = iver)
x_tilde <- residuals(mod_lnemp)

#' Create a datasets with residuals from these regressions
resid_data <- data_frame(y = y_tilde, x = x_tilde)

#'
#' Regress residuals of y regression on x regression
#'
mod_resid <- lm(y ~ x, data = resid_data)
print(summary(mod_resid))

#' Could also calculate the slope using cov
cov(resid_data$y, resid_data$x) / var(resid_data$x)

#' Could also calculate the slope using cov
cov(iver$povred, resid_data$x) / var(resid_data$x)

#' Slope is the same. Standard errors are **not**!
#' This is for intuition only. DO not use this method for inference.

ggplot(resid_data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm",se = FALSE) + 
  scale_x_continuous(expression(tilde(x)["lnenp"])) +
  scale_y_continuous(expression(tilde(y)["lnemp"]))  



