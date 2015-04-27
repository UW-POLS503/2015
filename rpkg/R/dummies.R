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
#' @examples
#' example_df <- data.frame(x = c(rep("a", 2), rep("b", 2)))
#' to_dummies(example_df, x)
#' to_dummies(example_df, x, remove = FALSE)
#' to_dummies(example_df, x, drop_level = TRUE)
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

which_w_default <- function(x, y, default = NA) {
  ret <- x[! is.na(y) & as.logical(y)]
  if (length(ret) == 0) ret <- default
  else ret <- ret[1]
  ret
}

#' Convert dummy variable columns to a categorical variable column
#'
#' \code{from_dummies} converts dummy variable columns to a categorical variable
#' column.
#'
#' @param .data A data frame
#' @param col The bare column name which will be created.
#' @param from The columns which contain the dummy variables.
#' @param remove If \code{TRUE}, then remove the input column from the output
#'   data frame.
#' @param default The value to use if no dummy variables match.
#' @return A data frame.
#' @examples
#' example_df <- data.frame(a = c(1, 0, 0), b = c(0, 1, 0))
#' from_dummies(example_df, x, c("a", "b"))
#' from_dummies(example_df, x, c("a", "b"), remove = FALSE)
#' from_dummies(example_df, x, c("a", "b"), default = "c")
#' @export
from_dummies <- function(.data, col, from, default = NA_character_,
                         remove = TRUE) {
  col <- col_name(substitute(col))
  from_dummies_(.data, col, from, default = default, remove = remove)
}

#' Standard evaluation version of \code{from_dummies}.
#'
#' This is an S3 generic.
#'
#' @inheritParams from_dummies
#' @export
from_dummies_ <- function(.data, col, from, default = NA_character_,
                          remove = TRUE) {
  UseMethod("from_dummies_")
}

from_dummies_.data.frame <- function(.data, col, from, default = NA_character_,
                                      remove = TRUE) {
  stopifnot(is.character(col), length(col) == 1)
  catvar <-
    apply(.data[ , from, drop = FALSE], 1,
          function(x) which_w_default(from, x, default = default))
  .data <- append_col(.data, catvar, col)
  if (remove) {
    for (i in from) {
      .data[[i]] <- NULL
    }
  }
  .data
}

from_dummies_.tbl_df <- function(.data, col, from, default = NA_character_,
                                 remove = TRUE) {
  dplyr::tbl_df(NextMethod())
}
