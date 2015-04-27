library("pols503")
context("categorize")

example_df <- data.frame(a = 1:10)

test_that("categorize works as expected", {
  newdf <- categorize(example_df, x,
             "lt 5" = a < 5,
             "eq 5" = a == 5,
             "gt 5" = a > 5)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equal(newdf$x, c(rep("lt 5", 4), "eq 5", rep("gt 5", 5)))
})

test_that("categorize works as expected with missing", {
  newdf <- categorize(example_df, x,
                     "lt 5" = a < 5,
                     "eq 5" = a == 5)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equivalent(newdf$x, c(rep("lt 5", 4), "eq 5", rep(NA_character_, 5)))
})

test_that("categorize works as expected with default", {
  newdf <- categorize(example_df, x,
                      "lt 5" = a < 5,
                      "eq 5" = a == 5, .default = "c")
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equivalent(newdf$x, c(rep("lt 5", 4), "eq 5", rep("c", 5)))
})
