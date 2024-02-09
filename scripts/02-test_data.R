#### Preamble ####
# Purpose: Tests majors and wages data
# Author: Diana
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: downloaded and cleaned UCSC student data

#### Workspace setup ####
library(tidyverse)

#### Test data ####
load("/cloud/project/outputs/Data/Majors_Income_Cleaned.Rda")
cleaned_majors_data$INCWAGE|> min() >= 0
cleaned_majors_data$INCWAGE|> max() <= 10000000
cleaned_majors_data$YEAR|> min() >= "2009"
cleaned_majors_data$YEAR |> max() <= "2018"
cleaned_majors_data$Industry |> class() =="character"
