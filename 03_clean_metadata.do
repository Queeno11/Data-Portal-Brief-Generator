*------------------------------------------------------------------------------*
*							METADATA for database						   
*------------------------------------------------------------------------------*

import excel "$data_raw\Country codes & metadata\metadata.xlsx", firstrow clear
duplicates drop code, force
replace code = lower(subinstr(code, ".", "_", .)) 
save "$data_processed\metadata_processed", replace

*-------------------------Add everything to database-------------------*
use "$data_processed\complete_series_nometadata_$date$extra", clear

** Add names
replace code = lower(subinstr(code, ".", "_", .)) 
// rename code code_merge
merge m:m code using "$data_processed\metadata_processed"
// merge m:m code_merge using "$data_processed\metadata_processed"
count if _merge==1
assert r(N) == 0 // Verifico que no haya ninguna variable sin metadata en la base del excel "metadata"
*	Me preocupan los _merge==1 porque son variables que tenemos que no se agregaró la metadata.
*	Los _merge==2 son variables viejas o con codificación no válida...
drop if _merge != 3
drop _merge

* Update names for portal
// clonevar original_name = code 
// replace code = name_portal if name_portal != ""
// drop name_portal
replace code = name_portal

** Add wb county data
merge m:1 wbcode using "$data_processed\country_class"
drop if _merge!=3 
drop _merge


*-------------------------------HCI + HCCI---------------------------------*

gen data = "HCI" if code=="eyrs" | code=="hci" | code=="hci_lower" | code=="hci_upper" | code=="nostu" | code=="psurv" | code=="qeyrs" | code=="test" | code=="se_lpv_prim" | code=="asr"
replace data = "HCCI" if missing(data)

* Scales. FIXME: This is outdated...
gen scale = ""
foreach var in asr hci hci_lower hci_upper nostu psurv {
replace scale = "0 - 1" if code=="`var'"
}
foreach var in basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y luu_2lu4_mf_a luu_2lu4_mf_y une_2eap_mf_a une_2eap_mf_y lastnm_birth_reg lastnm_probdeath_ncd se_lpv_prim uisqutp1 uisqutp2t3 uisschbsp1welec uisxgovexpimf unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stunting unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC {
replace scale = "0 - 100" if code=="`var'"
}
replace scale = "300 - 625" if code=="test"
replace scale = "0 - 100,000" if code=="lastnm_mmrt"
replace scale = "0 - 1,000" if code =="unicef_neomort"|code=="unicef_u5mort"
replace scale = "0 - not bounded" if scale==""

*--------------------------------Coverage----------------------------------*
gen year2 = year if value!=.
bysort code: egen minyear = min(year2)
bysort code: egen maxyear = max(year2)
*drop coverage
tostring minyear, replace
tostring maxyear, replace
gen coverage = minyear + " - " + maxyear 
drop year2 
destring minyear, replace
destring maxyear, replace

drop if year<minyear
	
*------------------------------Drop if gender------------------------------*
*Drop if no data splitted by gender: if an indicator has missing for all countries in both genders, then it doesnt have any gender opening.
gen gender_not_total = 0
replace gender_not_total = 1 if gender==1|gender==2

levelsof code, local(indicators)
foreach ind in `indicators' {
	count if code=="`ind'" & gender_not_total==1
	if r(N)==0 {
	   	drop if code == "`ind'" & gender_not_total==1 
		display "Indicator `ind' has no gender disaggregation"
}
}
drop gender_not_total	

*----------------------------Add note to variable -------------------------*// alison - 27 marzo 2023

gen note = ""
replace note = "This variable is classified in Adulthood and Elderly as stage of life, however it should also include the age group Youth" if code=="asr"
replace note = "To track progress over a decade, a version of the HCI was calculated for 103 economies. Data to populate the 2010 HCI was carefully selected to maximize comparability with the 2020 HCI. In particular, only those countries where learning scores measured by the same international assessment in 2010 and 2020 entered the comparison." if code=="hci" & year==2010

*---------Add column for type of graph  TO CONFIRM WITH GERMAN AND RYTHIA-----------*// alison - 29 marzo 2023

*gen graph_type = "Line Chart and Basic Bar Chart" */ melanie - 4 april 2023
*lab var graph_type "Graph Type" */ melanie - 4 april 2023

*----------------------------Add male/female to name-----------------------*// melanie - 28 marzo 2023

replace name = name + ", Female" if gender==2
replace name = name + ", Male" if gender==1

*----------------------------------Save------------------------------------*

ren coverage timespan // alison - 27 marzo 2023
ren wbincomegroup wbincome // alison - 27 marzo 2023
ren dimension topic

lab var wbcode "WB country code"
lab var year "Year"
lab var gender "Gender"
lab var code "Indicator code" 
lab var value "Indicator value"
lab var name "Indicator name"
lab var description "Indicator description"
lab var update "Latest update"
lab var source "Source of data"
*lab var coverage "Coverage years" // alison - 27 marzo 2023
lab var timespan "Timespan in years" // alison - 27 marzo 2023
lab var minyear "First year of indicator"
lab var maxyear "Last year of indicator"
lab var download_link "Download link"
lab var wbcountryname "Country name"
lab var wbregion "WB region"
lab var wbincome "WB income group"
lab var topic "Human Capital dimension"
*lab var stage "Stage of life" // alison - 27 marzo 2023
lab var stage_life "Stage of life" // alison - 27 marzo 2023
lab var data "HCI or HCCI"
lab var units "Units"
lab var scale "Scale"
lab var note "Note" // alison - 27 marzo 2023

lab def gender 0"Total" 1"Male" 2"Female", replace
lab val gender gender

*order wbcode wbcountryname wbregion wbincome year code gender name description units scale value update coverage minyear maxyear data stage topic source down // alison - 27 marzo 2023
order wbcode wbcountryname wbregion wbincome year code gender name description units scale value update timespan minyear maxyear data stage_life topic source download_link note // alison - 27 marzo 2023
sort wbcode wbcountryname year code gender 

compress

*save "$data_processed\complete_series_wmd", replace
*export delimited "$data_processed\complete_series_wmd.csv", replace
*export excel "$data_processed\complete_series_wmd.xlsx", replace firstrow(variables)

replace download_link = "https://databank.worldbank.org/source/world-development-indicators" if download_link=="https://datacatalog.worldbank.org/public-licenses#cc-by"

save "$data_output\complete_series_wmd_${date}${extra}", replace

* FIXME: i have to drop the missing in order to export the excel file as it supports only 1 million rows. Check with portal team...
drop if value==.
export excel "$data_output\complete_series_wmd_${date}${extra}.xlsx", replace firstrow(variables)


*DATA PORTAL:
drop if (name=="Labor force participation rate (%), Female"|name=="Labor force participation rate (%), Male")
drop if (name=="Male labor force participation rate (%), Male" | name=="Male labor force participation rate (%), Female")
drop if (name=="Female labor force participation rate (%), Male"|name=="Female labor force participation rate (%), Female")
replace name="Labor force participation rate (%), Female" if name=="Female labor force participation rate (%)"
replace name="Labor force participation rate (%), Male" if name=="Male labor force participation rate (%)"
replace date_download="$date_text" if source=="Unicef"

* FIX de Labor force gender
replace gender = 1 if name=="Labor force participation rate (%), Male"
replace gender = 2 if name=="Labor force participation rate (%), Female" 

replace name_portal = "emp_2wap_a" if name_portal=="emp_2wap_f_a" | name_portal=="emp_2wap_m_a" | name_portal=="emp_2wap_mf_a"
replace code = "emp_2wap_a" if code=="emp_2wap_f_a" | code=="emp_2wap_m_a" | code=="emp_2wap_mf_a"


keep wbcode wbcountryname wbregion wbincome year code gender name description units scale value update timespan minyear maxyear data stage_life topic source download_link note name_portal date_download
save "$data_output\complete_dataportal_${date}${extra}", replace

use "$data_output\complete_dataportal_${date}${extra}", replace
export excel using "$data_output\complete_dataportal_${date}${extra}.xlsx", firstrow(variables) replace

*-------------------Generate medians for benchmarking------------------------------* // alison - 27 marzo 2023

/* br wbcode wbregion wbincome year code gender value */

by code year wbregion gender, sort: egen median_reg = median(value) 

by code year wbincome gender, sort: egen median_income = median(value) 

by code year gender, sort: egen nr_countries = count(value)  // max 206/217 paises 

label var median_reg "Regional median value"
label var median_income "Income Group median value"
label var nr_countries "Number of countries"

sort wbcode year code gender

drop units scale update timespan minyear maxyear source download_link note

*export excel "$data_processed\benchmarking_${date}_all.xlsx", replace firstrow(variables)

save "$data_output\benchmarking_${date}_all", replace // alison - 29 marzo 2023
*use "$data_output\benchmarking_${date}_all", clear // alison - 29 marzo 2023

**************************************alison - 29 marzo 2023*************************************************
*keep the last available year for the 49 variables contained in the Country Briefs (including gender split)*
*************************************************************************************************************

keep if /*Early Childhood*/ code =="unicef_neomort" | code =="unicef_mealfreq" | code =="uisger02" | code =="lastnm_mmrt" | code =="unicef_care" | code =="lastnm_birth_reg" | code =="unicef_breastf" | code =="uisger02f" | code =="vacbcg" | code =="unicef_diarrhoea" | code =="uisger02m" /*School Age*/ | code =="uiscr1" | code =="lastnm_sec_ger" | code =="uiscr2" | code =="vachepbb" | code =="se_lpv_prim" | code =="se_lpv_prim_fe" | code =="uiscr1f" | code =="se_lpv_prim_ma" |code =="uiscr1m" | /*Youth*/ code =="eip_neet_mf_y" | code =="lastnm_afr" | code =="lastnm_ter_ger" | code =="une_2eap_f_y" | code =="eip_neet_f_y" | code =="une_2eap_mf_y" | code =="une_2eap_m_y" | code =="eip_neet_m_y" | /*Adults & Elderly*/ code =="eap_2wap_f_a" | code =="lastnm_probdeath_ncd" | code =="eap_2wap_m_a" | code =="sp_dyn_le00_fe_in" | code =="sp_dyn_le00_in" | code =="sp_dyn_le00_ma_in" /*ordenar*/ | code =="vacBCG" | code =="vacHEPBB" | code =="eip_2wap_a" /*before: vacbcg vachepbb eap_2wap_f_a*/

*tab code gender if year ==2021

drop if year != 2021 

drop if nr_countries == 0 //maybe delete in the future all those with value==0 too 

*see if they have enough countries for comparison
*tab nr_countries code 

export excel "$data_output\benchmarking_${date}_2021.xlsx", replace firstrow(variables) 

*-----------------Calculate indicators by category-------------------------* // melanie - 29 marzo 2023
/*
use "$data_processed\complete_series_wmd_${date}${extra}", clear
collapse (mean) value, by(name topic stage)
gen n = 1 
collapse (sum) n, by(topic)

use "$data_processed\complete_series_wmd_${date}${extra}", clear
collapse (mean) value, by(name topic stage)
gen n = 1 
collapse (sum) n, by(stage)

use "$data_processed\complete_series_wmd_${date}${extra}", clear
keep value year wbcode wbcountryname name code gender
reshape wide value, i(wbcode wbcountryname name code gender) j(year)
egen countt = rownonmiss(value1950 value1951 value1952 value1953 value1954 value1955 value1956 value1957 value1958 value1959 value1960 value1961 value1962 value1963 value1964 value1965 value1966 value1967 value1968 value1969 value1970 value1971 value1972 value1973 value1974 value1975 value1976 value1977 value1978 value1979 value1980 value1981 value1982 value1983 value1984 value1985 value1986 value1987 value1988 value1989 value1990 value1991 value1992 value1993 value1994 value1995 value1996 value1997 value1998 value1999 value2000 value2001 value2002 value2003 value2004 value2005 value2006 value2007 value2008 value2009 value2010 value2011 value2012 value2013 value2014 value2015 value2016 value2017 value2018 value2019 value2020 value2021)
drop if countt==0

bysort name: egen meanobs = mean(countt)
collapse (mean) meanobs, by(name)
*/
