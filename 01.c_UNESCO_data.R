################################################################################
###################################### UIS #####################################
################################################################################
rm(list=ls())
library(httr)
library(jsonlite)

# File path
path <- "C:/Users/llohi/OneDrive - Universidad Torcuato Di Tella/WB/Data-Portal-Brief-Generator/Data/Data_Raw"

base_url <- base_url <- "https://data.uis.unesco.org/sdmx-json/"
section <- "NATMON_DS"
indicators <- c("NERT_1_CP", "NERT_1_F_CP", "NERT_1_M_CP", 
                "NERT_2_CP", "NERT_2_F_CP", "NERT_2_M_CP", 
                "NERT_3_CP", "NERT_3_F_CP", "NERT_3_M_CP", 
                "OFST_1_CP", "OFST_1_F_CP", "OFST_1_M_CP", 
                "REPR_1_CP", "REPR_1_F_CP", "REPR_1_M_CP"
                )
#indicators <- "QUTP.2T3"
#NERT_1_CP = net enrollment primary
#REPR_1_CP = repetition rate primary
#OFST_1_CP = out of school primary
#REPR_1_CP = repetition rate primary
countries <- c("AUS",	"AUT",	"BEL",	"CAN",	"CZE",	"DNK",	"FIN",	"FRA",	
               "DEU",	"GRC",	"HUN",	"ISL",	"IRL",	"ITA",	"JPN",	"KOR",	
               "LUX",	"MEX",	"NLD",	"NZL",	"NOR",	"POL",	"PRT",	"SVK",	
               "ESP",	"SWE",	"CHE",	"TUR",	"GBR",	"USA",	"AFG",	"ALB",	
               "DZA",	"ASM",	"AND",	"AGO",	"AIA",	"ATG",	"ARG",	"ARM",	
               "ABW",	"AZE",	"BHS",	"BHR",	"BGD",	"BRB",	"BLR",	"BLZ",	
               "BEN",	"BMU",	"BTN",	"BOL",	"BIH",	"BWA",	"BRA",	"VGB",	
               "BRN",	"BGR",	"BFA",	"BDI",	"KHM",	"CMR",	"CPV",	"CYM",	
               "CAF",	"TCD",	"ZZA",	"CHL",	"CHN",	"COL",	"COM",	"COG",	
               "COK",	"CRI",	"CIV",	"HRV",	"CUB",	"CYP",	"PRK",	"COD",	
               "DJI",	"DMA",	"DOM",	"ECU",	"EGY",	"SLV",	"GNQ",	"ERI",	
               "EST",	"ETH",	"FRO",	"FLK",	"FJI",	"GUF",	"PYF",	"GAB",	
               "GMB",	"GEO",	"GHA",	"GIB",	"GRL",	"GRD",	"GLP",	"GUM",	
               "GTM",	"GIN",	"GNB",	"GUY",	"HTI",	"VAT",	"HND",	"HKG",	
               "IND",	"IDN",	"IRN",	"IRQ",	"IMN",	"ISR",	"JAM",	"JOR",	
               "KAZ",	"KEN",	"KIR",	"KWT",	"KGZ",	"LAO",	"LVA",	"LBN",	
               "LSO",	"LBR",	"LBY",	"LIE",	"LTU",	"MKD",	"MDG",	"MWI",	
               "MYS",	"MDV",	"MLI",	"MLT",	"MHL",	"MTQ",	"MRT",	"MUS",	
               "MYT",	"FSM",	"MDA",	"MCO",	"MNG",	"MSR",	"MAR",	"MOZ",	
               "MMR",	"NAM",	"NRU",	"NPL",	"NCL",	"NIC",	"NER",	"NGA",	
               "NIU",	"NFK",	"MNP",	"PSE",	"OMN",	"PAK",	"PLW",	"PAN",	
               "PNG",	"PRY",	"PER",	"PHL",	"PCN",	"PRI",	"QAT",	"REU",	
               "ROU",	"RUS",	"RWA",	"SHN",	"KNA",	"LCA",	"SPM",	"VCT",	
               "WSM",	"SMR",	"STP",	"SAU",	"SEN",	"SYC",	"SLE",	"SGP",	
               "SVN",	"SLB",	"SOM",	"ZAF",	"LKA",	"SDN",	"SUR",	"SJM",	
               "SWZ",	"SYR",	"TJK",	"TZA",	"THA",	"TLS",	"TGO",	"TKL",	
               "TON",	"TTO",	"TUN",	"TKM",	"TCA",	"TUV",	"UGA",	"UKR",	
               "ARE",	"URY",	"UZB",	"VUT",	"VEN",	"VNM",	"VIR",	"WLF",	
               "YEM",	"ZMB",	"ZWE",	"ESH",	"MAC",	"SRB",	"MNE",	"ALA",	
               "CUW",	"SXM",	"BLM",	"MAF",	"SSD",	"XDN",	"GGY",	"JEY")
indicators_str <- paste(indicators, collapse="+")
countries_str <- paste(countries, collapse="+")
full_url <- paste0(base_url, "data/", section, "/", indicators_str, ".", countries_str, "+40330+SDG+40334+40344+40525+UIS+40530+40505+40515+40520+40500+40535+40540+40510+40044+WB+40042+40030+40043+40041+40675+40606+40617+40603+40614+40618+40612+40616+40619+40611+40613+40630+40650+40651+40656+40642+40620+40640+40550/all?detail=DataOnly&dimensionAtObservation=AllDimensions")
#full_url <- "https://data.uis.unesco.org/sdmx-json/data/SDG_DS/SDG_3_1.AUS+AUT+BEL+CAN+CZE+DNK+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ITA+JPN+KOR+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+ZZA+CHL+CHN+COL+COM+COG+COK+CRI+CIV+HRV+CUB+CYP+PRK+COD+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+EST+ETH+FRO+FLK+FJI+GUF+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+VAT+HND+HKG+IND+IDN+IRN+IRQ+IMN+ISR+JAM+JOR+KAZ+KEN+KIR+KWT+KGZ+LAO+LVA+LBN+LSO+LBR+LBY+LIE+LTU+MKD+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+NCL+NIC+NER+NGA+NIU+NFK+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PCN+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SPM+VCT+WSM+SMR+STP+SAU+SEN+SYC+SLE+SGP+SVN+SLB+SOM+ZAF+LKA+SDN+SUR+SJM+SWZ+SYR+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+WLF+YEM+ZMB+ZWE+ESH+MAC+SRB+MNE+ALA+CUW+SXM+BLM+MAF+SSD+XDN+GGY+JEY+40330+SDG+40334+40344+40525+UIS+40530+40505+40515+40520+40500+40535+40540+40510+40044+WB+40042+40030+40043+40041+40675+40606+40617+40603+40614+40618+40612+40616+40619+40611+40613+40630+40650+40651+40656+40642+40620+40640+40550/all?detail=Full&dimensionAtObservation=AllDimensions"
response <- GET(full_url)
data <- fromJSON(content(response, "text"))
print(data)
str(data)
dimensions <- data$structure$dimensions$observation
indicators <- dimensions$values[[1]]$name
countries <- dimensions$values[[2]]$id
time_periods <- dimensions$values[[3]]$name
observations <- data$dataSets$observations

result <- data.frame(Indicator = character(),
                     Country = character(),
                     Time = character(),
                     Value = numeric(),
                     stringsAsFactors = FALSE)

# Iterate through the observations to build the data frame
for (obs_name in colnames(observations)) {
  obs <- observations[[obs_name]]
  value <- obs[[1]]
  
  # Extract the keys
  keys <- unlist(strsplit(obs_name, ":"))
  
  # Get the actual values
  indicator <- indicators[as.numeric(keys[1]) + 1]
  country <- countries[as.numeric(keys[2]) + 1]
  time_period <- time_periods[as.numeric(keys[3]) + 1]
  
  # Append to the result data frame
  result <- rbind(result, data.frame(Indicator = indicator,
                                     Country = country,
                                     Time = time_period,
                                     Value = value,
                                     stringsAsFactors = FALSE))
}

# Display the resulting data frame
print(result)
write.csv(result, file.path(path, "all_uis.csv"), row.names = TRUE)
cat("The file has been saved in", path, "\n")