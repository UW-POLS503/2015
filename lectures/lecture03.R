library("dplyr")

n <- 20
a <- 1
b <- 2
c <- -2
dat <- data_frame(x1 = rep(c(0, 1), each = n / 2),
                x2 = rep(c(1, 0), each = n / 2),
                y = a + b * x1 + c * x2 + rnorm(n, mean = 0, sd = 0.5))


lm(y ~ x1, data = dat)
lm(y ~ x2, data = dat)
lm(y ~ x1 + x2, data = X)

err <- -1.062
