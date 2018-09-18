library(tidyverse)
library(readr)
#setwd("data")
litters_data = readr::read_csv(file = "./data/FAS_litters.csv")
names(litters_data)
litters_data = janitor::clean_names(litters_data) #overwrite with a new version with cleaner names.
names(litters_data)
#loading pups dataset.
pups_data = janitor::clean_names(
  readr::read_csv(file = "./data/FAS_pups.csv")
)
names(pups_data)
#absolute paths
pups_data = janitor::clean_names(
  readr::read_csv(file = "C:/Users/dalgleish/Dropbox/Documents/columbia/p8105/lecture/data_import_p8105_jld2227/data/FAS_pups.csv")
)
names(pups_data)
## Look at data.
