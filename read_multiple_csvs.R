#'---
#'title: Read multiple csv's
#'author: ian handel
#'output: github_document
#'---


library(tidyverse)

#' ## Make some csv's

a <- tibble(x = 1:3,
            y = c(1, 6, 4),
            z = c(77, 33, 55))

a

b <- tibble(x = 1:3,
            y = c(1, 6, 4),
            z = c(22, 66, 22))

b

c <- tibble(x = 1:3,
            y = c(9, 1, 2),
            z = c(66, 22, 11))

c

write_csv(a, "file_a.csv")
write_csv(b, "file_b.csv")
write_csv(c, "file_c.csv")

#' ## Read them

library(fs) # for file stuff

#' ## get the file names ending in .csv
#' 
#' You could point this to any folder
#' 
#' You could filter it afterwards to remove certain files

files <- fs::dir_ls(glob = "*.csv")

#' ### just read them and make into data.frame

map_df(files, read_csv)

#' ### read them adding filename as a column

read_fun <- function(file){
  read_csv(file) %>% 
    mutate(filename = file)
}

map_df(files, read_fun)


