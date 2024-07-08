#install.packages("httr")
#install.packages("jsonlite")

library(httr)
library(jsonlite)

get_faostat_data <- function(domain, item, element, area, year_start, year_end) {
  base_url <- "https://api.fao.org/faostat/v1/en/data"
  params <- list(
    domainCode = domain,
    itemCode = item,
    elementCode = element,
    areaCode = area,
    year = paste(year_start, year_end, sep = ","),
    format = "json"
  )
  
  response <- GET(base_url, query = params)
  # Check if the request was successful
  if (http_type(response) != "application/json") {
    stop("API did not return json")
  }
  
  if (http_status(response)$category != "Success") {
    stop("API request failed with status: ", http_status(response)$message)
  }
  
  data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  
  # Convert the data to a data frame
  df <- as.data.frame(data$data)
  return(df)
}

# Example usage
domain <- "QCL" # Domain code
item <- "21049"  # Item code
element <- "5510" # Element code
area <- "2"    # Area code (e.g., Kenya)
year_start <- 2000
year_end <- 2020

df <- get_faostat_data(domain, item, element, area,year_start, year_end)
print(df)
