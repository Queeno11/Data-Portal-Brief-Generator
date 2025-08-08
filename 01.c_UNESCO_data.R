################################################################################
###################################### UIS #####################################
################################################################################
rm(list=ls())
library(httr)
library(jsonlite)
library(dplyr)

# File path
# path <- "C:/Users/llohi/OneDrive - Universidad Torcuato Di Tella/WB/Data-Portal-Brief-Generator/Data/Data_Raw"
# path <- "C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator\\Data\\Data_Raw"
path <-  "/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Data-Portal-Brief-Generator/Data/Data_Raw"

# FIXME: Old indicator names, check if we have them all
#indicators <- c("NERT_1_CP", "NERT_1_F_CP", "NERT_1_M_CP", 
#                "NERT_2_CP", "NERT_2_F_CP", "NERT_2_M_CP", 
#                "NERT_3_CP", "NERT_3_F_CP", "NERT_3_M_CP", 
#                "OFST_1_CP", "OFST_1_F_CP", "OFST_1_M_CP", 
#                "REPR_1_CP", "REPR_1_F_CP", "REPR_1_M_CP"
#                )

indicators <- c("OFST.1.CP", "XGDP.FSGOV", "XGOVEXP.IMF", "LR.AG15T24", "NER.0.CP",
                "NER.01.CP", "OAEPG.2.GPV", "OAEPG.1", "MATH.LOWERSEC", "READ.LOWERSEC",
                "MATH.PRIMARY", "READ.PRIMARY", "SCHBSP.1.WELEC", "REPR.1.CP", 
                "NERT.2.CP", "NERT.1.CP", "NERT.3.CP", "QUTP.1", "QUTP.2T3", "CR.3" 
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

#FIXME: Old indicator names in the URL, check if we have them all
#full_url <- paste0(base_url, "data/", section, "/", indicators_str, ".", countries_str, "+40330+SDG+40334+40344+40525+UIS+40530+40505+40515+40520+40500+40535+40540+40510+40044+WB+40042+40030+40043+40041+40675+40606+40617+40603+40614+40618+40612+40616+40619+40611+40613+40630+40650+40651+40656+40642+40620+40640+40550/all?detail=DataOnly&dimensionAtObservation=AllDimensions")
#full_url <- "https://data.uis.unesco.org/sdmx-json/data/SDG_DS/SDG_3_1.AUS+AUT+BEL+CAN+CZE+DNK+FIN+FRA+DEU+GRC+HUN+ISL+IRL+ITA+JPN+KOR+LUX+MEX+NLD+NZL+NOR+POL+PRT+SVK+ESP+SWE+CHE+TUR+GBR+USA+AFG+ALB+DZA+ASM+AND+AGO+AIA+ATG+ARG+ARM+ABW+AZE+BHS+BHR+BGD+BRB+BLR+BLZ+BEN+BMU+BTN+BOL+BIH+BWA+BRA+VGB+BRN+BGR+BFA+BDI+KHM+CMR+CPV+CYM+CAF+TCD+ZZA+CHL+CHN+COL+COM+COG+COK+CRI+CIV+HRV+CUB+CYP+PRK+COD+DJI+DMA+DOM+ECU+EGY+SLV+GNQ+ERI+EST+ETH+FRO+FLK+FJI+GUF+PYF+GAB+GMB+GEO+GHA+GIB+GRL+GRD+GLP+GUM+GTM+GIN+GNB+GUY+HTI+VAT+HND+HKG+IND+IDN+IRN+IRQ+IMN+ISR+JAM+JOR+KAZ+KEN+KIR+KWT+KGZ+LAO+LVA+LBN+LSO+LBR+LBY+LIE+LTU+MKD+MDG+MWI+MYS+MDV+MLI+MLT+MHL+MTQ+MRT+MUS+MYT+FSM+MDA+MCO+MNG+MSR+MAR+MOZ+MMR+NAM+NRU+NPL+NCL+NIC+NER+NGA+NIU+NFK+MNP+PSE+OMN+PAK+PLW+PAN+PNG+PRY+PER+PHL+PCN+PRI+QAT+REU+ROU+RUS+RWA+SHN+KNA+LCA+SPM+VCT+WSM+SMR+STP+SAU+SEN+SYC+SLE+SGP+SVN+SLB+SOM+ZAF+LKA+SDN+SUR+SJM+SWZ+SYR+TJK+TZA+THA+TLS+TGO+TKL+TON+TTO+TUN+TKM+TCA+TUV+UGA+UKR+ARE+URY+UZB+VUT+VEN+VNM+VIR+WLF+YEM+ZMB+ZWE+ESH+MAC+SRB+MNE+ALA+CUW+SXM+BLM+MAF+SSD+XDN+GGY+JEY+40330+SDG+40334+40344+40525+UIS+40530+40505+40515+40520+40500+40535+40540+40510+40044+WB+40042+40030+40043+40041+40675+40606+40617+40603+40614+40618+40612+40616+40619+40611+40613+40630+40650+40651+40656+40642+40620+40640+40550/all?detail=Full&dimensionAtObservation=AllDimensions"

indicator_params <- paste0("indicator=", indicators, collapse = "&")
country_params <- paste0("geoUnit=", countries, collapse = "&")
full_url <- paste0("https://api.uis.unesco.org/api/public/data/indicators?", indicator_params, "&", country_params, "&indicatorMetadata=true")

response <- GET(full_url)
data <- fromJSON(content(response, "text"))
print(data)
str(data)

dimensions <- data$indicatorMetadata
observations <- data$records

indicators <- dimensions %>%
  select(indicatorCode, name) %>%
  rename(indicator = name)

result <- observations %>%
  select(indicatorId, geoUnit, year, value) %>%
  rename(Country = geoUnit, Time = year, Value = value) %>%
  left_join(indicators, by = c("indicatorId" = "indicatorCode"))

#Old
#result <- data.frame(Indicator = character(),
#                     Country = character(),
#                     Time = character(),
#                     Value = numeric(),
#                     stringsAsFactors = FALSE)



# Display the resulting data frame
print(result)
write.csv(result, file.path(path, "all_uis.csv"), row.names = TRUE)
cat("The file has been saved in", path, "\n")
