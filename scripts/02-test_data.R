#### Preamble ####
# Purpose: Tests majors and wages data
# Author: Diana
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: downloaded and cleaned ACS Econ data

#### Workspace setup ####
library(tidyverse)

#### Test data ####
load("/cloud/project/outputs/Data/ACS_Data_UCSCEcon_Cleaned.Rda")
cleaned_data$WAGE_INCOME|> min() >= 0
cleaned_data$WAGE_INCOME|> max() <= 1000000
cleaned_data$YEAR|> min() >= "2009"
cleaned_data$AGE |> min() >= 0
