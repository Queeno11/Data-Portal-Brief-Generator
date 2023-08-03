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
ds wbcode wbcountryname wbregion wbincomegroup incomegroup hci* psurv* eyrs* test* qeyrs* asr* nostu* uhci* *_reg *_inc, not
local hcci = r(varlist)
egen has_hcci = rownonmiss(`hcci')
drop if has_hcci == 0 // Kosovo is the only case
drop has_hcci

*------------------------------Keep vars-----------------------------------*

*keep wb* unicef_neomort* unicef_mealfreq* vacBCG* uisger02* lastnm_mmrt* unicef_care* lastnm_birth_reg* unicef_breastf* unicef_diarrhoea* uiscr1* lastnm_sec_ger* vacHEPBB* se_lpv_prim* uiscr2* eip_neet_mf_y* lastnm_afr* lastnm_ter_ger* une_2eap_mf_y* emp_nifl_mf_y* eap_2wap_mf_a_f* eap_2wap_mf_a_m* sp_dyn_le00_in* lastnm_probdeath_ncd* une_2eap_mf_a* emp_nifl_mf_a* fao_prev_fsec_all* per_sa_allsa_cov_pop_tot* fao_water_stress_all* fao_food_prices* fao_prev_fsec_adf* unicef_sanitation* fao_prev_fsec_adm * unicef_water*

*----------------------------Country names---------------------------------*
gen wbcountrynameb=""
replace wbcountrynameb="the Comoros" if wbcountryname=="Comoros"
replace wbcountrynameb="the DRC" if wbcountryname=="Congo, Dem. Rep. "
replace wbcountryname="Democratic Republic of Congo" if wbcountryname=="Congo, Dem. Rep. "
replace wbcountrynameb="the Republic of Congo" if wbcountryname=="Congo, Rep. "
replace wbcountryname="Republic of Congo" if wbcountryname=="Congo, Rep. "
replace wbcountrynameb="Egypt" if wbcountryname=="Egypt, Arab Rep. "
replace wbcountryname="Arab Republic of Egypt" if wbcountryname=="Egypt, Arab Rep. "
replace wbcountrynameb="the Gambia" if wbcountryname=="Gambia, The"
replace wbcountryname="The Gambia" if wbcountryname=="Gambia, The"
replace wbcountrynameb="Iran" if wbcountryname=="Iran, Islamic Rep. "
replace wbcountryname="Islamic Republic of Iran" if wbcountryname=="Iran, Islamic Rep. "
replace wbcountrynameb="the Republic of Korea" if wbcountryname=="Korea, Rep. "
replace wbcountryname="Republic of Korea" if wbcountryname=="Korea, Rep. "
replace wbcountrynameb="the Kyrgyz Republic" if wbcountryname=="Kyrgyz Republic"
replace wbcountrynameb="North Macedonia" if wbcountryname=="North Macedonia"
replace wbcountryname="North Macedonia" if wbcountryname=="North Macedonia"
replace wbcountrynameb="the Netherlands" if wbcountryname=="Netherlands"
replace wbcountrynameb="the Czech Republic" if wbcountryname=="Czech Republic"
replace wbcountrynameb="the Philippines" if wbcountryname=="Philippines"
replace wbcountrynameb="the Russian Federation" if wbcountryname=="Russian Federation"
replace wbcountrynameb="the Seychelles" if wbcountryname=="Seychelles"
replace wbcountrynameb="the Slovak Republic" if wbcountryname=="Slovak Republic" 
replace wbcountrynameb="the Solomon Islands" if wbcountryname=="Solomon Islands"
replace wbcountrynameb="the United Arab Emirates" if wbcountryname=="United Arab Emirates"
replace wbcountrynameb="the United Kingdom" if wbcountryname=="United Kingdom"
replace wbcountrynameb="the United States" if wbcountryname=="United States"
replace wbcountrynameb="the West Bank and Gaza" if wbcountryname=="West Bank and Gaza"
replace wbcountrynameb="the Republic of Yemen" if wbcountryname=="Yemen, Rep. "
replace wbcountryname="Republic of Yemen" if wbcountryname=="Yemen, Rep. "
replace wbcountrynameb="the Bahamas" if wbcountryname=="Bahamas, The"
replace wbcountryname="The Bahamas" if wbcountryname=="Bahamas, The"
replace wbcountrynameb="Taiwan" if wbcountryname=="Taiwan, China"
replace wbcountryname="Taiwan" if wbcountryname=="Taiwan, China"
replace wbcountrynameb="the Dominican Republic" if wbcountryname=="Dominican Republic"
replace wbcountrynameb="CAR" if wbcountryname=="Central African Republic"
replace wbcountryname="Central African Republic" if wbcountryname=="Central African Republic"
replace wbcountrynameb="the Democratic People's Republic of Korea" if wbcountryname=="Korea, Dem. People's Rep. "
replace wbcountryname="Democratic People's Republic of Korea" if wbcountryname=="Korea, Dem. People's Rep. "
replace wbcountrynameb="Micronesia" if wbcountryname=="Micronesia, Fed. Sts. "
replace wbcountryname="Federated States of Micronesia" if wbcountryname=="Micronesia, Fed. Sts. "
replace wbcountrynameb="Macao" if wbcountryname=="Macao SAR, China"
replace wbcountrynameb="Hong Kong" if wbcountryname=="Hong Kong SAR, China"
replace wbcountrynameb="the Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountryname="Isle of Man" if wbcountryname=="Isle of Man"
replace wbcountrynameb="the Lao PDR" if wbcountryname=="Lao PDR"
replace wbcountryname="Lao People's Democratic Republic" if wbcountryname=="Lao PDR"
replace wbcountrynameb="the Marshall Islands" if wbcountryname=="Marshall Islands"
replace wbcountrynameb="the Northern Mariana Islands" if wbcountryname=="Northern Mariana Islands"
replace wbcountrynameb="Syria" if wbcountryname=="Syrian Arab Republic"
replace wbcountrynameb="Venezuela" if wbcountryname=="Venezuela, RB"
replace wbcountrynameb="the Virgin Islands" if wbcountryname=="Virgin Islands (U.S.)"
replace wbcountrynameb=wbcountryname if wbcountrynameb==""
	
gen wbcountrynameB = cond(regexm(wbcountrynameb, "^the "), "T"+ substr(wbcountrynameb, 2, .), wbcountrynameb)	

*--------------------------------HCI index---------------------------------*
gen hci_text_1 = ///
"A child born in " + wbcountrynameb + " just before the pandemic will be **" + strofreal(round(hci*100,1)) + "%**" ///
+ " as productive when she grows up as she could be if she enjoyed complete education and full health." if hci!=.

gen hci_text_2 = ///
cond(round(hci)>round(hci_reg) & round(hci_reg)<round(hci_lower) & round(hci)>round(hci_inc) & round(hci_inc)<round(hci_lower), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup + " (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_lower)> round(hci_reg) & round(hci)>round(hci_inc) & round(hci_lower)<round(hci_inc), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly higher than " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_reg)<round(hci_lower) & round(hci)<round(hci_inc) & round(hci_inc)<round(hci_upper), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)>round(hci_reg) & round(hci_reg)<round(hci_lower) & round(hci)<round(hci_inc) & round(hci_inc)>round(hci_upper), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)>round(hci_reg) & round(hci_lower)<round(hci_reg) & round(hci)>round(hci_inc) & round(hci_lower)>round(hci_inc), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and higher than for " + incomegroup + " (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)>round(hci_reg) & round(hci_reg)>round(hci_lower) & round(hci)>round(hci_inc) & round(hci_inc)>round(hci_lower), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_reg)>round(hci_lower) & round(hci)<round(hci_inc) & round(hci_inc)<round(hci_upper), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_reg)>round(hci_lower) & round(hci)<round(hci_inc) & round(hci_inc)>round(hci_upper), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)<round(hci_upper) & round(hci)>round(hci_inc) & round(hci_inc)<round(hci_lower), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)<round(hci_upper) & round(hci)>round(hci_inc) & round(hci_inc)>round(hci_lower), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)<round(hci_reg) & round(hci_reg)<round(hci_upper) & round(hci)<round(hci_inc) & round(hci_inc)<round(hci_upper), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_upper)> round(hci_reg) & round(hci)<round(hci_inc) & round(hci_upper)<round(hci_inc), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)>round(hci_upper) & round(hci)>round(hci_inc) & round(hci_inc)<round(hci_lower), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)>round(hci_upper) & round(hci)>round(hci_inc) & round(hci_inc)>round(hci_lower), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_upper)< round(hci_reg) & round(hci)<round(hci_inc) & round(hci_upper)>round(hci_inc), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) but slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)>round(hci_upper) & round(hci)<round(hci_inc) & round(hci_inc)>round(hci_upper), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)==round(hci_reg) & round(hci)==round(hci_inc), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)==round(hci_reg) & round(hci)>round(hci_inc) & round(hci_inc)<round(hci_lower), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)==round(hci_reg) & round(hci)>round(hci_inc) & round(hci_inc)>round(hci_lower), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly higher than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", ///
cond(round(hci)==round(hci_reg) & round(hci)<round(hci_inc) & round(hci_upper)<round(hci_inc), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)==round(hci_reg) & round(hci)<round(hci_inc) & round(hci_upper)>round(hci_inc), /// 
"This is similar to the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and slightly lower than for " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_lower)> round(hci_reg) & round(hci)==round(hci_inc), /// 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)>round(hci_reg) & round(hci_lower)<round(hci_reg) & round(hci)==round(hci_inc), /// 
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_reg)>round(hci_upper) & round(hci)==round(hci_inc), /// 
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
cond(round(hci)<round(hci_reg) & round(hci_upper)> round(hci_reg) & round(hci)==round(hci_inc), /// 
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg*100,1)) + "%) and similar to " + incomegroup +" (" + strofreal(round(hci_inc*100,1)) + "%).", /// 
""))))))))))))))))))))))))) if hci!=.

gen hci_text = hci_text_1 + " " + hci_text_2 + " " 
replace hci_text = "The data on HCI is not available in " + wbcountrynameb + "." if hci==.

*-------------------------------Components---------------------------------*

gen psurv_text = ///
"Of every 100 children born in " + wbcountrynameb + ", **" + strofreal(round(psurv,1)) + "** survive to age 5." if psurv!=.
replace psurv_text = "Internationally comparable data on proportion of live births that will survive until age 5 are not available for " + wbcountrynameb + "." if psurv==.

gen eyrs_text = ///
"In " + wbcountrynameb + ", a child who starts school at age 4 can expect to complete **" + strofreal(round(eyrs,0.1)) + " years**" ///
+ " of school by her 18th birthday." if eyrs!=.
replace eyrs_text = "Internationally comparable data on expected years of schooling are not available for " + wbcountrynameb + "." if eyrs==.

gen test_text = ///
"Students in " + wbcountrynameb + " score **" + strofreal(round(test,1))+ "**" ///
+ " on a scale where 625 represents advanced attainment and 300 represents minimum attainment." if test!=.
replace test_text = "Internationally comparable data on test scores are not available for " + wbcountrynameb + "." if test==.

gen qeyrs_text = ///
"Factoring in what children actually learn, expected years of school is only **" + strofreal(round(qeyrs,0.1)) + " years**." if qeyrs!=.
replace qeyrs_text = "Internationally comparable data on quality adjusted years of schooling are not available for " + wbcountrynameb + "." if qeyrs==.

gen asr_text = ///
"Across " + wbcountrynameb + ", the proportion of 15-year-olds that will survive until age 60 is **" + strofreal(round(asr,1)) + "**." ///
+ " This statistic is a proxy for the range of health risks that a child born today would experience as an adult under current conditions." if asr!=.
replace asr_text = "Internationally comparable data on adult survival are not available for " + wbcountrynameb + "." if asr==.

gen nostu_text = ///
"Approximately **" + strofreal(round(nostu,1)) + "** out of 100 children are **not stunted**." ///
+ " This means that **" + strofreal(round((100-nostu),1)) + "** out of 100 children are at risk of cognitive and physical limitations that can last a lifetime." if nostu!=.
replace nostu_text = "Internationally comparable data on stunting are not available for " + wbcountrynameb + "." if nostu==.

*-------------------------------UHCI---------------------------------*
*Gen variable for hci and uhci comparison:

*Calculate implicit unemployment rate:
gen not_employed = 1-(uhci/hci)

gen compare_uhci="more than half" if round(uhci)>50
replace compare_uhci="less than half" if round(uhci)<50
replace compare_uhci="half" if round(uhci)==50

gen comparegender_uhci="higher" if round(uhci_m)>round(uhci_f)
replace compare_uhci="lower" if round(uhci_m)<round(uhci_f)
replace compare_uhci="equal" if round(uhci_m)==round(uhci_f)

gen uhci_text = ///
"The Utilization-adjusted Human Capital Index (U-HCI), scales down the HCI by taking into account how many adults are not employed. The U-HCI for " + wbcountrynameb + " is **0" +  strofreal(round(uhci, 0.01)) + "**. Thus, children born today are only " + strofreal(round(uhci*100)) + "% as productive in adulthood as they could have been if they had access to full health and education, and they became fully employed adults."
replace uhci_text = "The data on the utilization-adjusted human capital index are not available for " + wbcountrynameb + ". The regional average for this indicator is **0" + strofreal(round(uhci_reg, 0.01)) + "** and the income group average is **0" + strofreal(round(uhci_inc, 0.01)) + "**." if uhci==.

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
				"`reginc_text' lower than the regional average (`reg_avg'`unit_reginc'). ", ///
				cond(`higher_than_regional', ///
				"`reginc_text' higher than the regional average (`reg_avg'`unit_reginc'). ", ///
				cond(`similar_than_regional', ///
				"`reginc_text' similar to the regional average (`reg_avg'`unit_reginc'). ", ///
				""))) if `indicator'!=. & wbcode=="`ctry'"
			}
			if mod(`i',2)==0 { // If i is even
				* Version 2. Example: "The indicator is below the regional average (32%) but above the income group average (42%)."
				local reginc_text ". The indicator is"
				capture gen `x'`m'_reginc_text = ""
				replace `x'`m'_reginc_text = ///
				cond(`lower_than_regional', ///
				"`reginc_text' below the regional average (`reg_avg'`unit_reginc'). ", ///
				cond(`higher_than_regional', ///
				"`reginc_text' above the regional average (`reg_avg'`unit_reginc'). ", ///
				cond(`similar_than_regional', ///
				"`reginc_text' similar to the regional average (`reg_avg'`unit_reginc'). ", ///
				""))) if `indicator'!=. & wbcode=="`ctry'"
			}
			drop selected
			
			local no_data_text "Internationally comparable data on this indicator is not available for `countryname'. The regional average for this indicator is `reg_avg'`unit_reginc', while within the income group, this indicator is `inc_avg'`unit_reginc'."
			
			local no_data_reg_text "Internationally comparable data on this indicator is not available for `countryname'. The income group average for this indicator is `inc_avg'`unit_reginc'."
			
			local no_data_inc_text "Internationally comparable data on this indicator is not available for `countryname'. The regional average for this indicator is `reg_avg'`unit_reginc'."
			
			local no_data_reginc_text "Internationally comparable data on this indicator is not available for `countryname'."


			

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
			replace `x'`m'_text = `x'`m'_no_data_start_text + ".** `no_data_text'" ///
				if `indicator'==. & `indicator'_reg!=. & `indicator'_inc!=. & wbcode=="`ctry'"
			* Only no_data_inc_text when no data or income data is available
			replace `x'`m'_text = `x'`m'_no_data_start_text + ".** `no_data_text'" ///
				if `indicator'==. & `indicator'_reg!=. & `indicator'_inc==. & wbcode=="`ctry'"
			* Only no_data_reg_text when no data or regional data is available
			replace `x'`m'_text = `x'`m'_no_data_start_text + ".** `no_data_text'" ///
				if `indicator'==. & `indicator'_reg==. & `indicator'_inc!=. & wbcode=="`ctry'"
			* Only no_data_reginc_text when no data or regional or income data is available
			replace `x'`m'_text = `x'`m'_no_data_start_text + ".** `no_data_text'" ///
				if `indicator'==. & `indicator'_reg==. & `indicator'_inc==. & wbcode=="`ctry'"	
			
				
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

capture gen change_up = e1_change_up+e2_change_up+e3_change_up+l1_change_up+l2_change_up+l3_change_up+h1_change_up+h2_change_up+h3_change_up+b1_change_up+b2_change_up+b3_change_up
capture gen change_down = e1_change_down+e2_change_down+e3_change_down+l1_change_down+l2_change_down+l3_change_down+h1_change_down+h2_change_down+h3_change_down+b1_change_down+b2_change_down+b3_change_down
capture gen unchanged = e1_unchanged+e2_unchanged+e3_unchanged+l1_unchanged+l2_unchanged+l3_unchanged+h1_unchanged+h2_unchanged+h3_unchanged+b1_unchanged+b2_unchanged+b3_unchanged

gen change_text = ""
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(change_down) + " went down." if (change_up!=0 & change_down!=0 & unchanged==0)
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(change_down) + " went down and " + strofreal(unchanged) + " remain unchanged." if (change_up!=0 & change_down!=0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, " + strofreal(change_up) + " out of twelve indicators increased, while " + strofreal(unchanged) + " remain unchanged." if (change_up!=0 & change_down==0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, " + strofreal(change_down) + " out of twelve indicators decreased, while " + strofreal(unchanged) + " remain unchanged." if (change_up==0 & change_down!=0 & unchanged!=0) 
replace change_text = "Comparing with the previous available data, all the indicators increased." if (change_up!=0 & change_down==0 & unchanged==0) 
replace change_text = "Comparing with the previous available data, all the indicators decreased." if (change_up==0 & change_down!=0 & unchanged==0) 
replace change_text = "Comparing with the previous available data, all the indicators remain unchanged." if (change_up==0 & change_down==0 & unchanged!=0) 

*drop *_start_text *_time_text *_reginc_text 
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

*---------------------------------Save-------------------------------------*	
	

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
