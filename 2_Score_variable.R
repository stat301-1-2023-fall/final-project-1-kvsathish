# Score variable ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(knitr)
library(kableExtra)

## read in data ----
allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

## For progress memo 2 ----

devtools::install_github("abresler/nbastatR")

## Kobe first year ----

# calc score for Kobe's first season
kobe_first_year <- allgames_stats %>%
  filter(Date >= as.Date("1996-11-03") & Date <= as.Date("1997-04-20")) |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

# see distribution of score
kobe_score1 <- ggplot(kobe_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Kobe's First Season",
       x = "Score", y = NULL)

# save plot
ggsave(
  filename = "plots/kobe_score1.png",
  plot = kobe_score1,
  units = "in"
)

# see Kobe's score over time
kobe_sbd1 <- ggplot(kobe_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Kobe Bryant's First Season")

# save plot
ggsave(
  filename = "plots/kobe_sbd1.png",
  plot = kobe_sbd1,
  units = "in"
)

# print scores for first five games
kobe_first_year <- head(kobe_first_year, 5)
kable(kobe_first_year)

# find avg score for first season
kobe_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("1996-11-03") & Date <= as.Date("1997-04-20")) |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

# print it
kable(kobe_fy_mean)

## Lebron first year ----

# find scores for Lebron's first year
lebron_first_year <- allgames_stats %>%
  filter(Date >= as.Date("2003-10-29") & Date <= as.Date("2004-04-14")) |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

# see distribution of scores in first season
lebron_score1 <- ggplot(lebron_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Lebron's First Season",
       x = "Score", y = NULL)

# save plot
ggsave(
  filename = "plots/lebron_score1.png",
  plot = lebron_score1,
  units = "in"
)

# see how Lebron's score changes during first season
lebron_sbd1 <- ggplot(lebron_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Lebron James' First Season")

# save plot
ggsave(
  filename = "plots/lebron_sbd1.png",
  plot = lebron_sbd1,
  units = "in"
)

# print scores for first five games
lebron_first_year <- head(lebron_first_year, 5)
kable(lebron_first_year)

# find the average score for first season
lebron_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("2003-10-29") & Date <= as.Date("2004-04-14")) |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

# print it
kable(lebron_fy_mean)

## Jordan first year ----

# find the scores for Jordan's first season
jordan_first_year <- allgames_stats %>%
  filter(Date >= as.Date("1984-10-26") & Date <= as.Date("1985-04-13")) |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

# see the distribution of scores 
jordan_score1 <- ggplot(jordan_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Jordan's First Season",
       x = "Score", y = NULL)

# save plot
ggsave(
  filename = "plots/jordan_score1.png",
  plot = jordan_score1,
  units = "in"
)

# see how Jordan's scores change over first season
jordan_sbd1 <- ggplot(jordan_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Michael Jordan's First Season")

# save plot
ggsave(
  filename = "plots/jordan_sbd1.png",
  plot = jordan_sbd1,
  width = 5,
  units = "in"
)

# print scores for first five games
jordan_first_year <- head(jordan_first_year, 5)
kable(jordan_first_year)

# find the average score for first season
jordan_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("1984-10-26") & Date <= as.Date("1985-04-13")) |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

# print it
kable(jordan_fy_mean)

## bivariate analyses ----

# jordan analysis ----

# find scores for all games played by Jordan
jordan_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

# plot the scores against duration of career
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

# lebron analysis ----

# find scores for all games played by Lebron
lebron_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

# plot the scores against duration of career
lscore_time <- ggplot(lebron_scores, aes(x = Date, y = Score)) +
  geom_point() +
  labs(title = "Scatterplot of Score vs. Year for Lebron James",
       x = "Year",
       y = "Score") +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

# save plot
ggsave(
  filename = "plots/lscore_time.png",
  plot = lscore_time,
  units = "in"
)

# kobe analysis ----

# find scores for all games played by Kobe
kobe_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

# plot the scores against duration of career
ggplot(kobe_scores, aes(x = Date, y = Score)) +
  geom_bin2d(bins = 20, aes(fill = ..count..), color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +  # Adjust color gradient
  labs(title = "Heatmap of X vs. Y",
       x = "X",
       y = "Y")

kscore_time <- ggplot(kobe_scores, aes(x = Date, y = Score)) +
  geom_point() +
  labs(title = "Scatterplot of Score vs. Year for Kobe Bryant",
       x = "Year",
       y = "Score") +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

ggplot(kobe_scores, aes(x = Date, y = Score)) +
  geom_point() +
  labs(title = "Scatterplot of Score vs. Year for Kobe Bryant",
       x = "Year",
       y = "Score") +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

# save plot
ggsave(
  filename = "plots/kscore_time.png",
  plot = kscore_time,
  units = "in"
)






