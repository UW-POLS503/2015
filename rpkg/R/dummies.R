#' Convert column to dummy variables
#'
#' \code{to_dummies} converts a column into multiple columns of dummy variables.
#'
#' @param .data A data frame
#' @param col The bare column name
#' @param contrasts A character string naming a function or a numeric matrix,
#'   to be used as a replacement value for the \code{\link{contrasts}} replacement
#'   function.
#' @param remove If \code{TRUE}, then remove the input column from the output
#'   data frame.
#' @param drop_level If \code{TRUE}, then drop a level when creating the variables.
#'   This is the default for models.
#' @param sep \code{character} string to use as the separator in the new column
#'   names.
#' @return A data frame.
#' @export
to_dummies <- function(.data, col,
                        contrasts = NULL,
                        remove = TRUE, drop_level = FALSE, sep = "_") {
  col <- col_name(substitute(col))
  to_dummies_(.data, col, contrasts = contrasts, remove = remove,
              drop_level = drop_level, sep = sep)
}

#' Standard evaluation version of \code{to_dummies}.
#'
#' This is an S3 generic.
#'
#' @inheritParams to_dummies
#' @export
to_dummies_ <- function(.data, col,
                        contrasts = NULL,
                        remove = TRUE, drop_level = FALSE, sep = "_") {
  UseMethod("to_dummies_")
}

to_dummies_.tbl_df <- function(.data, col,
                               contrasts = NULL,
                               remove = TRUE, drop_level = FALSE, sep = "_") {
  dplyr::tbl_df(NextMethod())
}

to_dummies_.data.frame <- function(.data, col,
                       contrasts = NULL,
                       remove = TRUE, drop_level = FALSE, sep = "_") {
  stopifnot(is.character(col), length(col) == 1)
  # do this so that the column keeps any factor attributes
  vals <- .data[ , col, drop = FALSE]
  if (! is.factor(vals[[col]])) {
    vals[[col]] <- as.factor(as.character(vals[[col]]))
  }
  # Override default contrasts
  if (! is.null(contrasts)) {
    contrasts(vals[[col]]) <- contrasts
  }
  if (drop_level) {
    f <- formula("~ x")
  } else {
    f <- formula("~ x - 1")
  }
  dummies <- data.frame(model.matrix(f, data = vals),
                        check.rows = FALSE,
                        check.names = FALSE, stringsAsFactors = FALSE)
  if (drop_level) {
    dummies[[1L]] <- NULL
  }
  colnames(dummies) <- gsub("^x", paste0(col, sep), colnames(dummies))
  .data <- append_df(.data, dummies)
  if (remove) {
    .data[[col]] <- NULL
  }
  .data
}
#
# # debug(to_dummies)
# test_df <- data.frame(x = c(rep("a", 2), rep("b", 2), rep("c", 2)),
#                       y = 1)
# to_dummies(test_df, "x")
# to_dummies(test_df, "x", drop_level = TRUE)
# to_dummies(test_df, "x", contrasts = "contr.sum")
# to_dummies(test_df, "x", drop_level = TRUE, contrasts = "contr.sum")
# to_dummies(mutate(test_df, x = ordered(x)), "x", drop_level = TRUE, sep = "")


# to_dummies <- function(data, col, ..., remove = TRUE) {
#   col <- col_name(substitute(col))
#   to_dummies_(data, col, ..., remove = TRUE)
# }
#
# which_w_default <- function(x, y, default = NA) {
#   ret <- x[as.logical(y)]
#   if (length(ret) == 0) ret <- default
#   else ret <- ret[1]
#   ret
# }
#
# from_dummy_ <- function(data, col, from, ... , default = NA, remove = TRUE) {
#   catvar <- gather(select(data, one_of(from)), .key, .value) %>%
#     rowwise() %>%
#     summarise(which_w_default(.key, .value)) %>%
#     select(-.key, -.value)
#   names(catvar) <- col
#   append_df(data, catvar)
# }
