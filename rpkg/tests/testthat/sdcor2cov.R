library("pols503")
context("sdcov2cor")


test_that("defaults to identity matrix", {
  s <- c(1, 2)
  sdcor2cov(s)
})

