# Music Popularity Predictor
# Recipes

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()

# data
load(here("data/music_split.rda"))


# kitchen sink recipe
rec_ks <- recipe(popularity ~ ., music_train) 

prep_ks <- rec_ks %>% 
  prep() %>% 
  bake(new_data = music_train)

# save kitchen sink recipe
save(rec_ks, prep_ks, file = here("data/rec_ks.rda"))






