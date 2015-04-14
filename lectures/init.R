# LECTURE_NUM needs to be set elsewhere
suppressPackageStartupMessages({
    library("ggplot2")
    library("dplyr")
    library("stringr")
    library("knitr")
    library("readr")
})

opts_chunk$set(fig.height = 3, fig.width = 5,
                      echo = FALSE,
                      cache = TRUE,
                      autodep = TRUE,
                      message = FALSE,
                      dev = "pdf",
                      error = FALSE,
                      fig.path = str_c('lecture-', LECTURE_NUM, '_files/'),
                      cache.path = str_c('lecture-', LECTURE_NUM, '_cache/'))
pat <- knit_patterns[["get"]]()
pat[["header.begin"]] <- "% HEADER HERE"
knit_patterns[["set"]](pat)

set.seed(5797646)

theme_local <- theme_minimal
