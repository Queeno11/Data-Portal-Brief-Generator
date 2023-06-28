*------------------------------------------------------------------------------*
*				Series UNICEF, WID, WHO, UNESCO, FAO, UN
*------------------------------------------------------------------------------*
cls
set more off
/* *--------------------------------Directories-------------------------------*
global root "C:\Users\Nico\Documents\World Bank\Data Portal"
*global root "C:\Users\llohi\Documents\WB\Data Portal"
*global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\"
cd "${root}"
global portal    	  "$root\Data"
global data_raw 	  "$portal\Data_Raw"
global data_processed "$portal\Data_Processed" */

*------------------------Codes and Country names---------------------------*
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_unicef.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_unicef", replace
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_FAO.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_FAO", replace
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_who.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_who", replace
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_UN.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_UN", replace
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_unesco.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes_equiv_unesco", replace
import excel "$data_raw\Country codes & metadata\wbcodes.xlsx", firstrow clear
save "$data_processed\Country codes\wbcodes", replace
import excel "$data_raw\country_classification.xlsx", firstrow clear
save "$data_processed\country_class", replace



*--------------------------------------------------------------------------*
*----------------------------------UNICEF----------------------------------*
*--------------------------------------------------------------------------*

*stillbirths *FIXME: no lo encontré en la API
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

***** NUEVOS via API:

use "$data_raw\UNICEF_api_${date}", clear
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

* Adds wbcode
merge m:1 unicef_code using "$data_processed\Country codes\wbcodes_equiv_unicef", nogen keep(3)
drop wbcountryname unicef_countryname unicef_code

* Adds stillbirth as is not in the API for some reason... FIXME: check why
merge 1:1 wbcode year gender using "$data_processed\unicef_stillbirths", nogen keep(3)

save "$data_processed\all_unicef", replace
	

*--------------------------------------------------------------------------*
*--------------------------------WDI online--------------------------------*
*--------------------------------------------------------------------------*

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

import excel "$data_raw\education_expenditure.xlsx", clear firstrow
rename IndicatorName name
rename CountryCode wbcode
rename CountryName wbcountryname
rename IndicatorCode code
bysort name code wbcode: gen n = _n
reshape long y, i(name code wbcode n) j(year)
drop n
drop if missing(name)
gen gender = 0
rename y value
save "$data_processed\educ_exp", replace

import excel "$data_raw\health_expenditure.xlsx", clear firstrow
rename IndicatorName name
rename CountryCode wbcode
rename CountryName wbcountryname
rename IndicatorCode code
bysort name code wbcode: gen n = _n
reshape long y, i(name code wbcode n) j(year)
drop n
drop if missing(name)
gen gender = 0
rename y value
save "$data_processed\health_exp", replace

*all WDI:
use "$data_processed\hci_web", clear
merge m:m wbcode using "$data_processed\educ_exp", nogen keep(3)
merge m:m wbcode using "$data_processed\health_exp", nogen keep(3)
save "$data_processed\wdi", replace

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
use "$data_processed\Country codes\wbcodes_equiv_who", clear
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
use "$data_processed\Country codes\wbcodes_equiv_who", clear
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
use "$data_processed\Country codes\wbcodes_equiv_who", clear
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
use "$data_processed\Country codes\wbcodes_equiv_who", clear
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
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_code using "$data_processed\unesco_repetition", nogen keep(3)
keep repetition year gender wbcode
save "$data_processed\unesco_repetition", replace

*Unesco minimum proficiency in reading and math:
*Reading, grades 2/3
import excel "$data_raw\unesco_minprof_r_G23.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_r_g23
gen gender=0
save "$data_processed\unesco_minprof_r_g23", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_r_g23", nogen keep(3)
keep wbcode year gender minprof_r_g23
save "$data_processed\unesco_minprof_r_g23", replace

*Reading, end primary
import excel "$data_raw\unesco_minprof_r_endprim.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_r_endprim
gen gender=0
save "$data_processed\unesco_minprof_r_endprim", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_r_endprim", nogen keep(3)
keep wbcode year gender minprof_r_endprim
save "$data_processed\unesco_minprof_r_endprim", replace

*Reading, end lower secondary
import excel "$data_raw\unesco_minprof_r_lowsec.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_r_lowsec
gen gender=0
save "$data_processed\unesco_minprof_r_lowsec", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_r_lowsec", nogen keep(3)
keep wbcode year gender minprof_r_lowsec
save "$data_processed\unesco_minprof_r_lowsec", replace

*Math, grades 2/3
import excel "$data_raw\unesco_minprof_m_G23.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_m_g23
gen gender=0
save "$data_processed\unesco_minprof_m_g23", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_m_g23", nogen keep(3)
keep wbcode year gender minprof_m_g23
save "$data_processed\unesco_minprof_m_g23", replace

*Math, end primary
import excel "$data_raw\unesco_minprof_m_endprim.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_m_endprim
gen gender=0
save "$data_processed\unesco_minprof_m_endprim", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_m_endprim", nogen keep(3)
keep wbcode year gender minprof_m_endprim
save "$data_processed\unesco_minprof_m_endprim", replace

*Math, end lower secondary
import excel "$data_raw\unesco_minprof_m_lowsec.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y minprof_m_lowsec
gen gender=0
save "$data_processed\unesco_minprof_m_lowsec", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_minprof_m_lowsec", nogen keep(3)
keep wbcode year gender minprof_m_lowsec
save "$data_processed\unesco_minprof_m_lowsec", replace

*Youth literacy rate
import excel "$data_raw\unesco_youthlit.xlsx", clear firstrow
bysort Country Region: gen n = _n
reshape long y, i(Country Region n) j(year)
drop n Region
rename Country UNESCO_countryname
rename y youth_lit
gen gender=0
save "$data_processed\unesco_youthlit", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_youthlit", nogen keep(3)
keep wbcode year gender youth_lit
save "$data_processed\unesco_youthlit", replace

*Out-of-school children, primary
import excel "$data_raw\unesco_outschool.xlsx", clear firstrow
drop FlagCodes Flags
drop TIME
rename NATMON_IND code
gen gender = .
replace gender = 2 if (code=="OFST_1_F_CP") 
replace gender = 1 if (code=="OFST_1_M_CP") 
replace gender = 0 if (code=="OFST_1_CP") 	
drop if gender==.
rename Country UNESCO_countryname
rename LOCATION UNESCO_code
rename Indicator name
rename Time year
rename Value out_school
lab var out_school "name"
save "$data_processed\unesco_outschool", replace
use "$data_processed\Country codes\wbcodes_equiv_unesco", clear
merge 1:m UNESCO_countryname using "$data_processed\unesco_outschool", nogen keep(3)
keep wbcode year gender out_school
save "$data_processed\unesco_outschool", replace

*-----------------------------all UNESCO---------------------------------*
use "$data_processed\unesco_ECedu", clear
merge 1:1 wbcode year gender using "$data_processed\unesco_repetition", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_r_g23", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_r_endprim", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_r_lowsec", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_m_g23", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_m_endprim", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_minprof_m_lowsec", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_youthlit", nogen
merge 1:1 wbcode year gender using "$data_processed\unesco_outschool", nogen
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

*Family planning:
import excel "$data_raw\UN_family_planning.xlsx", clear firstrow
keep if IndicatorName=="Demand for family planning satisfied by any method (Percent)"
keep if Variant=="Median"
gen gender=.
replace gender=2 if Sex=="Female"
replace gender=1 if Sex=="Male"
replace gender=0 if Sex=="Total"
rename Location UNname
rename Value met_fam_plan
rename Time year
save "$data_processed\UN_family_planning", replace
use "$data_processed\Country codes\wbcodes_equiv_UN", clear
merge 1:m UNname using "$data_processed\UN_family_planning", nogen keep(3)
keep wbcode gender met_fam_plan year
save "$data_processed\UN_family_planning", replace
*---------------------------------all UN-----------------------------------*
use "$data_processed\UNHCR_Forced_Displacement", clear
merge 1:1 wbcode year gender using "$data_processed\UN_population", nogen keep(3)
merge 1:m wbcode year gender using "$data_processed\UN_family_planning", nogen keep(3)
save "$data_processed\all_UN", replace

*-----------------------------------------------------------------------*
*----------------------------------ILO----------------------------------*
*-----------------------------------------------------------------------*	
*Employment high skill
import excel "$data_raw\employment_high_skill.xlsx", clear firstrow
keep if classif1label=="Age (Aggregate bands): Total"
gen gender=.
replace gender=2 if sexlabel=="Sex: Female"
replace gender=1 if sexlabel=="Sex: Male"
replace gender=0 if sexlabel=="Sex: Total"
drop if gender==. // There are sex==other that are stated as unreliable
rename ref_arealabel wbcountryname
rename classif2label name
rename time year
rename obs_value value
keep wbcountryname gender year name value
replace name="HighSkill" if name=="Occupation (Skill level): Skill levels 3 and 4 ~ high"
replace name="Total" if name=="Occupation (Skill level): Total"
reshape wide value, i(wbcountryname year gender) j(name) string
gen high_skill=valueHighSkill/valueTotal
save "$data_processed\ILO_highskill", replace
use "$data_processed\Country codes\wbcodes", clear
merge m:m wbcountryname using "$data_processed\ILO_highskill", nogen keep(3)
keep wbcode year gender high_skill
destring year, replace
save "$data_processed\ILO_highskill", replace

*youth/adult unemployment
*FIXME

*---------------------------------all ILO-----------------------------------*
use "$data_processed\ILO_highskill"
destring year, replace
save "$data_processed\all_ILO", replace

*------------------------ Utilization of HC (UHCI) ------------------------------*
import excel "$data_raw\UHCI_DataAppendix_Sep2020.xlsx", firstrow clear sheet("DataAppendix_UHCI")
gen gender = .
replace gender = 0 if Gender=="Total"
replace gender = 1 if Gender=="Male"
replace gender = 2 if Gender=="Female"
keep Countrycode gender UHCIbasic Year
rename (Countrycode UHCIbasic Year) (wbcode uhci year)

drop if uhci ==.
sort year
replace year = round(year)
duplicates drop wbcode year gender, force
save "$data_processed\UHCI", replace

*--------------------------------Merge all---------------------------------*

use "$data_processed\comp_series", clear // FIXME: ¿De donde sale este DTA? No es reproducible porque me falta lo que genera este archivo
drop vacbcg	vachepbb // Ya están en UNICEF API
merge 1:1 wbcode year gender using "$data_processed\all_unicef", nogen
merge 1:1 wbcode year gender using "$data_processed\all_who", nogen
merge 1:1 wbcode year gender using "$data_processed\all_unesco", nogen
merge 1:1 wbcode year gender using "$data_processed\all_FAO", nogen
merge 1:1 wbcode year gender using "$data_processed\all_UN", nogen
merge 1:1 wbcode year gender using "$data_processed\all_ILO", nogen
merge 1:1 wbcode year gender using "$data_processed\UHCI", nogen
lab def gender 0"Male/Female" 1"Male" 2"Female", replace
lab val gender gender
lab var wbcode "WB country code"
lab var year "Year"
lab var gender "Gender"
drop if missing(year)

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

python:
import pandas as pd
from sfi import Macro

data_raw = Macro.getGlobal("data_raw")
data_processed = Macro.getGlobal("data_processed")
 
complete_series_wmetadata = pd.read_stata(fr"{data_processed}\complete_series_wmetadata.dta")
names = pd.read_excel(fr"{data_raw}\Country codes & metadata\metadata.xlsx")
coded_names = names.code.unique()
variables = pd.Series(complete_series_wmetadata.code.unique())
assert variables.isin(coded_names).all(), f"There are indicators without metadata: {variables[-variables.isin(coded_names)]}"
print("####################")
print("All indicators have the respective metadata")
print("####################")
end