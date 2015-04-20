library("knitr")
library("lintr")

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
#' @return
lint_knit <- function(filename, linters = default_linters,
                      encoding = getOption("encoding"), cache = FALSE) {
	tmpfn <- tempfile()
	on.exit(if (file.exists(tmpfn) file.remove(tmpfn))
	knitr::purl(filename, output = tmpfn, documentation = 2L, quiet = TRUE)
	lints <- lintr::lint(tmpfn, linters = linters, cache = cache)
	for (i in seq_along(lints)) {
		lints[[i]][["filename"]] <- filename
	}
	lints
}

# knit_tidy <- function(hair, report, encoding = getOption("encoding"), ...) {
#   knitr::purl(filename, output = tmpfn, documentation = 2L, quiet = TRUE)
#   tidy_source(tmpfn)
#
# }

linters <- list(assignment_linter,
								single_quotes_linter,
								absolute_paths_linter,
								no_tab_linter,
								line_length_linter,
								commas_linter,
								infix_spaces_linter,
								spaces_left_parentheses_linter,
								spaces_inside_linter,
								open_curly_linter,
								object_multiple_dots_linter,
								#object_camel_case_linter,
								object_length_linter,
								object_usage_linter,
								trailing_whitespace_linter,
								trailing_blank_lines_linter
								)

rmd_files <- dir(".", pattern = ".*\\.Rmd$")
for (fn in rmd_files) {
	print(fn)
	print(lint_rmd(fn, linters = linters))
}

knit_lint <- function(ifile, encoding = encoding) {
  x <- readLines(ifile, encoding = encoding, warn = FALSE)
  n <- length(x)
  if (n == 0)
    return(x)
  p <- detect_pattern(x, tolower(file_ext(ifile)))
#   if (is.null(p))
#     return(x)
#   p <- all_patterns[[p]]
#   p1 = p$chunk.begin
#   p2 = p$chunk.end
#   i1 = grepl(p1, x)
#   i2 = filter_chunk_end(i1, grepl(p2, x))
#   m = numeric(n)
#   m[i1] = 1
#   m[i2] = 2
#   if (m[1] == 0)
#     m[1] = 2
#   for (i in seq_len(n - 1)) if (m[i + 1] == 0)
#     m[i + 1] = m[i]
#   x[m == 1 | i2] = ""
#   x[m == 2] = gsub(p$inline.code, "", x[m == 2])
#   x
    x
}
