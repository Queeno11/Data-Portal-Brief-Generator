################################################################################
###################################### SDG #####################################
################################################################################
rm(list=ls())
#install.packages("dplyr")
#install.packages("tidyr")
library(dplyr)
library(tidyr)
library(httr)
library(jsonlite)

# File path
path <- "C:/Users/llohi/OneDrive - Universidad Torcuato Di Tella/WB/Data-Portal-Brief-Generator/Data/Data_Raw"

# Base URL 
base_url <- "https://unstats.un.org/SDGAPI/v1/sdg/Indicator/Data"
params <- list(
  indicator = "4.2.2"
)

# Make the GET request
response <- GET(base_url, query = params)

# Check status
if (status_code(response) == 200) {
  data <- fromJSON(content(response, "text"))
  print(data)
} else {
  print(paste("Error:", status_code(response)))
}

str(data$data)

indicator <- data$data

# Flatten the 'data' part of the response
data_flattened <- data$data %>%
  unnest_wider(goal) %>%
  unnest_wider(target) %>%
  unnest_wider(indicator) %>%
  unnest_wider(series) %>%
  unnest_wider(seriesDescription) %>%
  unnest_wider(seriesCount) %>%
  unnest_wider(geoAreaCode) %>%
  unnest_wider(geoAreaName) %>%
  unnest_wider(timePeriodStart) %>%
  unnest_wider(value) %>%
  unnest_wider(valueType) %>%
  unnest_wider(basePeriod) %>%
  unnest_wider(source)

# Convert lists within columns to character vectors
data_flattened <- data_flattened %>%
  mutate(across(where(is.list), ~ sapply(., toString)))

# Display the first few rows of the flattened data
head(data_flattened)


# Convert to data frame
data_df <- as.data.frame(data)

# Display the first few rows of the data frame
head(data_df)

