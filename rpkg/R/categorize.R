#' Create categorical column from expressions
#'
#' Create a categorical variable from logical expressions on a data frame.
#'
#' @param .data A data frame
#' @param .col Bare column name
#' @param ... Named expressions evaluating a logical value. The name will
#'   be used for the categorical variable. For
#' @param .default The value to use for \code{col} if none of the logical
#'   predicates in \code{...} are true.
#' @return A data frame consisting of \code{.data} with the additional column
#'   \code{col}.
#' @export
#' @seealso \code{\link[plyr]{revalue}}, \code{\link[plyr]{mapvalues}},
#'   \code{\link{cut}}, \code{\link{switch}}
#' @examples
#'   categorize(data.frame(a = 1:10, b = rep(0:1, 5)),
#'              x,
#'              "lt 5" = a < 5,
#'              "ge 5, b" = a >= 5 & b == 1,
#'              "gt 5, not b" = a >= 5 & b == 0)
categorize <- function(.data, .col, ..., .default = NA_character_) {
  dots <- lazyeval::lazy_dots(...)
  col <- col_name(substitute(.col))
  default <- lazyeval::lazy(.default)
  categorize_(.data, col, dots, default)
}

#' Create categorical column from expressions (standard evaluation)
#'
#' This is a S3 generic.
#'
#' @param data A data frame
#' @param col A character vector with the column name to hold the new categorical
#'   variable
#' @param dots An object coercible into a \code{\link{lazy_dots}} object which
#'   contains the categories and conditions associated with them.
#' @param default Value for rows unmatched by any condition in \code{dots}.
#' @param ... Unused.
#' @export
categorize_ <- function(data, col, dots, default = NA_character_) {
  UseMethod("categorize_")
}

categorize_.data.frame <- function(data, col, dots, default) {
  conditions <- lazyeval::auto_name(lazyeval::as.lazy_dots(dots))
  # Default value if no expressions are TRUE
  data[[col]] <- as.character(lazyeval::lazy_eval(default, data))
  not_true_yet <- rep(TRUE, nrow(data))
  # Cannot use names directly, otherwise duplicate names don't work.
  for (i in seq_along(conditions)) {
    # Check if expr is truel
    category <- names(conditions)[i]
    is_true <- as.logical(lazyeval::lazy_eval(conditions[[i]], data))
    # Need to account for NAs
    is_true[is.na(is_true)] <- FALSE
    # Only update cols which haven't been previously true
    to_change <- is_true & not_true_yet
    data[[col]][to_change] <- as.character(category)
    not_true_yet <- not_true_yet & (! to_change)
  }
  data
}

categorize_.tbl_df <- function(data, col, dots, default) {
  dplyr::tbl_df(NextMethod())
}
