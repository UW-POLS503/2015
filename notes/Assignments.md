# Homework 3

The way in which the results were presented was confusing and did not allow student to effectively assess differences in parameters that would be bias.
This is because I only showed them how to calculate the point estimates without presenting the Monte Carlo standard error.
Students had (rightfully so) a hard time distinguishing "real" differences that would be indicatative of bias in the estimates from differences due to Monte Carlo error.
Christopher Adolph's version of the [assignment](http://faculty.washington.edu/cadolph/503/503hw3.pdf) did not ahve this issue since it had the students plot a density of the paramter estimates, which effectively hid the small monte carlo differences. 
I choose not to do that because I thought it hid how bias was actually computed.
Bias is a difference in the mean of the sampling distribution and the true parameter, and does not depend on the entire sampling distribution.
This seems to have been a mistake.
I should either go back to plotting the entire distribution, or include measure of the uncertainty due to Monte Carlo error.
In either case, I should have the results presented as plots and not in tables.

The p-value Type I and Type II error was particularly effective.

It is not clear that this is a good assignment as it is more of a guided tour.
Perhaps it is better served as an in class or lab assignemnt.

The simulations should be tied to the analytic results of the Gauss Markov Theorem. E.g. What is predicted. What do you get? Including cases where it says that standard errors are wrong, but doesn't say by how much, as in heteroskedasticity.

The heteroskedasticity example in homoskedasticty has bias that is undetectablebecause the default `hccm` mostly corrects for that.

In lecture I should emphasize the characteristic of p-values that if $H_0$ is true, then $p \sim U(0, 1)$.

Note: use of color vs. small multiples when a paper will be printed.

Thew endency in the p-value problem to plot everything on the same plot.

Emphasize that the write up is as important as getting the right answer.
It is not enough to get the "right" answer, you need to describe to the reader how and why you got that answer.

Many students didn't include the code itself for all the problems.
Consider how to allow the HW be reproducible without making it so long and verbose.
One idea is to show the students how to hide the output of code chunks, or only show the results.
The code will still be there in the Rmd, but the document will be easier to read.

