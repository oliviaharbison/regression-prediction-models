# Music Popularity Predictor
# Recipe - Kitchen Sink

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()

# data
load(here("data/music_split.rda"))

# kitchen sink recipe
rec_ks <- recipe(popularity ~ ., music_train) %>%
  step_naomit(all_predictors()) %>%
  step_rm(release_date) %>%
  step_dummy(all_nominal_predictors())

prep_ks <- rec_ks %>% 
  prep() %>% 
  bake(new_data = music_train)


# save kitchen sink recipe
save(rec_ks, prep_ks, file = here("data/rec_ks.rda"))



# kitchen sink recipe for tree models
rec_ks_tree <- recipe(popularity ~ ., music_train) %>%
  step_naomit(all_predictors()) %>%
  step_rm(release_date) %>%
  step_dummy(all_nominal_predictors(), one_hot = TRUE)

prep_ks_tree <- rec_ks_tree %>% 
  prep() %>% 
  bake(new_data = music_train)


# save kitchen sink recipe
save(rec_ks_tree, prep_ks_tree, file = here("data/rec_ks_tree.rda"))







