#' @import tidyr
#' @import lintr
#' @import knitr
#' @import dplyr
#' @importFrom pryr named_dots
NULL

# From tidyr:::append_df
append_df <- function (x, values, after = length(x)) {
  y <- append(x, values, after = after)
  class(y) <- class(x)
  attr(y, "row.names") <- attr(x, "row.names")
  y
}

# From tidyr:::col_name
col_name <- function (x, default = stop("Please supply column name",
                      call. = FALSE)) {
  if (is.character(x))
    return(x)
  if (identical(x, quote(expr = )))
    return(default)
  if (is.name(x))
    return(as.character(x))
  if (is.null(x))
    return(x)
  stop("Invalid column specification", call. = FALSE)
}

# From tidyr:::append_col
append_col <- function (x, col, name, after = length(x)) {
  append_df(x, setNames(list(col), name), after = after)
}
