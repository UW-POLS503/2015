# Software

Software workflow needs to handle

   - missing data
   - first differences and average predictive comparisons using simulation

- Automatic plots of AVP or 1st diff?
- Average Predictive Comparisons function. Like `predcomp` but slightly different.

# Changes

- Much more on interpretation.
  Need to cover analytical calculation of confidence intervals.
- Usability of simulation software needs to be improved.
  Either update simcf or move to Zelig.
- Need worked examples of data analysis from start to finish.
- Cover outliers before residual diagnostics.
  Not having covered the hat matrix comes up later in CV.
  Also, general purpose discussion of how regression weights observations.
- Did not discuss F-tests at all. Need to at least mention them even if not
  emphasizing statistical tests
- Consider not using the Fox textbook.
  Students do not like it.
- Reorder content

    - Even more emphasis on programming earlier
	- Require calculus prerequisite, cover matrix algebra on the 1st day
	- Do interpretation, substantive analysis right after introducing linear regression

- Reconsider live progamming. Discuss with sofwarecarpentry and others the best way to do lab.
- Ideas about final paper

    - Require students to have data after 2-3 weeks.
	- More checkups througout the course. Peer-review of progress?

- Ability to use cross-validation or bootstrapping is constrained by the ease of the workflow.
  Consider caret or mlr for cross validation. Write my own functions.
- Do not allow anyone to use limited dependent variables in final project. It distracts from the main purpose of the class. 
