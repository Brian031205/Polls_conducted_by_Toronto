#### Preamble ####
# Purpose: Simulate the dataset of polls conducted by the city of Toronto
# Author: Bolin Shen
# Date: 21 January 2024
# Contact: bolin.shen@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Start simulation ####

sim_application = c("Application_1", "Application_2", "Application_3", "Application_4")
sim_num_voter = c(100, 150, 200, 400)
sim_response_rate_met = c("Yes", "No")
sim_poll_result = c("In Favour", "Opposed", "Response Rate Not Met")

prob_application = sim_num_voter / sum(sim_num_voter)
prob_response_rate_met = c(0.5, 0.5)
prob_poll_result = c(0.4, 0.4, 0.2)

## Creating simulated data

set.seed(300) #random seed
num_observations = 100

simulated_data = 
  tibble(
    application = sample(x = sim_application, 
                      size = num_observations,
                      replace = TRUE,
                      prob = prob_application),
    response_rate_met = sample(x = sim_response_rate_met,
                  size = num_observations,
                  replace = TRUE,
                  prob = prob_response_rate_met),
    poll_result = sample(x = sim_poll_result,
                         size = num_observations,
                         replace = TRUE,
                         prob = prob_poll_result)
  )

# bar plot
simulated_data |> 
  ggplot(aes(fill = response_rate_met, x = application)) +
  geom_bar(position = "dodge") + ylab("Number of polls")

# bar plot
simulated_data |> 
  ggplot(aes(fill = poll_result, x = application)) +
  geom_bar(position = "dodge") + ylab("Number of polls")



# check 4 applications in the data 
length(unique(simulated_data$application)) == 4

# check 2 answers in response rate met
length(unique(simulated_data$response_rate_met)) == 2

# check 3 results in poll result
length(unique(simulated_data$poll_result)) == 3


