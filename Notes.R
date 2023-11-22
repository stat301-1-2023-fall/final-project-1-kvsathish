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

ggplot(kobe_first_year, aes(Score)) +
  geom_boxplot() +
  labs(title = "Distribution of Calculated Score", subtitle = "For Kobe's First Season",
       x = "Score", y = NULL)



ggplot(kobe_first_year, aes(Date, Score)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Calculated Score by Date for Kobe Bryant")

kobe_first_year <- head(kobe_first_year, 10)
kable(kobe_first_year)

kobe_fy_mean <- allgames_stats %>%
  filter(Date >= as.Date("1996-11-03") & Date <= as.Date("1997-04-20")) |> 
  filter(Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  summarize(Mean_Score = mean(Score))

kable(kobe_fy_mean)


