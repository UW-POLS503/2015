<!--
.. title: Brief Introduction to Matrices and Matrix Algebra R
-->

## Creating Matrices

You can create matrices with the `matrix` function.
The first argument is a vector, and the `nrow` and `ncol` arguments specify the number of rows and columns, respectively. Note that, by default, the elements of the matrix are filled in by column.


```r
A <- matrix(c(1, 5, 3, 0), nrow = 2, ncol = 2)
B <- matrix(c(1, 7, 2, 1, -3, -1), nrow = 2, ncol = 3)
C <- matrix(1:4, nrow = 2, ncol = 2)
```

The identity matrices can be created using the `diag` function. 
This creates the 2 x 2 diagonal matrix.

```r
diag(2)
```

```
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
```
However, the `diag` function is one of the more surpsing functions in R; read the "Details" section of its documentation.
These all do different things:

```r
diag(3)
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```

```r
diag(nrow = 3)
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```

```r
diag(c(1, 2, 3))
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    2    0
## [3,]    0    0    3
```

```r
diag(matrix(1:9, nrow = 3, ncol = 3))
```

```
## [1] 1 5 9
```

You can also create matrices by using `cbind` to combine vectors by column,

```r
a <- c(1, 2, 3)
b <- c(4, 5, 6)
cbind(a, b)
```

```
##      a b
## [1,] 1 4
## [2,] 2 5
## [3,] 3 6
```
and `rbind` to combine vectors by row,

```r
rbind(a, b)
```

```
##   [,1] [,2] [,3]
## a    1    2    3
## b    4    5    6
```
Note that `cbind` and `rbind` can take arbitrary number of arguments,

```r
c <- c(7, 8, 9)
rbind(a, b, c)
```

```
##   [,1] [,2] [,3]
## a    1    2    3
## b    4    5    6
## c    7    8    9
```


## Matrix Information

To find the dimensions of a matrix use `dim`, `ncol`, or `nrow`

```r
dim(B)
```

```
## [1] 2 3
```

```r
nrow(B)
```

```
## [1] 2
```

```r
ncol(B)
```

```
## [1] 3
```

To extract an element from a matrix use brackets. 
This extracts the 1st row, 2nd column from A,

```r
A[1, 2]
```

```
## [1] 3
```
This extracts the 2nd row, 1st column from A,

```r
A[2, 1]
```

```
## [1] 5
```
If you leave column blank, it extracts the entire row,

```r
A[1, ]
```

```
## [1] 1 3
```
If you leave row blank, it extracts the entire column,

```r
A[ , 1]
```

```
## [1] 1 5
```
You can also extract multiple rows or columns,

```r
B[1, 2:3]
```

```
## [1]  2 -3
```

## Matrix Operations

The common operators `+`, `-`, `*`, `/` and `^` work elementwise. In particular, `*` is **not** matrix multiplication.

```r
A + C
```

```
##      [,1] [,2]
## [1,]    2    6
## [2,]    7    4
```

```r
A + 2
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    7    2
```

```r
A - C
```

```
##      [,1] [,2]
## [1,]    0    0
## [2,]    3   -4
```

```r
A - 2
```

```
##      [,1] [,2]
## [1,]   -1    1
## [2,]    3   -2
```

```r
A * C
```

```
##      [,1] [,2]
## [1,]    1    9
## [2,]   10    0
```

```r
A * 2
```

```
##      [,1] [,2]
## [1,]    2    6
## [2,]   10    0
```

```r
A / C
```

```
##      [,1] [,2]
## [1,]  1.0    1
## [2,]  2.5    0
```

```r
A / 2
```

```
##      [,1] [,2]
## [1,]  0.5  1.5
## [2,]  2.5  0.0
```

```r
A ^ C
```

```
##      [,1] [,2]
## [1,]    1   27
## [2,]   25    0
```

```r
A ^ 2
```

```
##      [,1] [,2]
## [1,]    1    9
## [2,]   25    0
```

If you try to do operations with matrices that do not have comptible dimensions, you will get the following error.

```r
A + B
```

```
## Error in A + B: non-conformable arrays
```


To transpose a matrix use the `t` function

```r
t(A)
```

```
##      [,1] [,2]
## [1,]    1    5
## [2,]    3    0
```

```r
t(B)
```

```
##      [,1] [,2]
## [1,]    1    7
## [2,]    2    1
## [3,]   -3   -1
```

For matrix multiplication use the `%*%` operator

```r
A %*% C
```

```
##      [,1] [,2]
## [1,]    7   15
## [2,]    5   15
```

```r
t(C) %*% A
```

```
##      [,1] [,2]
## [1,]   11    3
## [2,]   23    9
```

```r
A %*% B
```

```
##      [,1] [,2] [,3]
## [1,]   22    5   -6
## [2,]    5   10  -15
```

You can multiply a matrix by a vector, but it will treat the vector as a column vector.

```r
B %*% c(1, 2, 3)
```

```
##      [,1]
## [1,]   -4
## [2,]    6
```

```r
c(1, 2) %*% B
```

```
##      [,1] [,2] [,3]
## [1,]   15    4   -5
```
but not,

```r
B %*% c(1, 2)
```

```
## Error in B %*% c(1, 2): non-conformable arguments
```

```r
c(1, 2, 3) %*% B
```

```
## Error in c(1, 2, 3) %*% B: non-conformable arguments
```

Aside: To find help for a special function, quote its name after `?`. For example,

```r
?"%*%"
```

To invert a matrix, use the `solve` function.
This will calculate $A^{-1}$,

```r
solve(A)
```

```
##           [,1]        [,2]
## [1,] 0.0000000  0.20000000
## [2,] 0.3333333 -0.06666667
```
You cannot invert non-square matrices

```r
solve(B)
```

```
## Error in solve.default(B): 'a' (2 x 3) must be square
```

Note that you should avoid using *solve* if at all possible.
Inverting matrices is computationally expensive (about $O(n^3)$), and there are more efficient methods to invert matrices using knowledge of features of the matrix.

