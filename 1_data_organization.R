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

# create a summary table of steals per player
stl_by_player <- allgames_stats %>%
  group_by(Player) %>%
  summarise(mean_steals = mean(STL, na.rm = TRUE),
            min_steals = min(STL, na.rm = TRUE),
            max_steals = max(STL, na.rm = TRUE),
            total_steals = sum(STL, na.rm = TRUE))
kable(stl_by_player)

# extra steals stuff
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

# create a summary table of blocks by player
blk_by_player <- allgames_stats %>%
  group_by(Player) %>%
  summarise(mean_blocks = mean(BLK, na.rm = TRUE),
            min_blocks = min(BLK, na.rm = TRUE),
            max_blocks = max(BLK, na.rm = TRUE),
            total_blocks = sum(BLK, na.rm = TRUE))
kable(blk_by_player)

# extra blocks stuff
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

