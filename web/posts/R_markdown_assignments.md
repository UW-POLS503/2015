<!--
.. title: Notes on
.. tags: draft
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
    ```
    
    ```
    ## Error in library("gapminder"): there is no package called 'gapminder'
    ```
    
    ```r
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
    ## Error in head(gapminder): object 'gapminder' not found
    ```
    
    ```r
    	glimpse(gapminder)
    ```
    
    ```
    ## Error in nrow(tbl): object 'gapminder' not found
    ```

3. Do not include warnings or messages unless the question asks for them. Examples of this include
    the message after using `geom_histogram` without a `binwidth` argument, or messages when loading
	certain packages. 
	Either fix the code so that the warning or message no longer appears, or use `warning = FALSE`
	or `message = FALSE` in the code chunk to suppress that output.
	
2. Do format your assignment intelligently. Clearly indicate each problem with a header, as well as the parts of problems.

