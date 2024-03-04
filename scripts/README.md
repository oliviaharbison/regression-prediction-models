## Music Popularity Predictor -- Scripts Folder


## Files
- `01_data_input.R`: Contains the initial loading of data and limiting to the correct decade along with quality check and target variable examination.
- `02_data_split.R`: Contains the split of the data into training and testing sets and v fold cross validation set up.
- `03_recipes.R`: Contains the recipes used in the models below.
- `04_baseline.R`: Contains the specifications, workflow, any necessary tuning, and fit for the baseline model. 
- `04_bt.R`: Contains the specifications, workflow, any necessary tuning, and fit for the boosted tree model. 
- `04_elastic_net.R`: Contains the specifications, workflow, any necessary tuning, and fit for the elastic net model. 
- `04_knn.R`: Contains the specifications, workflow, any necessary tuning, and fit for the K nearest neighbors model.
- `04_lm.R`: Contains the specifications, workflow, any necessary tuning, and fit for the linear model. 
- `04_rf.R`: Contains the specifications, workflow, any necessary tuning, and fit for the random forest model. 
- `05_assessment_mets.R`: Contains the assessment metrics for each of the models above.
