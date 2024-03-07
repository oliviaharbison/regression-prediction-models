# Music Popularity Predictor
# Random Forest Model

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()
doMC::registerDoMC(cores = parallel::detectCores(logical = TRUE))

# data
load(here("data/music_split.rda"))
load(here("data/rec_2_tree.rda"))

# model specifications ----
rf_spec <-
  rand_forest(
    mode = "regression",
    trees = 1000,
    min_n = tune(),
    mtry = tune()
  ) %>%
  set_engine("ranger")

# define workflows ----
rf_workflow <- workflow() %>%
  add_model(rf_spec) %>%
  add_recipe(rec_2_tree)

# hyperparameter tuning values ----
rf_params <- extract_parameter_set_dials(rf_spec) %>%
  update(mtry = mtry(range = c(1, 10)))

rf_grid <- grid_regular(rf_params, levels = 13)


# fit workflows/models ----
rf_tuned <- tune_grid(rf_workflow,
                      music_folds,
                      grid = rf_grid,
                      control = control_grid(save_workflow = TRUE))


# write out results (fitted/trained workflows) ----
save(rf_tuned, file = here("results/rf_tuned.rda"))
