################################################################################
###################################### ILO #####################################
################################################################################
rm(list=ls())
#install.packages('Rilostat')
library(rgho)
library(dplyr)
library(Rilostat)
#https://data.uis.unesco.org/sdmx-json/
#https://github.com/FAOSTAT
# File path
path <- "C:/Users/llohi/OneDrive - Universidad Torcuato Di Tella/WB/Data-Portal-Brief-Generator/Data/Data_Raw"

# Generate list of selected indicators
ilo_data_list <- list()
indicators_ilo <- c("EIP_NEET_SEX_AGE_RT_A", "EIP_2WAP_SEX_AGE_RT_A", "EAP_DWAP_SEX_AGE_RT_A", "UNE_2EAP_SEX_AGE_RT_A", "EMP_NIFL_SEX_AGE_RT_A", "EMP_TEMP_SEX_AGE_OCU_NB_A", "LUU_2LU4_SEX_AGE_RT_A")
# Not available: "EIP_2PLF_SEX_AGE_RT_A"
columns_to_keep <- c("id","indicator", "ref_area", "sex", "time", "obs_value", "classif1", "classif2")
for (ind in indicators_ilo){
  data <- get_ilostat(id = ind)
  data$id <- ind
  existing_columns <- intersect(columns_to_keep, names(data))
  missing_columns <- setdiff(columns_to_keep, existing_columns)
  for (col in missing_columns) {
    data[[col]] <- NA
  }
  ilo_data_list[[ind]] <- data %>% select(all_of(columns_to_keep))
}

metadata <- get_ilostat_toc(search='_')

combined_data <- do.call(rbind, ilo_data_list)
all_ilo <- merge(combined_data, metadata, by = "id", all.x = TRUE)
write.csv(all_ilo, file.path(path, "all_ilo.csv"), row.names = TRUE)
cat("The file has been saved in", path, "\n")
