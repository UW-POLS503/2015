library("pols503")
context("from_dummies")

example_df <- data.frame(a = c(1, 0, 0, 1), b = c(0, 1, 0, 1))

test_that("from_dummies works as expected", {
  newdf <- from_dummies(example_df, x, c("a", "b"))
  expect_equal(colnames(newdf), c("x"))
  expect_equal(newdf$x, c("a", "b", NA_character_, "a"))
})

test_that("from_dummies works as expected with default value", {
  newdf <- from_dummies(example_df, x, c("a", "b"), default = "c")
  expect_equal(colnames(newdf), c("x"))
  expect_equal(newdf$x, c("a", "b", "c", "a"))
})

test_that("from_dummies will not remove original cols", {
  newdf <- from_dummies(example_df, x, c("a", "b"), remove = FALSE)
  expect_equal(colnames(newdf), c("a", "b", "x"))
  expect_equal(newdf$x, c("a", "b", NA, "a"))
})

test_that("from_dummies_.data.frame works", {
  newdf <- from_dummies_(example_df, "x", c("a", "b"))
  expect_is(newdf, "data.frame")
  expect_equal(colnames(newdf), c("x"))
  expect_equal(newdf$x, c("a", "b", NA, "a"))
})

test_that("from_dummies_.tbl_df works", {
  newdf <- from_dummies_(tbl_df(example_df), "x", c("a", "b"))
  expect_is(newdf, "tbl_df")
  expect_equal(colnames(newdf), c("x"))
  expect_equal(newdf$x, c("a", "b", NA, "a"))
})
