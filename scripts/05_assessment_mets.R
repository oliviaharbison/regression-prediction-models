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
load(here("results/null_fit.rda"))
load(here("results/lm_fit.rda"))


## Null Model ----
null_mets <- collect_metrics(null_fit)


## Logistic Model ----
lm_mets <- collect_metrics(lm_fit)


## Combined Table ----

rmse_tbl <- tibble(
  Model = c("Null", "Logistic"),
  RMSE = c(null_mets %>% filter(.metric == "rmse") %>% pull(mean), lm_mets %>% filter(.metric == "rmse") %>% pull(mean))
)

# save
save(rmse_tbl, file = here("results/rmse_tbl.rda"))





