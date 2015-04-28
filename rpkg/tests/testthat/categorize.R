library("pols503")
library("dplyr")
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

test_that("default value that is a constant", {
  newdf <- categorize(example_df, x,
                      "lt 5" = a < 5,
                      "eq 5" = a == 5, .default = "c")
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equivalent(newdf$x, c(rep("lt 5", 4), "eq 5", rep("c", 5)))
})

test_that("default value that is a rowname", {
  example_df <- mutate(example_df, b = "missing")
  newdf <- categorize(example_df, x,
                      "lt 5" = a < 5,
                      "eq 5" = a == 5, .default = b)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "b", "x"))
  expect_equivalent(newdf$x, c(rep("lt 5", 4), "eq 5", rep("missing", 5)))
})

test_that("multiple conditions with the same name", {
  newdf <- categorize(example_df, x,
                      "a" = a < 5,
                      "a" = (a == 5),
                      .default = "c")
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equivalent(newdf$x, c(rep("a", 5), rep("c", 5)))
})

test_that("conditions without names are named", {
  newdf <- categorize(example_df, x,
                      a < 5,
                      a == 5,
                      a > 5)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("a", "x"))
  expect_equivalent(newdf$x, c(rep("a < 5", 4), "a == 5",
                               rep("a > 5", 5)))
})


test_that("overlapping conditions", {
  example_df2 <- data.frame(x = 1:6)
  newdf <- categorize(example_df2,
                      a,
                      "a" = x < 3,
                      "b" = x < 5,
                      "c" = x > 1)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("x", "a"))
  expect_equal(newdf$a, c("a", "a", "b", "b", "c", "c"))
})

test_that("conditions with multiple columns", {
  example_df2 <- data.frame(x = c(1, 1, 0, 0),
                            y = c(1, 0, 1, 0))
  newdf <- categorize(example_df2,
                      xy,
                      "a" = x & y,
                      "b" = x | y,
                      "c" = ! x & ! y)
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("x", "y", "xy"))
  expect_equal(newdf$xy, c("a", "b", "b", "c"))
})

test_that("returns a tbl_df", {
  newdf <- categorize(tbl_df(example_df), x,
                      "a" = a < 5)
  expect_is(newdf, "tbl_df")
})
