# Data Organization ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(palmerpenguins)
library(knitr)
library(lubridate)

## read in data ----
allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

view(allgames_stats)

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

# create a density plot for points
points_dist <- ggplot(allgames_stats, aes(x = PTS, fill = Player)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Distribution of Points in Respective Careers",
       x = "Points (PTS)",
       y = "Density") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/points_dist.png",
  plot = points_dist,
  units = "in"
)

# create a density plot for assists
assists_dist <- ggplot(allgames_stats, aes(x = AST, fill = Player)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Distribution of Assists in Respective Careers",
       x = "Assists (AST)",
       y = "Density") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/assists_dist.png",
  plot = assists_dist,
  units = "in"
)

# create a density plot for total rebounds
rebounds_dist <- ggplot(allgames_stats, aes(x = TRB, fill = Player)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Distribution of Rebounds in Respective Careers",
       x = "Rebounds (TRB)",
       y = "Density") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/rebounds_dist.png",
  plot = rebounds_dist,
  units = "in"
)

# create a density plot for steals
steals_dist <- ggplot(allgames_stats, aes(x = STL, fill = Player)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Distribution of Steals in Respective Careers",
       x = "Steals (STL)",
       y = "Density") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/steals_dist.png",
  plot = steals_dist,
  units = "in"
)

# create a density plot for blocks
blocks_dist <- ggplot(allgames_stats, aes(x = BLK, fill = Player)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Distribution of Blocks in Respective Careers",
       x = "Blocks (BLK)",
       y = "Density") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/blocks_dist.png",
  plot = blocks_dist,
  units = "in"
)

# create a histogram for minutes played
allgames_stats_min <- allgames_stats %>%
  mutate(MP_minutes = as.numeric(substring(MP, 1, 2)))

mp_dist <- ggplot(allgames_stats_min, aes(x = MP_minutes)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "darkblue", alpha = 0.7) +
  labs(title = "Histogram of Minutes Played", x = "Minutes Played", y = "Frequency") +
  theme_minimal()

# save the plot
ggsave(
  filename = "plots/mp_dist.png",
  plot = mp_dist,
  units = "in"
)

