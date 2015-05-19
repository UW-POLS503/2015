# Labs

Lab document

- should be .Rmd, compile to
- Learning Objectives at the top
- Should it show solutions by default? If not, then it forces individuals to type in the solutions. Labs by Cetinkya-Rundel do not show results ([example](https://stat.duke.edu/courses/Spring15/sta101.001/post/labs/lab9.html)); Labs by Software carpentry do show results ([example](http://swcarpentry.github.io/r-novice-inflammation/01-starting-with-data.html)).
- Tips http://swcarpentry.github.io/training-course/tips/
- Follow advice from software carpentry templates

    - Software Carpentry Lesson Templates: http://software-carpentry.org/blog/2014/10/new-lesson-template-v2.html (the concepts, but not the details of implementation).

Conduct of the lab

- Follow the tips for teaching in Software Carpentry [here](http://swcarpentry.github.io/slideshows/teaching-tips/index.html) and [here](http://software-carpentry.org/blog/2015/03/teaching-tips.html)

Courses with open materials to build from:

- Software Carpentry http://software-carpentry.org/
- Data Carpentry https://github.com/datacarpentry/datacarpentry/tree/master/lessons/R
- Jenny Bryan, UBC Stats 545 https://stat545-ubc.github.io/, especially Stat 101 and the Coursera cours "Data Analysis and Statistical Inference", https://www.coursera.org/course/statistics
- Cetinkya-Rundel, Duke. https://stat.duke.edu/~mc301/teaching/
- Jeff Leek (John Hopkins) Coursera data science specialization and JHU Biostatistics 753 and 754: https://github.com/jtleek/jhsph753and4
- R for Cats: http://rforcats.net/

## Assessments

- Software carpentry in-lesson assessment http://software-carpentry.org/blog/2015/03/teaching-tips.html
    - Real time feedback using sticky notes. Learners post a red sticky when they need help. They take down
	  all notes at the start of exercises. They post a green sticky note when they have finished.
	- Students make little name tents out of red and green paper. Prop it up on red side or green side depending on whether the lesson is too fast or slow.
	- Minute notes. At lunch and at the end of the day learners write one good point (something they learned) and one bad point (something that didnt' work, that they didn't understand, or that they already knew).
    - Etherpad for notes and sharing
	
- Data Analysis and Statistics Data Camp Lab.
    - This lab covered material that is covered in the class (Strongly Agre, Agree, Neutral, Disagree, Strongly Disagree)
	- The lab improved my understanding of these topics.
    - The data were relevant and interesting to me.
    - The length of time took to complete lab. (Less than 30 min, 30 min to 1 hour, 1 hour and 2 hours, more than 2 hours)

## Pre- and Post-Survey

### Pre-Survey

- remove question on "linear algebra". Based on the responses I think some confused it with algebra.
- Add question about multiplying two matrices, transpose of a matrix, and matrix x vector.

# R Packages and functions

Focus on a set of specific functions. Generally focus on the Hadleyverse.

- Graphics:

  - **ggplot** and not base or lattice
  - specific plots okay

- Data Manipulation: dplyr, magrittr, tidyr, broom, lubridate, stringr, (plyr)
- coefficient plots: **arm**, **coefplot**, using **broom** to **ggplot2**
- tables: 
    * texreg: both html and latex. Issues getting the LaTeX to play nice with markdown
    * stargazer: both html and latex
	* comparison http://stackoverflow.com/questions/5465314/tools-for-making-latex-tables-in-r
    * http://conjugateprior.org/2013/10/call-them-what-you-will/, http://conjugateprior.org/2013/03/r-to-latex-packages-coverage/

# Example Datasets

- Regression

    - Duncan Occupational Prestige  (car)
        - Regression Example: http://faculty.washington.edu/cadolph/503/topic4.pw.pdf
    - SLID: Survey of Labor and Income Dynamics in Canada (car)
	- Tufte 1976 Congressional (King, Tomz, Wittenberg)
	- Ansolabehere, Stephen, and David M. Konisky. , "The introduction of voter registration and its effect on turnout." used in Using Graphs Instead of Tables in Political Science.
	- Weight as function of age, height. Gelman and Hill example.
	- Mortality rates and various environmental factors from 60 US cities. Gelman and Hill example.
	- Belgian phone calls (MASS, Adolph http://faculty.washington.edu/cadolph/503/topic6.pw.pdf). Used for Robust regression.

    - Challenger Explosion

        - http://faculty.washington.edu/cadolph/503/topic1.pw.pdf. Plotting data.
	- Annual US GDP growth under different parties
	
	    - http://faculty.washington.edu/cadolph/503/topic1.pw.pdf#page=56 Simple comparison of means.

    - Cross-national data on fertility (children born per adult female) and the percentage of women practicing contraception from Robey.
	
        - http://faculty.washington.edu/cadolph/503/topic1.pw.pdf#page=69 Simple linear regression.

	- Iverson and Sosice. Redistribution in Rich Economies. (Outliers/Roubst regression)
	    - http://faculty.washington.edu/cadolph/503/topic6.pw.pdf Outlier
		- http://faculty.washington.edu/cadolph/503/topic2.pw.pdf#page=8 Basic linear regression example. Redistribuion on log effective number of parties, majoritarian, and proportional. Only 14 points.
		
	- Life Expectancy Data in 1985 (Barro and Lee)
	
        - http://faculty.washington.edu/cadolph/503/topic5.pw.pdf. Specification.
	
    - Duncan Occupational Prestige  (car)
	
        - Regression Example: http://faculty.washington.edu/cadolph/503/topic4.pw.pdf

    - Ross 2001 Oil Data. Labs
	- NES. Labs for Logit

- Logit
    - Nyblade and Krauss (2006), "Logit analysis of electoral incentives and LDP post allocation" used in Using Graps Instead of Tables

- From Amelia / missing data

    -  Burgoon, Brian. 2006. “On Welfare and Terror.” Journal of Conflict Resolution 50(2): 176–203. Effect of national welfare and economic politices on the number of terrorism inicidents caused by citizens of that country. Panel data. Example in Honaker and King, "What to do about Missing Values in Time-Series Cross-Section Data"
    - Baum, Matthew A., and David A. Lake. 2003. "The Political Economy of Growth: Democracy and Human Capital." American Journal of Political Science 47(2): 333–47. Democracy on economic growth. Panel data. Example in Honaker and King, "What to do about Missing Values in Time-Series Cross-Section Data"


   - Examples of missing data in the lit. Honaker and King p. 562:

     This problem is recognized in the comparative politics literature
	 where scholars have begun to examine the effect of missing data
	 on their empirical results. For example, Ross (2006) finds that
	 the estimated relationship between democracy and infant mortality
	 depends on the sample that remains after listwise
	 deletion. Timmons (2005) shows that the relationship found
	 between taxation and redistribution depends on the choice of
	 taxation measure, but superior measures are subject to increased
	 missingness and so not used by researchers. And Spence (2007)
	 finds that Rodrik’s (1998) results are dependent on the treatment
	 of missing data.

   - Effects of voting in Russia. Colton, Timothy. 2000. Transitional Citizens: Voters and What Influences Them in the New Russia. Cambridge, MA: Harvard University Press. Example in from King et. al, "Aanalyzing Incomplete Political Science Data: An Alternative Algorithm for Multiple Imputation", APSR, 2001.
   - Public Opinion about racial policy preferences. Brehm, John. 1993. The Phantom Respondents: Opinion Surveys and Political Representation. Ann Arbor: University of Michigan Press. Example in from King et. al, "Aanalyzing Incomplete Political Science Data: An Alternative Algorithm for Multiple Imputation", APSR, 2001.
   - Unemployment and Presdiential Approval. A toy example used in Blackwell et. al. http://gking.harvard.edu/files/gking/files/measure.pdf
   - Abortion attitudes. Data from 17 neighborhoods in South Bend, IN. uckfeldt, Robert, Eric Plutzer and John Sprague. 1993. “Alternative Contexts of Political Behavior: Churches, Neighborhoods, and Individuals.” Journal of Politics 55(2, May):365–381. Example from Blackwell et. al. http://gking.harvard.edu/files/gking/files/measure.pdf
   - Effect of democracy on trade policy. From Milner, Helen and Keiko Kubota. 2005. “Why the move to free trade? Democracy and trade policy in the developing countries.” International Organization 59(1):107–143. Example in Amelia vignette http://r.iq.harvard.edu/docs/amelia/amelia.pdf

## LPM vs. Logit/Probit

A blog exchange between David Giles and Pischke

- http://davegiles.blogspot.co.uk/2012/06/yet-another-reason-for-avoiding-linear.html
- http://davegiles.blogspot.ca/2012/06/another-gripe-about-linear-probability.html
- http://www.mostlyharmlesseconometrics.com/2012/07/probit-better-than-lpm/
- http://blogs.worldbank.org/impactevaluations/whether-to-probit-or-to-probe-it-in-defense-of-the-linear-probability-model
- https://nonparibus.wordpress.com/2012/07/13/the-linear-education-model/
- https://nonparibus.wordpress.com/2014/03/31/bogus-complaints-about-the-use-of-discrete-variablesttwit

