## Music Popularity Predictor - Results Folder


## Files
- `null_fit.rda`: Fit for the null model with the kitchen sink recipe
- `null_fit_2.rda`: Fit for the null model with the advanced recipe
- `lm_fit.rda`: Fit for the linear model with the kitchen sink recipe
- `lm_fit_2.rda`: Fit for the linear model with the advanced recipe
- `bt_tuned.rda`: Fit and tuning for the boosted tree model with the kitchen sink recipe
- `bt_tuned_2.rda`: Fit and tuning for the boosted tree model with the advanced recipe
- `elastic_tuned.rda`: Fit and tuning for the elastic net model with the kitchen sink recipe
- `elastic_tuned_2.rda`: Fit and tuning for the elastic net model with the advanced recipe
- `knn_tuned.rda`: Fit and tuning for the knn model with the kitchen sink recipe
- `knn_tuned_2.rda`: Fit and tuning for the knn model with the advanced recipe
- `rf_tuned.rda`: Fit and tuning for the random forest model with the kitchen sink recipe
- `rf_tuned_2.rda`: Fit and tuning for the random forest model with the advanced recipe
- `rmse_table.rda`: RMSE values for all of the models above to decide which is best
- `final_fit.rda`: Fit for the selected best model (random forest KS)
- `final_mets.rda`: Assessment metrics for the selected best model (random forest KS)
- `final_preds.rda`: Prediction outcomes for the selected best model (random forest KS)
- `results_plot.rda`: Plot of predicted popularity vs actual popularity for selected best model