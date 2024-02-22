# Music Popularity Predictor - Progress Memo 1
# Initial data input

# packages
library(tidyverse)
library(here)


# data
music_pop <- read_csv(here("data/music popularity.csv")) %>%
  mutate(release_date = as.Date(release_date))

music <- music_pop %>%
  filter(between(release_date, as.Date('1980-01-01'), as.Date('2009-12-31'))) %>%
  select(-id, -name, -artists, -starts_with("t_name"))

skimr::skim(music)

#save(music, file = here("data/music.rda"))

naniar::miss_var_summary(music) %>% arrange(-pct_miss) 

ggplot(music, aes(popularity)) +
  geom_histogram(bins = 40,
                 color = "white") +
  theme_minimal() +
  labs(
    x = "Popularity",
    y = "Count",
    title = "Distribution of Target Variable (Popularity)",
    caption = "Source: Kaggle"
  )

music %>% summarize(mean(popularity), median(popularity))

