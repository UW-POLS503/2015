<!--
.. title: Notes on R Markdown assignments
.. date: 2015-04-21
-->

1. Do include both code and output. In general, you should show all your code and the output of that code,
    including graphs and 
2. Do include words. Your homework should not be just code and output. You should explain in prose
    what you are doing, and more importantly why. Your w
1. Do **not** include **extraneous** output. In general, you should include the output of your code.
    However, do not print large objects. Most commonly, do not print out large data frames. If you
	would like to show example lines from a large data frame use `head` to show only the first few lines,
	or `glimpse`.

    
    ```r
    	library("gapminder")
    	library("dplyr")
    ```
    
    ```
    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:stats':
    ## 
    ##     filter
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union
    ```
    
    ```r
    # bad
    	# gapminder
    	
    	# good
    	head(gapminder)
    ```
    
    ```
    ##       country continent year lifeExp      pop gdpPercap
    ## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
    ## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
    ## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
    ## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
    ## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
    ## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134
    ```
    
    ```r
    	glimpse(gapminder)
    ```
    
    ```
    ## Observations: 1704
    ## Variables:
    ## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
    ## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
    ## $ year      (dbl) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
    ## $ lifeExp   (dbl) 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
    ## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
    ## $ gdpPercap (dbl) 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
    ```

3. Do not include warnings or messages unless the question asks for them. Examples of this include
    the message after using `geom_histogram` without a `binwidth` argument, or messages when loading
	certain packages. 
	Either fix the code so that the warning or message no longer appears, or use `warning = FALSE`
	or `message = FALSE` in the code chunk to suppress that output.
	
2. Do format your assignment intelligently. Clearly indicate each problem with a header, as well as the parts of problems.

