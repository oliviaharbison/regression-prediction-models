# Music Popularity Predictor - Progress Memo 1
# Initial data input

# packages
library(tidyverse)
library(here)


# data
music_pop <- read_csv(here("data/music popularity.csv")) %>%
  mutate(release_date = as.Date(release_date),
         t_mode0 = as.factor(t_mode0),
         t_mode1 = as.factor(t_mode1),
         t_mode2 = as.factor(t_mode2),
         t_sig0 = as.factor(t_sig0),
         t_sig1 = as.factor(t_sig1),
         t_sig2 = as.factor(t_sig2)) %>%
  filter(!is.na(t_dur2)) %>%
  na.omit(.)

music <- music_pop %>%
  filter(between(release_date, as.Date('1980-01-01'), as.Date('2009-12-31'))) %>%
  select(-id, -name, -artists, -starts_with("t_name"))

skimr::skim(music)

# save 

save(music, file = here("data/music.rda"))

# examine 

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

