# Music Popularity Predictor
# K Nearest Neighbors Model

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

# model specifications ----
knn_spec <- nearest_neighbor(mode = "regression", neighbors = tune()) %>%
  set_engine("kknn")

# define workflows ----
knn_workflow <- workflow() %>%
  add_model(knn_spec) %>%
  add_recipe(rec_2)

# hyperparameter tuning values ----
knn_params <- extract_parameter_set_dials(knn_spec) 

knn_grid <- grid_regular(knn_params, levels = 9)

# fit workflows/models ----
knn_tuned_2 <- tune_grid(knn_workflow,
                       music_folds,
                       grid = knn_grid,
                       control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(knn_tuned_2, file = here("results/knn_tuned_2.rda"))
