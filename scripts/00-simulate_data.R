#### Preamble ####
# Purpose: Simulates wages of different majors
# Author: Diana Liu
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: none


#### Workspace setup ####
#install.packages("tidyverse")
#install.packages("dplyr")
#install.packages("truncnorm")
library(tidyverse)
library(dplyr)
library(truncnorm)

#### Simulate data ####
set.seed(123)

Industries <- c("Agriculture", "Mining", "Utilities", "Construction", 
                "Manufacturing", "Wholesale Trade", "Retail Trade", "Transportation", 
                "Information", "FIRE", "Rental/Leasing", "Professional Services", 
                "Management Firms", "Admin. Support", "Education", 
                "Healthcare and Social Assist.", "Arts and Entertainment", 
                "Accomodation and Food", "Other Services", "Public Administration")

arts_majors <- tibble(
  Salary = rtruncnorm(n = 4000, a = 0, b = 200000, mean = 45000, sd = 20000),
  Industry = sample(x = Industries, 4000, replace = T)
)

business_majors <- tibble(
  Salary = rtruncnorm(n = 4000, a = 0, b = 200000, mean = 50000, sd = 20000),
  Industry = sample(x = Industries, 4000, replace = T)
)

science_majors <- tibble(
  Salary = rtruncnorm(n = 4000, a = 0, b = 200000, mean = 55000, sd = 20000),
  Industry = sample(x = Industries, 4000, replace = T)
)

applied_science_majors <- tibble(
  Salary = rtruncnorm(n = 4000, a = 0, b = 200000, mean = 60000, sd = 20000),
  Industry = sample(x = Industries, 4000, replace = T)
)

head(arts_majors)
head(business_majors)
head(science_majors)
head(applied_science_majors)



