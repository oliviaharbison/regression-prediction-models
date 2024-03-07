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


# finalize workflow ---
final_wflow <- bt_tuned %>%
  extract_workflow(bt_tuned) %>%  
  finalize_workflow(select_best(bt_tuned, metric = "rmse"))

# train final model ---
final_fit <- fit(final_wflow, car_train)

# save
save(final_fit, file = here("results/final_fit.rda"))


#After fitting/training the best model in the last task, assess the model's 
#performance on the test set

final_preds <- car_test %>%
  select(sales) %>%
  bind_cols(predict(final_fit, car_test))

metrics <- metric_set(rmse, mae, rsq)

final_mets <- metrics(final_preds, truth = sales, estimate = .pred)

# save
save(final_mets, file = here("results/final_mets.rda"))

# task 12 ----
plot <- ggplot(final_preds, aes(x = sales, y = .pred)) +
  geom_abline(lty = 2) +
  geom_point(alpha = 0.7) +
  labs(y = "Predicted Sales", x = "Sales") +
  coord_obs_pred() +
  theme_minimal()

# save
save(plot, file = here("results/plot.rda"))





