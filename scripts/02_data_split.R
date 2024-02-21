# Music Popularity Predictor
# Data Split

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()

# data

load(here("data/music.rda"))

# split

music_split <- initial_split(music, prop = 0.8, strata = popularity)
music_train <- training(music_split)
music_test <- testing(music_split)

dim(music_train)
dim(music_test)

# folds

music_folds <-
  vfold_cv(music_train,
           v = 5,
           repeats = 3,
           strata = popularity)

# save
#save(music_folds, music_split, music_train, music_test, file = here("data/music_split.rda"))
