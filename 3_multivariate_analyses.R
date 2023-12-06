# Multivariate Analyses ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(knitr)
library(lubridate)

## read in data ----
allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

## comparing Score and TOs ----

p_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  mutate(Turnovers_Category = case_when(
    TOV >= 0 & TOV <= 3 ~ "0-3",
    TOV > 3 & TOV <= 6 ~ "3-6",
    TOV > 6 & TOV <= 9 ~ "6-9",
    TOV > 9 & TOV <= 12 ~ "9-12",
    TRUE ~ "Other"
  ))

tov_scores <- ggplot(p_scores, aes(x = Score, y = Turnovers_Category, fill = Player)) +
  geom_boxplot(position = "dodge") +
  labs(title = "Dodged Boxplots of Score by Turnovers and Player",
       x = "Score",
       y = "Turnovers",
       fill = "Player")


ggsave(
  filename = "plots/tov_scores.png",
  plot = tov_scores,
  units = "in"
)
