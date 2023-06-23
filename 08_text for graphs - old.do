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

	*----------------------------Early childhood-------------------------------*
	
	/* Tal vez conviene hace un texto genérico con valor del indicador + valor hace aprox 5 años y después hacer el if para region e ingreso. Pero para eso habría que partir este if. */ 
	
	*------------------------*
	*Neonatal mortality rate
	*------------------------*
	gen unicef_neomort_text = ///
	cond(round(unicef_neomort)<round(unicef_neomort_reg) & round(unicef_neomort)<round(unicef_neomort_inc), /// 
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, lower than both the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort)>round(unicef_neomort_reg) & round(unicef_neomort)>round(unicef_neomort_inc), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, higher than both the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort)>round(unicef_neomort_reg) & round(unicef_neomort)<round(unicef_neomort_inc), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, higher than the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") but lower than the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort)<round(unicef_neomort_reg) & round(unicef_neomort)>round(unicef_neomort_inc), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, lower than the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") but higher than the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort,1)==round(unicef_neomort_reg,1) & round(unicef_neomort,1)==round(unicef_neomort_inc,1), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, similar to both the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort,1)==round(unicef_neomort_reg,1) & round(unicef_neomort,1)>round(unicef_neomort_inc,1), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, similar to the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and higher than the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort,1)==round(unicef_neomort_reg,1) & round(unicef_neomort,1)<round(unicef_neomort_inc,1), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, similar to the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and lower than the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort,1)>round(unicef_neomort_reg,1) & round(unicef_neomort,1)==round(unicef_neomort_inc,1), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, higher than the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and similar to the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
	cond(round(unicef_neomort,1)<round(unicef_neomort_reg,1) & round(unicef_neomort,1)==round(unicef_neomort_inc,1), ///
	"The neonatal mortality rate is **" + strofreal(round(unicef_neomort,1)) + " per 1,000 live births** *(" + strofreal(unicef_neomort_y) + ")*, lower than the regional average ("+ strofreal(round(unicef_neomort_reg,1)) +") and similar to the income group average ("+ strofreal(round(unicef_neomort_inc,1)) +"). ", ///
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
	
	/**** Una vez que estén los locals nuevos, generar estas nuevas variables (idealmente, pensar una nueva manera para hacer un merge, en lugar de escribir todo) ****/
{	
	gen pos = ""
	
replace pos = "l1" if wbcode=="AFG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="AFG" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="AFG" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="AFG" & name=="uiscr1"
replace pos = "e2" if wbcode=="AFG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="AFG" & name=="uiscr2"
replace pos = "h1" if wbcode=="AFG" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="AFG" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="AFG" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="AFG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="AFG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="AFG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="AGO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="AGO" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="AGO" & name=="uisger02"
replace pos = "e1" if wbcode=="AGO" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="AGO" & name=="uiscr1"
replace pos = "e3" if wbcode=="AGO" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="AGO" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="AGO" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="AGO" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="AGO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="AGO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="AGO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ALB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ALB" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ALB" & name=="uisger02"
replace pos = "e1" if wbcode=="ALB" & name=="uiscr1"
replace pos = "e2" if wbcode=="ALB" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ALB" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ALB" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ALB" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ALB" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ALB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ALB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ALB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ARE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ARE" & name=="uisger02"
replace pos = "l3" if wbcode=="ARE" & name=="vacBCG"
replace pos = "e1" if wbcode=="ARE" & name=="uiscr1"
replace pos = "e2" if wbcode=="ARE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ARE" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ARE" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ARE" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ARE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ARE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ARE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ARE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ARG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ARG" & name=="uisger02"
replace pos = "l3" if wbcode=="ARG" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="ARG" & name=="uiscr1"
replace pos = "e2" if wbcode=="ARG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ARG" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ARG" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ARG" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ARG" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ARG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ARG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ARG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ARM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ARM" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ARM" & name=="uisger02"
replace pos = "e1" if wbcode=="ARM" & name=="uiscr1"
replace pos = "e2" if wbcode=="ARM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ARM" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ARM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ARM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ARM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ARM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ARM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ARM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ATG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ATG" & name=="uisger02_f"
replace pos = "l3" if wbcode=="ATG" & name=="uisger02_m"
replace pos = "e1" if wbcode=="ATG" & name=="uiscr1"
replace pos = "e2" if wbcode=="ATG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ATG" & name=="uiscr2"
replace pos = "h1" if wbcode=="ATG" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ATG" & name=="eip_neet_mf_y"
replace pos = "h3" if wbcode=="ATG" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ATG" & name=="lastnm_probdeath_ncd"
replace pos = "b2" if wbcode=="ATG" & name=="sp_dyn_le00_in_f"
replace pos = "b3" if wbcode=="ATG" & name=="sp_dyn_le00_in_m"
replace pos = "l1" if wbcode=="AUS" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="AUS" & name=="uisger02"
replace pos = "l3" if wbcode=="AUS" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="AUS" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="AUS" & name=="se_lpv_prim_f"
replace pos = "e3" if wbcode=="AUS" & name=="se_lpv_prim_m"
replace pos = "h1" if wbcode=="AUS" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="AUS" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="AUS" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="AUS" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="AUS" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="AUS" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="AUT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="AUT" & name=="uisger02"
replace pos = "l3" if wbcode=="AUT" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="AUT" & name=="uiscr1"
replace pos = "e2" if wbcode=="AUT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="AUT" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="AUT" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="AUT" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="AUT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="AUT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="AUT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="AUT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="AZE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="AZE" & name=="uisger02"
replace pos = "l3" if wbcode=="AZE" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="AZE" & name=="uiscr1"
replace pos = "e2" if wbcode=="AZE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="AZE" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="AZE" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="AZE" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="AZE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="AZE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="AZE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="AZE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BDI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BDI" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="BDI" & name=="uisger02"
replace pos = "e1" if wbcode=="BDI" & name=="uiscr1"
replace pos = "e2" if wbcode=="BDI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BDI" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="BDI" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="BDI" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="BDI" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="BDI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BDI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BDI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BEL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BEL" & name=="uisger02"
replace pos = "l3" if wbcode=="BEL" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="BEL" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="BEL" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="BEL" & name=="uiscr2"
replace pos = "h1" if wbcode=="BEL" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="BEL" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="BEL" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="BEL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BEL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BEL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BEN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BEN" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="BEN" & name=="uisger02"
replace pos = "e1" if wbcode=="BEN" & name=="uiscr1"
replace pos = "e2" if wbcode=="BEN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BEN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="BEN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BEN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BEN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BEN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BEN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BEN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BFA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BFA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="BFA" & name=="uisger02"
replace pos = "e1" if wbcode=="BFA" & name=="uiscr1"
replace pos = "e2" if wbcode=="BFA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BFA" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="BFA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BFA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BFA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BFA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BFA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BFA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BGD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BGD" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="BGD" & name=="uisger02"
replace pos = "e1" if wbcode=="BGD" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="BGD" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="BGD" & name=="uiscr2"
replace pos = "h1" if wbcode=="BGD" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BGD" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BGD" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BGD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BGD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BGD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BGR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BGR" & name=="uisger02"
replace pos = "l3" if wbcode=="BGR" & name=="vacBCG"
replace pos = "e1" if wbcode=="BGR" & name=="uiscr1"
replace pos = "e2" if wbcode=="BGR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BGR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="BGR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="BGR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="BGR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="BGR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BGR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BGR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BHR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BHR" & name=="uisger02"
replace pos = "l3" if wbcode=="BHR" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="BHR" & name=="uiscr1"
replace pos = "e2" if wbcode=="BHR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BHR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="BHR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="BHR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="BHR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="BHR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BHR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BHR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BIH" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BIH" & name=="uisger02"
replace pos = "l3" if wbcode=="BIH" & name=="vacBCG"
replace pos = "e1" if wbcode=="BIH" & name=="uiscr2"
replace pos = "e2" if wbcode=="BIH" & name=="uiscr1_f"
replace pos = "e3" if wbcode=="BIH" & name=="uiscr1_m"
replace pos = "h1" if wbcode=="BIH" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BIH" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BIH" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BIH" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BIH" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BIH" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BLR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BLR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="BLR" & name=="uisger02"
replace pos = "e1" if wbcode=="BLR" & name=="uiscr1"
replace pos = "e2" if wbcode=="BLR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BLR" & name=="uiscr2"
replace pos = "h1" if wbcode=="BLR" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BLR" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BLR" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BLR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BLR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BLR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BRA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BRA" & name=="uisger02"
replace pos = "l3" if wbcode=="BRA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="BRA" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="BRA" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="BRA" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="BRA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BRA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BRA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BRA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BRA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BRA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BRN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BRN" & name=="uisger02"
replace pos = "l3" if wbcode=="BRN" & name=="vacBCG"
replace pos = "e1" if wbcode=="BRN" & name=="uiscr1"
replace pos = "e2" if wbcode=="BRN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BRN" & name=="uiscr2"
replace pos = "h1" if wbcode=="BRN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BRN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BRN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BRN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BRN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BRN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BTN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BTN" & name=="uisger02"
replace pos = "l3" if wbcode=="BTN" & name=="unicef_breastf"
replace pos = "e1" if wbcode=="BTN" & name=="uiscr1"
replace pos = "e2" if wbcode=="BTN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BTN" & name=="uiscr2"
replace pos = "h1" if wbcode=="BTN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="BTN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="BTN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="BTN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BTN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BTN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="BWA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="BWA" & name=="uisger02"
replace pos = "l3" if wbcode=="BWA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="BWA" & name=="uiscr1"
replace pos = "e2" if wbcode=="BWA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="BWA" & name=="uiscr2"
replace pos = "h1" if wbcode=="BWA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="BWA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="BWA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="BWA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="BWA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="BWA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CAF" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CAF" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="CAF" & name=="uisger02"
replace pos = "e1" if wbcode=="CAF" & name=="uiscr1"
replace pos = "e2" if wbcode=="CAF" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CAF" & name=="uiscr2"
replace pos = "h1" if wbcode=="CAF" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CAF" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="CAF" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="CAF" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CAF" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CAF" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CAN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CAN" & name=="lastnm_mmrt"
replace pos = "l3" if wbcode=="CAN" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="CAN" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="CAN" & name=="se_lpv_prim_f"
replace pos = "e3" if wbcode=="CAN" & name=="se_lpv_prim_m"
replace pos = "h1" if wbcode=="CAN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="CAN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="CAN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="CAN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CAN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CAN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CHE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CHE" & name=="uisger02"
replace pos = "l3" if wbcode=="CHE" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="CHE" & name=="uiscr1"
replace pos = "e2" if wbcode=="CHE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CHE" & name=="uiscr2"
replace pos = "h1" if wbcode=="CHE" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CHE" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CHE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CHE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CHE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CHE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CHL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CHL" & name=="uisger02"
replace pos = "l3" if wbcode=="CHL" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="CHL" & name=="uiscr1"
replace pos = "e2" if wbcode=="CHL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CHL" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CHL" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="CHL" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="CHL" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="CHL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CHL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CHL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CHN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CHN" & name=="uisger02"
replace pos = "l3" if wbcode=="CHN" & name=="unicef_diarrhoea"
replace pos = "e1" if wbcode=="CHN" & name=="se_lpv_prim"
replace pos = "e2" if wbcode=="CHN" & name=="vacHEPBB"
replace pos = "e3" if wbcode=="CHN" & name=="uiscr1"
replace pos = "h1" if wbcode=="CHN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CHN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CHN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CHN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CHN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CHN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CIV" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CIV" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="CIV" & name=="uisger02"
replace pos = "e1" if wbcode=="CIV" & name=="uiscr1"
replace pos = "e2" if wbcode=="CIV" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CIV" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CIV" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="CIV" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="CIV" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="CIV" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CIV" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CIV" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CMR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CMR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="CMR" & name=="uisger02"
replace pos = "e1" if wbcode=="CMR" & name=="uiscr1"
replace pos = "e2" if wbcode=="CMR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CMR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CMR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CMR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CMR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CMR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CMR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CMR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="COD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="COD" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="COD" & name=="uisger02"
replace pos = "e1" if wbcode=="COD" & name=="uiscr1"
replace pos = "e2" if wbcode=="COD" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="COD" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="COD" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="COD" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="COD" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="COD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="COD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="COD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="COG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="COG" & name=="uisger02"
replace pos = "l3" if wbcode=="COG" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="COG" & name=="se_lpv_prim_f"
replace pos = "e2" if wbcode=="COG" & name=="se_lpv_prim_m"
replace pos = "e3" if wbcode=="COG" & name=="uiscr1"
replace pos = "h1" if wbcode=="COG" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="COG" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="COG" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="COG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="COG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="COG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="COL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="COL" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="COL" & name=="uisger02"
replace pos = "e1" if wbcode=="COL" & name=="uiscr1"
replace pos = "e2" if wbcode=="COL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="COL" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="COL" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="COL" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="COL" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="COL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="COL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="COL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="COM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="COM" & name=="uisger02"
replace pos = "l3" if wbcode=="COM" & name=="vacBCG"
replace pos = "e1" if wbcode=="COM" & name=="uiscr1"
replace pos = "e2" if wbcode=="COM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="COM" & name=="uiscr2"
replace pos = "h1" if wbcode=="COM" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="COM" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="COM" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="COM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="COM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="COM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CRI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CRI" & name=="uisger02"
replace pos = "l3" if wbcode=="CRI" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="CRI" & name=="uiscr1"
replace pos = "e2" if wbcode=="CRI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CRI" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CRI" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="CRI" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="CRI" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="CRI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CRI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CRI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CUB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CUB" & name=="uisger02"
replace pos = "l3" if wbcode=="CUB" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="CUB" & name=="uiscr1"
replace pos = "e2" if wbcode=="CUB" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CUB" & name=="uiscr2"
replace pos = "h1" if wbcode=="CUB" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CUB" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CUB" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CUB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CUB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CUB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CYP" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CYP" & name=="uisger02"
replace pos = "l3" if wbcode=="CYP" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="CYP" & name=="uiscr1"
replace pos = "e2" if wbcode=="CYP" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CYP" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CYP" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CYP" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CYP" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CYP" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CYP" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CYP" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="CZE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="CZE" & name=="uisger02"
replace pos = "l3" if wbcode=="CZE" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="CZE" & name=="uiscr1"
replace pos = "e2" if wbcode=="CZE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="CZE" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="CZE" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="CZE" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="CZE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="CZE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="CZE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="CZE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="DEU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="DEU" & name=="uisger02"
replace pos = "l3" if wbcode=="DEU" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="DEU" & name=="uiscr1"
replace pos = "e2" if wbcode=="DEU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="DEU" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="DEU" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="DEU" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="DEU" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="DEU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="DEU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="DEU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="DMA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="DMA" & name=="uisger02"
replace pos = "l3" if wbcode=="DMA" & name=="vacBCG"
replace pos = "e1" if wbcode=="DMA" & name=="uiscr1"
replace pos = "e2" if wbcode=="DMA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="DMA" & name=="uiscr2"
replace pos = "h1" if wbcode=="DMA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="DMA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="DMA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="DMA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="DMA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="DMA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="DNK" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="DNK" & name=="uisger02"
replace pos = "l3" if wbcode=="DNK" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="DNK" & name=="uiscr1"
replace pos = "e2" if wbcode=="DNK" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="DNK" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="DNK" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="DNK" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="DNK" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="DNK" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="DNK" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="DNK" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="DOM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="DOM" & name=="uisger02"
replace pos = "l3" if wbcode=="DOM" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="DOM" & name=="uiscr1"
replace pos = "e2" if wbcode=="DOM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="DOM" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="DOM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="DOM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="DOM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="DOM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="DOM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="DOM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="DZA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="DZA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="DZA" & name=="unicef_care"
replace pos = "e1" if wbcode=="DZA" & name=="uiscr1"
replace pos = "e2" if wbcode=="DZA" & name=="uiscr2"
replace pos = "e3" if wbcode=="DZA" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="DZA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="DZA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="DZA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="DZA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="DZA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="DZA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ECU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ECU" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ECU" & name=="uisger02"
replace pos = "e1" if wbcode=="ECU" & name=="uiscr1"
replace pos = "e2" if wbcode=="ECU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ECU" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ECU" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ECU" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ECU" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ECU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ECU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ECU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="EGY" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="EGY" & name=="uisger02"
replace pos = "l3" if wbcode=="EGY" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="EGY" & name=="uiscr1"
replace pos = "e2" if wbcode=="EGY" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="EGY" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="EGY" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="EGY" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="EGY" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="EGY" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="EGY" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="EGY" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ESP" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ESP" & name=="uisger02"
replace pos = "l3" if wbcode=="ESP" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="ESP" & name=="uiscr1"
replace pos = "e2" if wbcode=="ESP" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ESP" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ESP" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ESP" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ESP" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ESP" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ESP" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ESP" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="EST" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="EST" & name=="uisger02"
replace pos = "l3" if wbcode=="EST" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="EST" & name=="uiscr1"
replace pos = "e2" if wbcode=="EST" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="EST" & name=="uiscr2"
replace pos = "h1" if wbcode=="EST" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="EST" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="EST" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="EST" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="EST" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="EST" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ETH" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ETH" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ETH" & name=="uisger02"
replace pos = "e1" if wbcode=="ETH" & name=="uiscr1"
replace pos = "e2" if wbcode=="ETH" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ETH" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ETH" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ETH" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ETH" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ETH" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ETH" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ETH" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="FIN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="FIN" & name=="uisger02"
replace pos = "l3" if wbcode=="FIN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="FIN" & name=="uiscr1"
replace pos = "e2" if wbcode=="FIN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="FIN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="FIN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="FIN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="FIN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="FIN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="FIN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="FIN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="FJI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="FJI" & name=="uisger02"
replace pos = "l3" if wbcode=="FJI" & name=="unicef_care"
replace pos = "e1" if wbcode=="FJI" & name=="uiscr1"
replace pos = "e2" if wbcode=="FJI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="FJI" & name=="uiscr2"
replace pos = "h1" if wbcode=="FJI" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="FJI" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="FJI" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="FJI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="FJI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="FJI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="FRA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="FRA" & name=="uisger02"
replace pos = "l3" if wbcode=="FRA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="FRA" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="FRA" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="FRA" & name=="uiscr2"
replace pos = "h1" if wbcode=="FRA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="FRA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="FRA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="FRA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="FRA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="FRA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="FSM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="FSM" & name=="uisger02"
replace pos = "l3" if wbcode=="FSM" & name=="vacBCG"
replace pos = "e1" if wbcode=="FSM" & name=="uiscr1"
replace pos = "e2" if wbcode=="FSM" & name=="uiscr2"
replace pos = "e3" if wbcode=="FSM" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="FSM" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="FSM" & name=="eip_neet_mf_y"
replace pos = "h3" if wbcode=="FSM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="FSM" & name=="lastnm_probdeath_ncd"
replace pos = "b2" if wbcode=="FSM" & name=="sp_dyn_le00_in_f"
replace pos = "b3" if wbcode=="FSM" & name=="sp_dyn_le00_in_m"
replace pos = "l1" if wbcode=="GAB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GAB" & name=="uisger02"
replace pos = "l3" if wbcode=="GAB" & name=="vacBCG"
replace pos = "e1" if wbcode=="GAB" & name=="uiscr1"
replace pos = "e2" if wbcode=="GAB" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="GAB" & name=="uiscr2"
replace pos = "h1" if wbcode=="GAB" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="GAB" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="GAB" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="GAB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GAB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GAB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GBR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GBR" & name=="uisger02"
replace pos = "l3" if wbcode=="GBR" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="GBR" & name=="uiscr1"
replace pos = "e2" if wbcode=="GBR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GBR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="GBR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="GBR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="GBR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="GBR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GBR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GBR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GEO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GEO" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="GEO" & name=="uisger02"
replace pos = "e1" if wbcode=="GEO" & name=="uiscr1"
replace pos = "e2" if wbcode=="GEO" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GEO" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="GEO" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GEO" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GEO" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="GEO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GEO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GEO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GHA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GHA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="GHA" & name=="uisger02"
replace pos = "e1" if wbcode=="GHA" & name=="uiscr1"
replace pos = "e2" if wbcode=="GHA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GHA" & name=="uiscr2"
replace pos = "h1" if wbcode=="GHA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GHA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GHA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="GHA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GHA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GHA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GIN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GIN" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="GIN" & name=="uisger02"
replace pos = "e1" if wbcode=="GIN" & name=="uiscr1"
replace pos = "e2" if wbcode=="GIN" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="GIN" & name=="uiscr2"
replace pos = "h1" if wbcode=="GIN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GIN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GIN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="GIN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GIN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GIN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GMB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GMB" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="GMB" & name=="uisger02"
replace pos = "e1" if wbcode=="GMB" & name=="uiscr1"
replace pos = "e2" if wbcode=="GMB" & name=="uiscr2"
replace pos = "e3" if wbcode=="GMB" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="GMB" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GMB" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GMB" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="GMB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GMB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GMB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GRC" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GRC" & name=="uisger02"
replace pos = "l3" if wbcode=="GRC" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="GRC" & name=="uiscr1"
replace pos = "e2" if wbcode=="GRC" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GRC" & name=="uiscr2"
replace pos = "h1" if wbcode=="GRC" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="GRC" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="GRC" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="GRC" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GRC" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GRC" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GRD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GRD" & name=="uisger02_f"
replace pos = "l3" if wbcode=="GRD" & name=="uisger02_m"
replace pos = "e1" if wbcode=="GRD" & name=="uiscr1"
replace pos = "e2" if wbcode=="GRD" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GRD" & name=="uiscr2"
replace pos = "h1" if wbcode=="GRD" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="GRD" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="GRD" & name=="eip_neet_mf_y"
replace pos = "b1" if wbcode=="GRD" & name=="lastnm_probdeath_ncd"
replace pos = "b2" if wbcode=="GRD" & name=="sp_dyn_le00_in_f"
replace pos = "b3" if wbcode=="GRD" & name=="sp_dyn_le00_in_m"
replace pos = "l1" if wbcode=="GTM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GTM" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="GTM" & name=="uisger02"
replace pos = "e1" if wbcode=="GTM" & name=="uiscr1"
replace pos = "e2" if wbcode=="GTM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="GTM" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="GTM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GTM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GTM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="GTM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GTM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GTM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="GUY" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="GUY" & name=="unicef_care"
replace pos = "l3" if wbcode=="GUY" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="GUY" & name=="vacHEPBB"
replace pos = "e2" if wbcode=="GUY" & name=="uiscr1"
replace pos = "e3" if wbcode=="GUY" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="GUY" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="GUY" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="GUY" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="GUY" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="GUY" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="GUY" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="HKG" & name=="uisger02_f"
replace pos = "l2" if wbcode=="HKG" & name=="uisger02_m"
replace pos = "l3" if wbcode=="HKG" & name=="unicef_neomort"
replace pos = "e1" if wbcode=="HKG" & name=="uiscr1"
replace pos = "e2" if wbcode=="HKG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="HKG" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="HKG" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="HKG" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="HKG" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="HKG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="HKG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="HKG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="HND" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="HND" & name=="uisger02"
replace pos = "l3" if wbcode=="HND" & name=="unicef_care"
replace pos = "e1" if wbcode=="HND" & name=="se_lpv_prim"
replace pos = "e2" if wbcode=="HND" & name=="vacHEPBB"
replace pos = "e3" if wbcode=="HND" & name=="uiscr1"
replace pos = "h1" if wbcode=="HND" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="HND" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="HND" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="HND" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="HND" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="HND" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="HRV" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="HRV" & name=="uisger02"
replace pos = "l3" if wbcode=="HRV" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="HRV" & name=="uiscr1"
replace pos = "e2" if wbcode=="HRV" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="HRV" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="HRV" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="HRV" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="HRV" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="HRV" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="HRV" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="HRV" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="HTI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="HTI" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="HTI" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="HTI" & name=="uiscr1"
replace pos = "e2" if wbcode=="HTI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="HTI" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="HTI" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="HTI" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="HTI" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="HTI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="HTI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="HTI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="HUN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="HUN" & name=="uisger02"
replace pos = "l3" if wbcode=="HUN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="HUN" & name=="uiscr1"
replace pos = "e2" if wbcode=="HUN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="HUN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="HUN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="HUN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="HUN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="HUN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="HUN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="HUN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="IDN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="IDN" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="IDN" & name=="uisger02"
replace pos = "e1" if wbcode=="IDN" & name=="uiscr1"
replace pos = "e2" if wbcode=="IDN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="IDN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="IDN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="IDN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="IDN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="IDN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="IDN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="IDN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="IND" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="IND" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="IND" & name=="uisger02"
replace pos = "e1" if wbcode=="IND" & name=="uiscr1"
replace pos = "e2" if wbcode=="IND" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="IND" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="IND" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="IND" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="IND" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="IND" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="IND" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="IND" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="IRL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="IRL" & name=="uisger02"
replace pos = "l3" if wbcode=="IRL" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="IRL" & name=="uiscr1"
replace pos = "e2" if wbcode=="IRL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="IRL" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="IRL" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="IRL" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="IRL" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="IRL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="IRL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="IRL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="IRN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="IRN" & name=="uisger02"
replace pos = "l3" if wbcode=="IRN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="IRN" & name=="uiscr1"
replace pos = "e2" if wbcode=="IRN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="IRN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="IRN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="IRN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="IRN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="IRN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="IRN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="IRN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="IRQ" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="IRQ" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="IRQ" & name=="unicef_care"
replace pos = "e1" if wbcode=="IRQ" & name=="vacHEPBB"
replace pos = "e2" if wbcode=="IRQ" & name=="uiscr1"
replace pos = "e3" if wbcode=="IRQ" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="IRQ" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="IRQ" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="IRQ" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="IRQ" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="IRQ" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="IRQ" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ISL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ISL" & name=="uisger02"
replace pos = "l3" if wbcode=="ISL" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="ISL" & name=="uiscr1"
replace pos = "e2" if wbcode=="ISL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ISL" & name=="uiscr2"
replace pos = "h1" if wbcode=="ISL" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ISL" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ISL" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ISL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ISL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ISL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ISR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ISR" & name=="uisger02"
replace pos = "l3" if wbcode=="ISR" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="ISR" & name=="uiscr1"
replace pos = "e2" if wbcode=="ISR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ISR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ISR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ISR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ISR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ISR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ISR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ISR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ITA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ITA" & name=="uisger02"
replace pos = "l3" if wbcode=="ITA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="ITA" & name=="uiscr1"
replace pos = "e2" if wbcode=="ITA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ITA" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ITA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ITA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ITA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ITA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ITA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ITA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="JAM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="JAM" & name=="lastnm_birth_reg"
replace pos = "l3" if wbcode=="JAM" & name=="vacBCG"
replace pos = "e1" if wbcode=="JAM" & name=="uiscr2"
replace pos = "e2" if wbcode=="JAM" & name=="uiscr1_f"
replace pos = "e3" if wbcode=="JAM" & name=="uiscr1_m"
replace pos = "h1" if wbcode=="JAM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="JAM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="JAM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="JAM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="JAM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="JAM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="JOR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="JOR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="JOR" & name=="uisger02"
replace pos = "e1" if wbcode=="JOR" & name=="uiscr1"
replace pos = "e2" if wbcode=="JOR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="JOR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="JOR" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="JOR" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="JOR" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="JOR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="JOR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="JOR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="JPN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="JPN" & name=="lastnm_mmrt"
replace pos = "l3" if wbcode=="JPN" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="JPN" & name=="se_lpv_prim_f"
replace pos = "e2" if wbcode=="JPN" & name=="se_lpv_prim_m"
replace pos = "e3" if wbcode=="JPN" & name=="uiscr1"
replace pos = "h1" if wbcode=="JPN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="JPN" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="JPN" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="JPN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="JPN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="JPN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KAZ" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KAZ" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="KAZ" & name=="uisger02"
replace pos = "e1" if wbcode=="KAZ" & name=="uiscr1"
replace pos = "e2" if wbcode=="KAZ" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KAZ" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="KAZ" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="KAZ" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="KAZ" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="KAZ" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KAZ" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KAZ" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KEN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KEN" & name=="uisger02"
replace pos = "l3" if wbcode=="KEN" & name=="vacBCG"
replace pos = "e1" if wbcode=="KEN" & name=="uiscr2"
replace pos = "e2" if wbcode=="KEN" & name=="uiscr1_f"
replace pos = "e3" if wbcode=="KEN" & name=="uiscr1_m"
replace pos = "h1" if wbcode=="KEN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="KEN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="KEN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="KEN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KEN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KEN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KGZ" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KGZ" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="KGZ" & name=="uisger02"
replace pos = "e1" if wbcode=="KGZ" & name=="uiscr1"
replace pos = "e2" if wbcode=="KGZ" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KGZ" & name=="uiscr2"
replace pos = "h1" if wbcode=="KGZ" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="KGZ" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="KGZ" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="KGZ" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KGZ" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KGZ" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KHM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KHM" & name=="uisger02"
replace pos = "l3" if wbcode=="KHM" & name=="vacBCG"
replace pos = "e1" if wbcode=="KHM" & name=="uiscr1"
replace pos = "e2" if wbcode=="KHM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KHM" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="KHM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="KHM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="KHM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="KHM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KHM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KHM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KIR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KIR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="KIR" & name=="uisger02"
replace pos = "e1" if wbcode=="KIR" & name=="uiscr1"
replace pos = "e2" if wbcode=="KIR" & name=="uiscr2"
replace pos = "e3" if wbcode=="KIR" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="KIR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="KIR" & name=="eip_neet_mf_y_f"
replace pos = "h3" if wbcode=="KIR" & name=="eip_neet_mf_y_m"
replace pos = "b1" if wbcode=="KIR" & name=="lastnm_probdeath_ncd"
replace pos = "b2" if wbcode=="KIR" & name=="sp_dyn_le00_in_f"
replace pos = "b3" if wbcode=="KIR" & name=="sp_dyn_le00_in_m"
replace pos = "l1" if wbcode=="KNA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KNA" & name=="uisger02"
replace pos = "l3" if wbcode=="KNA" & name=="vacBCG"
replace pos = "e1" if wbcode=="KNA" & name=="uiscr1"
replace pos = "e2" if wbcode=="KNA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KNA" & name=="uiscr2"
replace pos = "h1" if wbcode=="KNA" & name=="lastnm_ter_ger"
replace pos = "h2" if wbcode=="KNA" & name=="eip_neet_mf_y"
replace pos = "h3" if wbcode=="KNA" & name=="lastnm_afr"
replace pos = "b1" if wbcode=="KNA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KNA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KNA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KOR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KOR" & name=="uisger02"
replace pos = "l3" if wbcode=="KOR" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="KOR" & name=="uiscr1"
replace pos = "e2" if wbcode=="KOR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KOR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="KOR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="KOR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="KOR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="KOR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KOR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KOR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="KWT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="KWT" & name=="uisger02"
replace pos = "l3" if wbcode=="KWT" & name=="vacBCG"
replace pos = "e1" if wbcode=="KWT" & name=="uiscr1"
replace pos = "e2" if wbcode=="KWT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="KWT" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="KWT" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="KWT" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="KWT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="KWT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="KWT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="KWT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LAO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LAO" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="LAO" & name=="uisger02"
replace pos = "e1" if wbcode=="LAO" & name=="uiscr1"
replace pos = "e2" if wbcode=="LAO" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LAO" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="LAO" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LAO" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LAO" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="LAO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LAO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LAO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LBN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LBN" & name=="lastnm_mmrt"
replace pos = "l3" if wbcode=="LBN" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="LBN" & name=="vacHEPBB"
replace pos = "e2" if wbcode=="LBN" & name=="uiscr1"
replace pos = "e3" if wbcode=="LBN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="LBN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LBN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LBN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="LBN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LBN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LBN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LBR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LBR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="LBR" & name=="uisger02"
replace pos = "e1" if wbcode=="LBR" & name=="uiscr1"
replace pos = "e2" if wbcode=="LBR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LBR" & name=="uiscr2"
replace pos = "h1" if wbcode=="LBR" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LBR" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LBR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="LBR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LBR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LBR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LCA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LCA" & name=="uisger02"
replace pos = "l3" if wbcode=="LCA" & name=="vacBCG"
replace pos = "e1" if wbcode=="LCA" & name=="uiscr1"
replace pos = "e2" if wbcode=="LCA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LCA" & name=="uiscr2"
replace pos = "h1" if wbcode=="LCA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LCA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LCA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="LCA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LCA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LCA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LIE" & name=="lastnm_birth_reg"
replace pos = "l2" if wbcode=="LIE" & name=="uisger02_f"
replace pos = "l3" if wbcode=="LIE" & name=="uisger02_m"
replace pos = "e1" if wbcode=="LIE" & name=="uiscr1"
replace pos = "e2" if wbcode=="LIE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LIE" & name=="uiscr2"
replace pos = "h1" if wbcode=="LIE" & name=="lastnm_ter_ger"
replace pos = "h2" if wbcode=="LIE" & name=="eip_neet_mf_y"
replace pos = "h3" if wbcode=="LIE" & name=="lastnm_afr"
replace pos = "b1" if wbcode=="LIE" & name=="sp_dyn_le00_in_f"
replace pos = "b2" if wbcode=="LIE" & name=="sp_dyn_le00_in_m"
replace pos = "b3" if wbcode=="LIE" & name=="eap_2wap_mf_a_m"
replace pos = "l1" if wbcode=="LKA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LKA" & name=="uisger02"
replace pos = "l3" if wbcode=="LKA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="LKA" & name=="uiscr1"
replace pos = "e2" if wbcode=="LKA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LKA" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="LKA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LKA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LKA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="LKA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LKA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LKA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LSO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LSO" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="LSO" & name=="uisger02"
replace pos = "e1" if wbcode=="LSO" & name=="uiscr1"
replace pos = "e2" if wbcode=="LSO" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LSO" & name=="uiscr2"
replace pos = "h1" if wbcode=="LSO" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="LSO" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="LSO" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="LSO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LSO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LSO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LTU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LTU" & name=="uisger02"
replace pos = "l3" if wbcode=="LTU" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="LTU" & name=="uiscr1"
replace pos = "e2" if wbcode=="LTU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LTU" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="LTU" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="LTU" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="LTU" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="LTU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LTU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LTU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LUX" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LUX" & name=="uisger02"
replace pos = "l3" if wbcode=="LUX" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="LUX" & name=="uiscr1"
replace pos = "e2" if wbcode=="LUX" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LUX" & name=="uiscr2"
replace pos = "h1" if wbcode=="LUX" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="LUX" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="LUX" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="LUX" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LUX" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LUX" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="LVA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="LVA" & name=="uisger02"
replace pos = "l3" if wbcode=="LVA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="LVA" & name=="uiscr1"
replace pos = "e2" if wbcode=="LVA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="LVA" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="LVA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="LVA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="LVA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="LVA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="LVA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="LVA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MAC" & name=="uisger02_f"
replace pos = "l2" if wbcode=="MAC" & name=="uisger02_m"
replace pos = "l3" if wbcode=="MAC" & name=="unicef_neomort"
replace pos = "e1" if wbcode=="MAC" & name=="uiscr1"
replace pos = "e2" if wbcode=="MAC" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MAC" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MAC" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MAC" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MAC" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MAC" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MAC" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MAC" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MAR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MAR" & name=="uisger02"
replace pos = "l3" if wbcode=="MAR" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="MAR" & name=="uiscr1"
replace pos = "e2" if wbcode=="MAR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MAR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MAR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MAR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MAR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MAR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MAR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MAR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MDA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MDA" & name=="uisger02"
replace pos = "l3" if wbcode=="MDA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="MDA" & name=="uiscr1"
replace pos = "e2" if wbcode=="MDA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MDA" & name=="uiscr2"
replace pos = "h1" if wbcode=="MDA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MDA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MDA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MDA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MDA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MDA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MDG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MDG" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MDG" & name=="uisger02"
replace pos = "e1" if wbcode=="MDG" & name=="uiscr1"
replace pos = "e2" if wbcode=="MDG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MDG" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MDG" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MDG" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MDG" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MDG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MDG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MDG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MEX" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MEX" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MEX" & name=="uisger02"
replace pos = "e1" if wbcode=="MEX" & name=="uiscr1"
replace pos = "e2" if wbcode=="MEX" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MEX" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MEX" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MEX" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MEX" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MEX" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MEX" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MEX" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MHL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MHL" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MHL" & name=="uisger02"
replace pos = "e1" if wbcode=="MHL" & name=="uiscr1"
replace pos = "e2" if wbcode=="MHL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MHL" & name=="uiscr2"
replace pos = "h1" if wbcode=="MHL" & name=="lastnm_ter_ger"
replace pos = "h2" if wbcode=="MHL" & name=="eip_neet_mf_y_f"
replace pos = "h3" if wbcode=="MHL" & name=="eip_neet_mf_y_m"
replace pos = "b1" if wbcode=="MHL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MHL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MHL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MKD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MKD" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MKD" & name=="uisger02"
replace pos = "e1" if wbcode=="MKD" & name=="uiscr1"
replace pos = "e2" if wbcode=="MKD" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MKD" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MKD" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MKD" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MKD" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MKD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MKD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MKD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MLI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MLI" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MLI" & name=="uisger02"
replace pos = "e1" if wbcode=="MLI" & name=="uiscr1"
replace pos = "e2" if wbcode=="MLI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MLI" & name=="uiscr2"
replace pos = "h1" if wbcode=="MLI" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MLI" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MLI" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MLI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MLI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MLI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MLT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MLT" & name=="uisger02"
replace pos = "l3" if wbcode=="MLT" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="MLT" & name=="uiscr1"
replace pos = "e2" if wbcode=="MLT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MLT" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MLT" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MLT" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MLT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MLT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MLT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MLT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MMR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MMR" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MMR" & name=="uisger02"
replace pos = "e1" if wbcode=="MMR" & name=="uiscr1"
replace pos = "e2" if wbcode=="MMR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MMR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MMR" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MMR" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MMR" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MMR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MMR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MMR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MNE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MNE" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MNE" & name=="uisger02"
replace pos = "e1" if wbcode=="MNE" & name=="uiscr1"
replace pos = "e2" if wbcode=="MNE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MNE" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MNE" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MNE" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MNE" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MNE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MNE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MNE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MNG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MNG" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MNG" & name=="uisger02"
replace pos = "e1" if wbcode=="MNG" & name=="uiscr1"
replace pos = "e2" if wbcode=="MNG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MNG" & name=="uiscr2"
replace pos = "h1" if wbcode=="MNG" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MNG" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MNG" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MNG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MNG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MNG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MOZ" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MOZ" & name=="unicef_care"
replace pos = "l3" if wbcode=="MOZ" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="MOZ" & name=="uiscr1"
replace pos = "e2" if wbcode=="MOZ" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MOZ" & name=="uiscr2"
replace pos = "h1" if wbcode=="MOZ" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MOZ" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MOZ" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MOZ" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MOZ" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MOZ" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MRT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MRT" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MRT" & name=="uisger02"
replace pos = "e1" if wbcode=="MRT" & name=="uiscr1"
replace pos = "e2" if wbcode=="MRT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MRT" & name=="uiscr2"
replace pos = "h1" if wbcode=="MRT" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MRT" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MRT" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MRT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MRT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MRT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MUS" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MUS" & name=="uisger02"
replace pos = "l3" if wbcode=="MUS" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="MUS" & name=="uiscr1"
replace pos = "e2" if wbcode=="MUS" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MUS" & name=="uiscr2"
replace pos = "h1" if wbcode=="MUS" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MUS" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MUS" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MUS" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MUS" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MUS" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MWI" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MWI" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="MWI" & name=="uisger02"
replace pos = "e1" if wbcode=="MWI" & name=="uiscr1"
replace pos = "e2" if wbcode=="MWI" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MWI" & name=="uiscr2"
replace pos = "h1" if wbcode=="MWI" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="MWI" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="MWI" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="MWI" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MWI" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MWI" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="MYS" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="MYS" & name=="uisger02"
replace pos = "l3" if wbcode=="MYS" & name=="unicef_breastf"
replace pos = "e1" if wbcode=="MYS" & name=="uiscr1"
replace pos = "e2" if wbcode=="MYS" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="MYS" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="MYS" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="MYS" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="MYS" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="MYS" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="MYS" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="MYS" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NAM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NAM" & name=="uisger02"
replace pos = "l3" if wbcode=="NAM" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="NAM" & name=="uiscr1"
replace pos = "e2" if wbcode=="NAM" & name=="uiscr2"
replace pos = "e3" if wbcode=="NAM" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="NAM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="NAM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="NAM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="NAM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NAM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NAM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NER" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NER" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="NER" & name=="uisger02"
replace pos = "e1" if wbcode=="NER" & name=="uiscr1"
replace pos = "e2" if wbcode=="NER" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="NER" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="NER" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="NER" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="NER" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="NER" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NER" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NER" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NGA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NGA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="NGA" & name=="uisger02"
replace pos = "e1" if wbcode=="NGA" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="NGA" & name=="vacHEPBB"
replace pos = "e3" if wbcode=="NGA" & name=="uiscr1"
replace pos = "h1" if wbcode=="NGA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="NGA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="NGA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="NGA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NGA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NGA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NIC" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NIC" & name=="uisger02"
replace pos = "l3" if wbcode=="NIC" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="NIC" & name=="se_lpv_prim"
replace pos = "e2" if wbcode=="NIC" & name=="uiscr1"
replace pos = "e3" if wbcode=="NIC" & name=="lastnm_sec_ger"
replace pos = "h1" if wbcode=="NIC" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="NIC" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="NIC" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="NIC" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NIC" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NIC" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NLD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NLD" & name=="uisger02"
replace pos = "l3" if wbcode=="NLD" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="NLD" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="NLD" & name=="se_lpv_prim_f"
replace pos = "e3" if wbcode=="NLD" & name=="se_lpv_prim_m"
replace pos = "h1" if wbcode=="NLD" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="NLD" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="NLD" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="NLD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NLD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NLD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NOR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NOR" & name=="uisger02"
replace pos = "l3" if wbcode=="NOR" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="NOR" & name=="uiscr1"
replace pos = "e2" if wbcode=="NOR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="NOR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="NOR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="NOR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="NOR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="NOR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NOR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NOR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NPL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NPL" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="NPL" & name=="uisger02"
replace pos = "e1" if wbcode=="NPL" & name=="uiscr1"
replace pos = "e2" if wbcode=="NPL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="NPL" & name=="uiscr2"
replace pos = "h1" if wbcode=="NPL" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="NPL" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="NPL" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="NPL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NPL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NPL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NRU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NRU" & name=="uisger02"
replace pos = "l3" if wbcode=="NRU" & name=="vacBCG"
replace pos = "e1" if wbcode=="NRU" & name=="uiscr1"
replace pos = "e2" if wbcode=="NRU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="NRU" & name=="uiscr2"
replace pos = "h1" if wbcode=="NRU" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="NRU" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="NRU" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="NRU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NRU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NRU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="NZL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="NZL" & name=="uisger02"
replace pos = "l3" if wbcode=="NZL" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="NZL" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="NZL" & name=="se_lpv_prim_f"
replace pos = "e3" if wbcode=="NZL" & name=="se_lpv_prim_m"
replace pos = "h1" if wbcode=="NZL" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="NZL" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="NZL" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="NZL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="NZL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="NZL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="OMN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="OMN" & name=="uisger02"
replace pos = "l3" if wbcode=="OMN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="OMN" & name=="uiscr1"
replace pos = "e2" if wbcode=="OMN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="OMN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="OMN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="OMN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="OMN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="OMN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="OMN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="OMN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PAK" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PAK" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="PAK" & name=="uisger02"
replace pos = "e1" if wbcode=="PAK" & name=="uiscr1"
replace pos = "e2" if wbcode=="PAK" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PAK" & name=="uiscr2"
replace pos = "h1" if wbcode=="PAK" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PAK" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PAK" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PAK" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PAK" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PAK" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PAN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PAN" & name=="uisger02"
replace pos = "l3" if wbcode=="PAN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="PAN" & name=="uiscr1"
replace pos = "e2" if wbcode=="PAN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PAN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="PAN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PAN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PAN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PAN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PAN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PAN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PER" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PER" & name=="uisger02"
replace pos = "l3" if wbcode=="PER" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="PER" & name=="uiscr1"
replace pos = "e2" if wbcode=="PER" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PER" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="PER" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PER" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PER" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PER" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PER" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PER" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PHL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PHL" & name=="uisger02"
replace pos = "l3" if wbcode=="PHL" & name=="unicef_care"
replace pos = "e1" if wbcode=="PHL" & name=="uiscr1"
replace pos = "e2" if wbcode=="PHL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PHL" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="PHL" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PHL" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PHL" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PHL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PHL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PHL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PLW" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PLW" & name=="uisger02_f"
replace pos = "l3" if wbcode=="PLW" & name=="uisger02_m"
replace pos = "e1" if wbcode=="PLW" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="PLW" & name=="vacHEPBB"
replace pos = "e3" if wbcode=="PLW" & name=="uiscr1"
replace pos = "h1" if wbcode=="PLW" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PLW" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PLW" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PLW" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PLW" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PLW" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PNG" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PNG" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="PNG" & name=="uisger02"
replace pos = "e1" if wbcode=="PNG" & name=="uiscr1"
replace pos = "e2" if wbcode=="PNG" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PNG" & name=="uiscr2"
replace pos = "h1" if wbcode=="PNG" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="PNG" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="PNG" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="PNG" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PNG" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PNG" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="POL" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="POL" & name=="uisger02"
replace pos = "l3" if wbcode=="POL" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="POL" & name=="uiscr1"
replace pos = "e2" if wbcode=="POL" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="POL" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="POL" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="POL" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="POL" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="POL" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="POL" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="POL" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PRT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PRT" & name=="uisger02"
replace pos = "l3" if wbcode=="PRT" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="PRT" & name=="uiscr1"
replace pos = "e2" if wbcode=="PRT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PRT" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="PRT" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PRT" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PRT" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PRT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PRT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PRT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PRY" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PRY" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="PRY" & name=="uisger02"
replace pos = "e1" if wbcode=="PRY" & name=="uiscr1"
replace pos = "e2" if wbcode=="PRY" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="PRY" & name=="uiscr2"
replace pos = "h1" if wbcode=="PRY" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PRY" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PRY" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="PRY" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PRY" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PRY" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="PSE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="PSE" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="PSE" & name=="uisger02"
replace pos = "e1" if wbcode=="PSE" & name=="uiscr1"
replace pos = "e2" if wbcode=="PSE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="PSE" & name=="uiscr2"
replace pos = "h1" if wbcode=="PSE" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="PSE" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="PSE" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="PSE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="PSE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="PSE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="QAT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="QAT" & name=="uisger02"
replace pos = "l3" if wbcode=="QAT" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="QAT" & name=="uiscr1"
replace pos = "e2" if wbcode=="QAT" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="QAT" & name=="uiscr2"
replace pos = "h1" if wbcode=="QAT" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="QAT" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="QAT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="QAT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="QAT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="QAT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ROU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ROU" & name=="uisger02"
replace pos = "l3" if wbcode=="ROU" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="ROU" & name=="uiscr1"
replace pos = "e2" if wbcode=="ROU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ROU" & name=="uiscr2"
replace pos = "h1" if wbcode=="ROU" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="ROU" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="ROU" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ROU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ROU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ROU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="RUS" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="RUS" & name=="uisger02"
replace pos = "l3" if wbcode=="RUS" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="RUS" & name=="uiscr1"
replace pos = "e2" if wbcode=="RUS" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="RUS" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="RUS" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="RUS" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="RUS" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="RUS" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="RUS" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="RUS" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="RWA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="RWA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="RWA" & name=="uisger02"
replace pos = "e1" if wbcode=="RWA" & name=="uiscr1"
replace pos = "e2" if wbcode=="RWA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="RWA" & name=="uiscr2"
replace pos = "h1" if wbcode=="RWA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="RWA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="RWA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="RWA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="RWA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="RWA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SAU" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SAU" & name=="uisger02"
replace pos = "l3" if wbcode=="SAU" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="SAU" & name=="uiscr1"
replace pos = "e2" if wbcode=="SAU" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SAU" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SAU" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SAU" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SAU" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SAU" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SAU" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SAU" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SDN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SDN" & name=="uisger02"
replace pos = "l3" if wbcode=="SDN" & name=="vacBCG"
replace pos = "e1" if wbcode=="SDN" & name=="uiscr1"
replace pos = "e2" if wbcode=="SDN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SDN" & name=="uiscr2"
replace pos = "h1" if wbcode=="SDN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SDN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SDN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SDN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SDN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SDN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SEN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SEN" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="SEN" & name=="uisger02"
replace pos = "e1" if wbcode=="SEN" & name=="uiscr1"
replace pos = "e2" if wbcode=="SEN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SEN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SEN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SEN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SEN" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="SEN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SEN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SEN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SGP" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SGP" & name=="uisger02"
replace pos = "l3" if wbcode=="SGP" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="SGP" & name=="uiscr1"
replace pos = "e2" if wbcode=="SGP" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SGP" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SGP" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SGP" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SGP" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SGP" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SGP" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SGP" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SLB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SLB" & name=="uisger02"
replace pos = "l3" if wbcode=="SLB" & name=="unicef_care"
replace pos = "e1" if wbcode=="SLB" & name=="uiscr1"
replace pos = "e2" if wbcode=="SLB" & name=="uiscr2"
replace pos = "e3" if wbcode=="SLB" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="SLB" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SLB" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="SLB" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="SLB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SLB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SLB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SLE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SLE" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="SLE" & name=="uisger02"
replace pos = "e1" if wbcode=="SLE" & name=="uiscr1"
replace pos = "e2" if wbcode=="SLE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SLE" & name=="uiscr2"
replace pos = "h1" if wbcode=="SLE" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SLE" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SLE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SLE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SLE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SLE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SLV" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SLV" & name=="lastnm_birth_reg"
replace pos = "l3" if wbcode=="SLV" & name=="vacBCG"
replace pos = "e1" if wbcode=="SLV" & name=="vacHEPBB"
replace pos = "e2" if wbcode=="SLV" & name=="uiscr1"
replace pos = "e3" if wbcode=="SLV" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SLV" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SLV" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SLV" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="SLV" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SLV" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SLV" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SRB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SRB" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="SRB" & name=="uisger02"
replace pos = "e1" if wbcode=="SRB" & name=="uiscr1"
replace pos = "e2" if wbcode=="SRB" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SRB" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SRB" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SRB" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SRB" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="SRB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SRB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SRB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SSD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SSD" & name=="uisger02"
replace pos = "l3" if wbcode=="SSD" & name=="vacBCG"
replace pos = "e1" if wbcode=="SSD" & name=="lastnm_sec_ger"
replace pos = "e2" if wbcode=="SSD" & name=="uiscr1"
replace pos = "e3" if wbcode=="SSD" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SSD" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SSD" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SSD" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SSD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SSD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SSD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SVK" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SVK" & name=="uisger02"
replace pos = "l3" if wbcode=="SVK" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="SVK" & name=="uiscr1"
replace pos = "e2" if wbcode=="SVK" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SVK" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SVK" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SVK" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SVK" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SVK" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SVK" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SVK" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SVN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SVN" & name=="uisger02"
replace pos = "l3" if wbcode=="SVN" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="SVN" & name=="uiscr1"
replace pos = "e2" if wbcode=="SVN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SVN" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SVN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SVN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SVN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SVN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SVN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SVN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SWE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SWE" & name=="uisger02"
replace pos = "l3" if wbcode=="SWE" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="SWE" & name=="uiscr1"
replace pos = "e2" if wbcode=="SWE" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SWE" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SWE" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SWE" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SWE" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SWE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SWE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SWE" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SWZ" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SWZ" & name=="vacBCG"
replace pos = "l3" if wbcode=="SWZ" & name=="uisger02"
replace pos = "e1" if wbcode=="SWZ" & name=="uiscr1"
replace pos = "e2" if wbcode=="SWZ" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SWZ" & name=="uiscr2"
replace pos = "h1" if wbcode=="SWZ" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SWZ" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SWZ" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SWZ" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SWZ" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SWZ" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="SYC" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SYC" & name=="uisger02"
replace pos = "l3" if wbcode=="SYC" & name=="vacBCG"
replace pos = "e1" if wbcode=="SYC" & name=="uiscr1"
replace pos = "e2" if wbcode=="SYC" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SYC" & name=="uiscr2"
replace pos = "h1" if wbcode=="SYC" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="SYC" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="SYC" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="SYC" & name=="lastnm_probdeath_ncd"
replace pos = "b2" if wbcode=="SYC" & name=="sp_dyn_le00_in_f"
replace pos = "b3" if wbcode=="SYC" & name=="sp_dyn_le00_in_m"
replace pos = "l1" if wbcode=="SYR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="SYR" & name=="unicef_breastf"
replace pos = "l3" if wbcode=="SYR" & name=="vacBCG"
replace pos = "e1" if wbcode=="SYR" & name=="uiscr1"
replace pos = "e2" if wbcode=="SYR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="SYR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="SYR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="SYR" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="SYR" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="SYR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="SYR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="SYR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TCD" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TCD" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TCD" & name=="uisger02"
replace pos = "e1" if wbcode=="TCD" & name=="uiscr1"
replace pos = "e2" if wbcode=="TCD" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TCD" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="TCD" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="TCD" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="TCD" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="TCD" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TCD" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TCD" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TGO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TGO" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TGO" & name=="uisger02"
replace pos = "e1" if wbcode=="TGO" & name=="uiscr1"
replace pos = "e2" if wbcode=="TGO" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TGO" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="TGO" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="TGO" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="TGO" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="TGO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TGO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TGO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="THA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="THA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="THA" & name=="uisger02"
replace pos = "e1" if wbcode=="THA" & name=="uiscr1"
replace pos = "e2" if wbcode=="THA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="THA" & name=="uiscr2"
replace pos = "h1" if wbcode=="THA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="THA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="THA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="THA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="THA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="THA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TJK" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TJK" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TJK" & name=="uisger02"
replace pos = "e1" if wbcode=="TJK" & name=="uiscr1"
replace pos = "e2" if wbcode=="TJK" & name=="uiscr2"
replace pos = "e3" if wbcode=="TJK" & name=="vacHEPBB"
replace pos = "h1" if wbcode=="TJK" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="TJK" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="TJK" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="TJK" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TJK" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TJK" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TLS" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TLS" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TLS" & name=="uisger02"
replace pos = "e1" if wbcode=="TLS" & name=="uiscr1"
replace pos = "e2" if wbcode=="TLS" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TLS" & name=="uiscr2"
replace pos = "h1" if wbcode=="TLS" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="TLS" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="TLS" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="TLS" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TLS" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TLS" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TON" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TON" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TON" & name=="uisger02"
replace pos = "e1" if wbcode=="TON" & name=="uiscr1"
replace pos = "e2" if wbcode=="TON" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TON" & name=="uiscr2"
replace pos = "h1" if wbcode=="TON" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="TON" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="TON" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="TON" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TON" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TON" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TTO" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TTO" & name=="uisger02_f"
replace pos = "l3" if wbcode=="TTO" & name=="uisger02_m"
replace pos = "e1" if wbcode=="TTO" & name=="se_lpv_prim_f"
replace pos = "e2" if wbcode=="TTO" & name=="se_lpv_prim_m"
replace pos = "e3" if wbcode=="TTO" & name=="uiscr1"
replace pos = "h1" if wbcode=="TTO" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="TTO" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="TTO" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="TTO" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TTO" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TTO" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TUN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TUN" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TUN" & name=="uisger02"
replace pos = "e1" if wbcode=="TUN" & name=="uiscr1"
replace pos = "e2" if wbcode=="TUN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TUN" & name=="uiscr2"
replace pos = "h1" if wbcode=="TUN" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="TUN" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="TUN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="TUN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TUN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TUN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TUR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TUR" & name=="uisger02"
replace pos = "l3" if wbcode=="TUR" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="TUR" & name=="uiscr1"
replace pos = "e2" if wbcode=="TUR" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TUR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="TUR" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="TUR" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="TUR" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="TUR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TUR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TUR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TUV" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TUV" & name=="uisger02"
replace pos = "l3" if wbcode=="TUV" & name=="unicef_care"
replace pos = "e1" if wbcode=="TUV" & name=="uiscr1"
replace pos = "e2" if wbcode=="TUV" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TUV" & name=="uiscr2"
replace pos = "h1" if wbcode=="TUV" & name=="eip_neet_mf_y_f"
replace pos = "h2" if wbcode=="TUV" & name=="eip_neet_mf_y_m"
replace pos = "h3" if wbcode=="TUV" & name=="lastnm_afr"
replace pos = "b1" if wbcode=="TUV" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TUV" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TUV" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="TZA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="TZA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="TZA" & name=="uisger02"
replace pos = "e1" if wbcode=="TZA" & name=="uiscr1"
replace pos = "e2" if wbcode=="TZA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="TZA" & name=="uiscr2"
replace pos = "h1" if wbcode=="TZA" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="TZA" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="TZA" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="TZA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="TZA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="TZA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="UGA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="UGA" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="UGA" & name=="uisger02"
replace pos = "e1" if wbcode=="UGA" & name=="uiscr2"
replace pos = "e2" if wbcode=="UGA" & name=="uiscr1_f"
replace pos = "e3" if wbcode=="UGA" & name=="uiscr1_m"
replace pos = "h1" if wbcode=="UGA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="UGA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="UGA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="UGA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="UGA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="UGA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="UKR" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="UKR" & name=="uisger02"
replace pos = "l3" if wbcode=="UKR" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="UKR" & name=="vacHEPBB"
replace pos = "e2" if wbcode=="UKR" & name=="uiscr1"
replace pos = "e3" if wbcode=="UKR" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="UKR" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="UKR" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="UKR" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="UKR" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="UKR" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="UKR" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="URY" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="URY" & name=="uisger02"
replace pos = "l3" if wbcode=="URY" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="URY" & name=="uiscr1"
replace pos = "e2" if wbcode=="URY" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="URY" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="URY" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="URY" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="URY" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="URY" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="URY" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="URY" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="USA" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="USA" & name=="uisger02"
replace pos = "l3" if wbcode=="USA" & name=="lastnm_mmrt"
replace pos = "e1" if wbcode=="USA" & name=="uiscr1"
replace pos = "e2" if wbcode=="USA" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="USA" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="USA" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="USA" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="USA" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="USA" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="USA" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="USA" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="UZB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="UZB" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="UZB" & name=="uisger02"
replace pos = "e1" if wbcode=="UZB" & name=="uiscr1"
replace pos = "e2" if wbcode=="UZB" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="UZB" & name=="uiscr2"
replace pos = "h1" if wbcode=="UZB" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="UZB" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="UZB" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="UZB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="UZB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="UZB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="VCT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="VCT" & name=="uisger02"
replace pos = "l3" if wbcode=="VCT" & name=="vacBCG"
replace pos = "e1" if wbcode=="VCT" & name=="uiscr1"
replace pos = "e2" if wbcode=="VCT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="VCT" & name=="uiscr2"
replace pos = "h1" if wbcode=="VCT" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="VCT" & name=="lastnm_ter_ger"
replace pos = "h3" if wbcode=="VCT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="VCT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="VCT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="VCT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="VEN" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="VEN" & name=="uisger02"
replace pos = "l3" if wbcode=="VEN" & name=="lastnm_birth_reg"
replace pos = "e1" if wbcode=="VEN" & name=="uiscr1"
replace pos = "e2" if wbcode=="VEN" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="VEN" & name=="uiscr2"
replace pos = "h1" if wbcode=="VEN" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="VEN" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="VEN" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="VEN" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="VEN" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="VEN" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="VNM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="VNM" & name=="uisger02"
replace pos = "l3" if wbcode=="VNM" & name=="unicef_care"
replace pos = "e1" if wbcode=="VNM" & name=="uiscr1"
replace pos = "e2" if wbcode=="VNM" & name=="se_lpv_prim"
replace pos = "e3" if wbcode=="VNM" & name=="uiscr2"
replace pos = "h1" if wbcode=="VNM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="VNM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="VNM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="VNM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="VNM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="VNM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="VUT" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="VUT" & name=="uisger02"
replace pos = "l3" if wbcode=="VUT" & name=="vacBCG"
replace pos = "e1" if wbcode=="VUT" & name=="uiscr1"
replace pos = "e2" if wbcode=="VUT" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="VUT" & name=="uiscr2"
replace pos = "h1" if wbcode=="VUT" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="VUT" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="VUT" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="VUT" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="VUT" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="VUT" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="WSM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="WSM" & name=="uisger02"
replace pos = "l3" if wbcode=="WSM" & name=="unicef_care"
replace pos = "e1" if wbcode=="WSM" & name=="uiscr1"
replace pos = "e2" if wbcode=="WSM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="WSM" & name=="uiscr2"
replace pos = "h1" if wbcode=="WSM" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="WSM" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="WSM" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="WSM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="WSM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="WSM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="XKX" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="XKX" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="XKX" & name=="uisger02"
replace pos = "e1" if wbcode=="XKX" & name=="uiscr1"
replace pos = "e2" if wbcode=="XKX" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="XKX" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="XKX" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="XKX" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="XKX" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="XKX" & name=="sp_dyn_le00_in_f"
replace pos = "b2" if wbcode=="XKX" & name=="sp_dyn_le00_in_m"
replace pos = "b3" if wbcode=="XKX" & name=="eap_2wap_mf_a_m"
replace pos = "l1" if wbcode=="YEM" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="YEM" & name=="uisger02"
replace pos = "l3" if wbcode=="YEM" & name=="vacBCG"
replace pos = "e1" if wbcode=="YEM" & name=="uiscr1"
replace pos = "e2" if wbcode=="YEM" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="YEM" & name=="uiscr2"
replace pos = "h1" if wbcode=="YEM" & name=="lastnm_afr"
replace pos = "h2" if wbcode=="YEM" & name=="une_2eap_mf_y_f"
replace pos = "h3" if wbcode=="YEM" & name=="une_2eap_mf_y_m"
replace pos = "b1" if wbcode=="YEM" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="YEM" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="YEM" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ZAF" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ZAF" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ZAF" & name=="uisger02"
replace pos = "e1" if wbcode=="ZAF" & name=="uiscr1"
replace pos = "e2" if wbcode=="ZAF" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ZAF" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ZAF" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ZAF" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ZAF" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ZAF" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ZAF" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ZAF" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ZMB" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ZMB" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ZMB" & name=="uisger02"
replace pos = "e1" if wbcode=="ZMB" & name=="uiscr1"
replace pos = "e2" if wbcode=="ZMB" & name=="lastnm_sec_ger"
replace pos = "e3" if wbcode=="ZMB" & name=="se_lpv_prim"
replace pos = "h1" if wbcode=="ZMB" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ZMB" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ZMB" & name=="une_2eap_mf_y"
replace pos = "b1" if wbcode=="ZMB" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ZMB" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ZMB" & name=="sp_dyn_le00_in"
replace pos = "l1" if wbcode=="ZWE" & name=="unicef_neomort"
replace pos = "l2" if wbcode=="ZWE" & name=="unicef_mealfreq"
replace pos = "l3" if wbcode=="ZWE" & name=="uisger02"
replace pos = "e1" if wbcode=="ZWE" & name=="uiscr2"
replace pos = "e2" if wbcode=="ZWE" & name=="uiscr1_f"
replace pos = "e3" if wbcode=="ZWE" & name=="uiscr1_m"
replace pos = "h1" if wbcode=="ZWE" & name=="eip_neet_mf_y"
replace pos = "h2" if wbcode=="ZWE" & name=="lastnm_afr"
replace pos = "h3" if wbcode=="ZWE" & name=="lastnm_ter_ger"
replace pos = "b1" if wbcode=="ZWE" & name=="eap_2wap_mf_a_f"
replace pos = "b2" if wbcode=="ZWE" & name=="eap_2wap_mf_a_m"
replace pos = "b3" if wbcode=="ZWE" & name=="sp_dyn_le00_in"
}	
		
	
	*------------------------------Variable Label------------------------------*
{
	gen lab = ""	
	
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="AFG" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="AFG" & name=="unicef_mealfreq"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="AFG" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="AFG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="AFG" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="AFG" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="AFG" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="AFG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="AFG" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="AFG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="AFG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="AFG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="AGO" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="AGO" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="AGO" & name=="uisger02"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="AGO" & name=="lastnm_sec_ger"
replace lab = "Primary school completion (%)" if wbcode=="AGO" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="AGO" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="AGO" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="AGO" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="AGO" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="AGO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="AGO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="AGO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ALB" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ALB" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ALB" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ALB" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ALB" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ALB" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ALB" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ALB" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ALB" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ALB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ALB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ALB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ARE" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ARE" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="ARE" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="ARE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ARE" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ARE" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ARE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ARE" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ARE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ARE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ARE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ARE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ARG" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ARG" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="ARG" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="ARG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ARG" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ARG" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ARG" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ARG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ARG" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ARG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ARG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ARG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ARM" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ARM" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ARM" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ARM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ARM" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ARM" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ARM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ARM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ARM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ARM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ARM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ARM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ATG" & name=="unicef_neomort"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="ATG" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="ATG" & name=="uisger02_m"
replace lab = "Primary school completion (%)" if wbcode=="ATG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ATG" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="ATG" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ATG" & name=="lastnm_afr"
replace lab = "Youth NEET (%)" if wbcode=="ATG" & name=="eip_neet_mf_y"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ATG" & name=="lastnm_ter_ger"
replace lab = "Probability of dying from NCDs (%)" if wbcode=="ATG" & name=="lastnm_probdeath_ncd"
replace lab = "Female life expectancy at birth (years)" if wbcode=="ATG" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="ATG" & name=="sp_dyn_le00_in_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="AUS" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="AUS" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="AUS" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="AUS" & name=="lastnm_sec_ger"
replace lab = "Female learning poverty (%)" if wbcode=="AUS" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="AUS" & name=="se_lpv_prim_m"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="AUS" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="AUS" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="AUS" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="AUS" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="AUS" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="AUS" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="AUT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="AUT" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="AUT" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="AUT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="AUT" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="AUT" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="AUT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="AUT" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="AUT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="AUT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="AUT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="AUT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="AZE" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="AZE" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="AZE" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="AZE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="AZE" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="AZE" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="AZE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="AZE" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="AZE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="AZE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="AZE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="AZE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BDI" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="BDI" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BDI" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="BDI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BDI" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BDI" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BDI" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BDI" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="BDI" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="BDI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BDI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BDI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BEL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BEL" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="BEL" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BEL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BEL" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="BEL" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BEL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BEL" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="BEL" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="BEL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BEL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BEL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BEN" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="BEN" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BEN" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="BEN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BEN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BEN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="BEN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BEN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BEN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BEN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BEN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BEN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BFA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="BFA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BFA" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="BFA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BFA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BFA" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="BFA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BFA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BFA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BFA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BFA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BFA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BGD" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="BGD" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BGD" & name=="uisger02"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BGD" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BGD" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="BGD" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="BGD" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BGD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BGD" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BGD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BGD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BGD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BGR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BGR" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="BGR" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="BGR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BGR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BGR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BGR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BGR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="BGR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="BGR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BGR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BGR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BHR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BHR" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="BHR" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="BHR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BHR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BHR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BHR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BHR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="BHR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="BHR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BHR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BHR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BIH" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BIH" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="BIH" & name=="vacBCG"
replace lab = "Lower secondary school completion (%)" if wbcode=="BIH" & name=="uiscr2"
replace lab = "Female primary school completion (%)" if wbcode=="BIH" & name=="uiscr1_f"
replace lab = "Male primary school completion (%)" if wbcode=="BIH" & name=="uiscr1_m"
replace lab = "Youth NEET (%)" if wbcode=="BIH" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BIH" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BIH" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BIH" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BIH" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BIH" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BLR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="BLR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BLR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="BLR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BLR" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="BLR" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="BLR" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BLR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BLR" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BLR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BLR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BLR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BRA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BRA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="BRA" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BRA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="BRA" & name=="se_lpv_prim"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="BRA" & name=="vacHEPBB"
replace lab = "Youth NEET (%)" if wbcode=="BRA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BRA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BRA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BRA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BRA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BRA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BRN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BRN" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="BRN" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="BRN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BRN" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="BRN" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="BRN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BRN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BRN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BRN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BRN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BRN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BTN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BTN" & name=="uisger02"
replace lab = "Infants fed exclusively with breast milk (%)" if wbcode=="BTN" & name=="unicef_breastf"
replace lab = "Primary school completion (%)" if wbcode=="BTN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BTN" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="BTN" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BTN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BTN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="BTN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="BTN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BTN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BTN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="BWA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="BWA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="BWA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="BWA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="BWA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="BWA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="BWA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="BWA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="BWA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="BWA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="BWA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="BWA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CAF" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="CAF" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CAF" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="CAF" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CAF" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="CAF" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CAF" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="CAF" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="CAF" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="CAF" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CAF" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CAF" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CAN" & name=="unicef_neomort"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CAN" & name=="lastnm_mmrt"
replace lab = "Completeness of birth registration (%)" if wbcode=="CAN" & name=="lastnm_birth_reg"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CAN" & name=="lastnm_sec_ger"
replace lab = "Female learning poverty (%)" if wbcode=="CAN" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="CAN" & name=="se_lpv_prim_m"
replace lab = "Youth NEET (%)" if wbcode=="CAN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CAN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CAN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="CAN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CAN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CAN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CHE" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CHE" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CHE" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="CHE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CHE" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="CHE" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CHE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CHE" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CHE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CHE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CHE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CHE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CHL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CHL" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CHL" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="CHL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CHL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CHL" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="CHL" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CHL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CHL" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="CHL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CHL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CHL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CHN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CHN" & name=="uisger02"
replace lab = "Children with diarrhea who attended health facility (%)" if wbcode=="CHN" & name=="unicef_diarrhoea"
replace lab = "Learning poverty (%)" if wbcode=="CHN" & name=="se_lpv_prim"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="CHN" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="CHN" & name=="uiscr1"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CHN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CHN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CHN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CHN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CHN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CHN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CIV" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="CIV" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CIV" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="CIV" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CIV" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CIV" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="CIV" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CIV" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CIV" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="CIV" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CIV" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CIV" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CMR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="CMR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CMR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="CMR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CMR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CMR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CMR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CMR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CMR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CMR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CMR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CMR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="COD" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="COD" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="COD" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="COD" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="COD" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="COD" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="COD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="COD" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="COD" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="COD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="COD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="COD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="COG" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="COG" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="COG" & name=="lastnm_mmrt"
replace lab = "Female learning poverty (%)" if wbcode=="COG" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="COG" & name=="se_lpv_prim_m"
replace lab = "Primary school completion (%)" if wbcode=="COG" & name=="uiscr1"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="COG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="COG" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="COG" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="COG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="COG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="COG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="COL" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="COL" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="COL" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="COL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="COL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="COL" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="COL" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="COL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="COL" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="COL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="COL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="COL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="COM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="COM" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="COM" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="COM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="COM" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="COM" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="COM" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="COM" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="COM" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="COM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="COM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="COM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CRI" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CRI" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CRI" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="CRI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CRI" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CRI" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="CRI" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CRI" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CRI" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="CRI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CRI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CRI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CUB" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CUB" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CUB" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="CUB" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CUB" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="CUB" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CUB" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CUB" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CUB" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CUB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CUB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CUB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CYP" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CYP" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="CYP" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="CYP" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CYP" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CYP" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CYP" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CYP" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CYP" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CYP" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CYP" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CYP" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="CZE" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="CZE" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="CZE" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="CZE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="CZE" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="CZE" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="CZE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="CZE" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="CZE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="CZE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="CZE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="CZE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="DEU" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="DEU" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="DEU" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="DEU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="DEU" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="DEU" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="DEU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="DEU" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="DEU" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="DEU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="DEU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="DEU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="DMA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="DMA" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="DMA" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="DMA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="DMA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="DMA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="DMA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="DMA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="DMA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="DMA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="DMA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="DMA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="DNK" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="DNK" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="DNK" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="DNK" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="DNK" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="DNK" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="DNK" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="DNK" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="DNK" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="DNK" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="DNK" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="DNK" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="DOM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="DOM" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="DOM" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="DOM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="DOM" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="DOM" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="DOM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="DOM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="DOM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="DOM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="DOM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="DOM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="DZA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="DZA" & name=="unicef_mealfreq"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="DZA" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="DZA" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="DZA" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="DZA" & name=="vacHEPBB"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="DZA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="DZA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="DZA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="DZA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="DZA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="DZA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ECU" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ECU" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ECU" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ECU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ECU" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ECU" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ECU" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ECU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ECU" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ECU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ECU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ECU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="EGY" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="EGY" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="EGY" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="EGY" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="EGY" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="EGY" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="EGY" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="EGY" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="EGY" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="EGY" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="EGY" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="EGY" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ESP" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ESP" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="ESP" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="ESP" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ESP" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ESP" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ESP" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ESP" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ESP" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ESP" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ESP" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ESP" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="EST" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="EST" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="EST" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="EST" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="EST" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="EST" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="EST" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="EST" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="EST" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="EST" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="EST" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="EST" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ETH" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ETH" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ETH" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ETH" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ETH" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ETH" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ETH" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ETH" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ETH" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ETH" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ETH" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ETH" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="FIN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="FIN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="FIN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="FIN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="FIN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="FIN" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="FIN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="FIN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="FIN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="FIN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="FIN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="FIN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="FJI" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="FJI" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="FJI" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="FJI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="FJI" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="FJI" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="FJI" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="FJI" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="FJI" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="FJI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="FJI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="FJI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="FRA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="FRA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="FRA" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="FRA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="FRA" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="FRA" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="FRA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="FRA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="FRA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="FRA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="FRA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="FRA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="FSM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="FSM" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="FSM" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="FSM" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="FSM" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="FSM" & name=="vacHEPBB"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="FSM" & name=="lastnm_afr"
replace lab = "Youth NEET (%)" if wbcode=="FSM" & name=="eip_neet_mf_y"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="FSM" & name=="lastnm_ter_ger"
replace lab = "Probability of dying from NCDs (%)" if wbcode=="FSM" & name=="lastnm_probdeath_ncd"
replace lab = "Female life expectancy at birth (years)" if wbcode=="FSM" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="FSM" & name=="sp_dyn_le00_in_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GAB" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GAB" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="GAB" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="GAB" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="GAB" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="GAB" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GAB" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GAB" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="GAB" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="GAB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GAB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GAB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GBR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GBR" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="GBR" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="GBR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GBR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="GBR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GBR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GBR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="GBR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="GBR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GBR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GBR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GEO" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="GEO" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GEO" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="GEO" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GEO" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="GEO" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="GEO" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GEO" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GEO" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="GEO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GEO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GEO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GHA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="GHA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GHA" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="GHA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GHA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="GHA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="GHA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GHA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GHA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="GHA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GHA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GHA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GIN" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="GIN" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GIN" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="GIN" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="GIN" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="GIN" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="GIN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GIN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GIN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="GIN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GIN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GIN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GMB" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="GMB" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GMB" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="GMB" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="GMB" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="GMB" & name=="vacHEPBB"
replace lab = "Youth NEET (%)" if wbcode=="GMB" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GMB" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="GMB" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="GMB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GMB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GMB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GRC" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GRC" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="GRC" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="GRC" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GRC" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="GRC" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GRC" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GRC" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="GRC" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="GRC" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GRC" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GRC" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GRD" & name=="unicef_neomort"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="GRD" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="GRD" & name=="uisger02_m"
replace lab = "Primary school completion (%)" if wbcode=="GRD" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GRD" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="GRD" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GRD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GRD" & name=="lastnm_ter_ger"
replace lab = "Youth NEET (%)" if wbcode=="GRD" & name=="eip_neet_mf_y"
replace lab = "Probability of dying from NCDs (%)" if wbcode=="GRD" & name=="lastnm_probdeath_ncd"
replace lab = "Female life expectancy at birth (years)" if wbcode=="GRD" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="GRD" & name=="sp_dyn_le00_in_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GTM" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="GTM" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="GTM" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="GTM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="GTM" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="GTM" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="GTM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GTM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="GTM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="GTM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GTM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GTM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="GUY" & name=="unicef_neomort"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="GUY" & name=="unicef_care"
replace lab = "Completeness of birth registration (%)" if wbcode=="GUY" & name=="lastnm_birth_reg"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="GUY" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="GUY" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="GUY" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="GUY" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="GUY" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="GUY" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="GUY" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="GUY" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="GUY" & name=="sp_dyn_le00_in"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="HKG" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="HKG" & name=="uisger02_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="HKG" & name=="unicef_neomort"
replace lab = "Primary school completion (%)" if wbcode=="HKG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="HKG" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="HKG" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="HKG" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="HKG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="HKG" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="HKG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="HKG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="HKG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="HND" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="HND" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="HND" & name=="unicef_care"
replace lab = "Learning poverty (%)" if wbcode=="HND" & name=="se_lpv_prim"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="HND" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="HND" & name=="uiscr1"
replace lab = "Youth NEET (%)" if wbcode=="HND" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="HND" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="HND" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="HND" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="HND" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="HND" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="HRV" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="HRV" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="HRV" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="HRV" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="HRV" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="HRV" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="HRV" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="HRV" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="HRV" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="HRV" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="HRV" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="HRV" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="HTI" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="HTI" & name=="unicef_mealfreq"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="HTI" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="HTI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="HTI" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="HTI" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="HTI" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="HTI" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="HTI" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="HTI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="HTI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="HTI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="HUN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="HUN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="HUN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="HUN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="HUN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="HUN" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="HUN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="HUN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="HUN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="HUN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="HUN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="HUN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="IDN" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="IDN" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="IDN" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="IDN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="IDN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="IDN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="IDN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="IDN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="IDN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="IDN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="IDN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="IDN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="IND" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="IND" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="IND" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="IND" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="IND" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="IND" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="IND" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="IND" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="IND" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="IND" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="IND" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="IND" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="IRL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="IRL" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="IRL" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="IRL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="IRL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="IRL" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="IRL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="IRL" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="IRL" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="IRL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="IRL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="IRL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="IRN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="IRN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="IRN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="IRN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="IRN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="IRN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="IRN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="IRN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="IRN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="IRN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="IRN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="IRN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="IRQ" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="IRQ" & name=="unicef_mealfreq"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="IRQ" & name=="unicef_care"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="IRQ" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="IRQ" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="IRQ" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="IRQ" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="IRQ" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="IRQ" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="IRQ" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="IRQ" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="IRQ" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ISL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ISL" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="ISL" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="ISL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ISL" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="ISL" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ISL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ISL" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ISL" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ISL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ISL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ISL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ISR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ISR" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="ISR" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="ISR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ISR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ISR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ISR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ISR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ISR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ISR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ISR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ISR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ITA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ITA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="ITA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="ITA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ITA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ITA" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ITA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ITA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ITA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ITA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ITA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ITA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="JAM" & name=="unicef_neomort"
replace lab = "Completeness of birth registration (%)" if wbcode=="JAM" & name=="lastnm_birth_reg"
replace lab = "BCG vaccination (%)" if wbcode=="JAM" & name=="vacBCG"
replace lab = "Lower secondary school completion (%)" if wbcode=="JAM" & name=="uiscr2"
replace lab = "Female primary school completion (%)" if wbcode=="JAM" & name=="uiscr1_f"
replace lab = "Male primary school completion (%)" if wbcode=="JAM" & name=="uiscr1_m"
replace lab = "Youth NEET (%)" if wbcode=="JAM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="JAM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="JAM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="JAM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="JAM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="JAM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="JOR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="JOR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="JOR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="JOR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="JOR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="JOR" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="JOR" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="JOR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="JOR" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="JOR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="JOR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="JOR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="JPN" & name=="unicef_neomort"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="JPN" & name=="lastnm_mmrt"
replace lab = "Completeness of birth registration (%)" if wbcode=="JPN" & name=="lastnm_birth_reg"
replace lab = "Female learning poverty (%)" if wbcode=="JPN" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="JPN" & name=="se_lpv_prim_m"
replace lab = "Primary school completion (%)" if wbcode=="JPN" & name=="uiscr1"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="JPN" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="JPN" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="JPN" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="JPN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="JPN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="JPN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KAZ" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="KAZ" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KAZ" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="KAZ" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KAZ" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="KAZ" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KAZ" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KAZ" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="KAZ" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="KAZ" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KAZ" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KAZ" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KEN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KEN" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="KEN" & name=="vacBCG"
replace lab = "Lower secondary school completion (%)" if wbcode=="KEN" & name=="uiscr2"
replace lab = "Female primary school completion (%)" if wbcode=="KEN" & name=="uiscr1_f"
replace lab = "Male primary school completion (%)" if wbcode=="KEN" & name=="uiscr1_m"
replace lab = "Youth NEET (%)" if wbcode=="KEN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KEN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KEN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="KEN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KEN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KEN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KGZ" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="KGZ" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KGZ" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="KGZ" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KGZ" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="KGZ" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="KGZ" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KGZ" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KGZ" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="KGZ" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KGZ" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KGZ" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KHM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KHM" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="KHM" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="KHM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KHM" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="KHM" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="KHM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KHM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KHM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="KHM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KHM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KHM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KIR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="KIR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KIR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="KIR" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="KIR" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="KIR" & name=="vacHEPBB"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KIR" & name=="lastnm_afr"
replace lab = "Female youth NEET (%)" if wbcode=="KIR" & name=="eip_neet_mf_y_f"
replace lab = "Male youth NEET (%)" if wbcode=="KIR" & name=="eip_neet_mf_y_m"
replace lab = "Probability of dying from NCDs (%)" if wbcode=="KIR" & name=="lastnm_probdeath_ncd"
replace lab = "Female life expectancy at birth (years)" if wbcode=="KIR" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="KIR" & name=="sp_dyn_le00_in_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KNA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KNA" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="KNA" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="KNA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KNA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="KNA" & name=="uiscr2"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KNA" & name=="lastnm_ter_ger"
replace lab = "Youth NEET (%)" if wbcode=="KNA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KNA" & name=="lastnm_afr"
replace lab = "Female labour force participation (%)" if wbcode=="KNA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KNA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KNA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KOR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KOR" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="KOR" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="KOR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KOR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="KOR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KOR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KOR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="KOR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="KOR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KOR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KOR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="KWT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="KWT" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="KWT" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="KWT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="KWT" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="KWT" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="KWT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="KWT" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="KWT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="KWT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="KWT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="KWT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LAO" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="LAO" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LAO" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="LAO" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LAO" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="LAO" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="LAO" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LAO" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LAO" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="LAO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LAO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LAO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LBN" & name=="unicef_neomort"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="LBN" & name=="lastnm_mmrt"
replace lab = "Completeness of birth registration (%)" if wbcode=="LBN" & name=="lastnm_birth_reg"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="LBN" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="LBN" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="LBN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="LBN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LBN" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="LBN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="LBN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LBN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LBN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LBR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="LBR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LBR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="LBR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LBR" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="LBR" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="LBR" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LBR" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="LBR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="LBR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LBR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LBR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LCA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LCA" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="LCA" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="LCA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LCA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="LCA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="LCA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LCA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LCA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="LCA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LCA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LCA" & name=="sp_dyn_le00_in"
replace lab = "Completeness of birth registration (%)" if wbcode=="LIE" & name=="lastnm_birth_reg"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="LIE" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="LIE" & name=="uisger02_m"
replace lab = "Primary school completion (%)" if wbcode=="LIE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LIE" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="LIE" & name=="uiscr2"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LIE" & name=="lastnm_ter_ger"
replace lab = "Youth NEET (%)" if wbcode=="LIE" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LIE" & name=="lastnm_afr"
replace lab = "Female life expectancy at birth (years)" if wbcode=="LIE" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="LIE" & name=="sp_dyn_le00_in_m"
replace lab = "Male labour force participation (%)" if wbcode=="LIE" & name=="eap_2wap_mf_a_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LKA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LKA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="LKA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="LKA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LKA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="LKA" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="LKA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LKA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LKA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="LKA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LKA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LKA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LSO" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="LSO" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LSO" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="LSO" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LSO" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="LSO" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="LSO" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LSO" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LSO" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="LSO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LSO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LSO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LTU" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LTU" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="LTU" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="LTU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LTU" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="LTU" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LTU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LTU" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="LTU" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="LTU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LTU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LTU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LUX" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LUX" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="LUX" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="LUX" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LUX" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="LUX" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LUX" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LUX" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="LUX" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="LUX" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LUX" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LUX" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="LVA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="LVA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="LVA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="LVA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="LVA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="LVA" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="LVA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="LVA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="LVA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="LVA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="LVA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="LVA" & name=="sp_dyn_le00_in"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="MAC" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="MAC" & name=="uisger02_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MAC" & name=="unicef_neomort"
replace lab = "Primary school completion (%)" if wbcode=="MAC" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MAC" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MAC" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MAC" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MAC" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MAC" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MAC" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MAC" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MAC" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MAR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MAR" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="MAR" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="MAR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MAR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MAR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MAR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MAR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MAR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MAR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MAR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MAR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MDA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MDA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="MDA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="MDA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MDA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MDA" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MDA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MDA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MDA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MDA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MDA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MDA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MDG" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MDG" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MDG" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MDG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MDG" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MDG" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MDG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MDG" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MDG" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MDG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MDG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MDG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MEX" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MEX" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MEX" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MEX" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MEX" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MEX" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="MEX" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MEX" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MEX" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MEX" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MEX" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MEX" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MHL" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MHL" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MHL" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MHL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MHL" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MHL" & name=="uiscr2"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MHL" & name=="lastnm_ter_ger"
replace lab = "Female youth NEET (%)" if wbcode=="MHL" & name=="eip_neet_mf_y_f"
replace lab = "Male youth NEET (%)" if wbcode=="MHL" & name=="eip_neet_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="MHL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MHL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MHL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MKD" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MKD" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MKD" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MKD" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MKD" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MKD" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="MKD" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MKD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MKD" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MKD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MKD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MKD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MLI" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MLI" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MLI" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MLI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MLI" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MLI" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="MLI" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MLI" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MLI" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MLI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MLI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MLI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MLT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MLT" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="MLT" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="MLT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MLT" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MLT" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MLT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MLT" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MLT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MLT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MLT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MLT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MMR" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MMR" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MMR" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MMR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MMR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MMR" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="MMR" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MMR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MMR" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MMR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MMR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MMR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MNE" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MNE" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MNE" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MNE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MNE" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MNE" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="MNE" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MNE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MNE" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MNE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MNE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MNE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MNG" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MNG" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MNG" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MNG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MNG" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MNG" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="MNG" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MNG" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MNG" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MNG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MNG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MNG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MOZ" & name=="unicef_neomort"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="MOZ" & name=="unicef_care"
replace lab = "Completeness of birth registration (%)" if wbcode=="MOZ" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="MOZ" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MOZ" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MOZ" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MOZ" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MOZ" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MOZ" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MOZ" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MOZ" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MOZ" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MRT" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MRT" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MRT" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MRT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MRT" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MRT" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="MRT" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MRT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MRT" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MRT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MRT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MRT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MUS" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MUS" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="MUS" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="MUS" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MUS" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MUS" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="MUS" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MUS" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MUS" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MUS" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MUS" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MUS" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MWI" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="MWI" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MWI" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="MWI" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MWI" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="MWI" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="MWI" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MWI" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MWI" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="MWI" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MWI" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MWI" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="MYS" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="MYS" & name=="uisger02"
replace lab = "Infants fed exclusively with breast milk (%)" if wbcode=="MYS" & name=="unicef_breastf"
replace lab = "Primary school completion (%)" if wbcode=="MYS" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="MYS" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="MYS" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="MYS" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="MYS" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="MYS" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="MYS" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="MYS" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="MYS" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NAM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NAM" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="NAM" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="NAM" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="NAM" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="NAM" & name=="vacHEPBB"
replace lab = "Youth NEET (%)" if wbcode=="NAM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NAM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NAM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="NAM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NAM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NAM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NER" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="NER" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NER" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="NER" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NER" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="NER" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="NER" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NER" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NER" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="NER" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NER" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NER" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NGA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="NGA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NGA" & name=="uisger02"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NGA" & name=="lastnm_sec_ger"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="NGA" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="NGA" & name=="uiscr1"
replace lab = "Youth NEET (%)" if wbcode=="NGA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NGA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NGA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="NGA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NGA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NGA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NIC" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NIC" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="NIC" & name=="lastnm_mmrt"
replace lab = "Learning poverty (%)" if wbcode=="NIC" & name=="se_lpv_prim"
replace lab = "Primary school completion (%)" if wbcode=="NIC" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NIC" & name=="lastnm_sec_ger"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NIC" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NIC" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="NIC" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="NIC" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NIC" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NIC" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NLD" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NLD" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="NLD" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NLD" & name=="lastnm_sec_ger"
replace lab = "Female learning poverty (%)" if wbcode=="NLD" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="NLD" & name=="se_lpv_prim_m"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NLD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NLD" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="NLD" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="NLD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NLD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NLD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NOR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NOR" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="NOR" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="NOR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NOR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="NOR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NOR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NOR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="NOR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="NOR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NOR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NOR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NPL" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="NPL" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NPL" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="NPL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NPL" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="NPL" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="NPL" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NPL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NPL" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="NPL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NPL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NPL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NRU" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NRU" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="NRU" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="NRU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NRU" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="NRU" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="NRU" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NRU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NRU" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="NRU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NRU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NRU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="NZL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="NZL" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="NZL" & name=="lastnm_mmrt"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="NZL" & name=="lastnm_sec_ger"
replace lab = "Female learning poverty (%)" if wbcode=="NZL" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="NZL" & name=="se_lpv_prim_m"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="NZL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="NZL" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="NZL" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="NZL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="NZL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="NZL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="OMN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="OMN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="OMN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="OMN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="OMN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="OMN" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="OMN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="OMN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="OMN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="OMN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="OMN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="OMN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PAK" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="PAK" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PAK" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="PAK" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PAK" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="PAK" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="PAK" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PAK" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PAK" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PAK" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PAK" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PAK" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PAN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PAN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="PAN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="PAN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PAN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="PAN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="PAN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PAN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PAN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PAN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PAN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PAN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PER" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PER" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="PER" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="PER" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PER" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="PER" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="PER" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PER" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PER" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PER" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PER" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PER" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PHL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PHL" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="PHL" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="PHL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PHL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="PHL" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="PHL" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PHL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PHL" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PHL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PHL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PHL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PLW" & name=="unicef_neomort"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="PLW" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="PLW" & name=="uisger02_m"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PLW" & name=="lastnm_sec_ger"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="PLW" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="PLW" & name=="uiscr1"
replace lab = "Youth NEET (%)" if wbcode=="PLW" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PLW" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PLW" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PLW" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PLW" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PLW" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PNG" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="PNG" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PNG" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="PNG" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PNG" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="PNG" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PNG" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="PNG" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="PNG" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="PNG" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PNG" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PNG" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="POL" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="POL" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="POL" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="POL" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="POL" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="POL" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="POL" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="POL" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="POL" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="POL" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="POL" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="POL" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PRT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PRT" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="PRT" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="PRT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PRT" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="PRT" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="PRT" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PRT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PRT" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PRT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PRT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PRT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PRY" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="PRY" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PRY" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="PRY" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="PRY" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="PRY" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="PRY" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PRY" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="PRY" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="PRY" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PRY" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PRY" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="PSE" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="PSE" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="PSE" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="PSE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="PSE" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="PSE" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="PSE" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="PSE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="PSE" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="PSE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="PSE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="PSE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="QAT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="QAT" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="QAT" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="QAT" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="QAT" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="QAT" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="QAT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="QAT" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="QAT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="QAT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="QAT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="QAT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ROU" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ROU" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="ROU" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="ROU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ROU" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="ROU" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ROU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ROU" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="ROU" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ROU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ROU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ROU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="RUS" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="RUS" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="RUS" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="RUS" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="RUS" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="RUS" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="RUS" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="RUS" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="RUS" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="RUS" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="RUS" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="RUS" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="RWA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="RWA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="RWA" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="RWA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="RWA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="RWA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="RWA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="RWA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="RWA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="RWA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="RWA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="RWA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SAU" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SAU" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="SAU" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="SAU" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SAU" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SAU" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SAU" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SAU" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SAU" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SAU" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SAU" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SAU" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SDN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SDN" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="SDN" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="SDN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SDN" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="SDN" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SDN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SDN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SDN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SDN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SDN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SDN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SEN" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="SEN" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SEN" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="SEN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SEN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SEN" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="SEN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SEN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SEN" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="SEN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SEN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SEN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SGP" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SGP" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="SGP" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="SGP" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SGP" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SGP" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SGP" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SGP" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SGP" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SGP" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SGP" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SGP" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SLB" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SLB" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="SLB" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="SLB" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="SLB" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="SLB" & name=="vacHEPBB"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SLB" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="SLB" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="SLB" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="SLB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SLB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SLB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SLE" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="SLE" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SLE" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="SLE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SLE" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="SLE" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="SLE" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SLE" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="SLE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SLE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SLE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SLE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SLV" & name=="unicef_neomort"
replace lab = "Completeness of birth registration (%)" if wbcode=="SLV" & name=="lastnm_birth_reg"
replace lab = "BCG vaccination (%)" if wbcode=="SLV" & name=="vacBCG"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="SLV" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="SLV" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="SLV" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="SLV" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SLV" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SLV" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="SLV" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SLV" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SLV" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SRB" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="SRB" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SRB" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="SRB" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SRB" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SRB" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="SRB" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SRB" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SRB" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="SRB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SRB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SRB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SSD" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SSD" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="SSD" & name=="vacBCG"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SSD" & name=="lastnm_sec_ger"
replace lab = "Primary school completion (%)" if wbcode=="SSD" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="SSD" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SSD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SSD" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SSD" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SSD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SSD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SSD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SVK" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SVK" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="SVK" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="SVK" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SVK" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SVK" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SVK" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SVK" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SVK" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SVK" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SVK" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SVK" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SVN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SVN" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="SVN" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="SVN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SVN" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SVN" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SVN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SVN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SVN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SVN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SVN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SVN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SWE" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SWE" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="SWE" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="SWE" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SWE" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SWE" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SWE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SWE" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SWE" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SWE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SWE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SWE" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SWZ" & name=="unicef_neomort"
replace lab = "BCG vaccination (%)" if wbcode=="SWZ" & name=="vacBCG"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SWZ" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="SWZ" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SWZ" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="SWZ" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="SWZ" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SWZ" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="SWZ" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SWZ" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SWZ" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SWZ" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SYC" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="SYC" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="SYC" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="SYC" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SYC" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="SYC" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="SYC" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SYC" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SYC" & name=="lastnm_ter_ger"
replace lab = "Probability of dying from NCDs (%)" if wbcode=="SYC" & name=="lastnm_probdeath_ncd"
replace lab = "Female life expectancy at birth (years)" if wbcode=="SYC" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="SYC" & name=="sp_dyn_le00_in_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="SYR" & name=="unicef_neomort"
replace lab = "Infants fed exclusively with breast milk (%)" if wbcode=="SYR" & name=="unicef_breastf"
replace lab = "BCG vaccination (%)" if wbcode=="SYR" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="SYR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="SYR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="SYR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="SYR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="SYR" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="SYR" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="SYR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="SYR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="SYR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TCD" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TCD" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TCD" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TCD" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TCD" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="TCD" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="TCD" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TCD" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TCD" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="TCD" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TCD" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TCD" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TGO" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TGO" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TGO" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TGO" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TGO" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="TGO" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="TGO" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TGO" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TGO" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="TGO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TGO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TGO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="THA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="THA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="THA" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="THA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="THA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="THA" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="THA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="THA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="THA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="THA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="THA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="THA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TJK" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TJK" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TJK" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TJK" & name=="uiscr1"
replace lab = "Lower secondary school completion (%)" if wbcode=="TJK" & name=="uiscr2"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="TJK" & name=="vacHEPBB"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TJK" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TJK" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="TJK" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="TJK" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TJK" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TJK" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TLS" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TLS" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TLS" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TLS" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TLS" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="TLS" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="TLS" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TLS" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="TLS" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="TLS" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TLS" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TLS" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TON" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TON" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TON" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TON" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TON" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="TON" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="TON" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TON" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TON" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="TON" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TON" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TON" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TTO" & name=="unicef_neomort"
replace lab = "Female pre-primary school gross enrollment (%)" if wbcode=="TTO" & name=="uisger02_f"
replace lab = "Male pre-primary school gross enrollment (%)" if wbcode=="TTO" & name=="uisger02_m"
replace lab = "Female learning poverty (%)" if wbcode=="TTO" & name=="se_lpv_prim_f"
replace lab = "Male learning poverty (%)" if wbcode=="TTO" & name=="se_lpv_prim_m"
replace lab = "Primary school completion (%)" if wbcode=="TTO" & name=="uiscr1"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TTO" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="TTO" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="TTO" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="TTO" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TTO" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TTO" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TUN" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TUN" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TUN" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TUN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TUN" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="TUN" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TUN" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TUN" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="TUN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="TUN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TUN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TUN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TUR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TUR" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="TUR" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="TUR" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TUR" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="TUR" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="TUR" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TUR" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TUR" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="TUR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TUR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TUR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TUV" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TUV" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="TUV" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="TUV" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TUV" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="TUV" & name=="uiscr2"
replace lab = "Female youth NEET (%)" if wbcode=="TUV" & name=="eip_neet_mf_y_f"
replace lab = "Male youth NEET (%)" if wbcode=="TUV" & name=="eip_neet_mf_y_m"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TUV" & name=="lastnm_afr"
replace lab = "Female labour force participation (%)" if wbcode=="TUV" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TUV" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TUV" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="TZA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="TZA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="TZA" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="TZA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="TZA" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="TZA" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="TZA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="TZA" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="TZA" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="TZA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="TZA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="TZA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="UGA" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="UGA" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="UGA" & name=="uisger02"
replace lab = "Lower secondary school completion (%)" if wbcode=="UGA" & name=="uiscr2"
replace lab = "Female primary school completion (%)" if wbcode=="UGA" & name=="uiscr1_f"
replace lab = "Male primary school completion (%)" if wbcode=="UGA" & name=="uiscr1_m"
replace lab = "Youth NEET (%)" if wbcode=="UGA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="UGA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="UGA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="UGA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="UGA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="UGA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="UKR" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="UKR" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="UKR" & name=="lastnm_mmrt"
replace lab = "Hepatitis B vaccination (%)" if wbcode=="UKR" & name=="vacHEPBB"
replace lab = "Primary school completion (%)" if wbcode=="UKR" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="UKR" & name=="se_lpv_prim"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="UKR" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="UKR" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="UKR" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="UKR" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="UKR" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="UKR" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="URY" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="URY" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="URY" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="URY" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="URY" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="URY" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="URY" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="URY" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="URY" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="URY" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="URY" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="URY" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="USA" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="USA" & name=="uisger02"
replace lab = "Maternal mortality (deaths per 100,000 live births)" if wbcode=="USA" & name=="lastnm_mmrt"
replace lab = "Primary school completion (%)" if wbcode=="USA" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="USA" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="USA" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="USA" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="USA" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="USA" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="USA" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="USA" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="USA" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="UZB" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="UZB" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="UZB" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="UZB" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="UZB" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="UZB" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="UZB" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="UZB" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="UZB" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="UZB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="UZB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="UZB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="VCT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="VCT" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="VCT" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="VCT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="VCT" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="VCT" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="VCT" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="VCT" & name=="lastnm_ter_ger"
replace lab = "Youth unemployment (%)" if wbcode=="VCT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="VCT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="VCT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="VCT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="VEN" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="VEN" & name=="uisger02"
replace lab = "Completeness of birth registration (%)" if wbcode=="VEN" & name=="lastnm_birth_reg"
replace lab = "Primary school completion (%)" if wbcode=="VEN" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="VEN" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="VEN" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="VEN" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="VEN" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="VEN" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="VEN" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="VEN" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="VEN" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="VNM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="VNM" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="VNM" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="VNM" & name=="uiscr1"
replace lab = "Learning poverty (%)" if wbcode=="VNM" & name=="se_lpv_prim"
replace lab = "Lower secondary school completion (%)" if wbcode=="VNM" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="VNM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="VNM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="VNM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="VNM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="VNM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="VNM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="VUT" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="VUT" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="VUT" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="VUT" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="VUT" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="VUT" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="VUT" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="VUT" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="VUT" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="VUT" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="VUT" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="VUT" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="WSM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="WSM" & name=="uisger02"
replace lab = "Postnatal contact with health provider (%)" if wbcode=="WSM" & name=="unicef_care"
replace lab = "Primary school completion (%)" if wbcode=="WSM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="WSM" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="WSM" & name=="uiscr2"
replace lab = "Youth NEET (%)" if wbcode=="WSM" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="WSM" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="WSM" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="WSM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="WSM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="WSM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="XKX" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="XKX" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="XKX" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="XKX" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="XKX" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="XKX" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="XKX" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="XKX" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="XKX" & name=="lastnm_ter_ger"
replace lab = "Female life expectancy at birth (years)" if wbcode=="XKX" & name=="sp_dyn_le00_in_f"
replace lab = "Male life expectancy at birth (years)" if wbcode=="XKX" & name=="sp_dyn_le00_in_m"
replace lab = "Male labour force participation (%)" if wbcode=="XKX" & name=="eap_2wap_mf_a_m"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="YEM" & name=="unicef_neomort"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="YEM" & name=="uisger02"
replace lab = "BCG vaccination (%)" if wbcode=="YEM" & name=="vacBCG"
replace lab = "Primary school completion (%)" if wbcode=="YEM" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="YEM" & name=="lastnm_sec_ger"
replace lab = "Lower secondary school completion (%)" if wbcode=="YEM" & name=="uiscr2"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="YEM" & name=="lastnm_afr"
replace lab = "Female youth unemployment (%)" if wbcode=="YEM" & name=="une_2eap_mf_y_f"
replace lab = "Male youth unemployment (%)" if wbcode=="YEM" & name=="une_2eap_mf_y_m"
replace lab = "Female labour force participation (%)" if wbcode=="YEM" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="YEM" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="YEM" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ZAF" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ZAF" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ZAF" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ZAF" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ZAF" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ZAF" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ZAF" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ZAF" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ZAF" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ZAF" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ZAF" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ZAF" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ZMB" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ZMB" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ZMB" & name=="uisger02"
replace lab = "Primary school completion (%)" if wbcode=="ZMB" & name=="uiscr1"
replace lab = "Gross secondary school enrollment (%)" if wbcode=="ZMB" & name=="lastnm_sec_ger"
replace lab = "Learning poverty (%)" if wbcode=="ZMB" & name=="se_lpv_prim"
replace lab = "Youth NEET (%)" if wbcode=="ZMB" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ZMB" & name=="lastnm_afr"
replace lab = "Youth unemployment (%)" if wbcode=="ZMB" & name=="une_2eap_mf_y"
replace lab = "Female labour force participation (%)" if wbcode=="ZMB" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ZMB" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ZMB" & name=="sp_dyn_le00_in"
replace lab = "Neonatal mortality (deaths per 1,000 live births)" if wbcode=="ZWE" & name=="unicef_neomort"
replace lab = "Children receiving minimum meal frequency (%)" if wbcode=="ZWE" & name=="unicef_mealfreq"
replace lab = "Pre-primary school gross enrollment (%)" if wbcode=="ZWE" & name=="uisger02"
replace lab = "Lower secondary school completion (%)" if wbcode=="ZWE" & name=="uiscr2"
replace lab = "Female primary school completion (%)" if wbcode=="ZWE" & name=="uiscr1_f"
replace lab = "Male primary school completion (%)" if wbcode=="ZWE" & name=="uiscr1_m"
replace lab = "Youth NEET (%)" if wbcode=="ZWE" & name=="eip_neet_mf_y"
replace lab = "Adolescent fertility (births/1000 women)" if wbcode=="ZWE" & name=="lastnm_afr"
replace lab = "Gross tertiary education enrollment (%)" if wbcode=="ZWE" & name=="lastnm_ter_ger"
replace lab = "Female labour force participation (%)" if wbcode=="ZWE" & name=="eap_2wap_mf_a_f"
replace lab = "Male labour force participation (%)" if wbcode=="ZWE" & name=="eap_2wap_mf_a_m"
replace lab = "Life expectancy at birth (years)" if wbcode=="ZWE" & name=="sp_dyn_le00_in"
}	
	
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
	