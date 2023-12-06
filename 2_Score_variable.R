# Score variable ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(knitr)
library(kableExtra)

## read in data ----
allgames_stats <- read_csv("data/allgames_stats.csv")

allgames_stats

## Progress Memo 2 ----

devtools::install_github("abresler/nbastatR")

## Kobe first year ----
kobe_first_year <- allgames_stats %>%
  filter(Date >= as.Date("1996-11-03") & Date <= as.Date("1997-04-20")) |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

kobe_score1 <- ggplot(kobe_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Kobe's First Season",
       x = "Score", y = NULL)

ggsave(
  filename = "plots/kobe_score1.png",
  plot = kobe_score1,
  units = "in"
)

kobe_sbd1 <- ggplot(kobe_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Kobe Bryant's First Season")

ggsave(
  filename = "plots/kobe_sbd1.png",
  plot = kobe_sbd1,
  units = "in"
)

kobe_first_year <- head(kobe_first_year, 5)
kable(kobe_first_year)

kobe_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("1996-11-03") & Date <= as.Date("1997-04-20")) |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

kable(kobe_fy_mean)

## Lebron first year ----
lebron_first_year <- allgames_stats %>%
  filter(Date >= as.Date("2003-10-29") & Date <= as.Date("2004-04-14")) |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

lebron_score1 <- ggplot(lebron_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Lebron's First Season",
       x = "Score", y = NULL)

ggsave(
  filename = "plots/lebron_score1.png",
  plot = lebron_score1,
  units = "in"
)

lebron_sbd1 <- ggplot(lebron_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Lebron James' First Season")

ggsave(
  filename = "plots/lebron_sbd1.png",
  plot = lebron_sbd1,
  units = "in"
)

lebron_first_year <- head(lebron_first_year, 5)
kable(lebron_first_year)

lebron_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("2003-10-29") & Date <= as.Date("2004-04-14")) |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

kable(lebron_fy_mean)

## Jordan first year ----
jordan_first_year <- allgames_stats %>%
  filter(Date >= as.Date("1984-10-26") & Date <= as.Date("1985-04-13")) |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  select(Player, Date, Score) 

jordan_score1 <- ggplot(jordan_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Jordan's First Season",
       x = "Score", y = NULL)

ggsave(
  filename = "plots/jordan_score1.png",
  plot = jordan_score1,
  units = "in"
)

jordan_sbd1 <- ggplot(jordan_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score Over Michael Jordan's First Season")

ggsave(
  filename = "plots/jordan_sbd1.png",
  plot = jordan_sbd1,
  width = 5,
  units = "in"
)

jordan_first_year <- head(jordan_first_year, 5)
kable(jordan_first_year)

jordan_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("1984-10-26") & Date <= as.Date("1985-04-13")) |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

kable(jordan_fy_mean)

## bivariate analyses ----

# jordan analysis
jordan_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Michael Jordan") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

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

# lebron analysis
lebron_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Lebron James") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

lscore_time <- ggplot(lebron_scores, aes(x = Date, y = Score)) +
  geom_point() +
  labs(title = "Scatterplot of Score vs. Year for Lebron James",
       x = "Year",
       y = "Score") +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

ggsave(
  filename = "plots/lscore_time.png",
  plot = lscore_time,
  units = "in"
)

# kobe analysis
kobe_scores <- allgames_stats %>%
  filter(RSorPO == "Regular Season") |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

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

ggsave(
  filename = "plots/kscore_time.png",
  plot = kscore_time,
  units = "in"
)






