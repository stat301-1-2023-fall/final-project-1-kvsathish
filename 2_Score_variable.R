


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


## MORE Notes for final project

# look at how production changes in the postseason (still producing in a high rate)

# quality of team making the playoff

# analyze pts and stats uniquely before the EDA - see if they correlate with each other in any way
# make sure to weigh the variables uniquely
# wins should matter - incorporate it somehow (if team crumbles when they're playing bad)
# analyze games won to games lost
# standardize scores by using z score - avg pts for a year is 18 (divide by and find spread)
# standardize it - do it for every year
# z scores for each year should be standardized 
# score metric will likely look the same in each year - play at least 5 min per game to be considered
# relative to the rest of league, how much better are they?
# get season averages and standard deviation for calculations (be careful about players - make 10 min minimum and at least 10 games)
# 

# do univariate analysis of each variable for the score metric separately - compare to win totals and see if that team is in playoff contention (how good the team was)
# maybe join to see playoff vs. nonplayoff teams
# decide on the score metric and analyze relationship with the other variables
# analyze compared to wins/losses
# break down the playoff games too to evaluate postseason
# expected to have appendix when there's an abundance of analyses - put the not so cool one in the appendix section
# make a good narrative about score and analyzing each component - try the launchpads and ones that bear fruit 
# compare scores to other variables and go from there 
# see how score correlates to turnovers (how adjustment changes score)
# compare to the NBA game score metric
# multivariate - (when, score, turnovers)
# talk about how u came up with score (explain why u picked them) - these are the most important stats that contribute to winning
# five year phases of the career (all started young - after 5 years of experience)
# have a good number of bivariate/multivariate analyses (splitting season/postseason wins / splitting players into phases)



