#' Create categorical column from expressions
#'
#' Create a categorical variable from logical expressions on a data frame.
#'
#' @param .data A data frame
#' @param col Bare column name
#' @param ... Named expressions evaluating a logical value. The name will
#'   be used for the categorical variable. For
#' @param .default The value to use for \code{col} if none of the logical
#'   predicates in \code{...} are true.
#' @return A data frame consisting of \code{.data} with the additional column
#'   \code{col}.
#' @export
categorize <- function(.data, col, ..., .default = NA_character_) {
  stopifnot(is.data.frame(.data))
  col <- col_name(substitute(col))
  cats <- named_dots(...)
  # Default value if no expressions are TRUE
  .data[[col]] <- .default
  not_true_yet <- rep(TRUE, nrow(.data))
  for (category in names(cats)) {
    # Check if expr is true
    is_true <- as.logical(eval(cats[[category]],
                               .data,
                               parent.frame()))
    # Need to account for NAs
    is_true[is.na(is_true)] <- FALSE
    # Only update cols which haven't been previously true
    to_change <- is_true & not_true_yet
    .data[[col]][to_change] <- as.character(category)
    not_true_yet <- not_true_yet | to_change
  }
  .data
}
