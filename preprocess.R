# preprocess NFL game-by-game data
# fall 2019
# Megan Reilly

# setup and load libraries
library(tidyverse)
library(janitor)

# read the data from CSV
# source: https://data.fivethirtyeight.com/#nfl-elo
data = read.csv('nfl-elo/nfl_elo.csv')

# select necessary columns
# filter pre-super bowl era games (these lack necessary fields)
# add columns to find the winner and identify underdog games
data = data %>%
    select( 
        date, 
        season, 
        team1, 
        team2, 
        elo_prob1, 
        elo_prob2, 
        score1, 
        score2, 
        playoff
        ) %>%
    filter(season >= 1968) %>%
    mutate(
        winner = ifelse(
            score1 > score2, as.character(team1),
            ifelse(
                score1 < score2, as.character(team2),
                'TIE'
            )
        ),
        underdog = (abs(elo_prob1 - elo_prob2) > 0.5)
    )
2