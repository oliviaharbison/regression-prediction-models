# Music Popularity Predictor
# Assessment Metrics

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
load(here("results/null_fit_2.rda"))
load(here("results/lm_fit.rda"))
load(here("results/lm_fit_2.rda"))
load(here("results/bt_tuned.rda"))
load(here("results/bt_tuned_2.rda"))
load(here("results/elastic_tuned.rda"))
load(here("results/elastic_tuned_2.rda"))
load(here("results/knn_tuned.rda"))
load(here("results/knn_tuned_2.rda"))
load(here("results/rf_tuned.rda"))
load(here("results/rf_tuned_2.rda"))


## Null Model ----
null_mets <- collect_metrics(null_fit)
null_mets_2 <- collect_metrics(null_fit_2)


## Logistic Model ----
lm_mets <- collect_metrics(lm_fit)
lm_mets_2 <- collect_metrics(lm_fit_2)


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


## KNN Model
knn_mets <- collect_metrics(knn_tuned) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)
knn_mets_2 <- collect_metrics(knn_tuned_2) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)


## Random Forest Model
rf_mets <- collect_metrics(rf_tuned) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)
rf_mets_2 <- collect_metrics(rf_tuned_2) %>%
  filter(.metric == "rmse") %>%
  slice_min(mean)


## Combined Table ----

rmse_table <- tibble(
  Model = c(
    "KS Null",
    "Adv Rec Null",
    "KS Linear",
    "Adv Rec Linear",
    "KS Boosted Tree",
    "Adv Rec Boosted Tree",
    "KS Elastic Net",
    "Adv Rec Elastic Net",
    "KS KNN", 
    "Adv Rec KNN",
    "KS Random Forest",
    "Adv Rec Random Forest"
  ),
  RMSE = c(
    null_mets %>% filter(.metric == "rmse") %>% pull(mean),
    null_mets_2 %>% filter(.metric == "rmse") %>% pull(mean),
    lm_mets %>% filter(.metric == "rmse") %>% pull(mean),
    lm_mets_2 %>% filter(.metric == "rmse") %>% pull(mean),
    bt_mets %>% pull(mean),
    bt_mets_2 %>% pull(mean),
    elastic_mets %>% pull(mean),
    elastic_mets_2 %>% pull(mean),
    knn_mets %>% pull(mean),
    knn_mets_2 %>% pull(mean),
    rf_mets %>% pull(mean),
    rf_mets_2 %>% pull(mean)
  )
)


# save
save(rmse_table, file = here("results/rmse_table.rda"))





