library("pols503")
context("sdcov2cor")

test_that("sdcov2cor works", {
  s <- c(1, 2)
  R <- matrix(c(1, 0.25, 0.25, 1), nrow = 2)
  expect_equivalent(sdcor2cov(s, R), matrix(c(1, 0.5, 0.5, 4), nrow = 2))
})

test_that("defaults to identity matrix", {
  s <- c(1, 2)
  expect_equivalent(sdcor2cov(s), matrix(c(1, 0, 0, 4), nrow = 2))
})

