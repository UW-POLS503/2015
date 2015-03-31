# LECTURE_NUM needs to be set elsewhere
knitr::opts_chunk$set(fig.height = 3, fig.width = 5,
                      echo = FALSE, cache = TRUE, autodep = TRUE,
                      message = FALSE, dev = "pdf",
                      error = FALSE,
                      fig.path = str_c('lecture-', LECTURE_NUM, '_files/'),
                      cache.path = str_c('lecture-', LECTURE_NUM, '_cache/'))
set.seed(57976496)
