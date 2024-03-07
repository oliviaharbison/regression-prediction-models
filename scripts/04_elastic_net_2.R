# Music Popularity Predictor
# Elastic Net Model

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
elastic_spec <-
  linear_reg(penalty = tune(), 
             mixture = tune()) %>%
  set_engine("glmnet")

# define workflows ----
elastic_workflow <- workflow() %>%
  add_model(elastic_spec) %>%
  add_recipe(rec_2)

# hyperparameter tuning values ----
elastic_params <- extract_parameter_set_dials(elastic_spec)

elastic_grid <- grid_regular(elastic_params, levels = c(penalty = 20,
                                                        mixture = 25))


# fit workflows/models ----
elastic_tuned_2 <- tune_grid(elastic_workflow,
                           music_folds,
                           grid = elastic_grid,
                           control = control_grid(save_workflow = TRUE))

save(elastic_tuned_2, file = here("results/elastic_tuned_2.rda"))

load(here("results/elastic_tuned_2.rda"))
autoplot(elastic_tuned_2)
