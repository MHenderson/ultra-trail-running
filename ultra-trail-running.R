library(dplyr)
library(here)
library(ggplot2)
library(readr)

font1 <- "Roboto Condensed"
background_colour <- "aliceblue"
text_colour <- "#212121"

ultra_rankings <- read_csv(here("data-raw", "ultra_rankings.csv"))

ultra_rankings <- ultra_rankings %>%
  mutate(
    nationality = toupper(nationality)
  )

top_nationalities <- ultra_rankings %>%
  count(nationality) %>%
  arrange(desc(n)) %>%
  head(16) %>%
  pull(nationality)

ultra_rankings %>%
  filter(nationality %in% top_nationalities) %>%
  filter(age > 0) %>%
  ggplot() +
  geom_histogram(aes(age), binwidth = 5, alpha = .5) +
  facet_wrap(~nationality, scales = "free_y") +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = background_colour),
    panel.grid.major = element_line(color = 'grey', linetype = 'dotted', size = .5),
    panel.grid.minor = element_blank(),
    plot.title        = element_text(colour = text_colour, size = 28, hjust = 0, family = font1, margin = margin(5, 0, 5, 0)),
    plot.caption      = element_text(colour = text_colour, size = 10, family = font1, margin = margin(5, 0, 5, 0))
  ) +
  labs(
    title = "How Old Are Trail Runners?",
    subtitle = "Age distribution by nationality",
    caption = "Data: International Trail Running Association (ITRA) | Graphic: Matthew Henderson",
    x = "",
    y = ""
  )

ggsave("ultra-trail-running.png", width = 10, height = 8, dpi = "retina")
