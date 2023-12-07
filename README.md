## The Greatest Basketball Player of All Time: An EDA

This repository is for an analysis of data collected on the greatest basketball player of all time between Michael Jordan, Lebron James, and Kobe Bryant


## What's in the repo
This repo contains an in-depth analysis of the `allgames_stats` dataset to deduce who is the greatest basketball player of all time. All the work is organized as below: 

- `data/`: can find the cleaned `allgames_stats` dataset that is used for analysis as well as a separate codebook that describes every single variable involved in the dataset
- `.gitignore`: no large files stored here
- `plots`: contains 19 saved plots that represent visual represenations of the dataset for further analysis


### R scripts

- `1_data_organization`: can find necessary packages to be loaded, read in data, a brief analysis of missingness, and an exploration of all the variables contributing to the new `Score` metric (univariate analyses)
- `2_score_variable`: can find the Score metric was calculations, the calculated average Score in each season, and bivariate analyses that reveal how the Score changed over time for each player
- `3_multivariate_analyses`: can find the construction of plots that compare the new Score metric to turnovers, NBA GameScore, and win totals all across the three players
- `4_more_notes`: can find extra notes detailing the planning and extrapolation of analyses

### QMDs

These are the final representations of my data analysis, including two progress memos, a final report, and an executive summary.

## References

The dataset for analysis is named `Michael Jordan, Kobe Bryant and Lebron James stats`.
- Found on [https://www.kaggle.com/datasets/xvivancos/michael-jordan-kobe-bryant-and-lebron-james-stats/data?select=per_game_stats.csv](https://www.kaggle.com/datasets/xvivancos/michael-jordan-kobe-bryant-and-lebron-james-stats/data?select=per_game_stats.csv)

Although all the stats were compiled by Xavier, the raw statistical data is from Basketball Reference.
- Found on [https://www.basketball-reference.com/](https://www.basketball-reference.com/)  

