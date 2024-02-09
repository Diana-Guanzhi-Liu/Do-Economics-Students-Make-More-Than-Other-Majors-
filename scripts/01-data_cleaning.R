#### Preamble ####
# Purpose: Cleans the raw majors and wages data and combines them
# Author: Diana Liu
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: Manually downloaded the data from Open ICSPR and uploaded into raw data folder

#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Clean data ####
load("/cloud/project/Inputs/Raw Data/ACS_Data_UCSCEcon_NAICS.Rda")
Industry <- read.csv("/cloud/project/Inputs/Raw Data/NAICS2_to_Names.csv")
Majors <- readxl::read_xlsx("/cloud/project/Inputs/Raw Data/DEGFIELD_Code and Label.xlsx")

#Simplify and add Industry and Major name to UCSC Student Data
cleaned_majors_data <- 
  acs |>
  select(YEAR, DEGFIELD, INCWAGE, INDNAICS)
Industry$INDNAICS <- as.character(Industry$INDNAICS)
cleaned_majors_data$DEGFIELD <- as.character(cleaned_majors_data$DEGFIELD)
cleaned_majors_data <- as.data.frame(cleaned_majors_data)
Industry <- as.data.frame(Industry)
Majors <- as.data.frame(Majors)
cleaned_majors_data <- inner_join(cleaned_majors_data, Industry, by = "INDNAICS")
cleaned_majors_data <- inner_join(cleaned_majors_data, Majors, by = "DEGFIELD")
head(cleaned_majors_data)

#### Save data ####
save(cleaned_majors_data, file = "/cloud/project/outputs/Data/Majors_Income_Cleaned.Rda")

