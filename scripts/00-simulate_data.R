#### Preamble ####
# Purpose: Simulates wages of different majors
# Author: Diana Liu
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: none


#### Workspace setup ####
#install.packages("tidyverse")
#install.packages("dplyr")
library(tidyverse)
library(dplyr)

#### Simulate data ####
set.seed(123)


population <- tibble(
  Major = sample(x = c("Arts", "Sciences", "Business", "Applied Science"), size = 4000, replace = T),
  Salary = rnorm(4000, mean = 45000, sd = 20000)
)

head(population)


