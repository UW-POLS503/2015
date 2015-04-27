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
#' @seealso \code{\link[plyr]{revalue}}, \code{\link[plyr]{mapvalues}},
#'   \code{\link{cut}}, \code{\link{switch}}
#' @examples
#'   categorize(data.frame(a = 1:10, b = rep(0:1, 5)),
#'              x,
#'              "lt 5" = a < 5,
#'              "ge 5, b" = a >= 5 & b == 1,
#'              "gt 5, not b" = a >= 5 & b == 0)
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


# .categorize <- function(.data, col, ..., .default = NA_character_) {
#   dots <- lazyeval::lazy_dots(...)
#   col <- col_name(substitute(col))
#   default <- lazyeval::lazy(.default)
#   .categorize_(.data, col, .dots = dots, .default = default)
# }
#
# .categorize_ <- function(.data, col, ..., .dots, .default = NA_character_) {
#   stopifnot(is.data.frame(.data))
#   cats <- lazyeval::all_dots(.dots, ..., all_named = TRUE)
#   # Default value if no expressions are TRUE
#   .data[[col]] <- as.character(lazyeval::lazy_eval(.default, .data))
#   not_true_yet <- rep(TRUE, nrow(.data))
#   for (category in names(cats)) {
#     # Check if expr is true
#     is_true <- as.logical(lazyeval::lazy_eval(cats[[category]], .data))
#     # Need to account for NAs
#     is_true[is.na(is_true)] <- FALSE
#     # Only update cols which haven't been previously true
#     to_change <- is_true & not_true_yet
#     .data[[col]][to_change] <- as.character(category)
#     not_true_yet <- not_true_yet | to_change
#   }
#   .data
# }
# debug(.categorize)
# debug(.categorize_)
#
# foo <- .categorize(data.frame(v = 1:10 * 2, a = 1:10, b = rep(0:1, 5)),
#            quote(foo),
#            "lt 5" = a < 5,
#            "ge 5, b" = a >= 5 & b == 1,
#            .default = v)
