*------------------------------------------------------------------------------*
*			   Series UNICEF, WID, WHO, UNESCO, FAO, UN, ILO
*------------------------------------------------------------------------------*
cls
set more off

 *--------------------------------Directories-------------------------------*
// global root "C:\Users\Nico\Documents\World Bank\Data Portal"
global root "C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator"
*global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\"
cd "${root}"
global portal    	  "$root\Data"
global data_raw 	  "$portal\Data_Raw"
global data_processed "$portal\Data_Processed" 

*------------------------Codes and Country names---------------------------*
import excel "$data_raw\Country codes & metadata\wbcodes_equiv_ILO.xlsx", firstrow clear
save "$data_processed\wbcodes_equiv_ILO", replace
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
import excel "$data_raw\Country codes & metadata\country_classification.xlsx", firstrow clear
save "$data_processed\country_class", replace


*--------------------------------------------------------------------------*
*----------------------------------UNICEF----------------------------------*
*--------------------------------------------------------------------------*

***** via API:

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

save "$data_processed\all_unicef", replace

*--------------------------------------------------------------------------*
*--------------------------------WDI online--------------------------------*
*--------------------------------------------------------------------------*
*Add using  WDI API
wbopendata, indicator(SP.ADO.TFRT;SP.REG.BRTH.ZS;SH.STA.MMRT.NE;SE.SEC.ENRR;SE.TER.ENRR;SH.DTH.NCOM.ZS;SP.DYN.LE00.IN;SE.PRM.CMPT.ZS;SE.SEC.CMPT.LO.ZS;SE.PRE.ENRR;SE.PRM.UNER.ZS; SE.XPD.CTOT.ZS; SH.XPD.CHEX.GD.ZS) long clear
rename countrycode wbcode
gen gender=0
keep wbcode year gender sp_ado_tfrt sp_reg_brth_zs sh_sta_mmrt_ne se_sec_enrr se_ter_enrr sh_dth_ncom_zs sp_dyn_le00_in se_prm_cmpt_zs se_sec_cmpt_lo_zs se_pre_enrr se_prm_uner_zs se_xpd_ctot_zs sh_xpd_chex_gd_zs
rename sp_ado_tfrt SP_ADO_TFRT
rename sp_reg_brth_zs SP_REG_BRTH_ZS
rename sh_sta_mmrt_ne SH_STA_MMRT_NE
rename se_sec_enrr SE_SEC_ENRR
rename se_ter_enrr SE_TER_ENRR
rename sh_dth_ncom_zs SH_DTH_NCOM_ZS
rename sp_dyn_le00_in SP_DYN_LE00_IN
rename se_prm_cmpt_zs SE_PRM_CMPT_ZS
rename se_sec_cmpt_lo_zs SE_SEC_CMPT_LO_ZS
rename se_pre_enrr SE_PRE_ENRR
rename se_prm_uner_zs SE_PRM_UNER_ZS
rename se_xpd_ctot_zs SE_XPD_CTOT_ZS
rename sh_xpd_chex_gd_zs SH_XPD_CHEX_GD_ZS
save "$data_processed/wdi", replace


****HCI
wbopendata, indicator(HD.HCI.EYRS; HD.HCI.EYRS.FE; HD.HCI.EYRS.MA; HD.HCI.STNT; HD.HCI.STNT.FE; HD.HCI.STNT.MA; HD.HCI.HLOS; HD.HCI.HLOS.FE; HD.HCI.HLOS.MA; HD.HCI.OVRL; HD.HCI.OVRL.FE; HD.HCI.OVRL.LB.FE; HD.HCI.OVRL.UB.FE; HD.HCI.OVRL.LB; HD.HCI.OVRL.MA; HD.HCI.OVRL.LB.MA; HD.HCI.OVRL.UB.MA; HD.HCI.OVRL.UB; HD.HCI.LAYS; HD.HCI.LAYS.FE; HD.HCI.LAYS.MA; HD.HCI.MORT; HD.HCI.MORT.FE; HD.HCI.MORT.MA; HD.HCI.AMRT; HD.HCI.AMRT.FE; HD.HCI.AMRT.MA) clear
// import excel "$data_raw\hci_web.xlsx", clear firstrow
rename indicatorname name
rename indicatorcode code
rename countrycode wbcode
drop countryname
bysort name code wbcode: gen n = _n
reshape long yr, i(name code wbcode n) j(year)
drop n name
drop if missing(code)
*Replace gender if it ends with _ma or _fe
gen gender = 0
replace gender = 1 if substr(code, -3, 3) == ".MA"
replace gender = 2 if substr(code, -3, 3) == ".FE"
* Remove gender from the indicator name. As the subinstr works from the left, we need to reverse the string to remove the last occurence of .MA or .FE (this avoids any potential bug generated from an indicator named .MA[something])
replace code = reverse(subinstr(reverse(code), "AM.", "", 1))  if substr(code, -3, 3) == ".MA"
replace code = reverse(subinstr(reverse(code), "EF.", "", 1))  if substr(code, -3, 3) == ".FE"
replace code = subinstr(code, ".", "_", .)
rename yr value
reshape wide value, i(wbcode year gender) j(code) string
rename value* *
drop region regionname adminregion adminregionname incomelevel incomelevelname lendingtype lendingtypename 
save "$data_processed\hci_web", replace

*--------------------------------all WDI------------------------------*
use "$data_processed\hci_web", clear
merge 1:1 wbcode year gender using "$data_processed\wdi", nogen
save "$data_processed\all_wdi", replace

*---------------------------------------------------------------------*
*---------------------------------WHO---------------------------------*	
*---------------------------------------------------------------------*
import delimited "$data_raw/all_who", clear
rename (country sex) (WHO_code gender)
replace gender = "1" if gender=="SEX_MLE"
replace gender = "2" if gender=="SEX_FMLE"
replace gender = "0" if gender=="SEX_BTSX"
replace gender = "." if gender=="NA"
destring gender, replace
* Adolescent suicide rate: keep age-standarized suicide rate for 15-19 years
drop if indicatorcode=="SDGSUICIDE" & agegroup!="AGEGROUP_YEARS15-19"
* Keep standard def in anaemia
drop if indicatorcode=="NUTRITION_ANAEMIA_CHILDREN_PREV" & severity!="NA"
* Drop missing countries
drop if WHO_code=="NA"
merge m:1 WHO_code using "$data_processed\Country codes\wbcodes_equiv_who", keep(3) nogen
*  5,497 observation have missing countryname
save "$data_processed/all_who", replace
drop WHO_countryname title severity agegroup timedimensionvalue v1
replace numericvalue="." if numericvalue=="NA"
destring numericvalue, replace 
rename numericvalue value 
replace indicatorcode="NUTRITION_ANAEMIA_CHILDREN" if indicatorcode=="NUTRITION_ANAEMIA_CHILDREN_PREV"
* standarized names to match 2023 version
// replace indicatorcode="insuf_activity" if indicatorcode=="NCD_PAC_ADO"
// replace indicatorcode="u5_anaemia" if indicatorcode=="NUTRITION_ANAEMIA_CHILDREN_PREV"
// replace indicatorcode="hypertension_30_79" if indicatorcode=="NCD_HYP_PREVALENCE_A"
// replace indicatorcode="obesity" if indicatorcode=="NCD_BMI_30A"
// replace indicatorcode="suicide_15_19" if indicatorcode=="SDGSUICIDE"
*replace indicatorcode="u5_pneu_cs" if indicatorcode==""
reshape wide value, i(wbcode wbcountryname gender year) j(indicatorcode) string
rename value* *
save "$data_processed/all_who", replace
* Pneumonya care seeking not available, use lata from last year for now
merge 1:1 wbcode year gender using "$data_processed\who_pneumonia_cs", nogen
drop WHO_code wbcountryname
rename NUTRITION_ANAEMIA_CHILDREN NUTRITION_ANAEMIA_CHILDREN_PREV
save "$data_processed/all_who", replace


*-----------------------------------------------------------------------*
*--------------------------------UIS------------------------------------*
*-----------------------------------------------------------------------*
* UIS API
import delimited "$data_raw/all_uis", clear
gen indic=""
replace indic = "repetition" if strpos(indicator, "Repetition rate in primary education (all grades),")
replace indic = "out_school" if strpos(indicator, "Out-of-school children of primary school age,")
replace indic = "NERT_1_CP" if strpos(indicator, "Total net enrolment rate, primary")
replace indic = "NERT_2_CP" if strpos(indicator, "Total net enrolment rate, lower secondary")
replace indic = "NERT_3_CP" if strpos(indicator, "Total net enrolment rate, upper secondary")
gen gender=0
replace gender=1 if strpos(indicator, "male")
replace gender=2 if strpos(indicator, "female")
keep if indic!=""
replace value="." if value=="NA"
destring value, replace
rename (time country) (year UNESCO_countryname)
drop v1 indicator
reshape wide value, i(UNESCO_countryname year gender) j(indic) string
rename value* *
merge m:1 UNESCO_countryname using "$data_processed\Country codes\wbcodes_equiv_unesco", nogen keep(2 3) 
drop UNESCO_code UNESCO_countryname wbcountryname
save "$data_processed/uis_1", replace

*UIS SDGs API
import delimited "$data_raw/SDG_data", clear
gen indic=""
replace indic="minprof_r_g23" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_READ" & dimensionseducationlevel=="GRAD23"
replace indic="minprof_r_endprim" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_READ" & dimensionseducationlevel=="PRIMAR"
replace indic="minprof_r_lowsec" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_READ" & dimensionseducationlevel=="LOWSEC"
replace indic="minprof_m_g23" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_MATH" & dimensionseducationlevel=="GRAD23"
replace indic="minprof_m_endprim" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_MATH" & dimensionseducationlevel=="PRIMAR"
replace indic="minprof_m_lowsec" if series=="SE_TOT_PRFL" & dimensionstypeofskill=="SKILL_MATH" & dimensionseducationlevel=="LOWSEC"
replace indic="QUTP_1" if series=="SE_TRA_GRDL" & dimensionseducationlevel=="PRIMAR"
replace indic="QUTP_2T3" if series=="SE_TRA_GRDL" & dimensionseducationlevel=="SECOND"
replace indic="SCHBSP_1_WELEC" if series=="SE_ACS_ELECT" & dimensionseducationlevel=="PRIMAR"
drop if indic==""
gen gender=0
replace gender=1 if dimensionssex=="MALE"
replace gender=2 if dimensionssex=="FEMALE"
rename (geoareaname timeperiodstart) (UNESCO_countryname year)
keep UNESCO_countryname year gender indic value
reshape wide value, i(UNESCO_countryname year gender) j(indic) string
rename value* *
merge m:1 UNESCO_countryname using "$data_processed\Country codes\wbcodes_equiv_unesco", nogen keep(2 3) 
drop UNESCO_code UNESCO_countryname wbcountryname
save "$data_processed/uis_2", replace

*UIS SDGs download
import excel using "$data_raw/SDG_Feb2024_long", clear firstrow	
replace Value=. if (Metadata=="Magnitude NOT APPLICABLE"|Metadata=="Magnitude NIL")		
drop if Value==.
gen indic=""
replace indic="OAEPG_1" if IndicatorNumber=="4.1.5" & strpos(IndicatorName, "primary")
replace indic="OAEPG_2_GPV" if IndicatorNumber=="4.1.5" & strpos(IndicatorName, "lower secondary")
replace indic="XGDP_FSGOV" if IndicatorNumber=="Education 2030 FFA"
replace indic="XGOVEXP_IMF" if IndicatorNumber=="1.a.2"
replace indic="youth_lit" if IndicatorNumber=="4.6.2"
replace indic="ECedu" if IndicatorNumber=="4.2.4" & strpos(IndicatorName,"Net enrolment rate, early childhood education,")
replace indic="GER_01" if IndicatorNumber=="4.2.4" & strpos(IndicatorName,"Net enrolment rate, early childhood educational development")
drop if indic==""
gen gender=0
replace gender=1 if strpos(IndicatorName,"male")
replace gender=2 if strpos(IndicatorName,"female")
rename (Country Year) (UNESCO_countryname year)
drop Target Region IndicatorName Metadata IndicatorNumber
reshape wide Value, i(UNESCO_countryname year gender) j(indic) string
rename Value* *
merge m:1 UNESCO_countryname using "$data_processed\Country codes\wbcodes_equiv_unesco", nogen keep(2 3) 
drop UNESCO_code UNESCO_countryname wbcountryname
save "$data_processed/uis_3", replace

*All UIS
use "$data_processed/uis_1", clear
merge 1:1 wbcode year gender using "$data_processed/uis_2", nogen
merge 1:1 wbcode year gender using "$data_processed/uis_3", nogen
save "$data_processed/all_uis", replace

*-----------------------------------------------------------------------*
*--------------------------------FAO------------------------------------*
*-----------------------------------------------------------------------*
*Low birthweight
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode=="21049"
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v21049
// replace v21049="0" if v21049=="<2.5"
lab var v21049 "Prevalence of low birthweight (%)"
drop if FlagDescription=="Missing value"
destring v21049, replace
destring year, replace
/* rename v21049 fao_stunting */
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
merge m:m FAO_countryname using "$data_processed\Country codes\wbcodes_equiv_FAO", nogen keep(3)
drop FAO_countryname wbcountryname FAO_code
save "$data_processed\FAO_lowbirthweight",replace

*Undernourishment
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode=="210041"
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v210041
// replace v210041="0" if v210041=="<2.5"
lab var v210041 "Prevalence of undernourishment (%) (3-year average, last year)"
drop if FlagDescription=="Missing value"
destring v210041, replace
destring year, replace
// rename v210041 fao_undern
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
merge m:m FAO_countryname using "$data_processed\Country codes\wbcodes_equiv_FAO", nogen keep(3)
drop FAO_countryname wbcountryname FAO_code
save "$data_processed\FAO_undernourishment",replace

*Wasting
import excel "$data_raw\FAOSTAT_data.xlsx", clear firstrow
rename Area FAO_countryname
gen gender = .
replace gender = 0
keep if ItemCode=="21026"
gen year = substr(Year,6,4)
replace year=Year if missing(year)
drop Year
rename Value v21026
lab var v21026 "Prevalence of children (<5y) affected by wasting, %"
drop if FlagDescription=="Missing value"
destring v21026, replace
destring year, replace
/* rename v21026 fao_wasting */
drop DomainCode Domain AreaCodeM49 ElementCode Element ItemCode Item YearCode Unit Flag FlagDescription Note
merge m:m FAO_countryname using "$data_processed\Country codes\wbcodes_equiv_FAO", nogen keep(3)
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
*Forcibly displaced population: * UPDATED
**Includes: Internal displaced population (IDPs), Refugees, Asylum-seekers and others.
import excel "$data_raw\UNHCR_Forced_Displacement", first clear
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


*Population per country: *PENDING
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

*Generate ratios
use "$data_processed\UNHCR_Forced_Displacement", clear
merge 1:1 wbcode year gender using "$data_processed\UN_population", nogen keep(3)
gen refug_pop = (refugees/1000000)/population
gen aseek_pop = (A_seekers/1000000)/population
gen idp_pop = (IDPs/1000000)/population
save "$data_processed\UN_forced_disp_rates", replace

*Family planning: UPDATED
import delimited "$data_raw\UN_family_planning.csv", clear
keep if indicatorname=="Demand for family planning satisfied by any method (Percent)"
keep if variant=="Median"
keep if category=="All women"
keep if estimatemethod=="Interpolation"
gen gender=.
replace gender=2 if sex=="Female"
replace gender=1 if sex=="Male"
replace gender=0 if sex=="Total"
rename location UNname
rename value met_fam_plan
rename time year
save "$data_processed\UN_family_planning", replace
use "$data_processed\Country codes\wbcodes_equiv_UN", clear
merge 1:m UNname using "$data_processed\UN_family_planning", nogen keep(3)
keep wbcode gender met_fam_plan year
save "$data_processed\UN_family_planning", replace
*---------------------------------all UN-----------------------------------*
use "$data_processed\UN_forced_disp_rates", clear
merge m:1 wbcode year gender using "$data_processed\UN_family_planning", nogen
save "$data_processed\all_UN", replace

*-----------------------------------------------------------------------*
*----------------------------------ILO----------------------------------*
*-----------------------------------------------------------------------*	
* Replaced with API
import delimited using "$data_raw/all_ILO", clear
rename (time obs_value ref_area) (year value ilocode)
* Gen gender variables
gen gender=.
replace gender=0 if sex=="SEX_T"
replace gender=1 if sex=="SEX_M"
replace gender=2 if sex=="SEX_F"

* Destring value
replace value="." if value=="NA"
destring value, replace
* Keep specific age cohorts according to each indicator definition
* Youth NEET
drop if id=="EIP_NEET_SEX_AGE_RT_A" & classif1!="AGE_5YRBANDS_TOTAL"
* Labor force participation
drop if id=="EAP_2WAP_SEX_AGE_RT_A" & classif1!="AGE_YTHADULT_YGE25"
* Skilled employment
drop if id=="EMP_TEMP_SEX_AGE_OCU_NB_A" & classif1!="AGE_YTHADULT_Y15-64"
drop if id=="EMP_TEMP_SEX_AGE_OCU_NB_A" & (classif2!="OCU_SKILL_TOTAL" & classif2!="OCU_SKILL_L3-4") 
replace id="HighSkill" if id=="EMP_TEMP_SEX_AGE_OCU_NB_A" & classif2!="OCU_SKILL_L3-4"
replace id="Total" if id=="EMP_TEMP_SEX_AGE_OCU_NB_A" & classif2!="OCU_SKILL_TOTAL"
* For informal employment, keep estimates with source LFS only 
drop if id=="EMP_NIFL_SEX_AGE_RT_A" & database!="LFS"

* Rename to dif adult and youth
local filtered "EIP_2WAP_SEX_AGE_RT_A EMP_NIFL_SEX_AGE_RT_A EMP_TEMP_SEX_AGE_OCU_NB_A LUU_2LU4_SEX_AGE_RT_A UNE_2EAP_SEX_AGE_RT_A"
foreach var in `filtered'{
replace id="`var'_y" if id=="`var'" & classif1=="AGE_YTHADULT_Y15-24"
replace id="`var'_a" if id=="`var'" & classif1=="AGE_YTHADULT_YGE25"
drop if id=="`var'"
}

* Reshape and generate new vars
keep id ilocode gender year value
reshape wide value, i(ilocode year gender) j(id) string
rename value* *
gen high_skill=HighSkill/Total
drop HighSkill Total
gen youth_adult_un = UNE_2EAP_SEX_AGE_RT_A_y/UNE_2EAP_SEX_AGE_RT_A_a

* Label variables
lab var EAP_2WAP_SEX_AGE_RT_A   "Labor force participation (%)"
lab var EIP_2WAP_SEX_AGE_RT_A_a "Adult inactivity rate (%)"
lab var EIP_2WAP_SEX_AGE_RT_A_y "Youth inactivity rate (%)"
lab var EIP_NEET_SEX_AGE_RT_A   "Youth NEET (%)"
lab var EMP_NIFL_SEX_AGE_RT_A_a "Adult informal employment rate (%)"
lab var EMP_NIFL_SEX_AGE_RT_A_y "Youth informal employment rate (%)"
lab var LUU_2LU4_SEX_AGE_RT_A_a "Adult composite measure of labour underutilization"
lab var LUU_2LU4_SEX_AGE_RT_A_y "Youth composite measure of labour underutilization"
lab var UNE_2EAP_SEX_AGE_RT_A_a "Adult unemployment (%)"
lab var UNE_2EAP_SEX_AGE_RT_A_y "Youth unemployment (%)"

* Match names with 2023 version to avoid problems with data portal
gen emp_2wap_mf_a = EAP_2WAP_SEX_AGE_RT_A if gender==0
gen emp_2wap_m_a = EAP_2WAP_SEX_AGE_RT_A if gender==1
gen emp_2wap_f_a = EAP_2WAP_SEX_AGE_RT_A if gender==2
drop if missing(gender)
preserve
keep ilocode year gender EAP_2WAP_SEX_AGE_RT_A
reshape wide EAP_2WAP_SEX_AGE_RT_A, i(ilocode year) j(gender)
gen gender=0
rename (EAP_2WAP_SEX_AGE_RT_A0 EAP_2WAP_SEX_AGE_RT_A1 EAP_2WAP_SEX_AGE_RT_A2) (emp_2wap_mf_a emp_2wap_m_a emp_2wap_f_a)
save "$data_processed/eap_2wap_reshaped", replace
restore
merge 1:1 ilocode year gender using "$data_processed/eap_2wap_reshaped", nogen
// rename EIP_2WAP_SEX_AGE_RT_A_a eip_2wap_a
// rename EIP_2WAP_SEX_AGE_RT_A_y eip_2wap_y
// rename EIP_NEET_SEX_AGE_RT_A eip_neet_mf_y
// rename EMP_NIFL_SEX_AGE_RT_A_a emp_nifl_a
// rename EMP_NIFL_SEX_AGE_RT_A_y emp_nifl_y
// rename LUU_2LU4_SEX_AGE_RT_A_a luu_2lu4_mf_a 
// rename LUU_2LU4_SEX_AGE_RT_A_y luu_2lu4_mf_y
// rename UNE_2EAP_SEX_AGE_RT_A_a une_2eap_mf_a
// rename UNE_2EAP_SEX_AGE_RT_A_y une_2eap_mf_y

save "$data_processed/all_ilo", replace
merge m:1 ilocode using "$data_processed\Country codes\wbcodes_equiv_ILO", nogen keep(3)
* NOT AVAILABLE: POTENTIAL LABOR FORCE. Use the one from last year for now
merge 1:1 wbcode year gender using "$data_processed/2023/potential_labor", nogen keep(3)
drop ilocode ilocountryname wbcountryname
save "$data_processed/all_ilo", replace


*--------------------------------World Bank--------------------------------*	
wbopendata, indicator(SE.LPV.PRIM) long clear
rename countrycode wbcode
gen gender=0
keep year wbcode se_lpv_prim gender
save"$data_processed/learning_poverty_t", replace 

wbopendata, indicator(SE.LPV.PRIM.FE) long clear
rename countrycode wbcode
gen gender=2
rename se_lpv_prim_fe se_lpv_prim
keep year wbcode se_lpv_prim gender
save"$data_processed/learning_poverty_f", replace 

wbopendata, indicator(SE.LPV.PRIM.MA) long clear
rename countrycode wbcode
gen gender=1
rename se_lpv_prim_ma se_lpv_prim
keep year wbcode se_lpv_prim gender
save"$data_processed/learning_poverty_m", replace 

append using "$data_processed/learning_poverty_f"
append using "$data_processed/learning_poverty_t"

save"$data_processed/learning_poverty", replace


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

use "$data_processed\all_unicef", clear
merge 1:1 wbcode year gender using "$data_processed\all_who", nogen
merge 1:1 wbcode year gender using "$data_processed\all_uis", nogen
merge 1:1 wbcode year gender using "$data_processed\all_FAO", nogen
merge 1:1 wbcode year gender using "$data_processed\all_UN", nogen
merge 1:1 wbcode year gender using "$data_processed\learning_poverty", nogen
merge 1:1 wbcode year gender using "$data_processed\UHCI", nogen
merge 1:m wbcode year gender using "$data_processed\all_wdi", nogen
merge m:m wbcode year gender using "$data_processed\all_ILO", nogen
lab def gender 0"Male/Female" 1"Male" 2"Female", replace
lab val gender gender
lab var wbcode "WB country code"
lab var year "Year"
lab var gender "Gender"
drop if missing(year)

save "$data_processed\complete_series", replace

*---------------------------------dataset----------------------------------*

use "$data_processed\complete_series", clear
rename NUTRITION_ANAEMIA_CHILDREN_PREV NUTRITION_ANAEMIA_CHILDREN
rename * a_*
rename (a_wbcode a_year a_gender)(wbcode year gender)
reshape long a_, i(wbcode year gender) j(code) string
rename a_ value
replace code="NUTRITION_ANAEMIA_CHILDREN_PREV" if code=="NUTRITION_ANAEMIA_CHILDREN"
save "$data_processed\complete_series_nometadata_$date$extra", replace

* FIX:
* Jordania Egipto y KZG en youth lit
* Azerbaijan en org leanring, comparar 2020 vs 2017


python:
import pandas as pd
from sfi import Macro

date = Macro.getGlobal("date")
extra = Macro.getGlobal("extra")
data_raw = Macro.getGlobal("data_raw")
data_processed = Macro.getGlobal("data_processed")
 
complete_series_wmetadata = pd.read_stata(fr"{data_processed}\complete_series_nometadata_{date}{extra}.dta")
names = pd.read_excel(fr"{data_raw}\Country codes & metadata\metadata.xlsx")
coded_names = names.code.str.replace(".","_").str.lower().unique()
variables = pd.Series(complete_series_wmetadata.code.str.replace(".","_").str.lower().unique())
assert variables.isin(coded_names).all(), f"There are indicators without metadata: {variables[-variables.isin(coded_names)]}"
print("####################")
print("All indicators have the respective metadata")
print("####################")
end