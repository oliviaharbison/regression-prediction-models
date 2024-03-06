# Music Popularity Predictor
# Logistic Model

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()
doMC::registerDoMC(cores = parallel::detectCores(logical = TRUE))

# data
load(here("data/music_split.rda"))
load(here("data/rec_2.rda"))


### model specifications ---
lm_spec <- 
  linear_reg() %>%
  set_engine("lm")

### define workflows ---
lm_wflow <- workflow() %>%
  add_model(lm_spec) %>%
  add_recipe(rec_2)

### fit workflows/models ---
lm_fit_2 <- fit_resamples(lm_wflow, 
                        resamples = music_folds)

### write out results (fitted/trained workflows) ---
save(lm_fit_2, file = here("results/lm_fit_2.rda"))

