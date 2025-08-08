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

# MANUAL API: https://unstats.un.org/sdgs/files/SDMX_SDG_API_MANUAL.pdf

base_url <- "http://data.un.org/WS/rest/data/DF_SDG_GLH/..SE_TOT_PRFL+SE_TOT_CPLR+SE_ACS_ELECT+SE_TRA_GRDL.............?startPeriod=1960&endPeriod=2023&format=csv"

complete_url <- base_url
response <- GET(complete_url)
# directory <- "C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator\\Data\\Data_Raw"
directory <-  "/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Data-Portal-Brief-Generator/Data/Data_Raw"


file_name <- "dataSDG.csv"
path <- file.path(directory, file_name)
writeBin(content(response, "raw"),  path)


