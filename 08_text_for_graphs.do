*------------------------------------------------------------------------------*
*								Text for graphs						 
*------------------------------------------------------------------------------*

	

// * Check that all indicators selected have a text:
import excel "$data_raw\Country codes & metadata/briefs_texts", firstrow clear
drop d_*
save "$data_processed\briefs_texts", replace

// use "$data_output\complete_series_wmd_${date}", clear
// merge m:1 name_portal using "$data_processed\briefs_texts", nogen keep(match)
// count if (rank!=. & rank!=0 & missing(start_text))
// assert r(N)==0

*--------------------------Local for page 2--------------------------*
* This locals are the selected indicators for each country based on the availability of data
* and the indicators ranking. They come from the previous do file.
use "$data_output\new_locals", clear
local n_locals = _N
split locals, limit(1) // Create a column with only the local names
gen is_local = .
display "Generating indicator locals, please wait..."
qui forvalues i = 1(1)`n_locals' {
	gen selected = .
	replace selected = 1 if _n==`i'
	sort selected is_local
	local name = locals1
	replace locals = subinstr(locals, "`name'", "", .) if selected==1 
	local value = locals
	local `name' `value'
	replace is_local = 1 if selected==1
	drop selected
}
assert mi(is_local)==0
display "Done!"
*-------------------------- text briefs to dta -----------------------------*

import excel "$data_raw\Country codes & metadata/briefs_texts", firstrow clear
drop d_*
save "$data_processed\briefs_texts", replace

*--------------------------------Load data---------------------------------*
frame change default
clear all
set more off	
set maxvar 32000
use "$data_output\data_briefs", replace

* Remove observations with no HCCI
ds wbcode wbcountryname wbcountrynameb wbcountrynameB wbregion wbincomegroup incomegroup hci* psurv* eyrs* test* qeyrs* asr* nostu* uhci* *_reg *_inc, not
local hcci = r(varlist)
egen has_hcci = rownonmiss(`hcci')
drop if has_hcci == 0 // Kosovo is the only case
drop has_hcci

*------------------------------Keep vars-----------------------------------*

*keep wb* unicef_neomort* unicef_mealfreq* vacBCG* uisger02* lastnm_mmrt* unicef_care* lastnm_birth_reg* unicef_breastf* unicef_diarrhoea* uiscr1* lastnm_sec_ger* vacHEPBB* se_lpv_prim* uiscr2* eip_neet_mf_y* lastnm_afr* lastnm_ter_ger* une_2eap_mf_y* emp_nifl_mf_y* eap_2wap_mf_a_f* eap_2wap_mf_a_m* sp_dyn_le00_in* lastnm_probdeath_ncd* une_2eap_mf_a* emp_nifl_mf_a* fao_prev_fsec_all* per_sa_allsa_cov_pop_tot* fao_water_stress_all* fao_food_prices* fao_prev_fsec_adf* unicef_sanitation* fao_prev_fsec_adm * unicef_water*

*-----------------------------First paragraph-----------------------------*
gen first_par = "**Human capital – knowledge, skills, and good health – empowers people to achieve their potential and drives economic growth.** This brief tracks progress by " + wbcountrynameb + " in building and using human capital. "

*--------------------------------HCI index---------------------------------*
gen hci_text_1 = ///
"A child born in " + wbcountrynameb + " will be **" + strofreal(round(hci*100,1)) + "%**" ///
+ " as productive when she grows up as she could be if she enjoyed complete education and full health." if hci!=.

gen h_hci=hci*100
gen h_hci_reg = hci_reg*100
gen h_hci_inc = hci_inc*100
gen h_hci_lower = hci_lower*100
gen h_hci_upper = hci_upper*100

gen hci_text_2 = ///
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg<h_hci_lower & round(h_hci)>round(h_hci_inc) & h_hci_inc<h_hci_lower, /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup + " (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_lower>h_hci_reg & round(h_hci)>round(h_hci_inc) & h_hci_lower<h_hci_inc, /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly higher than " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg<h_hci_lower & round(h_hci)<round(h_hci_inc) & h_hci_inc<h_hci_upper, /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg<h_hci_lower & round(h_hci)<round(h_hci_inc) & h_hci_inc>h_hci_upper, /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)>round(h_hci_reg) & h_hci_lower<h_hci_reg & round(h_hci)>round(h_hci_inc) & h_hci_lower>h_hci_inc, /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and higher than for " + incomegroup + " (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg>h_hci_lower & round(h_hci)>round(h_hci_inc) & h_hci_inc>h_hci_lower, /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg>h_hci_lower & round(h_hci)<round(h_hci_inc) & h_hci_inc<h_hci_upper, /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_reg>h_hci_lower & round(h_hci)<round(h_hci_inc) & h_hci_inc>h_hci_upper, /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg<h_hci_upper & round(h_hci)>round(h_hci_inc) & h_hci_inc<h_hci_lower, /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg<h_hci_upper & round(h_hci)>round(h_hci_inc) & h_hci_inc>h_hci_lower, /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg<h_hci_upper & round(h_hci)<round(h_hci_inc) & h_hci_inc<h_hci_upper, /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_upper>h_hci_reg & round(h_hci)<round(h_hci_inc) & h_hci_upper<h_hci_inc, /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg>h_hci_upper & round(h_hci)>round(h_hci_inc) & h_hci_inc<h_hci_lower, /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg>h_hci_upper & round(h_hci)>round(h_hci_inc) & h_hci_inc>h_hci_lower, /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_upper<h_hci_reg & round(h_hci)<round(h_hci_inc) & h_hci_upper>h_hci_inc, /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg>h_hci_upper & round(h_hci)<round(h_hci_inc) & h_hci_inc>h_hci_upper, /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)==round(h_hci_reg) & round(h_hci)==round(h_hci_inc), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)==round(h_hci_reg) & round(h_hci)>round(h_hci_inc) & h_hci_inc<h_hci_lower, /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)==round(h_hci_reg) & round(h_hci)>round(h_hci_inc) & h_hci_inc>h_hci_lower, /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(h_hci)==round(h_hci_reg) & round(h_hci)<round(h_hci_inc) & h_hci_upper<h_hci_inc, /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)==round(h_hci_reg) & round(h_hci)<round(h_hci_inc) & h_hci_upper>h_hci_inc, /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_lower>h_hci_reg & round(h_hci)==round(h_hci_inc), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)>round(h_hci_reg) & h_hci_lower<h_hci_reg & round(h_hci)==round(h_hci_inc), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & h_hci_reg>h_hci_upper & round(h_hci)==round(h_hci_inc), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(h_hci)<round(h_hci_reg) & round(h_hci_upper)> round(h_hci_reg) & round(h_hci)==round(h_hci_inc), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
""))))))))))))))))))))))))) if hci!=.

gen hci_text = hci_text_1 + " " + hci_text_2 + " " 
replace hci_text = "The data on HCI is not available in " + wbcountrynameb + "." if hci==.

*-------------------------------Components---------------------------------*

gen psurv_text = ///
"Of every 100 children born in " + wbcountrynameb + ", **" + strofreal(round(psurv,1)) + "** survive to age 5." if psurv!=.
replace psurv_text = "Internationally comparable data on probability of survival to age 5 are not available for " + wbcountrynameb + "." if psurv==.

gen eyrs_text = ///
"In " + wbcountrynameb + ", a child who starts school at age 4 can expect to complete **" + strofreal(round(eyrs,0.1)) + "** years" ///
+ " of school by her 18th birthday." if eyrs!=.
replace eyrs_text = "Internationally comparable data on expected years of schooling are not available for " + wbcountrynameb + "." if eyrs==.

gen test_text = ///
"Students in " + wbcountrynameb + " score **" + strofreal(round(test,1))+ "**" ///
+ " on a scale where 625 represents advanced attainment and 300 represents minimum attainment." if test!=.
replace test_text = "Internationally comparable data on test scores are not available for " + wbcountrynameb + "." if test==.

gen qeyrs_text = ///
"Factoring in what children actually learn, expected years of school is **" + strofreal(round(qeyrs,0.1)) + "** years." if qeyrs!=.
replace qeyrs_text = "Internationally comparable data on quality adjusted years of schooling are not available for " + wbcountrynameb + "." if qeyrs==.

gen asr_text = ///
"Across " + wbcountrynameb + ", **" + strofreal(round(asr,1)) + "%** of 15-year-olds that survive until age 60." if asr!=.
replace asr_text = "Internationally comparable data on adult survival are not available for " + wbcountrynameb + "." if asr==.

gen nostu_text = ///
"Approximately **" + strofreal(round(nostu,1)) + "** out of 100 children are not stunted." ///
+ " This means that **" + strofreal(100-round(nostu,1)) + "** out of 100 children are at risk of cognitive and physical limitations that can last a lifetime." if nostu!=.
replace nostu_text = "Internationally comparable data on stunting are not available for " + wbcountrynameb + "." if nostu==.

*-------------------------------UHCI---------------------------------*
*Gen variable for hci and uhci comparison:

*Calculate implicit unemployment rate:
gen not_employed = 1-(uhci/hci)

/* gen compare_uhci="more than half" if round(uhci, 0.01)>.5
replace compare_uhci="less than half" if round(uhci, 0.01)<.5
replace compare_uhci="half" if round(uhci, 0.01)==.5

gen comparegender_uhci="higher" if round(uhci_m, 0.01)>round(uhci_f, 0.01)
replace compare_uhci="lower" if round(uhci_m, 0.01)<round(uhci_f, 0.01)
replace compare_uhci="equal" if round(uhci_m, 0.01)==round(uhci_f, 0.01) */

gen uhci_text_1 = ///
	"The Utilization-adjusted Human Capital Index (U-HCI) scales down the HCI by taking into account how many adults are not employed. " 
replace uhci_text_1 = uhci_text_1 + ///
	"The U-HCI for " + wbcountrynameb + " is **" +  strofreal(round(uhci, 0.01), "%9.2f") + "**. Thus, children born today will be " + strofreal(round(uhci*100)) + "% as productive in adulthood as they could have been if they had access to full health and education, and they became fully employed adults. " if uhci!=.
replace uhci_text_1 = uhci_text_1 + ///
	"The data on the utilization-adjusted human capital index are not available for " + wbcountrynameb + ". The regional average for this indicator is **" + strofreal(round(uhci_reg, 0.01), "%9.2f") + "** and the income group average is **" + strofreal(round(uhci_inc, 0.01), "%9.2f") + "**. " if uhci==.

gen uhci_text_2 = ///
"The U-HCI for girls is even lower at " +  strofreal(round(uhci_f,0.01), "%9.2f") + "."
replace uhci_text_2 = "The U-HCI for boys is even lower at " +  strofreal(round(uhci_m,0.01), "%9.2f") + "." if round(uhci_m, 0.01)<round(uhci_f, 0.01)
replace uhci_text_2 = "The U-HCI for girls and boys are the same." if round(uhci_m, 0.01)==round(uhci_f, 0.01)
replace uhci_text_2 = "" if missing(uhci)
replace uhci_text_2 = "Data are not available for producing gender disaggregated HCI and U-HCI" if (missing(uhci_m) & missing(uhci_f) & missing(hci_m) & missing(hci_f) & !missing(uhci))
replace uhci_text_2 = "Data are not available for producing gender disaggregated U-HCI" if (missing(uhci_m) & missing(uhci_f) & !missing(hci_m) & !missing(hci_f) & !missing(uhci))
replace uhci_text_2 = "Data are not available for producing gender disaggregated HCI" if (!missing(uhci_m) & !missing(uhci_f) & missing(hci_m) & missing(hci_f) & !missing(uhci))

gen uhci_text = uhci_text_1 + uhci_text_2

// GENDER COMPARISON 

gen gender_comp_1= ///
cond((round(hci_f,0.01))>(round(hci_m,0.01)), "higher than", ///
cond((round(hci_f,0.01))<(round(hci_m,0.01)), "lower than", ///
"similar to the HCI")) if !missing(hci_f, hci_m)

gen gender_text_1= ///
"In " + wbcountrynameb + ", the HCI for girls is " + gender_comp + /// 
" for boys. The table below shows gender disaggregation for each "  + ///
"of the HCI components." if (gender_comp != "")

replace gender_text_1= ///
"In " + wbcountrynameb + ", lack of data prevents comparison of HCI by gender. The table below shows gender disaggregation for each of the HCI components, where available." if (gender_comp == "")
	
// SES-COMPARISON 
/* Not available online!!!!
gen ses_hci_text_1= ///
"The ratio in HCI between the richest and poorest 20% of the population in " + wbcountrynameb + ///
" is **" + strofreal(round(hci_ratio_q5q1,0.01),"%04.2f") + "** (global average: 1.35; global range: 1.12-1.68)." if hci_ratio_q5q1!=.
replace ses_hci_text_1= "There are insufficient data to disaggregate the HCI by socio-economic groups." if hci_ratio_q5q1 ==.
*/

*-----------------------------Complementary--------------------------------*

/* Acá queda sumar lo de 6 de 11 indicadores aumentaron... */

gen hcci_text = "Due to the slow-moving nature of the HCI, an additional set of Human Capital Complementary Indicators (HCCIs) offer a snapshot of proximate dimensions of human capital in " + wbcountrynameb +  " that can be monitored to measure simultaneous progress in intermediate outcomes. "

*---------------------------- Loop over Stages -------------------------------*

/* Tal vez conviene hace un texto genérico con valor del indicador + valor hace aprox 5 años y después hacer el if para region e ingreso. Pero para eso habría que partir este if. */ 
frame create metadata
frame change metadata
use "$data_processed/metadata_processed", clear
duplicates drop name_portal, force
merge 1:1 name_portal using "$data_processed/briefs_texts", keep(match) nogen
frame change default

*** Names of stages
// e -> school
// l -> early	
// h -> youth 
// b -> adults
*** Number of indicators per stage
local ne = 3
local nl = 3
local nh = 3
local nb = 3
levelsof wbcode, local(wb_country_codes) 
display "Generating texts, please wait..."
foreach ctry in `wb_country_codes' {
	foreach x in e b h l {
		local i = 1 // Counter for texts
		forvalues m = 1(1)`n`x'' {
			display "`ctry': local `x'`m'_`ctry' ``x'`m'_`ctry''"
			gen selected = 1 if wbcode=="`ctry'"
			sort selected // Put current country first so locals are from the current country
			local indicator ``x'`m'_`ctry''

			** Generate locals for text
			* Text locals
			local countryname = wbcountrynameb
			local ind_value = strofreal(round(`indicator',1))
			local ind_year = strofreal(`indicator'_year)
			local ind_value_prev = strofreal(round(`indicator'_prev,1))
			local ind_year_prev = strofreal(`indicator'_year_prev)
			local diff_year = strofreal(`indicator'_year - `indicator'_year_prev)
			local diff_value = strofreal(abs(round(`indicator')-round(`indicator'_prev)))
			local reg_avg = strofreal(round(`indicator'_reg,1))
			local inc_avg = strofreal(round(`indicator'_inc,1))

			* Time locals
			local lower_than_prev = (round(`indicator')<round(`indicator'_prev))
			local higher_than_prev = (round(`indicator')>round(`indicator'_prev))
			local similar_than_prev = (round(`indicator')==round(`indicator'_prev))

			* Comparisons with regional and income group averages locals
			local lower_than_regional = (round(`indicator')<round(`indicator'_reg))
			local higher_than_regional = (round(`indicator')>round(`indicator'_reg))
			local similar_than_regional = (round(`indicator')==round(`indicator'_reg))
			local lower_than_income = (round(`indicator')<round(`indicator'_inc))
			local higher_than_income = (round(`indicator')>round(`indicator'_inc))
			local similar_than_income = (round(`indicator')==round(`indicator'_inc))

			* Indicator metadata locals
			frame change metadata
			preserve
			keep if name_portal == "`indicator'"
			local ind_name = name // FIXME: check if its not better to create two new columns for the metadata with the text and units for the briefs
			local ind_scale = units
			local start_text = start_text
			local no_data_start_text = no_data_start_text
			local unit_time = unit_time
			local unit_reginc = unit_reginc
			restore
			frame change default

			*** Generate texts 
			** Generate main text
			capture gen `x'`m'_start_text = ""
			replace `x'`m'_start_text = "`start_text'" if wbcode=="`ctry'"
			capture gen `x'`m'_no_data_start_text = ""
			replace `x'`m'_no_data_start_text = "`no_data_start_text'" if wbcode=="`ctry'"

			** Generate time text:
			* Version 1. Example: ", changed from 7% (2021). // This remains unchanged since 2021."
			local time_comparison_text ", compared to `ind_value_prev'`unit_time' in `ind_year_prev'"
			capture gen `x'`m'_time_text = ""
			replace `x'`m'_time_text = ///
			cond(`lower_than_prev', "`time_comparison_text'", ///
			cond(`higher_than_prev', "`time_comparison_text'", ///
			cond(`similar_than_prev', ". This remains unchanged since `ind_year_prev'", ///
			""))) if `indicator'!=. & wbcode=="`ctry'"

			** Generate region and income text:
			if mod(`i',2)==1 { // If i is odd
				* Version 1. Example: "The indicator is lower than the regional average (83%)."
				local reginc_text ". The indicator is"
				capture gen `x'`m'_reginc_text = ""
				replace `x'`m'_reginc_text = ///
				cond(`lower_than_regional', /// 
				"`reginc_text' lower than the regional average. ", ///
				cond(`higher_than_regional', ///
				"`reginc_text' higher than the regional average. ", ///
				cond(`similar_than_regional', ///
				"`reginc_text' similar to the regional average. ", ///
				""))) if `indicator'!=. & wbcode=="`ctry'"
			}
			if mod(`i',2)==0 { // If i is even
				* Version 2. Example: "The indicator is below the regional average (32%) but above the income group average (42%)."
				local reginc_text ". The indicator is"
				capture gen `x'`m'_reginc_text = ""
				replace `x'`m'_reginc_text = ///
				cond(`lower_than_regional', ///
				"`reginc_text' below the regional average. ", ///
				cond(`higher_than_regional', ///
				"`reginc_text' above the regional average. ", ///
				cond(`similar_than_regional', ///
				"`reginc_text' similar to the regional average. ", ///
				""))) if `indicator'!=. & wbcode=="`ctry'"
			}
			drop selected
			
			local no_data_text "Internationally comparable data on this indicator is not available for `countryname'. The regional average for this indicator is `reg_avg'`unit_reginc'"
			
			local no_data_reg_text "Internationally comparable data on this indicator is not available for `countryname'."
			

			

			** Generate final text
			capture gen `x'`m'_text = ""
			* Full text when all data is there
			replace `x'`m'_text = `x'`m'_start_text + `x'`m'_time_text + `x'`m'_reginc_text ///
				if `indicator'!=. & `indicator'_prev!=. & `indicator'_reg!=. & wbcode=="`ctry'"
			* No time text when previous data is not available
			replace `x'`m'_text = `x'`m'_start_text + `x'`m'_reginc_text ///
				if `indicator'!=. & `indicator'_prev==. & `indicator'_reg!=. & wbcode=="`ctry'"
			* No regional/income text when regional data is not available
			replace `x'`m'_text = `x'`m'_start_text + `x'`m'_time_text ///
				if `indicator'!=. & `indicator'_prev!=. & `indicator'_reg==. & wbcode=="`ctry'"
			* No time nor regional/income text when previous data is not available
			replace `x'`m'_text = `x'`m'_start_text ///
				if `indicator'!=. & `indicator'_prev==. & `indicator'_reg==. & wbcode=="`ctry'"
			* Only no_data_text when no data is available for that indicator 
			replace `x'`m'_text = `x'`m'_no_data_start_text + "`no_data_text'" ///
				if `indicator'==. & `indicator'_reg!=. & `indicator'_inc!=. & wbcode=="`ctry'"
			* Only no_data_inc_text when no data or income data is available
			replace `x'`m'_text = `x'`m'_no_data_start_text + "`no_data_text'" ///
				if `indicator'==. & `indicator'_reg!=. & wbcode=="`ctry'"
			* Only no_data_reg_text when no data or regional data is available
			replace `x'`m'_text = `x'`m'_no_data_start_text + "`no_data_text'" ///
				if `indicator'==. & `indicator'_reg==. & wbcode=="`ctry'"
				
			** Generate text with a summary of changing indicators:
			capture gen `x'`m'_change_up = 0
			replace `x'`m'_change_up = 1 if (round(`indicator')>round(`indicator'_prev) & wbcode=="`ctry'")
			capture gen `x'`m'_change_down = 0
			replace `x'`m'_change_down = 1 if (round(`indicator')<round(`indicator'_prev) & wbcode=="`ctry'")
			capture gen `x'`m'_unchanged = 0
			replace `x'`m'_unchanged = 1 if (round(`indicator')==round(`indicator'_prev) & wbcode=="`ctry'")

			* increase counter
			local i = `i' + 1
		}
	}
	/* }
	if _rc == 0 display in red "Data for `ctry' not available" */
}	

/* capture gen change_up = e1_change_up+e2_change_up+e3_change_up+l1_change_up+l2_change_up+l3_change_up+h1_change_up+h2_change_up+h3_change_up+b1_change_up+b2_change_up+b3_change_up
capture gen change_down = e1_change_down+e2_change_down+e3_change_down+l1_change_down+l2_change_down+l3_change_down+h1_change_down+h2_change_down+h3_change_down+b1_change_down+b2_change_down+b3_change_down
capture gen unchanged = e1_unchanged+e2_unchanged+e3_unchanged+l1_unchanged+l2_unchanged+l3_unchanged+h1_unchanged+h2_unchanged+h3_unchanged+b1_unchanged+b2_unchanged+b3_unchanged

gen change_text = ""
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(change_down) + " went down." if (change_up!=0 & change_down!=0 & unchanged==0)
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(change_down) + " went down and " + strofreal(unchanged) + " remain unchanged." if (change_up!=0 & change_down!=0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(unchanged) + " remain unchanged." if (change_up!=0 & change_down==0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, " + strofreal(change_down) + " out of twelve indicators decreased, while " + strofreal(unchanged) + " remain unchanged." if (change_up==0 & change_down!=0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, all the indicators increased." if (change_up!=0 & change_down==0 & unchanged==0) 
replace change_text = "Comparing with the previous available data, all the indicators decreased." if (change_up==0 & change_down!=0 & unchanged==0) 
replace change_text = "Comparing with the previous available data, all the indicators remain unchanged." if (change_up==0 & change_down==0 & unchanged!=0)  */

drop *_start_text *_reginc_text 
display "Text correctly generated!"

*-----------------Round values in hci variables for tables-----------------* 
/*	
foreach var in hci_m hci_f hci psurv_m psurv_f psurv asr_m asr_f asr nostu_m nostu_f nostu eyrs_m eyrs_f eyrs qeyrs_m qeyrs_f qeyrs test_m test_f test {
drop `var'_t
}	
*/

foreach var in nostu asr psurv {
replace `var' = `var'/100
}

foreach var in hci uhci hci_f uhci_f hci_m uhci_m psurv asr nostu {
	gen `var'_t = strofreal(`var',"%04.2f")
	replace `var'_t = "-" if `var'==.
}
destring hci_t, replace
replace hci_t = hci_t/100

gen hci_t2 = strofreal(hci_t,"%04.2f")
drop hci_t 
rename hci_t2 hci_t

*---------------------------------Save-------------------------------------*	
	
/* keep wb* *text  *text_1 *text_2 hci_lower hci_upper hci_m hci_f hci hci_m hci_f hci hci_m hci_f hci psurv_m psurv_f psurv psurv_m psurv_f psurv psurv_m psurv_f psurv qeyrs_m qeyrs_f qeyrs qeyrs_m qeyrs_f qeyrs qeyrs_m qeyrs_f qeyrs eyrs_m eyrs_f eyrs eyrs_m eyrs_f eyrs eyrs_m eyrs_f eyrs test_m test_f test test_m test_f test test_m test_f test asr_m asr_f asr asr_m asr_f asr asr_m asr_f asr nostu_m nostu_f nostu nostu_m nostu_f nostu nostu_m nostu_f nostu hci_m_t hci_f_t hci_t psurv_m_t psurv_f_t psurv_t asr_m_t asr_f_t asr_t nostu_m_t nostu_f_t nostu_t eyrs_m_t eyrs_f_t eyrs_t qeyrs_m_t qeyrs_f_t qeyrs_t test_m_t test_f_t test_t */
	

save "$data_output\ordered_text", replace
exit
*--------------------------Merge to original base--------------------------*
* FIXME: que onda esto??
/**** Esto se hace porque nos habían pedido agregar algunos valores de indicadores, a parte de los name, lab y text para cada stage y orden ****/
/* Habría que chequear cuál de estos es el correcto (parecen pisarse) y borrar los que no sirvan */ 

use "$data_processed\text", clear
drop unicef_neomort_text unicef_mealfreq_text vacBCG_text uisger02_text uisger02_f_text uisger02_m_text uisger01_text lastnm_mmrt_text_1 unicef_care_text lastnm_birth_reg_text_1 unicef_breastf_text unicef_diarrhoea_text uiscr1_text uiscr1_f_text uiscr1_m_text lastnm_sec_ger_text_1 se_lpv_prim_text se_lpv_prim_f_text se_lpv_prim_m_text vacHEPBB_text uiscr2_text eip_neet_mf_y_text eip_neet_mf_y_f_text eip_neet_mf_y_m_text lastnm_afr_text_1 lastnm_ter_ger_text une_2eap_mf_y_text une_2eap_mf_y_f_text une_2eap_mf_y_m_text eap_dwap_mf_a_f_text eap_dwap_mf_a_m_text sp_dyn_le00_in_text sp_dyn_le00_in_f_text sp_dyn_le00_in_m_text lastnm_probdeath_ncd_text_1
merge 1:1 wbcode using "$charts\ordered_text", nogen 	
export excel "$charts\ordered_2", replace firstrow(variable) 
save "$charts\ordered_text", replace
	
preserve
use "$charts\ordered_text", clear
keep wbcode text_early* text_school* text_youth* text_adults*
order wbcode text_early* text_school* text_youth* text_adults*
export excel "$charts\ordered_text.csv", replace firstrow(variable) 
restore 

preserve
use "$charts\ordered_text", clear
keep wbcode text_early* text_school* text_youth* text_adults*
order wbcode text_early* text_school* text_youth* text_adults*
export excel "$charts\ordered_text.csv", replace firstrow(variable) 
restore 
