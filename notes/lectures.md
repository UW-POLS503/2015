# HW3

- Need to introduce the programming in class or lab the week before

# May 12

Overview

- Went over HW3.
- Covered some more of http://faculty.washington.edu/cadolph/503/topic5.pw.pdf
- Covered all of http://pols503.github.io/pols_503_sp15/lectures/Lecture_Model_Specification_handout.pdf
- Went over the [Life Expectancy Example](http://pols503.github.io/pols_503_sp15/docs/docs/Life_Expectancy_Example.html)
- Went to 7:20. Did not cover bootstrap. 

Questions

- What to do about missing data? 
- What is likelihood? There was confusion between the standard error of the coefficients and the standard error of the regression.
- Is there any point of AIC/BIC anymore instead of using CV
- Why x-fold cross-validation? What percentage of observations should be held-out for cross-validation.
- Will reviewers understand cross-validation? If not, how to justify its use, even if better.
- Does CV assume that the test dataset is representative of the training? I discussed issue with spatial, temporal, and stratified data.

Comments

- I hadn't covered first differences yet, let alone simulation. There were no actual slides on
- I'm still concerned that interpreting in regression has been overlooked.
- The class needs more applied examples.
- The slides needed many revisions; not good transitions, many typos.
- The usage of Rmarkdown documents is still awkward.
- Need to streamline my advice of model fitting. It was rambling and not coherent, even in light of a lack of coherence in model choice.

# May 19

## Pre

Decided to consider issues with linear regression before turning to causal inference / 

- missing data
- outliers: covered in previous versions of the course; also somewhat important for considering weighting
- limited dependent variables, since several have it. Look at linear probability model.
- discuss general statistical approach and thoughts of statistical inference currently

## What I covered

- Review hw for 30 minutes

    - Q: what is the logit transformation?

- Outliers using Christopher Adolph's slides and my worked example. Covered until slide 32 of http://faculty.washington.edu/cadolph/503/topic6.pw.pdf.
  I switched between the slides and my worked example. I started with the slides, moved to the example of how to brute force answer the question,
  Went back to the slides for leverage and discrepancy, and then back to example for the application. Slides for the overview of what to do about it.

- Measurement / missingness: I mainly used the worked example; barely used the slides.

For the worked examples, I used the html document, but had Rstudio open to answer questions on the fly about what's in the data.

I did not cover limited dependent variables at all, and moved it to the next class.
I did not discuss the Schrodt and Achen articles and will not discuss them.

### Questions

- Can we compare hat values between regressions
- I could not think of the quote about outliers being the most interesting part of research
- Do people really use method X?
- How much detail is necessary to describe how you used multiple imputation
- Confusion about why is it okay to use dependent variables and other variables in the imputation stage.

## Post

- I liked starting with the brute force example of the influence of data points.
- The discussion of the distance metrics was rough, and needs to be improved.
- Working through the applied example of missing data was better than the theory, I think. Theory questions came up endogenously.

