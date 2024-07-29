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

#list <- "https://unstats.un.org/SDGAPI/v1/sdg/Series/Data?series=CR_3&pagesize=10000"
list <- "https://unstats.un.org/SDGAPI/v1/sdg/Indicator/List"
get_list <- GET(list)
list_data <- fromJSON(content(get_list, "text"), flatten = TRUE)

# Base URL 
base_url <- "https://unstats.un.org/SDGAPI/v1/sdg/Indicator/Data?indicator="
#base_url <- "https://unstats.un.org/SDGAPI/v1/sdg/Series/DataExcel"

all_data <- list()
# Indicators
  # 4.1.1: Proficiency in math and reading by level
  # 4.2.2: Completion rates
  # 4.2.4: Net enrollment rate in a) pre-primary edu and b) early childhood educ development
  # 4.1.5: Percentage of children over-age for grade (not available in this api)
  # 4.6.2: Literacy rate (not available in this api)
  # 4.c.1: Qualified teachers
  # 4.a.1: Schools with access to electricity
indicators = c("4.1.1", "4.2.2", "4.2.4", "4.c.1", "4.a.1")
# no data for "4.1.5", "4.6.2"
for (indicator in indicators) {
complete_url <- paste0(base_url, indicator, "&pageSize=10000")
# Make the GET request
#response <- GET(base_url, query = params)
response <- GET(complete_url)

# Check status
if (status_code(response) == 200) {
  # Ensure the content type is JSON
  if (http_type(response) == "application/json") {
    # Parse the JSON response
    data <- fromJSON(content(response, "text"), flatten = TRUE)
    # Check if data contains the expected structure
    if (!is.null(data$data)) {
      # Convert the data component to a data frame
      data_df <- as.data.frame(data$data)
      
      # Unnest lists within the data frame
      data_clean <- data_df %>%
        unnest(cols = everything(), names_sep = "_", keep_empty = TRUE)
      
      all_data[[indicator]] <- data_clean
    }  
     else {
      print("The data structure is not as expected.")
    }
  } else {
    print("The content is not in JSON format.")
  }
} else {
  print(paste("Error:", status_code(response)))
}
}

combined_data <- bind_rows(all_data)

# Save combined data to a single CSV file
write.csv(combined_data, file.path(path, "SDG_data.csv"), row.names = FALSE)

# Print a message indicating the process is complete
print("All data has been combined and saved to SDG_data.csv")


