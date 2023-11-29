# Data Organization ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(palmerpenguins)
library(knitr)

## read in data ----
allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

## evaluate variables and missingness in data ----
class_count <- sapply(allgames_stats, class)
num_categorical <- sum(class_count %in% c("factor", "character"))

cat("Number of categorical variables:", num_categorical)

allgames_stats |> 
  naniar::miss_var_summary() |> 
  print(n = 29)

## create a codebook for the data ----

# done in a new text file saved in data folder

## univariate analyses ----


