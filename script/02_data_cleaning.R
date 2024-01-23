#### Preamble ####
# Purpose: Cleans the raw poll data
# Author: Bolin Shen
# Date: 21 January 2024
# Contact: bolin.shen@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Read in raw data ####

# Read in the raw polls data. 
readr::read_csv("input/data/raw_poll_data.csv")

#### Basic cleaning - polls data ####
raw_poll_data <-
  read_csv(
    file = "input/data/raw_poll_data.csv",
    show_col_types = FALSE
  )

# creating a new column to reformat the open date to year only
data_year = as.Date(data$OPEN_DATE, format = "%Y-%m-%d")|> format("%Y")
cleaned_poll_data = raw_poll_data |> mutate(OPEN_DATE_YEAR = data_year)

# creating a new column to store the value of ballots return rate
cleaned_poll_data$ballot_return_rate <- round((cleaned_poll_data$BALLOTS_CAST / cleaned_poll_data$BALLOTS_DISTRIBUTED), 4)
 
# creating a new column to store the value of ballots in favour rate
cleaned_poll_data$ballot_in_favour_rate <- round((cleaned_poll_data$BALLOTS_IN_FAVOUR / (cleaned_poll_data$BALLOTS_OPPOSED + cleaned_poll_data$BALLOTS_IN_FAVOUR)), 4)


# organize name #
cleaned_poll_data <-
  clean_names(cleaned_poll_data)

head(cleaned_poll_data)

# select columns of interest #
cleaned_poll_data <-
  cleaned_poll_data |>
  select(
    application_for,
    open_date_year,
    response_rate_met,
    ballots_cast,
    ballots_distributed,
    poll_result,
    open_date,
    ballot_return_rate,
    ballot_in_favour_rate,
  )

# summarize data
summarized_poll_data <- 
  cleaned_poll_data |> 
  select(
    application_for,
    open_date,
    poll_result
  )


# save cleaned polls data #
write_csv(
  x = cleaned_poll_data,
  file = "input/data/cleaned_poll_data.csv"
)

# save summarized poll data #

write_csv(
  x = summarized_poll_data,
  file = "input/data/summarized_poll_data.csv"
)




