## Datasets for GOAT Analysis

## What's in the data file

- `allgames_stats_codebook.csv`: reveals all the variables involved in the manipulated dataset and what they mean
- `allgames_stats`: represents the cleaned, saved dataset for effective analysis
- `raw`: can find both the untouched `allgames_stats_raw` dataset and the `totals_stats_raw` dataset in this folder


## allgames_stats dataset description

### Data Overview and Quality

The `allgames_stats` dataset is approximately 533 KB in size, and it is sufficiently complex for my analysis.

#### Analyzing the data

In the dataset, there are 29 total variables and 4,254 total observations. Moreover, there are 6 categorical variables as well as 23 numerical variables. In terms of missingness, there is an issue for home games vs. away games. 

#### Issues in the data

In this dataset, home games are represented with `NA` values for the `X` variable. Also, some of the statistical percentages reflect `NA` values because zero attempts were made. This is often indicative of players missing a game due to injury or extenuating circumstanace. Another issue of missingness arises with the absence of GameScore values for Michael Jordan because it was a relatively new statistic during his early career. Sometimes, `NA` values would appear because some advanced statistics were not accounted for. Finally, an issue arises very rarely with the absence of a regular statistic like `Steals`. However, there is under a 0.260% rate of absence for values in similar variables.

#### Cleaning the data

First, the `NA` values that indicated home vs. away games were inconsequential for my data analysis, so I ignored them. For statistical percentages, I also ignored `NA` values present because my analysis of player performance and output ignored efficiency statistics like percentage of field goals made. Instead, I am accounting for the `NA` values indicative of missed games and missing statistical percentages by utilizing `MP` or total minutes played in each game. This overcomes the absence of some values by narrowing the analysis to when each player was actively on the court. In order to use minutes played in the calculation of my score metric, I made sure to conver the `MP` variable from `difftime` type to a numeric type for effective manipulation of the corresponding data. The absence of GameScore values and regular statistical observations led to the removal of these minimal observations to clean out rare irregularities in the dataset for analysis.

## References

The dataset for analysis is named `Michael Jordan, Kobe Bryant and Lebron James stats`.
- Found on [https://www.kaggle.com/datasets/xvivancos/michael-jordan-kobe-bryant-and-lebron-james-stats/data?select=per_game_stats.csv](https://www.kaggle.com/datasets/xvivancos/michael-jordan-kobe-bryant-and-lebron-james-stats/data?select=per_game_stats.csv)
Although all the stats were compiled by Xavier, the raw statistical data is from Basketball Reference.
- Found on [https://www.basketball-reference.com/](https://www.basketball-reference.com/) 
