# Multivariate Analyses ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(palmerpenguins)
library(knitr)

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

ggplot(p_scores, aes(x = Score, y = Turnovers_Category, fill = Player)) +
  geom_boxplot(position = "dodge") +
  labs(title = "Dodged Barplot of Score by Turnovers and Player",
       x = "Score",
       y = "Turnovers",
       fill = "Player")

jscore_time <- ggplot(jordan_scores, aes(x = Date, y = Score)) +
  geom_point() +
  labs(title = "Scatterplot of Score vs. Year for Michael Jordan",
       x = "Year",
       y = "Score") +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

ggsave(
  filename = "plots/jscore_time.png",
  plot = jscore_time,
  units = "in"
)