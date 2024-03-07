# Music Popularity Predictor
# Boosted Tree Model

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()
doMC::registerDoMC(cores = parallel::detectCores(logical = TRUE))

# data
load(here("data/music_split.rda"))
load(here("data/rec_ks_tree.rda"))

# model specifications ----
bt_spec <-
  boost_tree(
    mode = "regression",
    engine = "xgboost",
    mtry = tune(),
    min_n = tune(),
    learn_rate = tune()
  )

# define workflows ----
bt_workflow <- workflow() %>%
  add_model(bt_spec) %>%
  add_recipe(rec_ks_tree)

# hyperparameter tuning values ----
bt_params <- extract_parameter_set_dials(bt_spec) %>%
  update(mtry = mtry(range = c(1, 33)),
         learn_rate = learn_rate(range = c(-10, 5)))

bt_grid <- grid_regular(bt_params, levels = 15)


# fit workflows/models ----
bt_tuned <- tune_grid(bt_workflow,
                      music_folds,
                      grid = bt_grid,
                      control = control_grid(save_workflow = TRUE))

save(bt_tuned, file = here("results/bt_tuned.rda"))
