library("knitr")
library("pols503")

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
