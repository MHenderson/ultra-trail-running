library(here)
library(readr)

race <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/race.csv')

write_csv(race, file = here("data-raw", "race.csv"))
