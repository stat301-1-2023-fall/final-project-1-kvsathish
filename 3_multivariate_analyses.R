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

# find scores for all players and categorize turnovers
p_scores <- allgames_stats |> 
  filter(RSorPO == "Regular Season") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  mutate(Turnovers_Category = case_when(
    TOV >= 0 & TOV <= 3 ~ "0-3",
    TOV > 3 & TOV <= 6 ~ "3-6",
    TOV > 6 & TOV <= 9 ~ "6-9",
    TOV > 9 & TOV <= 12 ~ "9-12",
    TRUE ~ "Other"
  ))

# plot turnovers against score by players
tov_scores <- ggplot(p_scores, aes(x = Score, y = Turnovers_Category, fill = Player)) +
  geom_boxplot(position = "dodge") +
  labs(title = "Distributions of Score by Turnovers and Player",
       x = "Score",
       y = "Turnovers",
       fill = "Player") +
  theme_minimal()

# save plot
ggsave(
  filename = "plots/tov_scores.png",
  plot = tov_scores,
  units = "in",
  width = 6
)


## comparing Score and GmSc

# find scores for all players
g_scores <- allgames_stats |> 
  filter(RSorPO == "Regular Season") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000)

# plot the nba gamescore against new score metric by players
gmsc_scores <- ggplot(g_scores, aes(x = Score, y = GmSc, color = Player)) +
  geom_point(alpha = 0.15) +
  labs(title = "Comparison of Score and NBA GameScore Across Players",
       x = "Score",
       y = "GameScore") +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

# save plot
ggsave(
  filename = "plots/gmsc_scores.png",
  plot = gmsc_scores,
  units = "in",
  width = 9,
  height = 6
)


## comparing Score with win totals (success) ----


# see total wins by players
as_summary <- allgames_stats |> 
  group_by(Player) |> 
  summarise(Win_Total = sum(Result == "W", na.rm = TRUE))

kable(as_summary)


# find win total and group score into categories
ag_win <- allgames_stats |> 
  arrange(Date) |> 
  group_by(Player) |> 
  mutate(Win_Total = sum(Result == "W", na.rm = TRUE),
         Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000,
         Score_Category = cut(Score, 
                              breaks = c(0, 1, 2, 3, 4, 5, 6, 7, Inf),
                              labels = c("0-1", "1-2", "2-3", "3-4", "4-5",
                                         "5-6", "6-7", "Other")))

# calculate total wins for each category and player
ag_win_totals <- ag_win |> 
  group_by(Player, Score_Category) |> 
  summarize(Total_Wins = sum(Result == "W", na.rm = TRUE))

# make dodged barplot
wins_score <- ggplot(ag_win_totals, aes(x = Score_Category, y = Total_Wins, fill = Player)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  labs(title = "Total Wins by Score Category and Player",
       x = "Score Category",
       y = "Total Wins") +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal()

# save plot
ggsave(
  filename = "plots/wins_score.png",
  plot = wins_score,
  units = "in",
  width = 6,
  height = 4
)


# finding propotion of wins by score category ----

# calculate total wins for each player
total_wins_by_player <- ag_win |> 
  group_by(Player) |> 
  summarize(Total_Wins = sum(Result == "W", na.rm = TRUE))

# merge 2 datasets for proportion
ag_win_prop <- merge(ag_win_totals, total_wins_by_player, by = "Player") |> 
  mutate(Proportion = Total_Wins.x / Total_Wins.y)

# make dodged barplot
prop_score <- ggplot(ag_win_prop, aes(x = Score_Category, y = Proportion, fill = Player)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  labs(title = "Proportion of Wins by Score and Player",
       x = "Score Category",
       y = "Proportion of Total Wins") +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal()


# save plot
ggsave(
  filename = "plots/prop_score.png",
  plot = prop_score,
  units = "in",
  width = 6,
  height = 4
)



## extra stuff ----

win_totals <- allgames_stats |> 
  filter(RSorPO == "Regular Season", Player == "Kobe Bryant") |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  mutate(Win_Total = sum(Result == "W", na.rm = TRUE)) |> 
  select(Score, Date, Win_Total)

win_totals

ggplot(win_totals, aes(x = Date)) +
  geom_line(aes(y = Score, color = "Score"), size = 1) +
  geom_point(aes(y = Score), color = "black", size = 2, shape = 19) +
  geom_line(aes(y = Win_Total, color = "Win_Total"), size = 1, linetype = "dashed") +
  geom_point(aes(y = Win_Total), color = "black", size = 2, shape = 19) +
  labs(title = "Comparison of Score and Win_Total Across Time",
       x = "Date",
       y = "Count") +
  scale_color_manual(values = c("Score" = "blue", "Win_Total" = "red")) +
  theme_minimal()


ag_win <- allgames_stats |> 
  arrange(Date) |> 
  group_by(Player) |> 
  mutate(Win_Total = sum(Result == "W", na.rm = TRUE)) |> 
  mutate(Score = (PTS + AST + TRB + STL + BLK) / as.numeric(MP) * 10000) |> 
  mutate(Score_Category = case_when(
    Score >= 0 & Score <= 1 ~ "0-1",
    Score > 1 & Score <= 2 ~ "1-2",
    Score > 2 & Score <= 3 ~ "2-3",
    Score > 3 & Score <= 4 ~ "3-4",
    Score > 4 & Score <= 5 ~ "4-5",
    Score > 5 & Score <= 6 ~ "5-6",
    Score > 6 & Score <= 7 ~ "6-7",
    TRUE ~ "Other"
  ))


ggplot(ag_win, aes(x = Score_Category, y = Win_Total, fill = Player)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  labs(title = "Proportion of Wins by Score and Player",
       x = "Score",
       y = "Proportion of Wins") +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal()
