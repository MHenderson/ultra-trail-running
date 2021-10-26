head(race)

head(ultra_rankings)

# Data from: Benjamin Nowak by way of International Trail Running Association (ITRA)
# Data link: https://github.com/BjnNowak/UltraTrailRunning

# The data consists of two datasets. One contains the results of lots
# of races. The other gives more details about the races.

# ideas

# Elevation change seems quite interesting to me.

# Plotting location of races is also interesting to me.

# Maybe I could combine the times with the geographic/elevation data. Is there
# an interesting relationship to explore?

library(ggplot2)

# how does elevation gain compare to elevation loss?
# you would think that most races are circuits that end up
# at the place they started and therefore have equal gain
# and loss. but apparently some races have more gain
# than loss and others more loss than gain. it might
# be interesting to investigate the effect of this
# on times
race %>%
  ggplot(aes(elevation_gain, abs(elevation_loss))) +
    geom_point(size = .2, alpha = .2)

race %>%
  mutate(
    elevation_change = elevation_gain + elevation_loss
  ) %>%
  arrange(desc(elevation_change)) %>%
  head()

# looking at this table we can see that the data is
# not perfectly clean. for example, there is an event
# called
# Flagstaff To Grand Canyon Stagecoach Line
# and another event called
# FLAGSTAFF TO GRAND CANYON STAGECOACH LINE 100 MILE
# are they the same event?

# which country has the events with the greatest
# elevation change?
race %>%
  mutate(
    elevation_change = elevation_gain + elevation_loss
  ) %>%
  ggplot(aes(elevation_gain, abs(elevation_loss))) +
    geom_point() +
    facet_wrap(~country)

# the answer is: the most moutainous ones!
# switzerland, united states, chile, france
# actually, that's not really true.
# there are mountainous countries without races
# with much difference between altitude gain and loss,
# like canada

ultra_rankings <- ultra_rankings %>%
  mutate(
    nationality = toupper(nationality)
  )

top_nationalities <- ultra_rankings %>%
  count(nationality) %>%
  arrange(desc(n)) %>%
  head(49) %>%
  pull(nationality)

ultra_rankings %>%
  filter(nationality %in% top_nationalities) %>%
  head(10000) %>%
  ggplot() +
  geom_histogram(aes(age), binwidth = 5) +
  facet_wrap(~nationality, scales = "free") +
  theme_minimal()


