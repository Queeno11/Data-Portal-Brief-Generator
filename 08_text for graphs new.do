*------------------------------------------------------------------------------*
*								Text for graphs						   
*------------------------------------------------------------------------------*

*---------------------------------Pendings---------------------------------*	
	
	/*
	(Some) pendings for update:
	1 - check all texts and ifs (some minor errors were find last year, need for correction)
	2 - add text for new indicators
	3 - add text for previous 5 (approx) years
	*/
	

*--------------------------Local for page 2--------------------------*
* This locals are the selected indicators for each country based on the availability of data
* and the indicators ranking. They come from the previous do file.
use "$data_output\new_locals", clear
local n_locals = _N
split locals, limit(1) // Create a column with only the local names
gen is_local = .
forvalues i  = 1(1)`n_locals' {
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

*--------------------------------Load data---------------------------------*

	clear all
	set more off	
	set maxvar 32000
	use "$data_output\data_briefs", replace

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
"A child born in " + wbcountrynameb + " just before the pandemic will be **" + strofreal(round(hci,1)) + " percent**" ///
+ " as productive when she grows up as she could be if she enjoyed complete education and full health." if hci!=.

gen hci_text_2 = ///
cond(hci>hci_reg & hci_reg<hci_lower & hci>hci_inc & hci_inc<hci_lower, ///                 
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and " + incomegroup + " (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci>hci_reg & hci_lower> hci_reg & hci>hci_inc & hci_lower<hci_inc, ///                        
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and slightly higher than " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///    
cond(hci>hci_reg & hci_reg<hci_lower & hci<hci_inc & hci_inc<hci_upper, ///                        
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but slightly lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///
cond(hci>hci_reg & hci_reg<hci_lower & hci<hci_inc & hci_inc>hci_upper, ///                        
"This is higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///
cond(hci>hci_reg & hci_lower<hci_reg & hci>hci_inc & hci_lower>hci_inc, ///                      
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and higher than the average for " + incomegroup + " (" + strofreal(round(hci_inc,1)) + " percent).", ///
cond(hci>hci_reg & hci_reg>hci_lower & hci>hci_inc & hci_inc>hci_lower, ///                       
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///    
cond(hci>hci_reg & hci_reg>hci_lower & hci<hci_inc & hci_inc<hci_upper, ///                       
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but slightly lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci>hci_reg & hci_reg>hci_lower & hci<hci_inc & hci_inc>hci_upper, ///                       
"This is slightly higher than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci<hci_reg & hci_reg<hci_upper & hci>hci_inc & hci_inc<hci_lower, ///                     
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but higher than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///  
cond(hci<hci_reg & hci_reg<hci_upper & hci>hci_inc & hci_inc>hci_lower, ///                          
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but slightly higher than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///
cond(hci<hci_reg & hci_reg<hci_upper & hci<hci_inc & hci_inc<hci_upper, ///                         
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///     
cond(hci<hci_reg & hci_upper> hci_reg & hci<hci_inc & hci_upper<hci_inc, ///                         
"This is slightly lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", ///   
cond(hci<hci_reg & hci_reg>hci_upper & hci>hci_inc & hci_inc<hci_lower, ///                         
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but higher than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci<hci_reg & hci_reg>hci_upper & hci>hci_inc & hci_inc>hci_lower, ///                         
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but slightly higher than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci<hci_reg & hci_upper< hci_reg & hci<hci_inc & hci_upper>hci_inc, ///                         
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) but slightly lower than the average for " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
cond(hci<hci_reg & hci_reg>hci_upper & hci<hci_inc & hci_inc>hci_upper, ///                         
"This is lower than the average for the " + wbregion + " region (" + strofreal(round(hci_reg,1)) + " percent) and " + incomegroup +" (" + strofreal(round(hci_inc,1)) + " percent).", /// 
"")))))))))))))))) if hci!=.

gen hci_text = hci_text_1 + " " + hci_text_2 + " " 
replace hci_text = "The data on HCI is not available in " + wbcountrynameb + "." if hci==.

*-------------------------------Components---------------------------------*

gen psurv_text = ///
"**" + strofreal(round(psurv,1)) + "** out of 100 children born in " + wbcountrynameb + " survive to age 5." if psurv!=.
replace psurv_text = "Internationally comparable data on probability of survival to age 5 are not available for " + wbcountrynameb + "." if psurv==.

gen eyrs_text = ///
"In " + wbcountrynameb + ", a child who starts school at age 4 can expect to complete **" + strofreal(round(eyrs,0.1)) + " years**"  ///
+ " of school by her 18th birthday." if eyrs!=.
replace eyrs_text = "Internationally comparable data on expected years of schooling are not available for " + wbcountrynameb + "." if eyrs==.

gen test_text = ///
"Students in " + wbcountrynameb + " score **" + strofreal(round(test,1))+ "**" ///
+ " on a scale where 625 represents advanced attainment and 300 represents minimum attainment." if test!=.
replace test_text = "Internationally comparable data on test scores are not available for " + wbcountrynameb + "." if test==.

gen qeyrs_text = ///
"Factoring in what children actually learn, expected years of school is only **" + strofreal(round(qeyrs,0.1)) + " years**."  if qeyrs!=.
replace qeyrs_text = "Internationally comparable data on quality adjusted years of schooling are not available for " + wbcountrynameb + "." if qeyrs==.

gen asr_text = ///
"Across " + wbcountrynameb + ", **"  + strofreal(round(asr,1)) + " percent**" ///
+ " of 15-year olds will survive until age 60. This statistic is a proxy for the range of health risks that a child born today would experience as an adult under current conditions." if asr!=.
replace asr_text = "Internationally comparable data on adult survival are not available for " + wbcountrynameb + "." if asr==.

gen nostu_text = ///
"**" + strofreal(round(nostu,1)) + "** out of 100 children are **not** stunted." ///
+ " **" + strofreal(round((100-nostu),1)) +  "** out of 100 children are at risk of cognitive and physical limitations that can last a lifetime." if nostu!=.
replace nostu_text = "Internationally comparable data on stunting are not available for " + wbcountrynameb + "." if nostu==.

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
"The ratio in HCI between the richest and poorest 20 percent of the population in " + wbcountrynameb + ///
" is **" + strofreal(round(hci_ratio_q5q1,0.01),"%04.2f") + "** (global average: 1.35; global range: 1.12-1.68)." if hci_ratio_q5q1!=.
replace ses_hci_text_1= "There are insufficient data to disaggregate the HCI by socio-economic groups." if hci_ratio_q5q1 ==.
*/

*-----------------------------Complementary--------------------------------*

/* Acá queda sumar lo de 6 de 11 indicadores aumentaron... */

gen hcci_text = "Due to the slow moving nature of the HCI, an additional set of Human Capital Complementary Indicators (HCCIs) offer a snapshot of proximate dimensions of human capital in " + wbcountrynameb +  " that can be monitored to measure simultaneous progress in intermediate outcomes. "

*---------------------------- Loop over Stages -------------------------------*

/* Tal vez conviene hace un texto genérico con valor del indicador + valor hace aprox 5 años y después hacer el if para region e ingreso. Pero para eso habría que partir este if. */ 
frame create metadata
frame change metadata
use "$data_processed/metadata_processed"
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
foreach ctry in `wb_country_codes' {
	foreach x in e b h l {
		forvalues m = 1(1)`n`x'' {
			display "local `x'`m'_`ctry' ``x'`m'_`ctry''"
			local indicator ``x'`m'_`ctry''
			
			* Get indicator metadata as locals
			frame change metadata
			preserve
			keep if name_portal == "`indicator'"
			local ind_name = name // FIXME: check if its not better to create two new columns for the metadata with the text and units for the briefs
			local ind_scale = units
			restore
			frame change default
			
			* Comparisons with regional and income group averages
			local lower_than_regional = (round(`indicator')<round(`indicator'_reg))
			local higher_than_regional = (round(`indicator')>round(`indicator'_reg))
			local similar_than_regional = (round(`indicator')==round(`indicator'_reg))
			local lower_than_income = (round(`indicator')<round(`indicator'_inc))
			local higher_than_income = (round(`indicator')>round(`indicator'_inc))
			local similar_than_income = (round(`indicator')==round(`indicator'_inc))

			* Text locals
			local ind_value = strofreal(round(`indicator',1))
			local ind_year = strofreal(`indicator'_year)
			local reg_avg = strofreal(round(`indicator'_reg,1))
			local inc_avg = strofreal(round(`indicator'_inc,1))
			local main_text "The `ind_name' is **`ind_value' `ind_scale'** *(`ind_year')*"
			display "`main_text'"

			* Add regional comparison text and store in variable
			gen `x'`m'_text = ///
			cond(`lower_than_regional'   & `lower_than_income', /// 
			"`main_text', lower than both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
			cond(`higher_than_regional'  & `higher_than_income', ///
			"`main_text', higher than both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
			cond(`higher_than_regional'  & `lower_than_income', ///
			"`main_text', higher than the regional average (`reg_avg') but lower than the income group average (`inc_avg'). ", ///
			cond(`lower_than_regional'   & `higher_than_income', ///
			"`main_text', lower than the regional average (`reg_avg') but higher than the income group average (`inc_avg'). ", ///
			cond(`similar_than_regional' & `similar_than_income', ///
			"`main_text', similar to both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
			cond(`similar_than_regional' & `higher_than_income', ///
			"`main_text', similar to the regional average (`reg_avg') and higher than the income group average (`inc_avg'). ", ///
			cond(`similar_than_regional' & `lower_than_income', ///
			"`main_text', similar to the regional average (`reg_avg') and lower than the income group average (`inc_avg'). ", ///
			cond(`higher_than_regional'  & `similar_than_income', ///
			"`main_text', higher than the regional average (`reg_avg') and similar to the income group average (`inc_avg'). ", ///
			cond(`lower_than_regional'   & `similar_than_income', ///
			"`main_text', lower than the regional average (`reg_avg') and similar to the income group average (`inc_avg'). ", ///
			""))))))))) if `indicator'!=. & wbcode=="`ctry'"

		}
	stop
	}
}
stop
*------------------------*
*Neonatal mortality rate
*------------------------*
* Comparisons with regional and income group averages
local lower_than_regional = (round(unicef_neomort)<round(unicef_neomort_reg))
local higher_than_regional = (round(unicef_neomort)>round(unicef_neomort_reg))
local similar_than_regional = (round(unicef_neomort)==round(unicef_neomort_reg))
local lower_than_income = (round(unicef_neomort)<round(unicef_neomort_inc))
local higher_than_income = (round(unicef_neomort)>round(unicef_neomort_inc))
local similar_than_income = (round(unicef_neomort)==round(unicef_neomort_inc))

* Text locals
local ind_name = 
local ind_scale = 
local ind_value = strofreal(round(unicef_neomort,1))
local ind_year = strofreal(unicef_neomort_y)
local reg_avg = strofreal(round(unicef_neomort_reg,1))
local inc_avg = strofreal(round(unicef_neomort_inc,1))
local main_text = "The `ind_name' is **`ind_value' `ind_scale'** *(`ind_year')*"
	
* Generate text
gen unicef_neomort_text = ///
cond(`lower_than_regional'   & `lower_than_income', /// 
"`main_text', lower than both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
cond(`higher_than_regional'  & `higher_than_income', ///
"`main_text', higher than both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
cond(`higher_than_regional'  & `lower_than_income', ///
"`main_text', higher than the regional average (`reg_avg') but lower than the income group average (`inc_avg'). ", ///
cond(`lower_than_regional'   & `higher_than_income', ///
"`main_text', lower than the regional average (`reg_avg') but higher than the income group average (`inc_avg'). ", ///
cond(`similar_than_regional' & `similar_than_income', ///
"`main_text', similar to both the regional average (`reg_avg') and the income group average (`inc_avg'). ", ///
cond(`similar_than_regional' & `higher_than_income', ///
"`main_text', similar to the regional average (`reg_avg') and higher than the income group average (`inc_avg'). ", ///
cond(`similar_than_regional' & `lower_than_income', ///
"`main_text', similar to the regional average (`reg_avg') and lower than the income group average (`inc_avg'). ", ///
cond(`higher_than_regional'  & `similar_than_income', ///
"`main_text', higher than the regional average (`reg_avg') and similar to the income group average (`inc_avg'). ", ///
cond(`lower_than_regional'   & `similar_than_income', ///
"`main_text', lower than the regional average (`reg_avg') and similar to the income group average (`inc_avg'). ", ///
""))))))))) if unicef_neomort!=.

replace unicef_neomort_text = "Internationally comparable data on neonatal mortality rate are not available for " + wbcountrynameb + "." if unicef_neomort==.

*------------------------*
*Neonatal meal frequency
*------------------------*
gen unicef_mealfreq_text = ///
cond(round(unicef_mealfreq)<round(unicef_mealfreq_reg) & round(unicef_mealfreq)<round(unicef_mealfreq_inc), /// 
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, below both the regional (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) and income group (" + strofreal(round(unicef_mealfreq_inc,1)) +"%) averages. ", ///
cond(round(unicef_mealfreq)>round(unicef_mealfreq_reg) & round(unicef_mealfreq)>round(unicef_mealfreq_inc), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, above both the regional (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) and income group (" + strofreal(round(unicef_mealfreq_inc,1)) +"%) averages. ", ///
cond(round(unicef_mealfreq)>round(unicef_mealfreq_reg) & round(unicef_mealfreq)<round(unicef_mealfreq_inc), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, above the regional (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) average and below the income group (" + strofreal(round(unicef_mealfreq_inc,1)) +"%) average. ", ///
cond(round(unicef_mealfreq)<round(unicef_mealfreq_reg) & round(unicef_mealfreq)>round(unicef_mealfreq_inc), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, below the regional (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) average and above the income group (" + strofreal(round(unicef_mealfreq_inc,1)) +"%) average. ", ///
cond(round(unicef_mealfreq,1)==round(unicef_mealfreq_reg,1) & round(unicef_mealfreq,1)==round(unicef_mealfreq_inc,1), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, in line with both the regional (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) and income group (" + strofreal(round(unicef_mealfreq_inc,1)) +"%) averages. ", ///
cond(round(unicef_mealfreq,1)==round(unicef_mealfreq_reg,1) & round(unicef_mealfreq,1)>round(unicef_mealfreq_inc,1), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, in line with the regional average (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) but above the income group average (" + strofreal(round(unicef_mealfreq_inc,1)) +"%). ", ///
cond(round(unicef_mealfreq,1)==round(unicef_mealfreq_reg,1) & round(unicef_mealfreq,1)<round(unicef_mealfreq_inc,1), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, in line with the regional average (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) but below the income group average (" + strofreal(round(unicef_mealfreq_inc,1)) +"%). ", ///
cond(round(unicef_mealfreq,1)>round(unicef_mealfreq_reg,1) & round(unicef_mealfreq,1)==round(unicef_mealfreq_inc,1), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, above the regional average (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) and in line with the income group average (" + strofreal(round(unicef_mealfreq_inc,1)) +"%). ", ///
cond(round(unicef_mealfreq,1)<round(unicef_mealfreq_reg,1) & round(unicef_mealfreq,1)==round(unicef_mealfreq_inc,1), ///
"Adequate meal frequency among children 0-23 months is **" + strofreal(round(unicef_mealfreq,1)) +" percent** *(" + strofreal(unicef_mealfreq_y) + ")*, below the regional average (" + strofreal(round(unicef_mealfreq_reg,1)) + "%) and in line with the income group average (" + strofreal(round(unicef_mealfreq_inc,1)) +"%). ", ///
""))))))))) if unicef_mealfreq!=.
replace unicef_mealfreq_text = "Internationally comparable data on meal frequency are not available for " + wbcountrynameb + "." if unicef_mealfreq==.

*------------------------*
*Vaccination BCG
*------------------------*
gen vacBCG_text = ///
cond(round(vacBCG)<round(vacBCG_reg) & round(vacBCG)<round(vacBCG_inc), /// 
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, lower than both the regional and income group averages. ", ///
cond(round(vacBCG)>round(vacBCG_reg) & round(vacBCG)>round(vacBCG_inc), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, higher than both the regional and income group averages. ", ///
cond(round(vacBCG)>round(vacBCG_reg) & round(vacBCG)<round(vacBCG_inc), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, higher than the regional average but lower than the income group average. ", ///
cond(round(vacBCG)<round(vacBCG_reg) & round(vacBCG)>round(vacBCG_inc), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, lower than the regional average but higher than the income group average. ", ///
cond(round(vacBCG,1)==round(vacBCG_reg,1) & round(vacBCG,1)==round(vacBCG_inc,1), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, similar to both the regional and income group averages. ", ///
cond(round(vacBCG,1)==round(vacBCG_reg,1) & round(vacBCG,1)>round(vacBCG_inc,1), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, higher than the income group average but similar to the regional average. ", ///
cond(round(vacBCG,1)==round(vacBCG_reg,1) & round(vacBCG,1)<round(vacBCG_inc,1), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, lower than the income group average but similar than the regional average. ", ///
cond(round(vacBCG,1)>round(vacBCG_reg,1) & round(vacBCG,1)==round(vacBCG_inc,1), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, similar to the income group average but higher than the regional average. ", ///
cond(round(vacBCG,1)<round(vacBCG_reg,1) & round(vacBCG,1)==round(vacBCG_inc,1), ///
"The coverage of the BCG vaccine is **" + strofreal(round(vacBCG,1)) +" percent** *(" + strofreal(vacBCG_y) + ")*, similar to the income group average but lower than  the regional average. ", ///
""))))))))) if vacBCG!=.
replace vacBCG_text = "Internationally comparable data on BCG vaccine coverage are not available for " + wbcountrynameb + "." if vacBCG==.

*------------------------*
*Pre-primary gross enrollment ratio
*------------------------*
gen uisger02_text = ///
cond(round(uisger02)<round(uisger02_reg) & round(uisger02)<round(uisger02_inc), /// 
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, lower than both the regional and income group averages. ", ///
cond(round(uisger02)>round(uisger02_reg) & round(uisger02)>round(uisger02_inc), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, higher than both the regional and income group averages. ", ///
cond(round(uisger02)>round(uisger02_reg) & round(uisger02)<round(uisger02_inc), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, higher than the regional average and lower than the income group average. ", ///
cond(round(uisger02)<round(uisger02_reg) & round(uisger02)>round(uisger02_inc), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, lower than the regional average and higher than the income group average. ", ///
cond(round(uisger02,1)==round(uisger02_reg,1) & round(uisger02,1)==round(uisger02_inc,1), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, similar to both the regional and income group averages. ", ///
cond(round(uisger02,1)==round(uisger02_reg,1) & round(uisger02,1)>round(uisger02_inc,1), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, similar to the regional average and higher than the income group average. ", ///
cond(round(uisger02,1)==round(uisger02_reg,1) & round(uisger02,1)<round(uisger02_inc,1), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, similar to the regional average and lower than the income group average. ", ///
cond(round(uisger02,1)>round(uisger02_reg,1) & round(uisger02,1)==round(uisger02_inc,1), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, similar to the income group average and higher than the regional average. ", ///
cond(round(uisger02,1)<round(uisger02_reg,1) & round(uisger02,1)==round(uisger02_inc,1), ///
"The pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02,1)) +" percent** *(" + strofreal(uisger02_y) + ")*, similar to the income group average and lower than the regional average. ", ///
""))))))))) if uisger02!=.
replace uisger02_text = "Internationally comparable data on pre-primary school gross enrollment ratio are not available for " + wbcountrynameb + "." if uisger02==.

*------------------------*
*Pre-primary gross enrollment ratio, female
*------------------------*
gen uisger02_f_text = ///
cond(round(uisger02_f)<round(uisger02_f_reg) & round(uisger02_f)<round(uisger02_f_inc), /// 
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, lower than both the regional and income group averages. ", ///
cond(round(uisger02_f)>round(uisger02_f_reg) & round(uisger02_f)>round(uisger02_f_inc), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, higher than both the regional and income group averages. ", ///
cond(round(uisger02_f)>round(uisger02_f_reg) & round(uisger02_f)<round(uisger02_f_inc), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, higher than the regional average and lower than the income group average. ", ///
cond(round(uisger02_f)<round(uisger02_f_reg) & round(uisger02_f)>round(uisger02_f_inc), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, lower than the regional average and higher than the income group average. ", ///
cond(round(uisger02_f,1)==round(uisger02_f_reg,1) & round(uisger02_f,1)==round(uisger02_f_inc,1), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, similar to both the regional and income group averages. ", ///
cond(round(uisger02_f,1)==round(uisger02_f_reg,1) & round(uisger02_f,1)>round(uisger02_f_inc,1), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, similar to the regional average and higher than the income group average. ", ///
cond(round(uisger02_f,1)==round(uisger02_f_reg,1) & round(uisger02_f,1)<round(uisger02_f_inc,1), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, similar to the regional average and lower than the income group average. ", ///
cond(round(uisger02_f,1)>round(uisger02_f_reg,1) & round(uisger02_f,1)==round(uisger02_f_inc,1), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, similar to the income group average and higher than the regional average. ", ///
cond(round(uisger02_f,1)<round(uisger02_f_reg,1) & round(uisger02_f,1)==round(uisger02_f_inc,1), ///
"The female pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_f,1)) +" percent** *(" + strofreal(uisger02_f_y) + ")*, similar to the income group average and lower than the regional average. ", ///
""))))))))) if uisger02_f!=.
replace uisger02_f_text = "Internationally comparable data on female pre-primary school gross enrollment ratio are not available for " + wbcountrynameb + "." if uisger02_f==.

*------------------------*
*Pre-primary gross enrollment ratio, male
*------------------------*
gen uisger02_m_text = ///
cond(round(uisger02_m)<round(uisger02_m_reg) & round(uisger02_m)<round(uisger02_m_inc), /// 
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, lower than both the regional and income group averages. ", ///
cond(round(uisger02_m)>round(uisger02_m_reg) & round(uisger02_m)>round(uisger02_m_inc), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, higher than both the regional and income group averages. ", ///
cond(round(uisger02_m)>round(uisger02_m_reg) & round(uisger02_m)<round(uisger02_m_inc), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, higher than the regional average and lower than the income group average. ", ///
cond(round(uisger02_m)<round(uisger02_m_reg) & round(uisger02_m)>round(uisger02_m_inc), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, lower than the regional average and higher than the income group average. ", ///
cond(round(uisger02_m,1)==round(uisger02_m_reg,1) & round(uisger02_m,1)==round(uisger02_m_inc,1), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, similar to both the regional and income group averages. ", ///
cond(round(uisger02_m,1)==round(uisger02_m_reg,1) & round(uisger02_m,1)>round(uisger02_m_inc,1), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, similar to the regional average and higher than the income group average. ", ///
cond(round(uisger02_m,1)==round(uisger02_m_reg,1) & round(uisger02_m,1)<round(uisger02_m_inc,1), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, similar to the regional average and lower than the income group average. ", ///
cond(round(uisger02_m,1)>round(uisger02_m_reg,1) & round(uisger02_m,1)==round(uisger02_m_inc,1), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, similar to the income group average and higher than the regional average. ", ///
cond(round(uisger02_m,1)<round(uisger02_m_reg,1) & round(uisger02_m,1)==round(uisger02_m_inc,1), ///
"The male pre-primary school gross enrollment ratio is **" + strofreal(round(uisger02_m,1)) +" percent** *(" + strofreal(uisger02_m_y) + ")*, similar to the income group average and lower than the regional average. ", ///
""))))))))) if uisger02_m!=.
replace uisger02_m_text = "Internationally comparable data on male pre-primary school gross enrollment ratio are not available for " + wbcountrynameb + "." if uisger02_m==.

*------------------------*
*Gross enrolment ratio, early childhood educational development programs (%)
*------------------------*
gen uisger01_text = ///
cond(round(uisger01)<round(uisger01_reg) & round(uisger01)<round(uisger01_inc), /// 
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, lower than both the regional and income group averages. ", ///
cond(round(uisger01)>round(uisger01_reg) & round(uisger01)>round(uisger01_inc), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, higher than both the regional and income group averages. ", ///
cond(round(uisger01)>round(uisger01_reg) & round(uisger01)<round(uisger01_inc), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, higher than the regional average and lower than the income group average. ", ///
cond(round(uisger01)<round(uisger01_reg) & round(uisger01)>round(uisger01_inc), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, lower than the regional average and higher than the income group average. ", ///
cond(round(uisger01,1)==round(uisger01_reg,1) & round(uisger01,1)==round(uisger01_inc,1), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, similar to both the regional and income group averages. ", ///
cond(round(uisger01,1)==round(uisger01_reg,1) & round(uisger01,1)>round(uisger01_inc,1), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, similar to the regional average and higher than the income group average. ", ///
cond(round(uisger01,1)==round(uisger01_reg,1) & round(uisger01,1)<round(uisger01_inc,1), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, similar to the regional average and lower than the income group average. ", ///
cond(round(uisger01,1)>round(uisger01_reg,1) & round(uisger01,1)==round(uisger01_inc,1), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, similar to the income group average and higher than the regional average. ", ///
cond(round(uisger01,1)<round(uisger01_reg,1) & round(uisger01,1)==round(uisger01_inc,1), ///
"The gross enrollment ratio in early childhood educational development programs is **" + strofreal(round(uisger01,1)) +" percent** *(" + strofreal(uisger01_y) + ")*, similar to the income group average and lower than the regional average. ", ///
""))))))))) if uisger01!=.
replace uisger01_text = "Internationally comparable data on gross enrollment ratio in early childhood educational development programs are not available for " + wbcountrynameb + "." if uisger01==.

*------------------------*
*Maternal morality rate (per 100,000 live births)
*------------------------*
gen lastnm_mmrt_text_1 = ///
cond(round(lastnm_mmrt)<round(lastnm_mmrt_reg) & round(lastnm_mmrt)<round(lastnm_mmrt_inc), /// 
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is lower than both the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt)>round(lastnm_mmrt_reg) & round(lastnm_mmrt)>round(lastnm_mmrt_inc), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is higher than both the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt)>round(lastnm_mmrt_reg) & round(lastnm_mmrt)<round(lastnm_mmrt_inc), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is higher than the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and lower than the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt)<round(lastnm_mmrt_reg) & round(lastnm_mmrt)>round(lastnm_mmrt_inc), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is lower than the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and higher than the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt,1)==round(lastnm_mmrt_reg,1) & round(lastnm_mmrt,1)==round(lastnm_mmrt_inc,1), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is similar to both the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt,1)==round(lastnm_mmrt_reg,1) & round(lastnm_mmrt,1)>round(lastnm_mmrt_inc,1), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is similar to the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and higher than the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt,1)==round(lastnm_mmrt_reg,1) & round(lastnm_mmrt,1)<round(lastnm_mmrt_inc,1), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is similar to the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and lower than the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt,1)>round(lastnm_mmrt_reg,1) & round(lastnm_mmrt,1)==round(lastnm_mmrt_inc,1), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is higher than the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and similar to the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
cond(round(lastnm_mmrt,1)<round(lastnm_mmrt_reg,1) & round(lastnm_mmrt,1)==round(lastnm_mmrt_inc,1), ///
"For every 100,000 live births, **" + strofreal(round(lastnm_mmrt,1)) +" women** *(" + strofreal(lastnm_mmrt_y) + ")* die from pregnancy related causes. This is lower than the average for its region (" + strofreal(round(lastnm_mmrt_reg,1)) + ") and similar to the average for its income group (" + strofreal(round(lastnm_mmrt_inc,1)) + "). ", ///
""))))))))) if lastnm_mmrt!=.
replace lastnm_mmrt_text_1 = "Internationally comparable data on maternal mortality rate are not available for " + wbcountrynameb + "." if lastnm_mmrt==.

*------------------------*
*Newborns who have postnatal contact with health provider (within 2 days) (%)
*------------------------*
gen unicef_care_text = ///
cond(round(unicef_care)<round(unicef_care_reg) & round(unicef_care)<round(unicef_care_inc), /// 
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care)>round(unicef_care_reg) & round(unicef_care)>round(unicef_care_inc), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care)>round(unicef_care_reg) & round(unicef_care)<round(unicef_care_inc), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care)<round(unicef_care_reg) & round(unicef_care)>round(unicef_care_inc), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + "at the income group level. ", ///
cond(round(unicef_care,1)==round(unicef_care_reg,1) & round(unicef_care,1)==round(unicef_care_inc,1), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care,1)==round(unicef_care_reg,1) & round(unicef_care,1)>round(unicef_care_inc,1), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care,1)==round(unicef_care_reg,1) & round(unicef_care,1)<round(unicef_care_inc,1), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care,1)>round(unicef_care_reg,1) & round(unicef_care,1)==round(unicef_care_inc,1), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
cond(round(unicef_care,1)<round(unicef_care_reg,1) & round(unicef_care,1)==round(unicef_care_inc,1), ///
"**" + strofreal(round(unicef_care,1)) + " percent** *(" + strofreal(unicef_care_y) + ")* of newborns have postnatal contact with health providers during their first two days of life, compared to " + strofreal(round(unicef_care_reg,1)) + " at the regional level and " + strofreal(round(unicef_care_inc,1)) + " at the income group level. ", ///
""))))))))) if unicef_care!=.
replace unicef_care_text = "Internationally comparable data on having postnatal contact are not available for " + wbcountrynameb + "." if unicef_care==.

*------------------------*
*Completeness of birth registration (%)
*------------------------*
gen lastnm_birth_reg_text_1 = ///
cond(round(lastnm_birth_reg)<round(lastnm_birth_reg_reg) & round(lastnm_birth_reg)<round(lastnm_birth_reg_inc), /// 
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg)>round(lastnm_birth_reg_reg) & round(lastnm_birth_reg)>round(lastnm_birth_reg_inc), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg)>round(lastnm_birth_reg_reg) & round(lastnm_birth_reg)<round(lastnm_birth_reg_inc), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg)<round(lastnm_birth_reg_reg) & round(lastnm_birth_reg)>round(lastnm_birth_reg_inc), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg,1)==round(lastnm_birth_reg_reg,1) & round(lastnm_birth_reg,1)==round(lastnm_birth_reg_inc,1), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg,1)==round(lastnm_birth_reg_reg,1) & round(lastnm_birth_reg,1)>round(lastnm_birth_reg_inc,1), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg,1)==round(lastnm_birth_reg_reg,1) & round(lastnm_birth_reg,1)<round(lastnm_birth_reg_inc,1), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg,1)>round(lastnm_birth_reg_reg,1) & round(lastnm_birth_reg,1)==round(lastnm_birth_reg_inc,1), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
cond(round(lastnm_birth_reg,1)<round(lastnm_birth_reg_reg,1) & round(lastnm_birth_reg,1)==round(lastnm_birth_reg_inc,1), ///
"Complete birth registration is **" + strofreal(round(lastnm_birth_reg,1)) + " percent** *(" + strofreal(lastnm_birth_reg_y) + ")*, compared to " + strofreal(round(lastnm_birth_reg_reg,1)) + " at the regional level and " + strofreal(round(lastnm_birth_reg_inc,1)) + " at the income group level. ", ///
""))))))))) if lastnm_birth_reg!=.
replace lastnm_birth_reg_text_1 = "Internationally comparable data on complete birth registration are not available for " + wbcountrynameb + "." if lastnm_birth_reg==.

*------------------------*
*Infants 0–5 months who are fed exclusively with breast milk (%)
*------------------------*
gen unicef_breastf_text = ///
cond(round(unicef_breastf)<round(unicef_breastf_reg) & round(unicef_breastf)<round(unicef_breastf_inc), /// 
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, lower than both the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) and the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf)>round(unicef_breastf_reg) & round(unicef_breastf)>round(unicef_breastf_inc), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, higher than both the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) and the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf)>round(unicef_breastf_reg) & round(unicef_breastf)<round(unicef_breastf_inc), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, higher than the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but lower than the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf)<round(unicef_breastf_reg) & round(unicef_breastf)>round(unicef_breastf_inc), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, lower than the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but higher than the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf,1)==round(unicef_breastf_reg,1) & round(unicef_breastf,1)==round(unicef_breastf_inc,1), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, similar to the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) and the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf,1)==round(unicef_breastf_reg,1) & round(unicef_breastf,1)>round(unicef_breastf_inc,1), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, similar to the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but higher than the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf,1)==round(unicef_breastf_reg,1) & round(unicef_breastf,1)<round(unicef_breastf_inc,1), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, similar to the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but lower than the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf,1)>round(unicef_breastf_reg,1) & round(unicef_breastf,1)==round(unicef_breastf_inc,1), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, higher than the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but similar to the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
cond(round(unicef_breastf,1)<round(unicef_breastf_reg,1) & round(unicef_breastf,1)==round(unicef_breastf_inc,1), ///
"**" + strofreal(round(unicef_breastf,1)) + " percent** *(" + strofreal(unicef_breastf_y) + ")* of infants 0-5 months are fed excusively with breast milk, lower than the regional average (" + strofreal(round(unicef_breastf_reg,1)) + "%) but similar to the income group average (" + strofreal(round(unicef_breastf_inc,1)) + "%). ", ///
""))))))))) if unicef_breastf!=.
replace unicef_breastf_text = "Internationally comparable data on infants 0-5 months that are fed excusively with breast milk are not available for " + wbcountrynameb + "." if unicef_breastf==.

*------------------------*
*Children (age<5) with diarrhea who attended health facility (%)
*------------------------*
gen unicef_diarrhoea_text = ///
cond(round(unicef_diarrhoea)<round(unicef_diarrhoea_reg) & round(unicef_diarrhoea)<round(unicef_diarrhoea_inc), /// 
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea)>round(unicef_diarrhoea_reg) & round(unicef_diarrhoea)>round(unicef_diarrhoea_inc), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea)>round(unicef_diarrhoea_reg) & round(unicef_diarrhoea)<round(unicef_diarrhoea_inc), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea)<round(unicef_diarrhoea_reg) & round(unicef_diarrhoea)>round(unicef_diarrhoea_inc), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea,1)==round(unicef_diarrhoea_reg,1) & round(unicef_diarrhoea,1)==round(unicef_diarrhoea_inc,1), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea,1)==round(unicef_diarrhoea_reg,1) & round(unicef_diarrhoea,1)>round(unicef_diarrhoea_inc,1), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea,1)==round(unicef_diarrhoea_reg,1) & round(unicef_diarrhoea,1)<round(unicef_diarrhoea_inc,1), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea,1)>round(unicef_diarrhoea_reg,1) & round(unicef_diarrhoea,1)==round(unicef_diarrhoea_inc,1), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
cond(round(unicef_diarrhoea,1)<round(unicef_diarrhoea_reg,1) & round(unicef_diarrhoea,1)==round(unicef_diarrhoea_inc,1), ///
"The share of children (ages 0-5) with diarrhea who attended a health facility is **" + strofreal(round(unicef_diarrhoea,1)) + " percent** *(" + strofreal(unicef_diarrhoea_y) + ")*. ", ///
""))))))))) if unicef_diarrhoea!=.
replace unicef_diarrhoea_text = "Internationally comparable data on share of children with diarrhea who attended a health facility are not available for " + wbcountrynameb + "." if unicef_diarrhoea==.

*------------------------------School age----------------------------------*

*------------------------*
*Primary completion rate (%)
*------------------------*
gen uiscr1_text = ///
cond(round(uiscr1)<round(uiscr1_reg) & round(uiscr1)<round(uiscr1_inc), /// 
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, lower than both the regional (" + strofreal(round(uiscr1_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_inc,1)) + "%) averages. ", ///
cond(round(uiscr1)>round(uiscr1_reg) & round(uiscr1)>round(uiscr1_inc), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, higher than both the regional (" + strofreal(round(uiscr1_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_inc,1)) + "%) averages. ", ///
cond(round(uiscr1)>round(uiscr1_reg) & round(uiscr1)<round(uiscr1_inc), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
cond(round(uiscr1)<round(uiscr1_reg) & round(uiscr1)>round(uiscr1_inc), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
cond(round(uiscr1,1)==round(uiscr1_reg,1) & round(uiscr1,1)==round(uiscr1_inc,1), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, similar to both the regional (" + strofreal(round(uiscr1_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_inc,1)) + "%) averages. ", ///
cond(round(uiscr1,1)==round(uiscr1_reg,1) & round(uiscr1,1)>round(uiscr1_inc,1), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
cond(round(uiscr1,1)==round(uiscr1_reg,1) & round(uiscr1,1)<round(uiscr1_inc,1), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
cond(round(uiscr1,1)>round(uiscr1_reg,1) & round(uiscr1,1)==round(uiscr1_inc,1), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
cond(round(uiscr1,1)<round(uiscr1_reg,1) & round(uiscr1,1)==round(uiscr1_inc,1), ///
"Primary school completion rate is **" + strofreal(round(uiscr1,1)) + " percent** *(" + strofreal(uiscr1_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_inc,1)) + "%). ", ///
""))))))))) if uiscr1!=.
replace uiscr1_text = "Internationally comparable data on primary school completion rate are not available for " + wbcountrynameb + "." if uiscr1==.

*------------------------*
*Primary completion rate (%), female
*------------------------*
gen uiscr1_f_text = ///
cond(round(uiscr1_f)<round(uiscr1_f_reg) & round(uiscr1_f)<round(uiscr1_f_inc), /// 
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, lower than both the regional (" + strofreal(round(uiscr1_f_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_f_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_f)>round(uiscr1_f_reg) & round(uiscr1_f)>round(uiscr1_f_inc), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, higher than both the regional (" + strofreal(round(uiscr1_f_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_f_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_f)>round(uiscr1_f_reg) & round(uiscr1_f)<round(uiscr1_f_inc), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
cond(round(uiscr1_f)<round(uiscr1_f_reg) & round(uiscr1_f)>round(uiscr1_f_inc), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
cond(round(uiscr1_f,1)==round(uiscr1_f_reg,1) & round(uiscr1_f,1)==round(uiscr1_f_inc,1), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, similar to both the regional (" + strofreal(round(uiscr1_f_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_f_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_f,1)==round(uiscr1_f_reg,1) & round(uiscr1_f,1)>round(uiscr1_f_inc,1), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
cond(round(uiscr1_f,1)==round(uiscr1_f_reg,1) & round(uiscr1_f,1)<round(uiscr1_f_inc,1), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
cond(round(uiscr1_f,1)>round(uiscr1_f_reg,1) & round(uiscr1_f,1)==round(uiscr1_f_inc,1), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
cond(round(uiscr1_f,1)<round(uiscr1_f_reg,1) & round(uiscr1_f,1)==round(uiscr1_f_inc,1), ///
"Female primary school completion rate is **" + strofreal(round(uiscr1_f,1)) + " percent** *(" + strofreal(uiscr1_f_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_f_inc,1)) + "%). ", ///
""))))))))) if uiscr1_f!=.
replace uiscr1_f_text = "Internationally comparable data on female primary school completion rate are not available for " + wbcountrynameb + "." if uiscr1_f==.

*------------------------*
*Primary completion rate (%), male
*------------------------*
gen uiscr1_m_text = ///
cond(round(uiscr1_m)<round(uiscr1_m_reg) & round(uiscr1_m)<round(uiscr1_m_inc), /// 
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, lower than both the regional (" + strofreal(round(uiscr1_m_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_m_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_m)>round(uiscr1_m_reg) & round(uiscr1_m)>round(uiscr1_m_inc), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, higher than both the regional (" + strofreal(round(uiscr1_m_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_m_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_m)>round(uiscr1_m_reg) & round(uiscr1_m)<round(uiscr1_m_inc), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
cond(round(uiscr1_m)<round(uiscr1_m_reg) & round(uiscr1_m)>round(uiscr1_m_inc), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
cond(round(uiscr1_m,1)==round(uiscr1_m_reg,1) & round(uiscr1_m,1)==round(uiscr1_m_inc,1), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, similar to both the regional (" + strofreal(round(uiscr1_m_reg,1)) + "%) and income group (" + strofreal(round(uiscr1_m_inc,1)) + "%) averages. ", ///
cond(round(uiscr1_m,1)==round(uiscr1_m_reg,1) & round(uiscr1_m,1)>round(uiscr1_m_inc,1), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
cond(round(uiscr1_m,1)==round(uiscr1_m_reg,1) & round(uiscr1_m,1)<round(uiscr1_m_inc,1), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, similar to the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
cond(round(uiscr1_m,1)>round(uiscr1_m_reg,1) & round(uiscr1_m,1)==round(uiscr1_m_inc,1), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, higher than the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
cond(round(uiscr1_m,1)<round(uiscr1_m_reg,1) & round(uiscr1_m,1)==round(uiscr1_m_inc,1), ///
"Male primary school completion rate is **" + strofreal(round(uiscr1_m,1)) + " percent** *(" + strofreal(uiscr1_m_y) + ")*, lower than the regional average (" + strofreal(round(uiscr1_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr1_m_inc,1)) + "%). ", ///
""))))))))) if uiscr1_m!=.
replace uiscr1_m_text = "Internationally comparable data on male primary school completion rate are not available for " + wbcountrynameb + "." if uiscr1_m==.

*------------------------*
*Gross secondary enrollment (%)
*------------------------*

gen lastnm_sec_ger_text_1 = ///
cond(round(lastnm_sec_ger)<round(lastnm_sec_ger_reg) & round(lastnm_sec_ger)<round(lastnm_sec_ger_inc), /// 
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, lower than both the regional (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_sec_ger)>round(lastnm_sec_ger_reg) & round(lastnm_sec_ger)>round(lastnm_sec_ger_inc), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, higher than both the regional (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_sec_ger)>round(lastnm_sec_ger_reg) & round(lastnm_sec_ger)<round(lastnm_sec_ger_inc), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, higher than the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and lower than the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
cond(round(lastnm_sec_ger)<round(lastnm_sec_ger_reg) & round(lastnm_sec_ger)>round(lastnm_sec_ger_inc), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, lower than the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and higher than the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
cond(round(lastnm_sec_ger,1)==round(lastnm_sec_ger_reg,1) & round(lastnm_sec_ger,1)==round(lastnm_sec_ger_inc,1), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, similar to both the regional (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_sec_ger,1)==round(lastnm_sec_ger_reg,1) & round(lastnm_sec_ger,1)>round(lastnm_sec_ger_inc,1), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, similar to the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and higher than the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
cond(round(lastnm_sec_ger,1)==round(lastnm_sec_ger_reg,1) & round(lastnm_sec_ger,1)<round(lastnm_sec_ger_inc,1), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, similar to the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and lower than the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
cond(round(lastnm_sec_ger,1)>round(lastnm_sec_ger_reg,1) & round(lastnm_sec_ger,1)==round(lastnm_sec_ger_inc,1), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, higher than the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and similar to the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
cond(round(lastnm_sec_ger,1)<round(lastnm_sec_ger_reg,1) & round(lastnm_sec_ger,1)==round(lastnm_sec_ger_inc,1), ///
"The secondary school gross enrollment rate is **" + strofreal(round(lastnm_sec_ger,1)) + " percent** *(" + strofreal(lastnm_sec_ger_y) + ")*, lower than the regional average (" + strofreal(round(lastnm_sec_ger_reg,1)) + "%) and similar to the income group average (" + strofreal(round(lastnm_sec_ger_inc,1)) + "%). ", ///
""))))))))) if lastnm_sec_ger!=.
replace lastnm_sec_ger_text = "Internationally comparable data on secondary school gross enrollment rate are not available for " + wbcountrynameb + "." if lastnm_sec_ger==.

*------------------------*
*Learning poverty (%)
*------------------------*
gen se_lpv_prim_text = ///
cond(round(se_lpv_prim)<round(se_lpv_prim_reg) & round(se_lpv_prim)<round(se_lpv_prim_inc), /// 
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim)>round(se_lpv_prim_reg) & round(se_lpv_prim)>round(se_lpv_prim_inc), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim)>round(se_lpv_prim_reg) & round(se_lpv_prim)<round(se_lpv_prim_inc), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim)<round(se_lpv_prim_reg) & round(se_lpv_prim)>round(se_lpv_prim_inc), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim,1)==round(se_lpv_prim_reg,1) & round(se_lpv_prim,1)==round(se_lpv_prim_inc,1), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim,1)==round(se_lpv_prim_reg,1) & round(se_lpv_prim,1)>round(se_lpv_prim_inc,1), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim,1)==round(se_lpv_prim_reg,1) & round(se_lpv_prim,1)<round(se_lpv_prim_inc,1), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim,1)>round(se_lpv_prim_reg,1) & round(se_lpv_prim,1)==round(se_lpv_prim_inc,1), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim,1)<round(se_lpv_prim_reg,1) & round(se_lpv_prim,1)==round(se_lpv_prim_inc,1), ///
"**" + strofreal(round(se_lpv_prim,1)) + " percent** *(" + strofreal(se_lpv_prim_y) + ")* of 10-year-olds cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_inc,1)) + " percent at the income group level. ", ///
""))))))))) if se_lpv_prim!=.
replace se_lpv_prim_text = "Internationally comparable data on learning poverty are not available for " + wbcountrynameb + "." if se_lpv_prim==.

*------------------------*
*Learning poverty (%), female
*------------------------*
gen se_lpv_prim_f_text = ///
cond(round(se_lpv_prim_f)<round(se_lpv_prim_f_reg) & round(se_lpv_prim_f)<round(se_lpv_prim_f_inc), /// 
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f)>round(se_lpv_prim_f_reg) & round(se_lpv_prim_f)>round(se_lpv_prim_f_inc), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f)>round(se_lpv_prim_f_reg) & round(se_lpv_prim_f)<round(se_lpv_prim_f_inc), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f)<round(se_lpv_prim_f_reg) & round(se_lpv_prim_f)>round(se_lpv_prim_f_inc), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f,1)==round(se_lpv_prim_f_reg,1) & round(se_lpv_prim_f,1)==round(se_lpv_prim_f_inc,1), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f,1)==round(se_lpv_prim_f_reg,1) & round(se_lpv_prim_f,1)>round(se_lpv_prim_f_inc,1), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f,1)==round(se_lpv_prim_f_reg,1) & round(se_lpv_prim_f,1)<round(se_lpv_prim_f_inc,1), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f,1)>round(se_lpv_prim_f_reg,1) & round(se_lpv_prim_f,1)==round(se_lpv_prim_f_inc,1), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_f,1)<round(se_lpv_prim_f_reg,1) & round(se_lpv_prim_f,1)==round(se_lpv_prim_f_inc,1), ///
"**" + strofreal(round(se_lpv_prim_f,1)) + " percent** *(" + strofreal(se_lpv_prim_f_y) + ")* of 10-year-old girls cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_f_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_f_inc,1)) + " percent at the income group level. ", ///
""))))))))) if se_lpv_prim_f!=.
replace se_lpv_prim_f_text = "Internationally comparable data on female learning poverty are not available for " + wbcountrynameb + "." if se_lpv_prim_f==.

*------------------------*
*Learning poverty (%), male
*------------------------*
gen se_lpv_prim_m_text = ///
cond(round(se_lpv_prim_m)<round(se_lpv_prim_m_reg) & round(se_lpv_prim_m)<round(se_lpv_prim_m_inc), /// 
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m)>round(se_lpv_prim_m_reg) & round(se_lpv_prim_m)>round(se_lpv_prim_m_inc), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m)>round(se_lpv_prim_m_reg) & round(se_lpv_prim_m)<round(se_lpv_prim_m_inc), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m)<round(se_lpv_prim_m_reg) & round(se_lpv_prim_m)>round(se_lpv_prim_m_inc), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m,1)==round(se_lpv_prim_m_reg,1) & round(se_lpv_prim_m,1)==round(se_lpv_prim_m_inc,1), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m,1)==round(se_lpv_prim_m_reg,1) & round(se_lpv_prim_m,1)>round(se_lpv_prim_m_inc,1), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m,1)==round(se_lpv_prim_m_reg,1) & round(se_lpv_prim_m,1)<round(se_lpv_prim_m_inc,1), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m,1)>round(se_lpv_prim_m_reg,1) & round(se_lpv_prim_m,1)==round(se_lpv_prim_m_inc,1), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
cond(round(se_lpv_prim_m,1)<round(se_lpv_prim_m_reg,1) & round(se_lpv_prim_m,1)==round(se_lpv_prim_m_inc,1), ///
"And **" + strofreal(round(se_lpv_prim_m,1)) + " percent** *(" + strofreal(se_lpv_prim_m_y) + ")* of 10-year-old boys cannot read and understand a simple text by the end of primary school, compared to " + strofreal(round(se_lpv_prim_m_reg,1)) + " percent at the regional level and " + strofreal(round(se_lpv_prim_m_inc,1)) + " percent at the income group level. ", ///
""))))))))) if se_lpv_prim_m!=.
replace se_lpv_prim_m_text = "Internationally comparable data on male learning poverty are not available for " + wbcountrynameb + "." if se_lpv_prim_m==.

*------------------------*
*Hepatitis B vaccination rate
*------------------------*
gen vacHEPBB_text = ///
cond(round(vacHEPBB)<round(vacHEPBB_reg) & round(vacHEPBB)<round(vacHEPBB_inc), /// 
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is lower than both the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB)>round(vacHEPBB_reg) & round(vacHEPBB)>round(vacHEPBB_inc), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is higher than both the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB)>round(vacHEPBB_reg) & round(vacHEPBB)<round(vacHEPBB_inc), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is higher than the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB)<round(vacHEPBB_reg) & round(vacHEPBB)>round(vacHEPBB_inc), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is lower than the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB,1)==round(vacHEPBB_reg,1) & round(vacHEPBB,1)==round(vacHEPBB_inc,1), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is similar to both the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB,1)==round(vacHEPBB_reg,1) & round(vacHEPBB,1)>round(vacHEPBB_inc,1), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is similar to the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB,1)==round(vacHEPBB_reg,1) & round(vacHEPBB,1)<round(vacHEPBB_inc,1), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is similar to the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB,1)>round(vacHEPBB_reg,1) & round(vacHEPBB,1)==round(vacHEPBB_inc,1), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is higher than the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
cond(round(vacHEPBB,1)<round(vacHEPBB_reg,1) & round(vacHEPBB,1)==round(vacHEPBB_inc,1), ///
"Hepatitis B vaccine coverage is **" + strofreal(round(vacHEPBB,1)) + " percent** *(" + strofreal(vacHEPBB_y) + ")*. This is lower than the average for its region (" + strofreal(round(vacHEPBB_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(vacHEPBB_inc,1)) + "%). ", ///
""))))))))) if vacHEPBB!=.
replace vacHEPBB_text = "Internationally comparable data on Hepatitis B vaccine coverage are not available for " + wbcountrynameb + "." if vacHEPBB==.

*------------------------*
*Lower secondary completion rate (%)
*------------------------*
gen uiscr2_text = ///
cond(round(uiscr2)<round(uiscr2_reg) & round(uiscr2)<round(uiscr2_inc), /// 
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, lower than both the regional (" + strofreal(round(uiscr2_reg,1)) + "%) and income group (" + strofreal(round(uiscr2_inc,1)) + "%) averages. ", ///
cond(round(uiscr2)>round(uiscr2_reg) & round(uiscr2)>round(uiscr2_inc), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, higher than both the regional (" + strofreal(round(uiscr2_reg,1)) + "%) and income group (" + strofreal(round(uiscr2_inc,1)) + "%) averages. ", ///
cond(round(uiscr2)>round(uiscr2_reg) & round(uiscr2)<round(uiscr2_inc), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, higher than the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
cond(round(uiscr2)<round(uiscr2_reg) & round(uiscr2)>round(uiscr2_inc), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, lower than the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
cond(round(uiscr2,1)==round(uiscr2_reg,1) & round(uiscr2,1)==round(uiscr2_inc,1), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, similar to both the regional (" + strofreal(round(uiscr2_reg,1)) + "%) and income group (" + strofreal(round(uiscr2_inc,1)) + "%) averages. ", ///
cond(round(uiscr2,1)==round(uiscr2_reg,1) & round(uiscr2,1)>round(uiscr2_inc,1), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, similar to the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and higher than the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
cond(round(uiscr2,1)==round(uiscr2_reg,1) & round(uiscr2,1)<round(uiscr2_inc,1), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, similar to the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and lower than the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
cond(round(uiscr2,1)>round(uiscr2_reg,1) & round(uiscr2,1)==round(uiscr2_inc,1), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, higher than the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
cond(round(uiscr2,1)<round(uiscr2_reg,1) & round(uiscr2,1)==round(uiscr2_inc,1), ///
"The lower secondary school completion rate is **" + strofreal(round(uiscr2,1)) + " percent** *(" + strofreal(uiscr2_y) + ")*, lower than the regional average (" + strofreal(round(uiscr2_reg,1)) + "%) and similar to the income group average (" + strofreal(round(uiscr2_inc,1)) + "%). ", ///
""))))))))) if uiscr2!=.
replace uiscr2_text = "Internationally comparable data on lower secondary school completion rate are not available for " + wbcountrynameb + "." if uiscr2==.

*-------------------------------Youth--------------------------------------*

*------------------------*
*Youth NEET (% ages 15-24)
*------------------------*
gen eip_neet_mf_y_text = ///
cond(round(eip_neet_mf_y)<round(eip_neet_mf_y_reg) & round(eip_neet_mf_y)<round(eip_neet_mf_y_inc), /// 
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is lower than both the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y)>round(eip_neet_mf_y_reg) & round(eip_neet_mf_y)>round(eip_neet_mf_y_inc), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is higher than both the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y)>round(eip_neet_mf_y_reg) & round(eip_neet_mf_y)<round(eip_neet_mf_y_inc), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y)<round(eip_neet_mf_y_reg) & round(eip_neet_mf_y)>round(eip_neet_mf_y_inc), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y,1)==round(eip_neet_mf_y_reg,1) & round(eip_neet_mf_y,1)==round(eip_neet_mf_y_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is similar to both the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y,1)==round(eip_neet_mf_y_reg,1) & round(eip_neet_mf_y,1)>round(eip_neet_mf_y_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y,1)==round(eip_neet_mf_y_reg,1) & round(eip_neet_mf_y,1)<round(eip_neet_mf_y_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y,1)>round(eip_neet_mf_y_reg,1) & round(eip_neet_mf_y,1)==round(eip_neet_mf_y_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y,1)<round(eip_neet_mf_y_reg,1) & round(eip_neet_mf_y,1)==round(eip_neet_mf_y_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y,1)) +" percent** *(" + strofreal(eip_neet_mf_y_y) + ")* of the youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_inc,1)) + "%). ", ///
""))))))))) if eip_neet_mf_y!=.
replace eip_neet_mf_y_text = "Internationally comparable data on youth not in employment, education or training are not available for " + wbcountrynameb + "." if eip_neet_mf_y==.

*------------------------*
*Youth NEET (% ages 15-24), female
*------------------------*
gen eip_neet_mf_y_f_text = ///
cond(round(eip_neet_mf_y_f)<round(eip_neet_mf_y_f_reg) & round(eip_neet_mf_y_f)<round(eip_neet_mf_y_f_inc), /// 
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is lower than both the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f)>round(eip_neet_mf_y_f_reg) & round(eip_neet_mf_y_f)>round(eip_neet_mf_y_f_inc), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is higher than both the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f)>round(eip_neet_mf_y_f_reg) & round(eip_neet_mf_y_f)<round(eip_neet_mf_y_f_inc), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f)<round(eip_neet_mf_y_f_reg) & round(eip_neet_mf_y_f)>round(eip_neet_mf_y_f_inc), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_reg,1) & round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is similar to both the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_reg,1) & round(eip_neet_mf_y_f,1)>round(eip_neet_mf_y_f_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_reg,1) & round(eip_neet_mf_y_f,1)<round(eip_neet_mf_y_f_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f,1)>round(eip_neet_mf_y_f_reg,1) & round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_f,1)<round(eip_neet_mf_y_f_reg,1) & round(eip_neet_mf_y_f,1)==round(eip_neet_mf_y_f_inc,1), ///
"**" + strofreal(round(eip_neet_mf_y_f,1)) +" percent** *(" + strofreal(eip_neet_mf_y_f_y) + ")* of the female youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_f_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_f_inc,1)) + "%). ", ///
""))))))))) if eip_neet_mf_y_f!=.
replace eip_neet_mf_y_f_text = "Internationally comparable data on female youth not in employment, education or training are not available for " + wbcountrynameb + "." if eip_neet_mf_y_f==.

*------------------------*
*Youth NEET (% ages 15-24), male
*------------------------*
gen eip_neet_mf_y_m_text = ///
cond(round(eip_neet_mf_y_m)<round(eip_neet_mf_y_m_reg) & round(eip_neet_mf_y_m)<round(eip_neet_mf_y_m_inc), /// 
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is lower than both the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m)>round(eip_neet_mf_y_m_reg) & round(eip_neet_mf_y_m)>round(eip_neet_mf_y_m_inc), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is higher than both the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m)>round(eip_neet_mf_y_m_reg) & round(eip_neet_mf_y_m)<round(eip_neet_mf_y_m_inc), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m)<round(eip_neet_mf_y_m_reg) & round(eip_neet_mf_y_m)>round(eip_neet_mf_y_m_inc), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_reg,1) & round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_inc,1), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is similar to both the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_reg,1) & round(eip_neet_mf_y_m,1)>round(eip_neet_mf_y_m_inc,1), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_reg,1) & round(eip_neet_mf_y_m,1)<round(eip_neet_mf_y_m_inc,1), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is similar to the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m,1)>round(eip_neet_mf_y_m_reg,1) & round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_inc,1), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is higher than the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
cond(round(eip_neet_mf_y_m,1)<round(eip_neet_mf_y_m_reg,1) & round(eip_neet_mf_y_m,1)==round(eip_neet_mf_y_m_inc,1), ///
"And, **" + strofreal(round(eip_neet_mf_y_m,1)) +" percent** *(" + strofreal(eip_neet_mf_y_m_y) + ")* of the male youth is not in employment, education or training. This is lower than the average for its region (" + strofreal(round(eip_neet_mf_y_m_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(eip_neet_mf_y_m_inc,1)) + "%). ", ///
""))))))))) if eip_neet_mf_y_m!=.
replace eip_neet_mf_y_m_text = "Internationally comparable data on male youth not in employment, education or training are not available for " + wbcountrynameb + "." if eip_neet_mf_y_m==.

*------------------------*
*Adolescent fertility rate (births/1000 women ages 15-19)
*------------------------*
gen lastnm_afr_text_1 = ///
cond(round(lastnm_afr)<round(lastnm_afr_reg) & round(lastnm_afr)<round(lastnm_afr_inc), /// 
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is lower than both the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr)>round(lastnm_afr_reg) & round(lastnm_afr)>round(lastnm_afr_inc), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is higher than both the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr)>round(lastnm_afr_reg) & round(lastnm_afr)<round(lastnm_afr_inc), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is higher than the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr)<round(lastnm_afr_reg) & round(lastnm_afr)>round(lastnm_afr_inc), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is lower than the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr,1)==round(lastnm_afr_reg,1) & round(lastnm_afr,1)==round(lastnm_afr_inc,1), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is similar to both the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr,1)==round(lastnm_afr_reg,1) & round(lastnm_afr,1)>round(lastnm_afr_inc,1), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is similar to the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and higher than the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr,1)==round(lastnm_afr_reg,1) & round(lastnm_afr,1)<round(lastnm_afr_inc,1), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is similar to the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and lower than the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr,1)>round(lastnm_afr_reg,1) & round(lastnm_afr,1)==round(lastnm_afr_inc,1), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is higher than the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
cond(round(lastnm_afr,1)<round(lastnm_afr_reg,1) & round(lastnm_afr,1)==round(lastnm_afr_inc,1), ///
"The adolescent fertility rate, i.e., the number of births for every 1000 women aged 15-19, is **" + strofreal(round(lastnm_afr,1)) +"** *(" + strofreal(lastnm_afr_y) + ")*. This is lower than the average for its region (" + strofreal(round(lastnm_afr_reg,1)) + "%) and similar to the average for its income group (" + strofreal(round(lastnm_afr_inc,1)) + "%). ", ///
""))))))))) if lastnm_afr!=.
replace lastnm_afr_text = "Internationally comparable data on adolescent fertility rate are not available for " + wbcountrynameb + "." if lastnm_afr==.

*------------------------*
*Gross tertiary enrollment (%)
*------------------------*
gen lastnm_ter_ger_text = ///
cond(round(lastnm_ter_ger)<round(lastnm_ter_ger_reg) & round(lastnm_ter_ger)<round(lastnm_ter_ger_inc), /// 
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, lower than the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_ter_ger)>round(lastnm_ter_ger_reg) & round(lastnm_ter_ger)>round(lastnm_ter_ger_inc), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, higher than the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_ter_ger)>round(lastnm_ter_ger_reg) & round(lastnm_ter_ger)<round(lastnm_ter_ger_inc), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, lower than the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average but higher than the regional average (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%). ", ///
cond(round(lastnm_ter_ger)<round(lastnm_ter_ger_reg) & round(lastnm_ter_ger)>round(lastnm_ter_ger_inc), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, lower than the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) average but higher than the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average. ", ///
cond(round(lastnm_ter_ger,1)==round(lastnm_ter_ger_reg,1) & round(lastnm_ter_ger,1)==round(lastnm_ter_ger_inc,1), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, similar to both the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) and income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) averages. ", ///
cond(round(lastnm_ter_ger,1)==round(lastnm_ter_ger_reg,1) & round(lastnm_ter_ger,1)>round(lastnm_ter_ger_inc,1), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, similar to the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) average but higher than the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average. ", ///
cond(round(lastnm_ter_ger,1)==round(lastnm_ter_ger_reg,1) & round(lastnm_ter_ger,1)<round(lastnm_ter_ger_inc,1), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, similar to the regional (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%) average but lower than the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average. ", ///
cond(round(lastnm_ter_ger,1)>round(lastnm_ter_ger_reg,1) & round(lastnm_ter_ger,1)==round(lastnm_ter_ger_inc,1), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, similar to the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average but higher than the regional average (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%). ", ///
cond(round(lastnm_ter_ger,1)<round(lastnm_ter_ger_reg,1) & round(lastnm_ter_ger,1)==round(lastnm_ter_ger_inc,1), ///
"Tertiary education gross enrollment ratio is **" + strofreal(round(lastnm_ter_ger,1)) +" percent** *(" + strofreal(lastnm_ter_ger_y) + ")*, similar to the income group (" + strofreal(round(lastnm_ter_ger_inc,1)) + "%) average but lower than the regional average (" + strofreal(round(lastnm_ter_ger_reg,1)) + "%). ", ///
""))))))))) if lastnm_ter_ger!=.
replace lastnm_ter_ger_text = "Internationally comparable data on tertiary education gross enrollment ratio are not available for " + wbcountrynameb + "." if lastnm_ter_ger==.

*------------------------*
*Youth unemployment
*------------------------*
gen une_2eap_mf_y_text = ///
cond(round(une_2eap_mf_y)<round(une_2eap_mf_y_reg) & round(une_2eap_mf_y)<round(une_2eap_mf_y_inc), /// 
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, lower than both the regional (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y)>round(une_2eap_mf_y_reg) & round(une_2eap_mf_y)>round(une_2eap_mf_y_inc), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, higher than both the regional (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y)>round(une_2eap_mf_y_reg) & round(une_2eap_mf_y)<round(une_2eap_mf_y_inc), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y)<round(une_2eap_mf_y_reg) & round(une_2eap_mf_y)>round(une_2eap_mf_y_inc), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y,1)==round(une_2eap_mf_y_reg,1) & round(une_2eap_mf_y,1)==round(une_2eap_mf_y_inc,1), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, similar to both the regional (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y,1)==round(une_2eap_mf_y_reg,1) & round(une_2eap_mf_y,1)>round(une_2eap_mf_y_inc,1), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y,1)==round(une_2eap_mf_y_reg,1) & round(une_2eap_mf_y,1)<round(une_2eap_mf_y_inc,1), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y,1)>round(une_2eap_mf_y_reg,1) & round(une_2eap_mf_y,1)==round(une_2eap_mf_y_inc,1), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y,1)<round(une_2eap_mf_y_reg,1) & round(une_2eap_mf_y,1)==round(une_2eap_mf_y_inc,1), ///
"Youth unemployment is **" + strofreal(round(une_2eap_mf_y,1)) + " percent** *(" + strofreal(une_2eap_mf_y_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_inc,1)) + "%). ", ///
""))))))))) if une_2eap_mf_y!=.
replace une_2eap_mf_y_text = "Internationally comparable data on youth unemployment are not available for " + wbcountrynameb + "." if une_2eap_mf_y==.

*------------------------*
*Youth unemployment, female
*------------------------*
gen une_2eap_mf_y_f_text = ///
cond(round(une_2eap_mf_y_f)<round(une_2eap_mf_y_f_reg) & round(une_2eap_mf_y_f)<round(une_2eap_mf_y_f_inc), /// 
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, lower than both the regional (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_f)>round(une_2eap_mf_y_f_reg) & round(une_2eap_mf_y_f)>round(une_2eap_mf_y_f_inc), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, higher than both the regional (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_f)>round(une_2eap_mf_y_f_reg) & round(une_2eap_mf_y_f)<round(une_2eap_mf_y_f_inc), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_f)<round(une_2eap_mf_y_f_reg) & round(une_2eap_mf_y_f)>round(une_2eap_mf_y_f_inc), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_reg,1) & round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_inc,1), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, similar to both the regional (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_reg,1) & round(une_2eap_mf_y_f,1)>round(une_2eap_mf_y_f_inc,1), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_reg,1) & round(une_2eap_mf_y_f,1)<round(une_2eap_mf_y_f_inc,1), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_f,1)>round(une_2eap_mf_y_f_reg,1) & round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_inc,1), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_f,1)<round(une_2eap_mf_y_f_reg,1) & round(une_2eap_mf_y_f,1)==round(une_2eap_mf_y_f_inc,1), ///
"Female youth unemployment is **" + strofreal(round(une_2eap_mf_y_f,1)) + " percent** *(" + strofreal(une_2eap_mf_y_f_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_f_inc,1)) + "%). ", ///
""))))))))) if une_2eap_mf_y_f!=.
replace une_2eap_mf_y_f_text = "Internationally comparable data on female youth unemployment are not available for " + wbcountrynameb + "." if une_2eap_mf_y_f==.

*------------------------*
*Youth unemployment, male
*------------------------*
gen une_2eap_mf_y_m_text = ///
cond(round(une_2eap_mf_y_m)<round(une_2eap_mf_y_m_reg) & round(une_2eap_mf_y_m)<round(une_2eap_mf_y_m_inc), /// 
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, lower than both the regional (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_m)>round(une_2eap_mf_y_m_reg) & round(une_2eap_mf_y_m)>round(une_2eap_mf_y_m_inc), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, higher than both the regional (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_m)>round(une_2eap_mf_y_m_reg) & round(une_2eap_mf_y_m)<round(une_2eap_mf_y_m_inc), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_m)<round(une_2eap_mf_y_m_reg) & round(une_2eap_mf_y_m)>round(une_2eap_mf_y_m_inc), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_reg,1) & round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_inc,1), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, similar to both the regional (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and income group (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%) averages. ", ///
cond(round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_reg,1) & round(une_2eap_mf_y_m,1)>round(une_2eap_mf_y_m_inc,1), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_reg,1) & round(une_2eap_mf_y_m,1)<round(une_2eap_mf_y_m_inc,1), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, similar to the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_m,1)>round(une_2eap_mf_y_m_reg,1) & round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_inc,1), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, higher than the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
cond(round(une_2eap_mf_y_m,1)<round(une_2eap_mf_y_m_reg,1) & round(une_2eap_mf_y_m,1)==round(une_2eap_mf_y_m_inc,1), ///
"Male youth unemployment is **" + strofreal(round(une_2eap_mf_y_m,1)) + " percent** *(" + strofreal(une_2eap_mf_y_m_y) + ")*, lower than the regional average (" + strofreal(round(une_2eap_mf_y_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(une_2eap_mf_y_m_inc,1)) + "%). ", ///
""))))))))) if une_2eap_mf_y_m!=.
replace une_2eap_mf_y_m_text = "Internationally comparable data on male youth unemployment are not available for " + wbcountrynameb + "." if une_2eap_mf_y_m==.

*----------------------------Adults&elderly--------------------------------*

*------------------------*
*Female labor force participation
*------------------------*
gen eap_2wap_mf_a_f_text = ///
cond(round(eap_2wap_mf_a_f)<round(eap_2wap_mf_a_f_reg) & round(eap_2wap_mf_a_f)<round(eap_2wap_mf_a_f_inc), /// 
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, lower than both the regional (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_f)>round(eap_2wap_mf_a_f_reg) & round(eap_2wap_mf_a_f)>round(eap_2wap_mf_a_f_inc), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, higher than both the regional (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_f)>round(eap_2wap_mf_a_f_reg) & round(eap_2wap_mf_a_f)<round(eap_2wap_mf_a_f_inc), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, higher than the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_f)<round(eap_2wap_mf_a_f_reg) & round(eap_2wap_mf_a_f)>round(eap_2wap_mf_a_f_inc), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, lower than the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_reg,1) & round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_inc,1), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, similar to both the regional (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_reg,1) & round(eap_2wap_mf_a_f,1)>round(eap_2wap_mf_a_f_inc,1), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, similar to the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and higher than the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_reg,1) & round(eap_2wap_mf_a_f,1)<round(eap_2wap_mf_a_f_inc,1), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, similar to the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and lower than the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_f,1)>round(eap_2wap_mf_a_f_reg,1) & round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_inc,1), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, higher than the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_f,1)<round(eap_2wap_mf_a_f_reg,1) & round(eap_2wap_mf_a_f,1)==round(eap_2wap_mf_a_f_inc,1), ///
"The female labor force participation is **" + strofreal(round(eap_2wap_mf_a_f,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_f_y) + ")*, lower than the regional average (" + strofreal(round(eap_2wap_mf_a_f_reg,1)) + "%) and similar to the income group average (" + strofreal(round(eap_2wap_mf_a_f_inc,1)) + "%). ", ///
""))))))))) if eap_2wap_mf_a_f!=.
replace eap_2wap_mf_a_f_text = "Internationally comparable data on female labor force participation are not available for " + wbcountrynameb + "." if eap_2wap_mf_a_f==.

*------------------------*
*Male labor force participation
*------------------------*
gen eap_2wap_mf_a_m_text = ///
cond(round(eap_2wap_mf_a_m)<round(eap_2wap_mf_a_m_reg) & round(eap_2wap_mf_a_m)<round(eap_2wap_mf_a_m_inc), /// 
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, lower than both the regional (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_m)>round(eap_2wap_mf_a_m_reg) & round(eap_2wap_mf_a_m)>round(eap_2wap_mf_a_m_inc), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, higher than both the regional (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_m)>round(eap_2wap_mf_a_m_reg) & round(eap_2wap_mf_a_m)<round(eap_2wap_mf_a_m_inc), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, higher than the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_m)<round(eap_2wap_mf_a_m_reg) & round(eap_2wap_mf_a_m)>round(eap_2wap_mf_a_m_inc), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, lower than the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_reg,1) & round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_inc,1), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, similar to both the regional (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and income group (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%) averages. ", ///
cond(round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_reg,1) & round(eap_2wap_mf_a_m,1)>round(eap_2wap_mf_a_m_inc,1), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, similar to the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and higher than the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_reg,1) & round(eap_2wap_mf_a_m,1)<round(eap_2wap_mf_a_m_inc,1), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, similar to the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and lower than the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_m,1)>round(eap_2wap_mf_a_m_reg,1) & round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_inc,1), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, higher than the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
cond(round(eap_2wap_mf_a_m,1)<round(eap_2wap_mf_a_m_reg,1) & round(eap_2wap_mf_a_m,1)==round(eap_2wap_mf_a_m_inc,1), ///
"The male labor force participation is **" + strofreal(round(eap_2wap_mf_a_m,1)) + " percent** *(" + strofreal(eap_2wap_mf_a_m_y) + ")*, lower than the regional average (" + strofreal(round(eap_2wap_mf_a_m_reg,1)) + "%) and similar to the income group average (" + strofreal(round(eap_2wap_mf_a_m_inc,1)) + "%). ", ///
""))))))))) if eap_2wap_mf_a_m!=.
replace eap_2wap_mf_a_m_text = "Internationally comparable data on male labor force participation are not available for " + wbcountrynameb + "." if eap_2wap_mf_a_m==.

*------------------------*
*Life expectancy
*------------------------*
gen sp_dyn_le00_in_text = ///
cond(round(sp_dyn_le00_in)<round(sp_dyn_le00_in_reg) & round(sp_dyn_le00_in)<round(sp_dyn_le00_in_inc), /// 
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, lower than both the regional (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in)>round(sp_dyn_le00_in_reg) & round(sp_dyn_le00_in)>round(sp_dyn_le00_in_inc), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, higher than both the regional (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in)>round(sp_dyn_le00_in_reg) & round(sp_dyn_le00_in)<round(sp_dyn_le00_in_inc), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in)<round(sp_dyn_le00_in_reg) & round(sp_dyn_le00_in)>round(sp_dyn_le00_in_inc), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_reg,1) & round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_inc,1), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, similar to both the regional (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_reg,1) & round(sp_dyn_le00_in,1)>round(sp_dyn_le00_in_inc,1), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_reg,1) & round(sp_dyn_le00_in,1)<round(sp_dyn_le00_in_inc,1), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in,1)>round(sp_dyn_le00_in_reg,1) & round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_inc,1), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in,1)<round(sp_dyn_le00_in_reg,1) & round(sp_dyn_le00_in,1)==round(sp_dyn_le00_in_inc,1), ///
"Life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in,1)) + " years** *(" + strofreal(sp_dyn_le00_in_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_inc,1)) + " years). ", ///
""))))))))) if sp_dyn_le00_in!=.
replace sp_dyn_le00_in_text = "Internationally comparable data on life expectancy at birth are not available for " + wbcountrynameb + "." if sp_dyn_le00_in==.

*------------------------*
*Life expectancy, female
*------------------------*
gen sp_dyn_le00_in_f_text = ///
cond(round(sp_dyn_le00_in_f)<round(sp_dyn_le00_in_f_reg) & round(sp_dyn_le00_in_f)<round(sp_dyn_le00_in_f_inc), /// 
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, lower than both the regional (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_f)>round(sp_dyn_le00_in_f_reg) & round(sp_dyn_le00_in_f)>round(sp_dyn_le00_in_f_inc), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, higher than both the regional (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_f)>round(sp_dyn_le00_in_f_reg) & round(sp_dyn_le00_in_f)<round(sp_dyn_le00_in_f_inc), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_f)<round(sp_dyn_le00_in_f_reg) & round(sp_dyn_le00_in_f)>round(sp_dyn_le00_in_f_inc), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_reg,1) & round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_inc,1), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, similar to both the regional (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_reg,1) & round(sp_dyn_le00_in_f,1)>round(sp_dyn_le00_in_f_inc,1), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_reg,1) & round(sp_dyn_le00_in_f,1)<round(sp_dyn_le00_in_f_inc,1), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_f,1)>round(sp_dyn_le00_in_f_reg,1) & round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_inc,1), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_f,1)<round(sp_dyn_le00_in_f_reg,1) & round(sp_dyn_le00_in_f,1)==round(sp_dyn_le00_in_f_inc,1), ///
"Female life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_f,1)) + " years** *(" + strofreal(sp_dyn_le00_in_f_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_f_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_f_inc,1)) + " years). ", ///
""))))))))) if sp_dyn_le00_in_f!=.
replace sp_dyn_le00_in_f_text = "Internationally comparable data on female life expectancy at birth are not available for " + wbcountrynameb + "." if sp_dyn_le00_in_f==.

*------------------------*
*Life expectancy, male
*------------------------*
gen sp_dyn_le00_in_m_text = ///
cond(round(sp_dyn_le00_in_m)<round(sp_dyn_le00_in_m_reg) & round(sp_dyn_le00_in_m)<round(sp_dyn_le00_in_m_inc), /// 
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, lower than both the regional (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_m)>round(sp_dyn_le00_in_m_reg) & round(sp_dyn_le00_in_m)>round(sp_dyn_le00_in_m_inc), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, higher than both the regional (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_m)>round(sp_dyn_le00_in_m_reg) & round(sp_dyn_le00_in_m)<round(sp_dyn_le00_in_m_inc), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_m)<round(sp_dyn_le00_in_m_reg) & round(sp_dyn_le00_in_m)>round(sp_dyn_le00_in_m_inc), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_reg,1) & round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_inc,1), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, similar to both the regional (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and income group (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years) averages. ", ///
cond(round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_reg,1) & round(sp_dyn_le00_in_m,1)>round(sp_dyn_le00_in_m_inc,1), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and higher than the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_reg,1) & round(sp_dyn_le00_in_m,1)<round(sp_dyn_le00_in_m_inc,1), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, similar to the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and lower than the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_m,1)>round(sp_dyn_le00_in_m_reg,1) & round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_inc,1), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, higher than the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
cond(round(sp_dyn_le00_in_m,1)<round(sp_dyn_le00_in_m_reg,1) & round(sp_dyn_le00_in_m,1)==round(sp_dyn_le00_in_m_inc,1), ///
"Male life expectancy at birth is **" + strofreal(round(sp_dyn_le00_in_m,1)) + " years** *(" + strofreal(sp_dyn_le00_in_m_y) + ")*, lower than the regional average (" + strofreal(round(sp_dyn_le00_in_m_reg,1)) + " years) and similar to the income group average (" + strofreal(round(sp_dyn_le00_in_m_inc,1)) + " years). ", ///
""))))))))) if sp_dyn_le00_in_m!=.
replace sp_dyn_le00_in_m_text = "Internationally comparable data on male life expectancy at birth are not available for " + wbcountrynameb + "." if sp_dyn_le00_in_m==.

*------------------------*
*Not dying from NCDs
*------------------------*
gen lastnm_probdeath_ncd_text_1 = ///
cond(round(lastnm_probdeath_ncd)<round(lastnm_probdeath_ncd_reg) & round(lastnm_probdeath_ncd)<round(lastnm_probdeath_ncd_inc), /// 
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, lower than both the regional (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and income group (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%) averages. ", ///
cond(round(lastnm_probdeath_ncd)>round(lastnm_probdeath_ncd_reg) & round(lastnm_probdeath_ncd)>round(lastnm_probdeath_ncd_inc), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, higher than both the regional (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and income group (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%) averages. ", ///
cond(round(lastnm_probdeath_ncd)>round(lastnm_probdeath_ncd_reg) & round(lastnm_probdeath_ncd)<round(lastnm_probdeath_ncd_inc), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, higher than the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and lower than the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
cond(round(lastnm_probdeath_ncd)<round(lastnm_probdeath_ncd_reg) & round(lastnm_probdeath_ncd)>round(lastnm_probdeath_ncd_inc), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, lower than the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and higher than the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
cond(round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_reg,1) & round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_inc,1), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, similar to both the regional (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and income group (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%) averages. ", ///
cond(round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_reg,1) & round(lastnm_probdeath_ncd,1)>round(lastnm_probdeath_ncd_inc,1), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, similar to the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and higher than the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
cond(round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_reg,1) & round(lastnm_probdeath_ncd,1)<round(lastnm_probdeath_ncd_inc,1), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, similar to the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and lower than the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
cond(round(lastnm_probdeath_ncd,1)>round(lastnm_probdeath_ncd_reg,1) & round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_inc,1), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, higher than the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and similar to the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
cond(round(lastnm_probdeath_ncd,1)<round(lastnm_probdeath_ncd_reg,1) & round(lastnm_probdeath_ncd,1)==round(lastnm_probdeath_ncd_inc,1), ///
"The probability of dying from non-communicable diseases between the ages of 30 to 70 is **" + strofreal(round(lastnm_probdeath_ncd,1)) +" percent**, lower than the regional average (" + strofreal(round(lastnm_probdeath_ncd_reg,1)) + "%) and similar to the income group average (" + strofreal(round(lastnm_probdeath_ncd_inc,1)) + "%). ", ///
""))))))))) if lastnm_probdeath_ncd!=.
replace lastnm_probdeath_ncd_text_1 = "Internationally comparable data on probability of dying from non-communicable diseases between the ages of 30 to 70 are not available for " + wbcountrynameb + "." if lastnm_probdeath_ncd==.

*-----------------Round values in hci variables for tables-----------------* 
/*	
foreach var in hci_m hci_f hci psurv_m psurv_f psurv  asr_m asr_f asr nostu_m nostu_f nostu eyrs_m eyrs_f eyrs qeyrs_m qeyrs_f qeyrs test_m test_f test {
drop `var'_t
}	
*/

gen hci_table = hci/100

foreach var in nostu asr psurv{
replace `var' = `var'/100
}

foreach var in hci_m hci_f hci_table hci psurv_m psurv_f psurv  asr_m asr_f asr nostu_m nostu_f nostu{
gen `var'_t = strofreal(`var',"%04.2f")
}

foreach var in eyrs_m eyrs_f eyrs qeyrs_m qeyrs_f qeyrs{
gen `var'_t = strofreal(`var',"%4.1f")
}

foreach var in test_m test_f test{
gen `var'_t = strofreal(`var',"%4.0f")
}

foreach var in hci_m hci_f hci psurv_m psurv_f psurv asr_m asr_f asr nostu_m nostu_f nostu eyrs_m eyrs_f eyrs qeyrs_m qeyrs_f qeyrs test_m test_f test{
replace `var'_t = "-" if `var'_t=="."
}


foreach var in hci_m hci_f hci psurv_m psurv_f psurv  asr_m asr_f asr nostu_m nostu_f nostu eyrs_m eyrs_f eyrs qeyrs_m qeyrs_f qeyrs test_m test_f test{
tab `var'_t
}	

foreach var in nostu asr psurv{
replace `var' = `var'*100
}

*---------------------------------Save-------------------------------------*	
	
keep wb* *text  *text_1 *text_2 hci_lower hci_upper hci_m hci_f hci hci_m hci_f hci hci_m hci_f hci psurv_m psurv_f psurv psurv_m psurv_f psurv psurv_m psurv_f psurv qeyrs_m qeyrs_f qeyrs qeyrs_m qeyrs_f qeyrs qeyrs_m qeyrs_f qeyrs eyrs_m eyrs_f eyrs eyrs_m eyrs_f eyrs eyrs_m eyrs_f eyrs test_m test_f test test_m test_f test test_m test_f test asr_m asr_f asr asr_m asr_f asr asr_m asr_f asr nostu_m nostu_f nostu nostu_m nostu_f nostu nostu_m nostu_f nostu hci_m_t hci_f_t hci_t psurv_m_t psurv_f_t psurv_t asr_m_t asr_f_t asr_t nostu_m_t nostu_f_t nostu_t eyrs_m_t eyrs_f_t eyrs_t qeyrs_m_t qeyrs_f_t qeyrs_t test_m_t test_f_t test_t
	
destring hci_t, replace
replace hci_t = hci_t/100

gen hci_t2 = strofreal(hci_t,"%04.2f")
drop hci_t 
rename hci_t2 hci_t
br hci_t	


save "$data_processed\text", replace

*---------------------------------Ordering---------------------------------*

use "$data_processed\text", clear
/* Mantener estos? o más? */
keep wbcode unicef_neomort_text unicef_mealfreq_text vacBCG_text uisger02_text uisger02_f_text uisger02_m_text uisger01_text lastnm_mmrt_text_1 unicef_care_text lastnm_birth_reg_text_1 unicef_breastf_text unicef_diarrhoea_text uiscr1_text uiscr1_f_text uiscr1_m_text lastnm_sec_ger_text_1 se_lpv_prim_text se_lpv_prim_f_text se_lpv_prim_m_text vacHEPBB_text uiscr2_text eip_neet_mf_y_text eip_neet_mf_y_f_text eip_neet_mf_y_m_text lastnm_afr_text_1 lastnm_ter_ger_text une_2eap_mf_y_text une_2eap_mf_y_f_text une_2eap_mf_y_m_text eap_2wap_mf_a_f_text eap_2wap_mf_a_m_text sp_dyn_le00_in_text sp_dyn_le00_in_f_text sp_dyn_le00_in_m_text lastnm_probdeath_ncd_text_1

*----------------------------Rename and reshape----------------------------*

rename *text_1 *text
rename *_text text*
reshape long text, i(wbcode) string
rename _j name

*----------------------------Position variable-----------------------------*
	
drop if pos==""
rename (name text lab)(name_ text_ lab_)
reshape wide name_ text_ lab_, i(wbcode) j(pos) string
rename *_e* *_school_*
rename *_l* *_early_*	
rename *_h* *_youth_* 
rename *_b* *_adults_*
aorder 
order wbcode
export excel "$charts\ordered_2", replace firstrow(variable) 
save "$charts\ordered_text", replace

*--------------------------Merge to original base--------------------------*

/**** Esto se hace porque nos habían pedido agregar algunos valores de indicadores, a parte de los name, lab y text para cada stage y orden ****/
/* Habría que chequear cuál de estos es el correcto (parecen pisarse) y borrar los que no sirvan */ 

use "$data_processed\text", clear
drop unicef_neomort_text unicef_mealfreq_text vacBCG_text uisger02_text uisger02_f_text uisger02_m_text uisger01_text lastnm_mmrt_text_1 unicef_care_text lastnm_birth_reg_text_1 unicef_breastf_text unicef_diarrhoea_text uiscr1_text uiscr1_f_text uiscr1_m_text lastnm_sec_ger_text_1 se_lpv_prim_text se_lpv_prim_f_text se_lpv_prim_m_text vacHEPBB_text uiscr2_text eip_neet_mf_y_text eip_neet_mf_y_f_text eip_neet_mf_y_m_text lastnm_afr_text_1 lastnm_ter_ger_text une_2eap_mf_y_text une_2eap_mf_y_f_text une_2eap_mf_y_m_text eap_2wap_mf_a_f_text eap_2wap_mf_a_m_text sp_dyn_le00_in_text sp_dyn_le00_in_f_text sp_dyn_le00_in_m_text lastnm_probdeath_ncd_text_1
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
