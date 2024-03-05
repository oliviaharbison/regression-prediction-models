# Music Popularity Predictor
# EDA

# packages
library(tidyverse)
library(tidymodels)
library(here)
library(Hmisc)
library(naniar)
library(splines)

tidymodels_prefer()

# data
load(here("data/music_split.rda"))

data <- music_train %>%
  slice_sample(n = 12475) %>%
  select(-release_date)

histograms <- lapply(data, hist) %>% ggplot()

ggplot(histograms, aes(x = .)) +
  facet_wrap(~ .id, nrow = 1) +
  geom_histogram()

library(patchwork)
# predictors that are not normally distributed: total_tracks, t_dur0, t_dur1, t_dur2, t_speech0, t_speech1, t_speech2, t_live0, t_live1, t_live2, 
h <- function(var){
#  hist(sqrt(1 - var))
#  hist(sqrt(var))
  hist(log(var))
  hist(log(var, base = 10))
#  hist(exp(var))
  hist(var)
}
h(data$total_tracks) #log10
h(data$t_dur0) # log
h(data$t_speech0) #1/x
h(data$t_energy0) #sqrt(1-x)
h(data$t_live0) #log

corrplot::corrplot(cor(na.omit(data)))

hist(log(data$t_energy0, base = .5))

hist(1/(data$t_speech0))

# MISSING DATA:

gg_miss_var(data)

# there is no missing data 

# natural splines
ggplot(data, aes(x = log(t_dur0), y = popularity)) + 
  geom_point(alpha = .2) + 
  geom_smooth(
    method = lm,
    formula = y ~ ns(x, df = 10),
    color = "lightblue",
    se = FALSE
  )


