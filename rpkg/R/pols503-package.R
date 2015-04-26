#' @import tidyr
#' @import
#'

to_dummies_ <- function(data, col, ..., remove = TRUE) {
  l <- dummies:::dummy.data.frame(data, names = col, ...)
  data <- tidyr:::append_df(data, l, which(names(data) == col))
  if (remove) {
    data[[col]] <- NULL
  }
  data
}

to_dummies <- function(data, col, ..., remove = TRUE) {
  col <- col_name(substitute(col))
  to_dummy_(data, col, ..., remove = TRUE)
}

which_w_default <- function(x, y, default = NA) {
  ret <- x[as.logical(y)]
  if (length(ret) == 0) ret <- default
  else ret <- ret[1]
  ret
}

from_dummy_ <- function(data, col, from, ... , default == NA, remove = TRUE) {
  catvar <- gather(select(data, one_of(from)), .key, .value) %>%
    rowwise() %>%
    summarise(which_w_default(.key, .value)) %>%
    select(-.key, -.value)
  names(catvar) <- col
  append_df(data, catvar)
}

categorize_ <- function(data, ...) {
}

