*------------------------------------------------------------------------------*
*				Series UNICEF, WID, WHO, UNESCO, FAO, UN
*------------------------------------------------------------------------------*
cls
set more off
*--------------------------------Directories-------------------------------*
global root "C:\Users\Nico\Documents\World Bank\Data Portal"
*global root "C:\Users\llohi\Documents\WB\Data Portal"
*global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\"
cd "${root}"
global portal    	  "$root\Data"
global data_raw 	  "$portal\Data_Raw"
global data_processed "$portal\Data_Processed"

*------------------------Codes and Country names---------------------------*
capture qui dir "$data_processed\Country codes\"
if _rc!=0 shell mkdir "$data_processed\Country codes\"

import excel "$data_raw\Country codes\wbcodes_equiv_unicef.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_unicef", replace
import excel "$data_raw\Country codes\wbcodes_equiv_FAO.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_FAO", replace
import excel "$data_raw\Country codes\wbcodes_equiv_who.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_who", replace
import excel "$data_raw\Country codes\wbcodes_equiv_UN.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_UN", replace
import excel "$data_raw\Country codes\wbcodes_equiv_unesco.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_unesco", replace
*--------------------------------------------------------------------------*
*----------------------------------UNICEF----------------------------------*
*--------------------------------------------------------------------------*
* FIXME: Agregar todo esto a la API y chau.
*vaccines
foreach vac in BCG DTP1 DTP3 HEPB3 HEPBB HIB3 IPV1 MCV1 MCV2 PCV3 POL3 ROTAC { // I noticed we are not using the vaccine YFV - alison - 27 marzo 2023
import excel "$data_raw\unicef_vaccines.xlsx", firstrow clear sheet("`vac'")
*rename iso wbcode // alison - 27 marzo 2023
rename iso3 wbcode // alison - 27 marzo 2023
reshape long y, i(wbcode) j(year)
*drop unicef country // alison - 27 marzo 2023
drop unicef_region country // alison - 27 marzo 2023
gen gender=0
rename y vac`vac'
lab var vac`vac' "Vaccination coverage of `vac'"
keep vac`vac' year wbcode gender
save "$data_processed\unicef_`vac'", replace 
}

*under 5 mortality
import excel "$data_raw\unicef_u5mort_series.xlsx", firstrow clear
reshape long y, i(wbcode) j(year)
rename y unicef_u5mort
lab var unicef_u5mort "Under-5 mortality rate"
*drop wbcountry // alison - 27 marzo 2023
drop wbcountryname // alison - 27 marzo 2023
gen gender=0
save "$data_processed\unicef_u5mort", replace

*5-14 mortality
import excel "$data_raw\unicef_514mort_series.xlsx", firstrow clear
reshape long y, i(wbcode) j(year)
rename y unicef_514mort
lab var unicef_514mort "Infant mortality rate"
*drop wbcountry // alison - 27 marzo 2023
drop wbcountryname // alison - 27 marzo 2023
gen gender=0
save "$data_processed\unicef_514mort", replace

*under 5 mortality
import excel "$data_raw\unicef_1524mort_series.xlsx", firstrow clear
reshape long y, i(wbcode) j(year)
rename y unicef_1524mort
lab var unicef_1524mort "Ages 15-24 mortality rate"
*drop wbcountry // alison - 27 marzo 2023
drop wbcountryname // alison - 27 marzo 2023
gen gender=0
save "$data_processed\unicef_1524mort", replace

*care for mothers
import excel "$data_raw\unicef_caremother_series.xlsx", firstrow clear
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country Codes\wbcodes", nogen keep(3)
reshape long y, i(wbcode) j(year)
rename y unicef_caremother
lab var unicef_caremother "Percentage of women (ages 15-49) who received postnatal care within 2 days of giving birth"
*drop wbcountry // alison - 27 marzo 2023
drop wbcountryname // alison - 27 marzo 2023
*foreach var in unicef_ { // alison - 27 marzo 2023
foreach var in unicef_caremother { // alison - 27 marzo 2023
replace `var' = "" if `var'=="-"
replace `var' = "100" if `var'==">99"
replace `var' = "0" if `var'=="<1"
destring `var', replace
}
gen gender=0
save "$data_processed\unicef_caremother", replace

*stillbirths
import excel "$data_raw\unicef_stillbirths.xlsx", firstrow clear
drop Y Z A* B*
drop in 196
drop in 196
drop in 196
drop in 196
drop in 196
reshape long y, i(wbcode wbcountryname) j(year) // alison - 27 marzo 2023
*reshape long y, i(wbcode wbcou) j(year) // alison - 27 marzo 2023
rename y unicef_stillbirths
lab var unicef_stillbirths "Babies born dead after 24 completed weeks of pregnancy" // alison - 27 marzo 2023
*drop wbcountry // alison - 27 marzo 2023
drop wbcountryname // alison - 27 marzo 2023
gen gender=0
save "$data_processed\unicef_stillbirths", replace

*unicef_hygiene
import excel "$data_raw\unicef_hygiene.xlsx", firstrow clear
drop D
drop if missing(year)	
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
rename value unicef_hygiene
lab var unicef_hygiene "Basic hygiene in household"
drop if year=="-"
destring year, replace
foreach var in unicef_hygiene {
replace `var' = "" if `var'=="-"
replace `var' = "100" if `var'==">99"
replace `var' = "0" if `var'=="<1"
destring `var', replace
}
drop wbcountryname
gen gender=0
save "$data_processed\unicef_hygiene", replace

*unicef_water
import excel "$data_raw\unicef_water.xlsx", firstrow clear
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
rename value unicef_water
lab var unicef_water "Basic water in household"
drop wbcountryname
gen gender=0
save "$data_processed\unicef_water", replace

*unicef_sanitation
import excel "$data_raw\unicef_sanitation.xlsx", firstrow clear
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
rename value unicef_sanitation
lab var unicef_sanitation "Basic sanitation in household"
foreach var in unicef_sanitation {
replace `var' = "" if `var'=="-"
replace `var' = "100" if `var'==">99"
replace `var' = "0" if `var'=="<1"
destring `var', replace
}
drop wbcountryname
gen gender=0
save "$data_processed\unicef_sanitation", replace

*unicef_schools
import excel "$data_raw\unicef_water_schools.xlsx", firstrow clear
foreach var in basic_water_schools basic_hygiene_schools basic_sanitation_schools {
replace `var' = "" if `var'=="-"
replace `var' = "100" if `var'==">99"
replace `var' = "0" if `var'=="<1"
destring `var', replace
}
rename name wbcountryname
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
*lab var basic_water "Basic water in schools" // alison - 27 marzo 2023
*lab var basic_hyg "Basic hygiene in schools" // alison - 27 marzo 2023
*lab var basic_sanit "Basic sanitation in schools" // alison - 27 marzo 2023
lab var basic_water_schools "Basic water in schools" // alison - 27 marzo 2023
lab var basic_hygiene_schools "Basic hygiene in schools" // alison - 27 marzo 2023
lab var basic_sanitation_schools "Basic sanitation in schools" // alison - 27 marzo 2023
drop wbcountryname
gen gender=0
save "$data_processed\unicef_schools", replace

*unicef_healthfac
import excel "$data_raw\unicef_water_health.xlsx", firstrow clear
*foreach var in basic_water_ basic_hygiene_ basic_sanitation_ {  // alison - 27 marzo 2023
foreach var in basic_water_health basic_hygiene_health basic_sanitation_health {  // alison - 27 marzo 2023
replace `var' = "" if `var'=="-"
replace `var' = "100" if `var'==">99"
replace `var' = "0" if `var'=="<1"
destring `var', replace
}
rename name wbcountryname
*replace wbcountry = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
replace wbcountryname = "Cote d'Ivoire" if wbcountryname=="Côte d'Ivoire" // alison - 27 marzo 2023
merge m:1 wbcountryname using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
*lab var basic_water "Basic water in health facilities" // alison - 27 marzo 2023
*lab var basic_hygi "Basic hygiene in health facilities" // alison - 27 marzo 2023
*lab var basic_sanit "Basic sanitation in health facilities" // alison - 27 marzo 2023
lab var basic_water_health "Basic water in health facilities" // alison - 27 marzo 2023
lab var basic_hygiene_health "Basic hygiene in health facilities" // alison - 27 marzo 2023
lab var basic_sanitation_health "Basic sanitation in health facilities" // alison - 27 marzo 2023
drop wbcountryname
gen gender=0
save "$data_processed\unicef_health", replace


*****NUEVOS:

use "$data_raw\UNICEF api", clear
gen gender=.
replace gender=0 if SEX=="_T"
replace gender=1 if SEX=="M"
replace gender=2 if SEX=="F"
drop SEX COUNTRY
rename REF_AREA unicef_code

destring TIME_PERIOD, replace
rename TIME_PERIOD year

* Generate str variable and destring
set trace off
foreach oldvar of varlist i_* {
	* Renombro eliminandole la i_*
	local var = subinstr("`oldvar'","i_","",1)
	rename `oldvar' `var'
	
	* Destringeo, eliminando casos con pej <100
	clonevar `var'_str = `var'
	replace `var' = subinstr(`var',"<","",1)
	replace `var' = subinstr(`var',">","",1)
	*replace `var' = "0" if `var' == "<0.01"
	*replace `var' = "1" if `var' == "<100"
	*replace `var' = "2" if `var' == "<200"
	*replace `var' = "3" if `var' == "<500"
	destring `var', replace
	drop `var'_str
} 

		rename ED_MAT_G23 ed_mat_g23
		rename ED_READ_G23 ed_read_g23
		rename HVA_EPI_DTH_ANN_15_24 AID_deaths_1524
		rename HVA_EPI_DTH_RT_0_14 AID_deaths_014
		rename HVA_EPI_INF_RT_0_14 HIV_inc_014
		rename HVA_EPI_INF_RT_10_19 HIV_inc_1019
		rename HVA_PMTCT_MTCT HIV_mother_child
		rename MNCH_ANC1 antenatal_care_1
		rename MNCH_ANC4 antenatal_care_4
		rename MNCH_ITN ITN_children
		rename MNCH_ITNPREG ITN_pregnant
		rename MNCH_MLRCARE care_febrile_children
		rename NT_ANT_HAZ_NE2 stunting
		rename NT_ANT_WHZ_NE2 wasting
		rename NT_ANT_WHZ_NE3 severe_wasting
		rename NT_ANT_WHZ_PO2 overweight
		rename PT_CHLD_5_17_LBR_ECON child_labor
		rename MNCH_ORS ORS_children


* Adds wbcode
merge m:1 unicef_code using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
drop wbcountryname unicef_countryname unicef_code
save "$data_processed\all_unicef", replace
	

*--------------------------------------------------------------------------*
*---------------------------------WDI Nora---------------------------------*
*--------------------------------------------------------------------------*

use "$data_raw\inputdata", clear
keep year wbcountryname wbcode hci_mf_lower_2020 hci_mf_upper_2020 hci_m_2010 hci_f_2010 hci_mf_2010 hci_m_2018 hci_f_2018 hci_mf_2018 hci_m_2020 hci_f_2020 hci_mf_2020 psurv_m_2010 psurv_f_2010 psurv_mf_2010 psurv_m_2018 psurv_f_2018 psurv_mf_2018 psurv_m_2020 psurv_f_2020 psurv_mf_2020 qeyrs_m_2010 qeyrs_f_2010 qeyrs_mf_2010 qeyrs_m_2018 qeyrs_f_2018 qeyrs_mf_2018 qeyrs_m_2020 qeyrs_f_2020 qeyrs_mf_2020 eyrs_m_2010 eyrs_f_2010 eyrs_mf_2010 eyrs_m_2018 eyrs_f_2018 eyrs_mf_2018 eyrs_m_2020 eyrs_f_2020 eyrs_mf_2020 test_m_2010 test_f_2010 test_mf_2010 test_m_2018 test_f_2018 test_mf_2018 test_m_2020 test_f_2020 test_mf_2020 asr_m_2010 asr_f_2010 asr_mf_2010 asr_m_2018 asr_f_2018 asr_mf_2018 asr_m_2020 asr_f_2020 asr_mf_2020 nostu_m_2010 nostu_f_2010 nostu_mf_2010 nostu_m_2018 nostu_f_2018 nostu_mf_2018 nostu_m_2020 nostu_f_2020 nostu_mf_2020
drop year
reshape long hci_mf_lower_ hci_mf_upper_ hci_m_ hci_f_ hci_mf_ psurv_m_ psurv_f_ psurv_mf_ qeyrs_m_ qeyrs_f_ qeyrs_mf_ eyrs_m_ eyrs_f_ eyrs_mf_ test_m_ test_f_ test_mf_ asr_m_ asr_f_ asr_mf_ nostu_m_ nostu_f_ nostu_mf_, i(wbcode wbcountryname) j(year)
rename *_ *
rename (hci_mf_lower hci_mf_upper)(hci_lower_mf hci_upper_mf)
reshape long hci_ hci_upper_ hci_lower_ psurv_ qeyrs_ eyrs_ test_ asr_ nostu_, i(wbcode wbcountryname year) j(gender2) string
rename *_ *
gen gender = 0 if gender2=="mf"
replace gender = 1 if gender2=="m"
replace gender = 2 if gender2=="f"
drop gender2
drop wbcountryname
save "$data_processed\hci", replace

*--------------------------------WDI online--------------------------------*

import excel "$data_raw\hci_web.xlsx", clear firstrow
bysort name code wbcode: gen n = _n
reshape long y, i(name code wbcode n) j(year)
drop n
drop if missing(name)
gen gender = . 
replace gender = 1 if strpos(name,"Male")
replace gender = 2 if strpos(name,"Female")
replace gender = 0 if missing(gender)
rename y value
save "$data_processed\hci_web", replace


*---------------------------------------------------------------------*
*---------------------------------WHO---------------------------------*	
*---------------------------------------------------------------------*
*Only change from csv to excel. All variable names changes are done in this code

*who_activity
import excel "$data_raw\who_activity.xlsx", clear firstrow
rename SpatialDimValueCode WHO_code
rename FactValueNumeric insuf_activity
rename Period year
destring year, replace
lab var insuf_activity "Insufficient physical activity among adolescents"
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
keep insuf_activity year gender WHO_code
save "$data_processed\who_activity", replace
use "$data_processed\wbcodes_equivalences_WHO", clear
merge 1:m WHO_code using "$data_processed\who_activity", nogen keep(3)
keep wbcode insuf_activity gender year
save "$data_processed\who_activity", replace

*who_anaemia
import excel "$data_raw\who_anaemia.xlsx", clear firstrow
rename SpatialDimValueCode WHO_code
rename FactValueNumeric u5_anaemia
rename Period year
destring year, replace
lab var u5_anaemia "Prevalence of anaemia, under 5 children" 
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
keep u5_anaemia year gender WHO_code
save "$data_processed\who_anaemia", replace
use "$data_processed\wbcodes_equivalences_WHO", clear
merge 1:m WHO_code using "$data_processed\who_anaemia", nogen keep(3)
keep wbcode u5_anaemia gender year
save "$data_processed\who_anaemia", replace

	
*who_hypertension
import excel "$data_raw\who_hypertension.xlsx", clear firstrow
drop if IndicatorCode=="NCD_HYP_PREVALENCE_C" //use only age-standarized data
rename SpatialDimValueCode WHO_code
replace Value=substr(Value,1,4) //CHECK: This is because FactValueNumeric is not available, you have to extract the number form the CI.
destring Value, replace
rename Value hypertension_30_79
lab var hypertension_30_79 "Prevalence of hypertension, 30-79 years, age-std"
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
rename Period year
destring year, replace
keep year hypertension_30_79 WHO_code gender
save "$data_processed\who_hypertension", replace
use "$data_processed\wbcodes_equivalences_WHO", clear
merge 1:m WHO_code using "$data_processed\who_hypertension", nogen keep(3)
keep wbcode hypertension_30_79 gender year
save "$data_processed\who_hypertension", replace

*who_obesity
import excel "$data_raw\who_obesity.xlsx", clear firstrow
rename SpatialDimValueCode WHO_code
rename FactValueNumeric obesity
lab var obesity "Prevalence of obesity among adult, BMI>=30"
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
rename Period year
destring year, replace
keep year obesity WHO_code gender
save "$data_processed\who_obesity", replace
use "$data_processed\wbcodes_equivalences_WHO", clear
merge 1:m WHO_code using "$data_processed\who_obesity", nogen keep(3)
keep wbcode obesity gender year
save "$data_processed\who_obesity", replace

*who_suicide
import excel "$data_raw\who_suicide.xlsx", clear firstrow
rename SpatialDimValueCode WHO_code
rename FactValueNumeric suicide_15_19
lab var suicide_15_19 "Crude suicide rates (per 100 000 p),15-19 years "
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
rename Period year
destring year, replace
keep suicide_15_19 year gender WHO_code
save "$data_processed\who_suicide", replace
use "$data_processed\Country codes\wbcodes_equiv_who", clear
merge 1:m WHO_code using "$data_processed\who_suicide", nogen keep(3)
keep wbcode suicide_15_19 gender year
save "$data_processed\who_suicide", replace

*who_pneumonia_careseeking
import excel "$data_raw\who_pneumonia_cs.xlsx", clear firstrow
rename SpatialDimValueCode WHO_code
rename FactValueNumeric u5_pneu_cs
gen year = substr(Period,6,4)
replace year=Period if year==""
destring year, replace
lab var u5_pneu_cs "Children aged < 5 years with pneumonia symptoms taken to a healthcare provider (%)"
gen gender = .
replace gender = 1 if (Dim1type=="Sex" & Dim1=="Male")
replace gender = 2 if (Dim1type=="Sex" & Dim1=="Female")
replace gender = 0 if (Dim1type=="Sex" & Dim1=="Both sexes")
keep u5_pneu_cs year gender WHO_code
destring u5_pneu_cs, replace
save "$data_processed\who_pneumonia_cs", replace
use "$data_processed\Country codes\wbcodes_equiv_who", clear
merge 1:m WHO_code using "$data_processed\who_pneumonia_cs", nogen keep(3)
keep wbcode u5_pneu_cs gender year
save "$data_processed\who_pneumonia_cs", replace

*--------------------------------all WHO---------------------------------*

use "$data_processed\who_activity", clear
merge 1:1 wbcode year gender using "$data_processed\who_anaemia", nogen
merge 1:1 wbcode year gender using "$data_processed\who_hypertension", nogen
merge 1:1 wbcode year gender using "$data_processed\who_obesity", nogen
merge 1:1 wbcode year gender using "$data_processed\who_suicide", nogen
merge 1:1 wbcode year gender using "$data_processed\who_pneumonia_cs", nogen
save "$data_processed\all_who", replace


*-----------------------------------------------------------------------*
*--------------------------------UNESCO---------------------------------*
*-----------------------------------------------------------------------*
*Unesco early childhood education
//Add a y_ in the columns for years in excel
import excel "$data_raw\unesco_ECedu.xlsx", clear firstrow
rename Country UNESCO_countryname
reshape long y, i(UNESCO_countryname) j(year)
rename y ECedu
lab var ECedu "Gross enrolment ratio, early childhood education (%)"
gen gender = .
replace gender = 0
drop if missing(ECedu)
save "$data_processed\unesco_ECedu", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_ECedu", nogen keep(3)
keep wbcode year gender ECedu
save "$data_processed\unesco_ECedu", replace


*Unesco repetition rate   													// Include enrolment per grade?
import excel "$data_raw\unesco_repetition.xlsx", clear firstrow
rename NATMON_IND code
keep if (code=="REPR_1_F_CP" | code=="REPR_1_M_CP" | code=="REPR_1_CP")
gen gender = .
replace gender = 2 if (code=="REPR_1_F_CP") 
replace gender = 1 if (code=="REPR_1_M_CP") 
replace gender = 0 if (code=="REPR_1_CP") 	
rename Value repetition
lab var repetition "Repetition rate in primary education (all grades)"
rename Time year
rename LOCATION UNESCO_code
drop if missing(repetition)
keep year repetition gender UNESCO_code 
save "$data_processed\unesco_repetition", replace
use "$data_processed\Country codes\wbcodes_equivalences_UNESCO", clear
merge 1:m UNESCO_code using "$data_processed\unesco_repetition", nogen keep(3)
keep repetition year gender wbcode
save "$data_processed\unesco_repetition", replace

*-----------------------------all UNESCO---------------------------------*
use "$data_processed\unesco_ECedu", clear
merge 1:1 wbcode year gender using "$data_processed\unesco_repetition", nogen
save "$data_processed\all_unesco", replace


*-----------------------------------------------------------------------*
*--------------------------------FAO------------------------------------*
*-----------------------------------------------------------------------*
*Low birthweight
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode==21049
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v21049
replace v21049="0" if v21049=="<2.5"
lab var v21049 "Prevalence of low birthweight (%)"
drop if FlagDescription=="Missing value"
destring v21049, replace
destring year, replace
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
save "$data_processed\FAO_lowbirthweight",replace
use "$data_processed\Country codes\wbcodes_equiv_FAO"
merge m:m FAO_countryname using "$data_processed\FAO_lowbirthweight", nogen keep(3)
drop FAO_countryname wbcountryname FAO_code
save "$data_processed\FAO_lowbirthweight",replace

*Undernourishment
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode==210041
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v210041
replace v210041="0" if v210041=="<2.5"
lab var v210041 "Prevalence of undernourishment (%) (3-year average, last year)"
drop if FlagDescription=="Missing value"
destring v210041, replace
destring year, replace
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
save "$data_processed\FAO_undernourishment",replace
use "$data_processed\Country codes\wbcodes_equiv_FAO"
merge m:m FAO_countryname using "$data_processed\FAO_undernourishment", nogen keep(3)
drop FAO_countryname wbcountryname FAO_code
save "$data_processed\FAO_undernourishment",replace

*Wasting
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode==21026
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v21026
lab var v21026 "Prevalence of children (<5y) affected by wasting, %"
drop if FlagDescription=="Missing value"
destring v21026, replace
destring year, replace
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
save "$data_processed\FAO_wasting",replace
use "$data_processed\Country codes\wbcodes_equiv_FAO"
merge m:m FAO_countryname using "$data_processed\FAO_wasting", nogen keep(3)
drop FAO_countryname wbcountryname FAO_code
save "$data_processed\FAO_wasting",replace
	
*--------------------------------all FAO---------------------------------*
use "$data_processed\FAO_lowbirthweight", clear
merge 1:1 wbcode year gender using "$data_processed\FAO_undernourishment", nogen
merge 1:1 wbcode year gender using "$data_processed\FAO_wasting", nogen
save "$data_processed\all_FAO", replace


*-----------------------------------------------------------------------*
*-----------------------------UNITED NATIONS----------------------------*
*-----------------------------------------------------------------------*	
*Forcibly displaced population:
**Includes: Internal displaced population (IDPs), Refugees, Asylum-seekers and others.
import excel "$data_raw\UNHCR_Forced_Displacement.xlsx", clear firstrow
rename CountryoforiginISO UNcode
rename Year year
rename IDPsofconcerntoUNHCR IDPs
rename Asylumseekers A_seekers
rename RefugeesunderUNHCRsmandate refugees
rename Othersofconcern FD_others
drop if (Countryoforigin=="Stateless" | Countryoforigin=="Tibetan" | Countryoforigin=="Unknown")
gen gender = .
replace gender = 0
lab var IDPs "Change in the number of internal displaced population of concern to UNHCR"
lab var A_seekers "Change in the number of asylum-seekers"
lab var refugees "Change in the number of refugees under UNHCR´s mandate"
lab var FD_others "Change in the number of other people of concern"
keep year IDPs refugees A_seekers gender UNcode
save "$data_processed\UNHCR_forced_displacement", replace
use "$data_processed\Country codes\wbcodes_equiv_UN", clear
merge 1:m UNcode using "$data_processed\UNHCR_forced_displacement", nogen keep(3)
keep wbcode year gender IDPs refugees A_seekers
save "$data_processed\UNHCR_forced_displacement", replace


*Population per country:
import excel "$data_raw\UN_population.xlsx", clear firstrow
rename B UNname
rename Year year
keep if Series=="Population mid-year estimates (millions)"
rename Value population
gen gender = .
replace gender = 0
lab var population "Population mid-year estimates (millions)"
keep year population gender UNname
save "$data_processed\UN_population", replace
use "$data_processed\Country codes\wbcodes_equiv_UN", clear
merge 1:m UNname using "$data_processed\UN_population", nogen keep(3)
keep wbcode year gender population
drop if wbcode==""
save "$data_processed\UN_population", replace

*---------------------------------all UN-----------------------------------*
use "$data_processed\UNHCR_Forced_Displacement"
merge 1:1 wbcode year gender using "$data_processed\UN_population", nogen keep(3)
save "$data_processed\all_UN", replace

*--------------------------------Merge all---------------------------------*

use "$data_processed\comp_series", clear // FIXME: ¿De donde sale este DTA? No es reproducible porque me falta lo que genera este archivo
merge 1:1 wbcode year gender using "$data_processed\all_unicef", nogen
merge 1:1 wbcode year gender using "$data_processed\all_who", nogen
merge 1:1 wbcode year gender using "$data_processed\all_unesco", nogen
merge 1:1 wbcode year gender using "$data_processed\all_FAO", nogen
merge 1:1 wbcode year gender using "$data_processed\all_UN", nogen
*merge 1:1 wbcode year gender using "$data_processed\hci", nogen
lab def gender 0"Male/Female" 1"Male" 2"Female", replace
lab val gender gender
lab var wbcode "WB country code"
lab var year "Year"
lab var gender "Gender"
drop if missing(year)
*drop vacbcg vache // alison - 27 marzo 2023
drop vacbcg vache* // para verificar - se quiere borrar 1 variable vache con miniscula?  alison - 27 marzo 2023
save "$data_processed\complete_series", replace

*---------------------------------dataset----------------------------------*

use "$data_processed\complete_series", clear
*rename NUTRITION_ANAEMIA_CHILDREN_PREV NUTRITION_ANAEMIA_CHILDREN
rename * a_*
rename (a_wbcode a_year a_gender)(wbcode year gender)
reshape long a_, i(wbcode year gender) j(code) string
rename a_ value
append using "$data_processed\hci_web"
*replace code="NUTRITION_ANAEMIA_CHILDREN_PREV" if code=="NUTRITION_ANAEMIA_CHILDREN"
drop name
save "$data_processed\complete_series_wmetadata", replace
