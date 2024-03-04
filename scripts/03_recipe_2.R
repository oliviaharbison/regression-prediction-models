# Music Popularity Predictor
# Recipe 2

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()

# data
load(here("data/music_split.rda"))


# Recipe 2

rec_2 <- recipe(popularity ~ ., music_train) %>%
  step_naomit(all_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_rm(release_date) %>%
  step_log(t_dur0, t_dur1, t_dur2, t_live0, t_live1, t_live2, offset = 0.0000000000001) %>%
  step_log(total_tracks, t_speech0, t_speech1, t_speech2, base = 10, offset = 0.0000000000001) %>%
  step_interact(terms = ~ starts_with("t_acous"):starts_with("t_energy")) %>%
  step_interact(terms = ~ starts_with("t_val"):starts_with("t_dance")) %>%
  step_nzv(all_predictors()) %>%
  step_zv(all_predictors()) %>%
  step_normalize(all_predictors())


# Prep and bake
rec_2_prep <- prep(rec_2) %>%
  bake(new_data = NULL)



