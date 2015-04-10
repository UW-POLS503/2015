<!--
.. title: POLS/CS&SS 503: Advanced Quantitative Political Methodology
.. slug: index
.. date: 2015-03-25 21:36:15 UTC-07:00
.. description: Syllabus for Jeffrey Arnold, POLS/CS&SS 503: Advanced Quantitative Political Methodology, Spring 2015, University of Washington.
-->

<p class="lead">
University of Washington, Spring 2015
</p>

<table>
<tr>
<td><a href="http://www.polisci.washington.edu/"><img src="uw-deptPoliSci_273@2x.png" height="74px"></a></td>
<td><a href="https://www.csss.washington.edu/"><img src="CSSStranMD@2x.png" height="95opx"></a></td>
</tr>
</table>

# Teaching Team

<table class = "table table-striped table-hover">
<tr>
<td>Professor </td>
<td> <a href="http://jrnold.me">Jeffrey Arnold</a> </td>
<td> <a href="mailto:jrnold@uw.ed">jrnold@uw.edu</a> </td>
</tr>
<tr>
<td>TAs</td>
<td><a href="http://www.sergiogarciarios.com/">Sergio García-Rios</a> </td>
<td><a href="mailto:sigarcia@uw.edu">sigarcia@uw.edu</a> </td>
</tr>
<tr>
<td></td>
<td><a href="http://staff.washington.edu/csjohns/">Carolina Johnson</a> </td>
<td><a href="mailto:csjohns@uw.edu">csjohns@uw.edu</a> </td>
</tr>
</table>

# Class Meetings

<table class = "table table-striped table-hover">
<td>Class </td>
<td>Tues </td>
<td> 4:30-7:20 pm </td>
<td> SAV 158 </td>
</tr>
<tr>
<td>Lab </td>
<td>Fri </td>
<td>1:30-3:30 pm </td>
<td> SAV 117 </td>
</tr>
</table>

## Office Hours

<table class = "table table-striped table-hover">
<tr>
<td>Jeffrey Arnold</td>
<td>Th 3:00--5:00 pm</td>
<td>Smith 221B </td>
</tr>
<tr>
<td>Carolina Johnson</td>
<td>Tu 3:30--4:30 pm </td>
<td> SAV 119 </td>
</tr>
<tr>
<td>Sergio García-Rios </td>
<td>F 12:30--1:30 pm </td>
<td> SAV 119 </td>
</tr>
</table>

# Overview and Class Goals

<!-- Begin from Chris Adolph syllabus -->

This course continues the graduate sequence in quantitative political methodology, focused particularly on fitting, interpreting, and refining the linear regression model.

Our agenda includes gaining familiarity with statistical programming via the popular R environment, developing clear and informative graphical representations of regression results, and understanding regression models in matrix form.

<!-- End from Chris Adolph syllabus -->

# Prerequisites

<!-- Begin from Chris Adolph syllabus -->

It is desirable for students to have taken the introductory course in the
sequence (Political Science 501), but any prior course on basic social statistics and linear regression should suffice.

<!-- End from Chris Adolph syllabus -->

# Assessment and Evaluation

## Problem Sets

Problem sets assigned weekly or bi-weekly. These problem sets will include programming problems with an emphasis on writing understandable, reproducible code.

The assignments and due dates will be distributed during the quarter.
<!-- These assignments may involve peer review / grading. -->

Assignments will be *both* submitted digitally through [canvas](https://canvas.uw.edu/courses/964019) at the due date and a paper copy to the TA at the next lab section.

## Final Paper

A 15--20 page original report on an original quantitative analysis or replication-and-extension of a published article.
The quantitative analysis should be conducted in R and reproducible.
Students may work in pairs on the final paper with instructor permission.

The final paper is due on **June 9, 2015 15:00 PDT**.

For advice see the [FAQ](faq.html#paper).

## Email & Canvas: 

The teaching team will send announcements regularly by email.

Any non-personal questions related to the material in the course should be posted as a [Canvas](https://canvas.uw.edu/courses/964019) discussion.
Reserve email for personal or administrative matters.
Before posting, check that the question has not been asked and answered already.

It is often more efficient to answer questions in person, so try to ask them attend office hours.

## Resources

There are a couple places on campus that you can go to get additional statistical conulting

- CSSCR has a drop-in statistical consulting center in Savery 119. They provide consulting on statistical software, e.g. R. http://csscr.washington.edu/consulting.html
- CSSS Statistical Consulting provides general statistical consulting (questions about your research project).
  You can find their hours and locations on thier [site](https://www.csss.washington.edu/Consulting/).


# Texts

### Required

- @fox_applied_2008
- @gelman_data_2006
- @angrist_mostly_2009 (UW library eBook available)

### Optional

- @zuur_beginners_2009 (UW library eBook available)

# Schedule and Topics

**Warning:** The uncertainty on this schedule is high.
Given that this is my first time teaching this course, I expect many adjustments to be made.

## Week 1: Introduction to 503 and R, Math Review

### Tuesday, March 31


- [Deck 1](lectures/Lecture_01_handout.pdf)
- Readings
    - In-class R Markdown example analysis: [Rmd source](docs/Challenger_Analysis.Rmd), [html output](docs/Challenger_Analysis.html)
    - Gelman and Hill, Ch 2
    - Fox, Ch 2, 3 (review)

### Friday, April 3

- Lab document: [.Rmd](labs/lab1.Rmd), [html](labs/lab1.html)
- Data: [gapminder.csv](labs/gapminder.csv)
- Readings:
    - Complete Data Camp "Introduction to R", https://www.datacamp.com/courses/free-introduction-to-r
    - @wickham_layered_2010

## Week 2: Assumptions & Properties of the Linear Regression Model, Part I

### Tuesday, April 7

- [Deck 2](lectures/Lecture_02_handout.pdf)
- Readings: 
    - Matrix algebra readings. Read **any** of the following
        - Moore @moore_mathematics_2013, Chapter 12 (on [Canvas](https://canvas.uw.edu/files/31074693/download?download_frd=1)).
        - Kevin Quinn's matrix algebra [handout](docs/matrix.pdf)
        - [CSSS Math Camp Lectures](http://www.csss.washington.edu/MathCamp/Lectures/) Section 4
	- Fox, Ch. 5, 9.1--9.2

### Friday, April 10

- @wickham_tidy_2014
- Zuur, Ch 1, 2, 3 (optional)

## Week 3: Assumptions & Properties of the Linear Regression Model, Part II

### Tuesday, April 14

- Fox, Ch. 6, 9.3
	
### Friday, April 17

- Zuur, Ch 5 (optional)

## Week 4: Statistical Inference / Interpretation of the Linear Model

### Tuesday, April 21

- Gelman and Hill, Ch 3
- @brambor_understanding_2006

### Friday, April 17

- Zuur, Ch 4, 6 (optional)

## Week 5: Model Fitting and Data Transformation

### Tuesday, Apr 28

- Fox, Ch 12, 13, 17.1--17.2
- Gelman and Hill, Ch 4, 7 (optional)
	
### Friday, May 1

TBD

## Week 6: Outliers, Robust Regression, Bootstrapping

### Tuesday, May 5

- Fox, Ch 11, 19

### Friday, May 8

TBD

## Week 7: Causal Inference

### Tuesday, May 12

TBD

### Friday, May 15

TBD

## Week 8: Prediction

### Tuesday, May 19

TBD

### Friday, May 22

TBD

## Week 9: Limited Dependent Variables, Robust standard errors

### Tuesday, May 26

TBD

### Friday, May 29

TBD

## Week 10: 

### Tuesday, June 2

TBD

### Friday, June 5

TBD

* * * 

Syllabus derived from Christopher Adolph. (Spring 2014). *POLS/CSSS 503: Advanced Quantitative Political Methodology* [Syllabus]. University of Washington. http://faculty.washington.edu/cadolph/503/503.pdf [CC-BY-SA](https://creativecommons.org/licenses/by-sa/2.0/).

<!--  LocalWords:  UTC td href TAs García SAV gelman angrist UW eBook
 -->
<!--  LocalWords:  zuur Brambor TBD CSSS img src 221B Tu faq html
 -->
<!--  LocalWords:  wickham brambor
 -->
