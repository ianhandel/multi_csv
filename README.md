Read multiple csv's
================
ian handel
Fri Feb 22 13:45:11 2019

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0           ✔ purrr   0.2.5      
    ## ✔ tibble  2.0.99.9000     ✔ dplyr   0.7.8      
    ## ✔ tidyr   0.8.2           ✔ stringr 1.3.1      
    ## ✔ readr   1.3.1           ✔ forcats 0.3.0

    ## ── Conflicts ────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

Make some csv's
---------------

``` r
a <- tibble(x = 1:3,
            y = c(1, 6, 4),
            z = c(77, 33, 55))

a
```

    ## # A tibble: 3 x 3
    ##       x     y     z
    ##   <int> <dbl> <dbl>
    ## 1     1     1    77
    ## 2     2     6    33
    ## 3     3     4    55

``` r
b <- tibble(x = 1:3,
            y = c(1, 6, 4),
            z = c(22, 66, 22))

b
```

    ## # A tibble: 3 x 3
    ##       x     y     z
    ##   <int> <dbl> <dbl>
    ## 1     1     1    22
    ## 2     2     6    66
    ## 3     3     4    22

``` r
c <- tibble(x = 1:3,
            y = c(9, 1, 2),
            z = c(66, 22, 11))

c
```

    ## # A tibble: 3 x 3
    ##       x     y     z
    ##   <int> <dbl> <dbl>
    ## 1     1     9    66
    ## 2     2     1    22
    ## 3     3     2    11

``` r
write_csv(a, "file_a.csv")
write_csv(b, "file_b.csv")
write_csv(c, "file_c.csv")
```

Read them
---------

``` r
library(fs) # for file stuff
```

get the file names ending in .csv
---------------------------------

You could point this to any folder

You could filter it afterwards to remove certain files

``` r
files <- fs::dir_ls(glob = "*.csv")
```

### just read them and make into data.frame

``` r
map_df(files, read_csv)
```

    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )

    ## # A tibble: 9 x 3
    ##       x     y     z
    ##   <dbl> <dbl> <dbl>
    ## 1     1     1    77
    ## 2     2     6    33
    ## 3     3     4    55
    ## 4     1     1    22
    ## 5     2     6    66
    ## 6     3     4    22
    ## 7     1     9    66
    ## 8     2     1    22
    ## 9     3     2    11

### read them adding filename as a column

``` r
read_fun <- function(file){
  read_csv(file) %>% 
    mutate(filename = file)
}

map_df(files, read_fun)
```

    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )
    ## Parsed with column specification:
    ## cols(
    ##   x = col_double(),
    ##   y = col_double(),
    ##   z = col_double()
    ## )

    ## # A tibble: 9 x 4
    ##       x     y     z filename  
    ##   <dbl> <dbl> <dbl> <chr>     
    ## 1     1     1    77 file_a.csv
    ## 2     2     6    33 file_a.csv
    ## 3     3     4    55 file_a.csv
    ## 4     1     1    22 file_b.csv
    ## 5     2     6    66 file_b.csv
    ## 6     3     4    22 file_b.csv
    ## 7     1     9    66 file_c.csv
    ## 8     2     1    22 file_c.csv
    ## 9     3     2    11 file_c.csv
