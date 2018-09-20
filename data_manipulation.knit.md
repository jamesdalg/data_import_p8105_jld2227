---
title: "Data Wrangling"
author: "James Dalgleish"
date: "September 20, 2018"
output: html_document
---



```r
library(tidyverse)
```

```
## -- Attaching packages -------------------------------------------------------------------------------------------------------------------------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.0.0     v purrr   0.2.5
## v tibble  1.4.2     v dplyr   0.7.6
## v tidyr   0.8.1     v stringr 1.3.1
## v readr   1.1.1     v forcats 0.3.0
```

```
## -- Conflicts ----------------------------------------------------------------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(readr)
#setwd("data")
# litters_data = readr::read_csv(file = "./data/FAS_litters.csv")
# names(litters_data)
# litters_data = janitor::clean_names(litters_data) #overwrite with a new version with cleaner names.
# names(litters_data)
# #loading pups dataset.
# pups_data = janitor::clean_names(
#   readr::read_csv(file = "./data/FAS_pups.csv")
# )
# names(pups_data)
# #absolute paths
# pups_data = janitor::clean_names(
#   readr::read_csv(file = "C:/Users/dalgleish/Dropbox/Documents/columbia/p8105/lecture/data_import_p8105_jld2227/data/FAS_pups.csv")
# )
# names(pups_data)
## Look at data.
```

```r
options(tibble.print_min = 3)

litters_data = read_csv("./data/FAS_litters.csv",
  col_types = "ccddiiii")
litters_data = janitor::clean_names(litters_data)

pups_data = read_csv("./data/FAS_pups.csv",
  col_types = "ciiiii")
pups_data = janitor::clean_names(pups_data)
```
##Select Variables

```r
select(litters_data, group,  litter_number, gd0_weight)
```

```
## # A tibble: 49 x 3
##   group litter_number gd0_weight
##   <chr> <chr>              <dbl>
## 1 Con7  #85                 19.7
## 2 Con7  #1/2/95/2           27  
## 3 Con7  #5/5/3/83/3-3       26  
## # ... with 46 more rows
```

```r
select(litters_data, group,  gd0_weight, litter_number)
```

```
## # A tibble: 49 x 3
##   group gd0_weight litter_number
##   <chr>      <dbl> <chr>        
## 1 Con7        19.7 #85          
## 2 Con7        27   #1/2/95/2    
## 3 Con7        26   #5/5/3/83/3-3
## # ... with 46 more rows
```

```r
select(litters_data, group, gd_of_birth:pups_survive)
```

```
## # A tibble: 49 x 5
##   group gd_of_birth pups_born_alive pups_dead_birth pups_survive
##   <chr>       <int>           <int>           <int>        <int>
## 1 Con7           20               3               4            3
## 2 Con7           19               8               0            7
## 3 Con7           19               6               0            5
## # ... with 46 more rows
```

```r
select(litters_data, -litter_number)
```

```
## # A tibble: 49 x 7
##   group gd0_weight gd18_weight gd_of_birth pups_born_alive pups_dead_birth
##   <chr>      <dbl>       <dbl>       <int>           <int>           <int>
## 1 Con7        19.7        34.7          20               3               4
## 2 Con7        27          42            19               8               0
## 3 Con7        26          41.4          19               6               0
## # ... with 46 more rows, and 1 more variable: pups_survive <int>
```

```r
select(litters_data, group,  litter_number, gest_day_0_weight = gd0_weight)
```

```
## # A tibble: 49 x 3
##   group litter_number gest_day_0_weight
##   <chr> <chr>                     <dbl>
## 1 Con7  #85                        19.7
## 2 Con7  #1/2/95/2                  27  
## 3 Con7  #5/5/3/83/3-3              26  
## # ... with 46 more rows
```

```r
rename(litters_data, gest_day_0_weight = gd0_weight)
```

```
## # A tibble: 49 x 8
##   group litter_number gest_day_0_weig~ gd18_weight gd_of_birth
##   <chr> <chr>                    <dbl>       <dbl>       <int>
## 1 Con7  #85                       19.7        34.7          20
## 2 Con7  #1/2/95/2                 27          42            19
## 3 Con7  #5/5/3/83/3-3             26          41.4          19
## # ... with 46 more rows, and 3 more variables: pups_born_alive <int>,
## #   pups_dead_birth <int>, pups_survive <int>
```
... use select helpers:


```r
select(litters_data,starts_with("gd"))
```

```
## # A tibble: 49 x 3
##   gd0_weight gd18_weight gd_of_birth
##        <dbl>       <dbl>       <int>
## 1       19.7        34.7          20
## 2       27          42            19
## 3       26          41.4          19
## # ... with 46 more rows
```

```r
select(litters_data,litter_number,starts_with("gd"))
```

```
## # A tibble: 49 x 4
##   litter_number gd0_weight gd18_weight gd_of_birth
##   <chr>              <dbl>       <dbl>       <int>
## 1 #85                 19.7        34.7          20
## 2 #1/2/95/2           27          42            19
## 3 #5/5/3/83/3-3       26          41.4          19
## # ... with 46 more rows
```

```r
select(litters_data, litter_number, everything()) #everything that gives everything that you haven't already selected. You can put the more important variables  on the left.
```

```
## # A tibble: 49 x 8
##   litter_number group gd0_weight gd18_weight gd_of_birth pups_born_alive
##   <chr>         <chr>      <dbl>       <dbl>       <int>           <int>
## 1 #85           Con7        19.7        34.7          20               3
## 2 #1/2/95/2     Con7        27          42            19               8
## 3 #5/5/3/83/3-3 Con7        26          41.4          19               6
## # ... with 46 more rows, and 2 more variables: pups_dead_birth <int>,
## #   pups_survive <int>
```


```r
select(pups_data,litter_number, sex,pd_ears)
```

```
## # A tibble: 313 x 3
##   litter_number   sex pd_ears
##   <chr>         <int>   <int>
## 1 #85               1       4
## 2 #85               1       4
## 3 #1/2/95/2         1       5
## # ... with 310 more rows
```
Do some filtering!!!

```r
filter(litters_data, gd0_weight < 25)
```

```
## # A tibble: 20 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Con7  #85                 19.7        34.7          20               3
##  2 Mod7  #59                 17          33.4          19               8
##  3 Mod7  #103                21.4        42.1          19               9
##  4 Mod7  #4/2/95/2           23.5        NA            19               9
##  5 Mod7  #5/3/83/5-2         22.6        37            19               5
##  6 Mod7  #106                21.7        37.8          20               5
##  7 Mod7  #94/2               24.4        42.9          19               7
##  8 Mod7  #62                 19.5        35.9          19               7
##  9 Low7  #84/2               24.3        40.8          20               8
## 10 Low7  #107                22.6        42.4          20               9
## 11 Low7  #85/2               22.2        38.5          20               8
## 12 Low7  #98                 23.8        43.8          20               9
## 13 Low7  #102                22.6        43.3          20              11
## 14 Low7  #101                23.8        42.7          20               9
## 15 Low7  #112                23.9        40.5          19               6
## 16 Mod8  #97                 24.5        42.8          20               8
## 17 Low8  #53                 21.8        37.2          20               8
## 18 Low8  #100                20          39.2          20               8
## 19 Low8  #4/84               21.8        35.2          20               4
## 20 Low8  #99                 23.5        39            20               6
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

```r
filter(litters_data, gd0_weight >= 25)
```

```
## # A tibble: 14 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Con7  #1/2/95/2           27          42            19               8
##  2 Con7  #5/5/3/83/3-3       26          41.4          19               6
##  3 Con7  #5/4/2/95/2         28.5        44.1          19               5
##  4 Con8  #3/5/2/2/95         28.5        NA            20               8
##  5 Con8  #5/4/3/83/3         28          NA            19               9
##  6 Mod7  #3/82/3-2           28          45.9          20               5
##  7 Low7  #111                25.5        44.6          20               3
##  8 Mod8  #7/82-3-2           26.9        43.2          20               7
##  9 Mod8  #7/110/3-2          27.5        46            19               8
## 10 Mod8  #2/95/2             28.5        44.5          20               9
## 11 Mod8  #82/4               33.4        52.7          20               8
## 12 Low8  #79                 25.4        43.8          19               8
## 13 Low8  #108                25.6        47.5          20               8
## 14 Low8  #110                25.5        42.7          20               7
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

```r
filter(litters_data, pups_born_alive == 8)
```

```
## # A tibble: 16 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Con7  #1/2/95/2           27          42            19               8
##  2 Con8  #2/95/3             NA          NA            20               8
##  3 Con8  #3/5/2/2/95         28.5        NA            20               8
##  4 Con8  #3/5/3/83/3-~       NA          NA            20               8
##  5 Mod7  #59                 17          33.4          19               8
##  6 Mod7  #3/83/3-2           NA          NA            19               8
##  7 Low7  #84/2               24.3        40.8          20               8
##  8 Low7  #85/2               22.2        38.5          20               8
##  9 Mod8  #97                 24.5        42.8          20               8
## 10 Mod8  #5/93/2             NA          NA            19               8
## 11 Mod8  #7/110/3-2          27.5        46            19               8
## 12 Mod8  #82/4               33.4        52.7          20               8
## 13 Low8  #53                 21.8        37.2          20               8
## 14 Low8  #79                 25.4        43.8          19               8
## 15 Low8  #100                20          39.2          20               8
## 16 Low8  #108                25.6        47.5          20               8
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

```r
filter(litters_data, !is.na(gd0_weight))
```

```
## # A tibble: 34 x 8
##   group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##   <chr> <chr>              <dbl>       <dbl>       <int>           <int>
## 1 Con7  #85                 19.7        34.7          20               3
## 2 Con7  #1/2/95/2           27          42            19               8
## 3 Con7  #5/5/3/83/3-3       26          41.4          19               6
## # ... with 31 more rows, and 2 more variables: pups_dead_birth <int>,
## #   pups_survive <int>
```

```r
filter(litters_data, group == "Low8" | group == "Low7")
```

```
## # A tibble: 15 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Low7  #84/2               24.3        40.8          20               8
##  2 Low7  #107                22.6        42.4          20               9
##  3 Low7  #85/2               22.2        38.5          20               8
##  4 Low7  #98                 23.8        43.8          20               9
##  5 Low7  #102                22.6        43.3          20              11
##  6 Low7  #101                23.8        42.7          20               9
##  7 Low7  #111                25.5        44.6          20               3
##  8 Low7  #112                23.9        40.5          19               6
##  9 Low8  #53                 21.8        37.2          20               8
## 10 Low8  #79                 25.4        43.8          19               8
## 11 Low8  #100                20          39.2          20               8
## 12 Low8  #4/84               21.8        35.2          20               4
## 13 Low8  #108                25.6        47.5          20               8
## 14 Low8  #99                 23.5        39            20               6
## 15 Low8  #110                25.5        42.7          20               7
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

```r
filter(litters_data, group %in% c("Low7","Low8"))
```

```
## # A tibble: 15 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Low7  #84/2               24.3        40.8          20               8
##  2 Low7  #107                22.6        42.4          20               9
##  3 Low7  #85/2               22.2        38.5          20               8
##  4 Low7  #98                 23.8        43.8          20               9
##  5 Low7  #102                22.6        43.3          20              11
##  6 Low7  #101                23.8        42.7          20               9
##  7 Low7  #111                25.5        44.6          20               3
##  8 Low7  #112                23.9        40.5          19               6
##  9 Low8  #53                 21.8        37.2          20               8
## 10 Low8  #79                 25.4        43.8          19               8
## 11 Low8  #100                20          39.2          20               8
## 12 Low8  #4/84               21.8        35.2          20               4
## 13 Low8  #108                25.6        47.5          20               8
## 14 Low8  #99                 23.5        39            20               6
## 15 Low8  #110                25.5        42.7          20               7
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

```r
filter(litters_data, pups_born_alive %in% 4:7, !is.na(gd0_weight))
```

```
## # A tibble: 12 x 8
##    group litter_number gd0_weight gd18_weight gd_of_birth pups_born_alive
##    <chr> <chr>              <dbl>       <dbl>       <int>           <int>
##  1 Con7  #5/5/3/83/3-3       26          41.4          19               6
##  2 Con7  #5/4/2/95/2         28.5        44.1          19               5
##  3 Mod7  #3/82/3-2           28          45.9          20               5
##  4 Mod7  #5/3/83/5-2         22.6        37            19               5
##  5 Mod7  #106                21.7        37.8          20               5
##  6 Mod7  #94/2               24.4        42.9          19               7
##  7 Mod7  #62                 19.5        35.9          19               7
##  8 Low7  #112                23.9        40.5          19               6
##  9 Mod8  #7/82-3-2           26.9        43.2          20               7
## 10 Low8  #4/84               21.8        35.2          20               4
## 11 Low8  #99                 23.5        39            20               6
## 12 Low8  #110                25.5        42.7          20               7
## # ... with 2 more variables: pups_dead_birth <int>, pups_survive <int>
```

##Mutate







