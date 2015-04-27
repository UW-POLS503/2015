#' Lint code chunks in a knitr document
#'
#' Lint any document that knitr will read.
#' The markup used for R chunks is recognized and defined the in the same manner
#' as \code{\link[knitr]{knit}}; which this function internally uses.
#' The extension will be matched against the patterns in \code{knitr::all_paterns},
#' The patttern can be manually set using the \code{\link{knit_patterns}} object.
#'
#' Note that this does not lint any inline code in the knitr document.
#'
#' @inheritParams lintr::lint
#' @param encoding The encoding fo the input file; see \code{\link{file}}.
#' @export
lint_knit <- function(filename, linters = default_linters,
                      encoding = getOption("encoding"), cache = FALSE) {
  tmpfn <- tempfile()
  on.exit(if (file.exists(tmpfn)) {file.remove(tmpfn)})
    knitr::purl(filename, output = tmpfn, documentation = 2L, quiet = TRUE)
    lints <- lintr::lint(tmpfn, linters = linters, cache = cache)
    for (i in seq_along(lints)) {
      lints[[i]][["filename"]] <- filename
    }
    lints
}
