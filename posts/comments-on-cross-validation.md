<!--
.. title: Comments on Cross Validation
.. slug: comments-on-cross-validation
.. date: 2015-05-13 00:00:22 UTC-07:00
.. tags: cross validation, draft
.. category: 
.. link: 
.. description: 
.. type: text
.. author: Jeffrey Arnold
-->

To answer a few questions brought up in class regarding cross-validation and prediction.
General recommendations for hold-out training data 

For the number folds in cross-validation, the recommended values are 5- or 10-fold cross validation.
At these values, the generalization error has a good combination of [bias and variance](http://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff).[^cvfold]
For model validation with a single hold-out sample the convention appears to be to use 70-80% of the data for training, and 20-30% for testing.
However, it is more efficient to use cross-validation methods if possible.

For examples of cross-validation or prediction in political science research.
You can point to them, and their arguments, to justify the use of cross-validation in your own work.

- Hill, Daniel W. Jr., and Zachary M. Jones. 2014. “An Empirical Evaluation of Explanations for State Repression.” *American Political Science Review* 108(03): 661–87. <http://journals.cambridge.org/article_S0003055414000306>
- Ward, Michael D., Brian D. Greenhill, and Kristin M. Bakke. 2010. “The Perils of Policy by P-Value: Predicting Civil Conflicts.” *Journal of Peace Research* 47(4): 363–75. <http://jpr.sagepub.com/content/47/4/363>
- Ward, Michael D., and Peter D. Hoff. 2007. “Persistent Patterns of International Commerce.” Journal of Peace Research 44(2): 157–75. <http://jpr.sagepub.com.offcampus.lib.washington.edu/content/44/2/157>
- Hoff, Peter D., and Michael D. Ward. 2004. “Modeling Dependencies in International Relations Networks.” *Political Analysis*  12(2): 160–75. <http://pan.oxfordjournals.org.offcampus.lib.washington.edu/content/12/2/160>
- Fariss, Christopher J., and Zachary M. Jones. “Enhancing Validity in Observational Settings When Replication Is Not Possible.” <http://zmjones.com/static/papers/replication.pdf>
- Beck, Nathaniel, Gary King, and Langche Zeng. 2000. “Improving Quantitative Studies of International Conflict: A Conjecture.” *The American Political Science Review* 94(1): 21–35.

[^cvfold]: See [Hastie, Tibshirani, and Friedman](http://statweb.stanford.edu/~tibs/ElemStatLearn/printings/ESLII_print10.pdf#page=261), *Elements of Statistical Learning*, p. 242.
