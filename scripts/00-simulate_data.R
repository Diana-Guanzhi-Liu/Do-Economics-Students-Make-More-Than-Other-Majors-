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
  Major = c("American Studies", "Anthropology",
  "Applied Ling and Multiling", "Art", "Art History",
  "Biochemistry&Molecular Bio", "Bioengineering", "Bioinformatics", "Biology",
  "Biology-Molec, Cell & Dev", "Business Mgmt Economics", "Chemistry", 
  "Classical Studies", "Cognitive Science", "Community Studies", 
  "Comp Sci Computer Game Des", "Computer & Info Science", "Computer Engineering", 
  "Computer Science", "Critical Race&EthnicStudies", "Earth Sciences", 
  "Ecology and Evolution", "Economics", "Electrical Engineering", "Engineering",
  "Environmental Planning", "Environmental Studies", "Feminist Studies", 
  "Film and Digital Media", "Film and Video", "German Studies", "Global Economics", 
  "Health Sciences", "History", "Human Biology", "Individual", 
  "Information Systems Management", "Italian Studies", "Jewish Studies", 
  "Language and Culture", "Language Studies", "Latin Amer & Latino Studies",
  "Legal Studies", "Linguistics", "Literature", "Marine Biology", "Mathematics",
  "Modern Society & Soc Thght", "Molec Cell Develop Biology", "Music", 
  "Network & Digital Technology", "Neuroscience", "Philosophy", "Physics",
  "Physics Education", "Plant Sciences", "Politics", "Psychobiology", "Psychology", 
  "Robotics Engineering", "Sociology", "Spanish Studies", 
  "Technology&Info Management", "Theater Arts", "Women's Studies"),
  Salary = rnorm(65, mean = 45000, sd = 20000)
)

population


