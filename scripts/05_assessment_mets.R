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
load(here("results/bt_tuned.rda"))
load(here("results/bt_tuned_2.rda"))
load(here("results/elastic_tuned.rda"))
load(here("results/elastic_tuned_2.rda"))

## Null Model ----
null_mets <- collect_metrics(null_fit)


## Logistic Model ----
lm_mets <- collect_metrics(lm_fit)


## Boosted Tree Model
bt_mets <- collect_metrics(bt_tuned) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)
bt_mets_2 <- collect_metrics(bt_tuned_2) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)


## Elastic Net Model
elastic_mets <- collect_metrics(elastic_tuned) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)
elastic_mets_2 <- collect_metrics(elastic_tuned_2) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)


## Combined Table ----

rmse_tbl <- tibble(
  Model = c("Null", "Linear", "KS Boosted Tree", "Adv Rec Boosted Tree", "KS Elastic Net", "Adv Rec Elastic Net"),
  RMSE = c(null_mets %>% filter(.metric == "rmse") %>% pull(mean), 
           lm_mets %>% filter(.metric == "rmse") %>% pull(mean),
           bt_mets %>% pull(mean),
           bt_mets_2 %>% pull(mean),
           elastic_mets %>% pull(mean),
           elastic_mets_2 %>% pull(mean))
)

# save
save(rmse_tbl, file = here("results/rmse_tbl.rda"))





