# Music Popularity Predictor
# Baseline Model

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()
doMC::registerDoMC(cores = parallel::detectCores(logical = TRUE))

# data
load(here("data/music_split.rda"))
load(here("data/rec_ks.rda"))

# model specs

null_spec <- null_model() %>% 
  set_engine("parsnip") %>% 
  set_mode("regression") 


# model workflow

null_workflow <- workflow() %>% 
  add_model(null_spec) %>% 
  add_recipe(rec_ks)


# model fit

null_fit <- null_workflow |> 
  fit_resamples(
    resamples = music_folds, 
    control = control_resamples(save_workflow = TRUE)
  )


# save
#save(null_fit, file = here("results/null_fit.rda"))


