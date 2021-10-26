library(here)
library(readr)

ultra_rankings <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/ultra_rankings.csv')

write_csv(ultra_rankings, file = here("data-raw", "ultra_rankings.csv"))
