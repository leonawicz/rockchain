library(rockchain)
library(dplyr)
coins <- select(ticker(), 1:3)
usethis::use_data(coins)
