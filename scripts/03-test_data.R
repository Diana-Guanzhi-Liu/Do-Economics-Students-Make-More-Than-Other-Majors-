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

# Tests if industries in cleaned data are in the list of NAICS indstries
correct_industries <-
  c("Agriculture", "Mining", "Utilities", "Construction", 
    "Manufacturing", "Wholesale Trade", "Retail Trade", "Transportation", 
    "Information", "FIRE", "Rental/Leasing", "Professional Services", 
    "Management Firms", "Admin. Support", "Education", 
    "Healthcare and Social Assist.", "Arts and Entertainment", 
    "Accomodation and Food", "Other Services", "Public Administration")
if (all(cleaned_majors_data$Industry |>
        unique() %in% correct_industries)) {
  "The cleaned industries match the expected industries"
} else {
  "Not all of the industries have been cleaned completely"
}

# Tests if industries in cleaned data are characters
if (all(cleaned_majors_data$Industry |>
        unique() %>% class() == "character")) {
  "The cleaned industries are the correct class"
} else {
  "Not all of the industries have been cleaned completely"
}

# Tests if income in cleaned data are all positive
if (all(cleaned_majors_data$INCWAGE |>
        unique() >= 0)) {
  "The cleaned income has no negative numbers"
} else {
  "Not all of the income have been cleaned completely"
}

# Tests if income in cleaned data are numeric
if (all(cleaned_majors_data$INCWAGE |>
        unique() %>% class() == "numeric")) {
  "The cleaned income are the correct class"
} else {
  "Not all of the income have been cleaned completely"
}

