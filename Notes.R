library(tidyverse)
library(naniar)
library(knitr)

allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

class_count <- sapply(allgames_stats, class)
num_categorical <- sum(class_count %in% c("factor", "character"))

cat("Number of categorical variables:", num_categorical)

allgames_stats |> 
  naniar::miss_var_summary() |> 
  print(n = 29)

## Progress Memo 2 ----

devtools::install_github("abresler/nbastatR")
