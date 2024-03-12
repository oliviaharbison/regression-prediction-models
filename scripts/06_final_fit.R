# Music Popularity Predictor
# Fit final model

# packages
library(tidyverse)
library(tidymodels)
library(here)
set.seed(80)

tidymodels_prefer()
doMC::registerDoMC(cores = parallel::detectCores(logical = TRUE))

# data
load(here("data/music_split.rda"))
load(here("results/rf_tuned.rda"))


# finalize workflow ---
final_wflow <- rf_tuned %>%
  extract_workflow(rf_tuned) %>%  
  finalize_workflow(select_best(rf_tuned, metric = "rmse"))


# train final model ---
final_fit <- fit(final_wflow, music_train)

# save
save(final_fit, file = here("results/final_fit.rda"))


# assess performance ----

final_preds <- music_test %>%
  select(popularity) %>%
  bind_cols(predict(final_fit, music_test))

metrics <- metric_set(rmse, mae, rsq)

final_mets <- metrics(final_preds, truth = popularity, estimate = .pred) %>%
  select(-.estimator,
         Metric = .metric,
         Estimate = .estimate)

# save
save(final_preds, file = here("results/final_preds.rda"))
save(final_mets, file = here("results/final_mets.rda"))


# plot ----
results_plot <- ggplot(final_preds, aes(x = popularity, y = .pred)) +
  geom_abline(lty = 5, color = "blue", linewidth = 1.25) +
  geom_point(alpha = 0.25) +
  labs(y = "Predicted Popularity", x = "Actual Popularity",
       title = "Performance on testing set",
       subtitle = "KS Random Forest Model Predictions vs Truth",
       caption = "Data source: Kaggle") +
  coord_obs_pred() +
  theme_minimal()
results_plot

# save
save(results_plot, file = here("results/results_plot.rda"))


