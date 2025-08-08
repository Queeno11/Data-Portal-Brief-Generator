################################################################################
###################################### WHO #####################################
################################################################################
# Add data from WHO - GHO using rgho library

rm(list=ls())
#install.packages('rgho')
library(rgho)
library(dplyr)
library(stringr)

# File path
# path <- "C:/Users/llohi/OneDrive - Universidad Torcuato Di Tella/WB/Data-Portal-Brief-Generator/Data/Data_Raw"
# path <- "C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator\\Data\\Data_Raw"
path <-  "/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Data-Portal-Brief-Generator/Data/Data_Raw"

who_data_list <- list()
# Define the list of indicators
indicator_codes <- c("NCD_PAC_ADO", "NCD_HYP_PREVALENCE_A", "SRHINSTITUTIONALBIRTH", "MH_12", "NCD_BMI_30A", "SDGSUICIDE", "NUTRITION_ANAEMIA_CHILDREN_PREV") 
# indicator_codes <- c("SRHINSTITUTIONALBIRTH")
# SDGSUICIDE = Crude suicide rates
# MH_12 = Age standarized suicide rates (esta es la que se descargó)
columns_to_keep <- c("IndicatorCode", "NumericValue", "COUNTRY", "TimeDimensionValue", "YEAR", "SEX", "AGEGROUP", "SEVERITY", "DATASOURCE")
for (ind in indicator_codes){
data <- get_gho_data(code=ind)
existing_columns <- intersect(columns_to_keep, names(data))
missing_columns <- setdiff(columns_to_keep, existing_columns)
for (col in missing_columns) {
  data[[col]] <- NA
}
who_data_list[[ind]] <- data %>% select(all_of(columns_to_keep))
}

# Filter suicide rate to keep age group 15-19 years
#who_data_list[["SDGSUICIDE"]] <- who_data_list[["SDGSUICIDE"]] %>% filter(AGEGROUP == "AGEGROUP_YEARS15-19")

# Merge all in one dataset
combined_data <- do.call(rbind, who_data_list)
# Keep data for specific years, not time ranges of more than one year
combined_data <- combined_data %>% filter(grepl("^\\d{4}$", TimeDimensionValue))
# Obtain metadata
metadata <- get_gho_values(dimension = "GHO")
metadata <- metadata %>% rename(IndicatorCode = Code)

### This section selects duplicates coming from different sources ###
data_flag <- combined_data %>%
  filter(IndicatorCode == "SRHINSTITUTIONALBIRTH")%>%
  group_by(COUNTRY, YEAR, SEX, AGEGROUP) %>%
  mutate(duplicate = n() > 1) %>%
  ungroup()

duplicates_sources <- data_flag %>%
  filter(duplicate) %>%
  group_by(COUNTRY, YEAR, SEX, AGEGROUP) %>%
  summarise(SOURCES = paste(unique(DATASOURCE), collapse = "; "), .groups = "drop")

num_duplicates <- nrow(duplicates_sources)
cat("Number of duplicate observations:", num_duplicates, "\n")

print(duplicates_sources)

delete_obs <- data_flag %>%
  filter(duplicate & (str_detect(DATASOURCE, "WHO")| str_detect(DATASOURCE, "GOV"))) %>%
  select(COUNTRY, YEAR, SEX, AGEGROUP, DATASOURCE)

cat("Number of obs deleted:", nrow(delete_obs), "\n")

combined_data <- combined_data %>%
  anti_join(delete_obs, by = c("COUNTRY", "YEAR", "SEX", "AGEGROUP", "DATASOURCE"))

##########################

all_who <- merge(combined_data, metadata, by = "IndicatorCode", all.x = TRUE) %>%
  select (-DATASOURCE)
write.csv(all_who, file.path(path, "all_who.csv"), row.names = TRUE)
cat("The file has been saved in", path, "\n")
