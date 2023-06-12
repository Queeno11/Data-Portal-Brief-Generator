*------------------------------------------------------------------------------*
*---------------------------------Prepare data---------------------------------*
*------------------------------------------------------------------------------*

	
*--------------------------------Load data---------------------------------*

	clear all
	set more off
	set maxvar 32000
	use "$data_output\complete_series_wmd_${date}", replace
	drop name description units scale update timespan minyear maxyear data source download_link note
	
*--------------------------------keep years--------------------------------*

	/* Me quedo con último año disponible */
	gen year2 = year if value!=.
	bysort wbcode wbcountryname code gender: egen myear = max(year2)
	forvalues m = 1(1)9 {
	gen year_`m' = myear - `m'
	}
	
	/* Chequeo si hay valor para el indicador 1 año atrás, 2 años atrás, etc */
	forvalues m = 1(1)9 {
	gen o = 1 if value!=. & year==year_`m'
	bysort wbcode code gender: egen ok`m' = max(o) 
	drop o
	}
	
	/* Condicional a que sí haya valor, uso el de 5 años atrás, sino 6, sino 7, ... */
	gen prevyear = .
	replace prevyear = year_5 if ok5==1
	replace prevyear = year_6 if ok6==1 & prevyear==.
	replace prevyear = year_7 if ok7==1 & prevyear==.
	replace prevyear = year_8 if ok8==1 & prevyear==.
	replace prevyear = year_4 if ok4==1 & prevyear==.
	replace prevyear = year_3 if ok3==1 & prevyear==.
	replace prevyear = year_2 if ok2==1 & prevyear==.
	
	/* Me quedo solo con el último año disponible + el de aprox 5 años antes */
	keep if year==myear | year==prevyear
	gen orderr = 0 if year==prevyear
	replace orderr = 1 if year==myear
	drop myear year2 ok* year_* prevyear

	/* Elimino indicadores que no van en los briefs */
	keep if rank != .
	keep if stage_life != ""
	keep if topic != ""

	/* Hago el reshape para que quede en variables separadas y así poder usar los mismos locals del do file de gráficos */
	reshape wide year value, i(wbcode wbcountryname wbregion wbincome gender code rank stage_life topic) j(orderr)
	collapse (max) year0 value0 year1 value1, by(wbcode wbcountryname wbregion wbincome gender code rank stage_life	topic)
	drop if year1<2015
	rename year1 year
	rename year0 prevyear
	rename value1 value
	rename value0 pv

	drop topic stage_life rank
*---------------------------------Reshape----------------------------------*

	/* Hago reshape por código (me quedan los códigos como variables) */		
	reshape wide value pv, i(wbcode wbcountryname wbregion wbincome year prevyear gender) j(code) string
	rename value* * 
	rename pv* *_prev
		
	
	/* Hago reshape por género */ 
	* Genero lista con las variables que quiero mantener para los briefs
	ds
	local all_vars: colnames r(varlist)
	local exclude_vars wbcode wbcountryname wbregion wbincome year prevyear gend
	global indicators: list difference all_vars exclude_vars
	di "$indicators"
	
	gen gend = "_t" if gender==0
	replace gend = "_m" if gender==1
	replace gend = "_f" if gender==2
	drop gender
	
	reshape wide $indicators, i(wbcode wbcountryname wbregion wbincome year prevyear) j(gend) string
	rename *_t *
	rename *_prev_f *_f_prev
	rename *_prev_m *_m_prev
	
	foreach var of varlist _all {
	capture assert mi(`var')
	if !_rc {
	drop `var'
	}
	}
	
	global nselect asr_f eap_2wap_mf_a_f eip_2plf_a_f eip_2plf_y_f eip_2wap_a_f eip_2wap_y_f eip_neet_mf_y_f emp_nifl_a_f emp_nifl_y_f eyrs_f hci_f hci_lower_f hci_upper_f lastnm_birth_reg_f lastnm_sec_ger_f lastnm_ter_ger_f luu_2lu4_mf_a_f luu_2lu4_mf_y_f nostu_f psurv_f qeyrs_f se_lpv_prim_f sp_dyn_le00_in_f test_f uiscr1_f uiscr2_f uisger02_f une_2eap_mf_a_f une_2eap_mf_y_f unicef_breastf_f unicef_diarrhoea_f unicef_mealfreq_f asr_m eap_2wap_mf_a_m eip_2plf_a_m eip_2plf_y_m eip_2wap_a_m eip_2wap_y_m eip_neet_mf_y_m emp_nifl_a_m emp_nifl_y_m eyrs_m hci_m hci_lower_m hci_upper_m lastnm_birth_reg_m lastnm_sec_ger_m lastnm_ter_ger_m luu_2lu4_mf_a_m luu_2lu4_mf_y_m nostu_m psurv_m qeyrs_m se_lpv_prim_m sp_dyn_le00_in_m test_m uiscr1_m uiscr2_m uisger02_m une_2eap_mf_a_m une_2eap_mf_y_m unicef_breastf_m unicef_diarrhoea_m unicef_mealfreq_m asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC
	
	global prev asr_f_prev eap_2wap_mf_a_f_prev eip_2plf_a_f_prev eip_2plf_y_f_prev eip_2wap_a_f_prev eip_2wap_y_f_prev eip_neet_mf_y_f_prev emp_nifl_a_f_prev emp_nifl_y_f_prev eyrs_f_prev hci_f_prev hci_lower_f_prev hci_upper_f_prev lastnm_birth_reg_f_prev lastnm_sec_ger_f_prev lastnm_ter_ger_f_prev luu_2lu4_mf_a_f_prev luu_2lu4_mf_y_f_prev nostu_f_prev psurv_f_prev qeyrs_f_prev se_lpv_prim_f_prev sp_dyn_le00_in_f_prev test_f_prev uiscr1_f_prev uiscr2_f_prev uisger02_f_prev une_2eap_mf_a_f_prev une_2eap_mf_y_f_prev unicef_breastf_f_prev unicef_diarrhoea_f_prev unicef_mealfreq_f_prev asr_m_prev eap_2wap_mf_a_m_prev eip_2plf_a_m_prev eip_2plf_y_m_prev eip_2wap_a_m_prev eip_2wap_y_m_prev eip_neet_mf_y_m_prev emp_nifl_a_m_prev emp_nifl_y_m_prev eyrs_m_prev hci_m_prev hci_lower_m_prev hci_upper_m_prev lastnm_birth_reg_m_prev lastnm_sec_ger_m_prev lastnm_ter_ger_m_prev luu_2lu4_mf_a_m_prev luu_2lu4_mf_y_m_prev nostu_m_prev psurv_m_prev qeyrs_m_prev se_lpv_prim_m_prev sp_dyn_le00_in_m_prev test_m_prev uiscr1_m_prev uiscr2_m_prev uisger02_m_prev une_2eap_mf_a_m_prev une_2eap_mf_y_m_prev unicef_breastf_m_prev unicef_diarrhoea_m_prev unicef_mealfreq_m_prev asr_prev basic_hygiene_health_prev basic_hygiene_schools_prev basic_sanitation_health_prev basic_sanitation_schools_prev basic_water_health_prev basic_water_schools_prev eap_2wap_mf_a_prev eip_2plf_a_prev eip_2plf_y_prev eip_2wap_a_prev eip_2wap_y_prev eip_neet_mf_y_prev emp_nifl_a_prev emp_nifl_y_prev eyrs_prev hci_prev hci_lower_prev hci_upper_prev lastnm_afr_prev lastnm_birth_reg_prev lastnm_mmrt_prev lastnm_probdeath_ncd_prev lastnm_sec_ger_prev lastnm_ter_ger_prev luu_2lu4_mf_a_prev luu_2lu4_mf_y_prev nostu_prev psurv_prev qeyrs_prev se_lpv_prim_prev sp_dyn_le00_in_prev test_prev uiscr1_prev uiscr2_prev uiscr3_prev uisger01_prev uisger02_prev uisoaepg1_prev uisoaepg2gpv_prev uisqutp1_prev uisqutp2t3_prev uisschbsp1welec_prev uisxgdpfsgov_prev uisxgovexpimf_prev une_2eap_mf_a_prev une_2eap_mf_y_prev unicef_1524mort_prev unicef_514mort_prev unicef_breastf_prev unicef_care_prev unicef_caremother_prev unicef_diarrhoea_prev unicef_hygiene_prev unicef_mealfreq_prev unicef_neomort_prev unicef_sanitation_prev unicef_stillbirths_prev unicef_stunting_prev unicef_u5mort_prev unicef_water_prev vacBCG_prev vacDTP1_prev vacDTP3_prev vacHEPB3_prev vacHEPBB_prev vacHIB3_prev vacIPV1_prev vacMCV1_prev vacMCV2_prev vacPCV3_prev vacPOL3_prev vacROTAC_prev
	
	/* Genero variables de año */
	foreach var in $nselect {
	gen `var'_y = year if `var'!=.
	}
	drop year
	
	foreach var in $prev {
	gen `var'_y = prevyear if `var'!=.
	}
	rename *_prev_y *_y_prev
	drop prevyear
	
	/* Así me queda solo 1 obs por cada wbcode wbcountryname wbregion wbincome */
	collapse (max) asr_f_prev asr_f eap_2wap_mf_a_f_prev eap_2wap_mf_a_f eip_2plf_a_f_prev eip_2plf_a_f eip_2plf_y_f_prev eip_2plf_y_f eip_2wap_a_f_prev eip_2wap_a_f eip_2wap_y_f_prev eip_2wap_y_f eip_neet_mf_y_f_prev eip_neet_mf_y_f emp_nifl_a_f_prev emp_nifl_a_f emp_nifl_y_f_prev emp_nifl_y_f eyrs_f_prev eyrs_f hci_f_prev hci_f hci_lower_f_prev hci_lower_f hci_upper_f_prev hci_upper_f lastnm_birth_reg_f_prev lastnm_birth_reg_f lastnm_sec_ger_f_prev lastnm_sec_ger_f lastnm_ter_ger_f_prev lastnm_ter_ger_f luu_2lu4_mf_a_f_prev luu_2lu4_mf_a_f luu_2lu4_mf_y_f_prev luu_2lu4_mf_y_f nostu_f_prev nostu_f psurv_f_prev psurv_f qeyrs_f_prev qeyrs_f se_lpv_prim_f_prev se_lpv_prim_f sp_dyn_le00_in_f_prev sp_dyn_le00_in_f test_f_prev test_f uiscr1_f_prev uiscr1_f uiscr2_f_prev uiscr2_f uisger02_f_prev uisger02_f une_2eap_mf_a_f_prev une_2eap_mf_a_f une_2eap_mf_y_f_prev une_2eap_mf_y_f unicef_breastf_f_prev unicef_breastf_f unicef_diarrhoea_f_prev unicef_diarrhoea_f unicef_mealfreq_f_prev unicef_mealfreq_f asr_m_prev asr_m eap_2wap_mf_a_m_prev eap_2wap_mf_a_m eip_2plf_a_m_prev eip_2plf_a_m eip_2plf_y_m_prev eip_2plf_y_m eip_2wap_a_m_prev eip_2wap_a_m eip_2wap_y_m_prev eip_2wap_y_m eip_neet_mf_y_m_prev eip_neet_mf_y_m emp_nifl_a_m_prev emp_nifl_a_m emp_nifl_y_m_prev emp_nifl_y_m eyrs_m_prev eyrs_m hci_m_prev hci_m hci_lower_m_prev hci_lower_m hci_upper_m_prev hci_upper_m lastnm_birth_reg_m_prev lastnm_birth_reg_m lastnm_sec_ger_m_prev lastnm_sec_ger_m lastnm_ter_ger_m_prev lastnm_ter_ger_m luu_2lu4_mf_a_m_prev luu_2lu4_mf_a_m luu_2lu4_mf_y_m_prev luu_2lu4_mf_y_m nostu_m_prev nostu_m psurv_m_prev psurv_m qeyrs_m_prev qeyrs_m se_lpv_prim_m_prev se_lpv_prim_m sp_dyn_le00_in_m_prev sp_dyn_le00_in_m test_m_prev test_m uiscr1_m_prev uiscr1_m uiscr2_m_prev uiscr2_m uisger02_m_prev uisger02_m une_2eap_mf_a_m_prev une_2eap_mf_a_m une_2eap_mf_y_m_prev une_2eap_mf_y_m unicef_breastf_m_prev unicef_breastf_m unicef_diarrhoea_m_prev unicef_diarrhoea_m unicef_mealfreq_m_prev unicef_mealfreq_m asr_prev asr basic_hygiene_health_prev basic_hygiene_health basic_hygiene_schools_prev basic_hygiene_schools basic_sanitation_health_prev basic_sanitation_health basic_sanitation_schools_prev basic_sanitation_schools basic_water_health_prev basic_water_health basic_water_schools_prev basic_water_schools eap_2wap_mf_a_prev eap_2wap_mf_a eip_2plf_a_prev eip_2plf_a eip_2plf_y_prev eip_2plf_y eip_2wap_a_prev eip_2wap_a eip_2wap_y_prev eip_2wap_y eip_neet_mf_y_prev eip_neet_mf_y emp_nifl_a_prev emp_nifl_a emp_nifl_y_prev emp_nifl_y eyrs_prev eyrs hci_prev hci hci_lower_prev hci_lower hci_upper_prev hci_upper lastnm_afr_prev lastnm_afr lastnm_birth_reg_prev lastnm_birth_reg lastnm_mmrt_prev lastnm_mmrt lastnm_probdeath_ncd_prev lastnm_probdeath_ncd lastnm_sec_ger_prev lastnm_sec_ger lastnm_ter_ger_prev lastnm_ter_ger luu_2lu4_mf_a_prev luu_2lu4_mf_a luu_2lu4_mf_y_prev luu_2lu4_mf_y nostu_prev nostu psurv_prev psurv qeyrs_prev qeyrs se_lpv_prim_prev se_lpv_prim sp_dyn_le00_in_prev sp_dyn_le00_in test_prev test uiscr1_prev uiscr1 uiscr2_prev uiscr2 uiscr3_prev uiscr3 uisger01_prev uisger01 uisger02_prev uisger02 uisoaepg1_prev uisoaepg1 uisoaepg2gpv_prev uisoaepg2gpv uisqutp1_prev uisqutp1 uisqutp2t3_prev uisqutp2t3 uisschbsp1welec_prev uisschbsp1welec uisxgdpfsgov_prev uisxgdpfsgov uisxgovexpimf_prev uisxgovexpimf une_2eap_mf_a_prev une_2eap_mf_a une_2eap_mf_y_prev une_2eap_mf_y unicef_1524mort_prev unicef_1524mort unicef_514mort_prev unicef_514mort unicef_breastf_prev unicef_breastf unicef_care_prev unicef_care unicef_caremother_prev unicef_caremother unicef_diarrhoea_prev unicef_diarrhoea unicef_hygiene_prev unicef_hygiene unicef_mealfreq_prev unicef_mealfreq unicef_neomort_prev unicef_neomort unicef_sanitation_prev unicef_sanitation unicef_stillbirths_prev unicef_stillbirths unicef_stunting_prev unicef_stunting unicef_u5mort_prev unicef_u5mort unicef_water_prev unicef_water vacBCG_prev vacBCG vacDTP1_prev vacDTP1 vacDTP3_prev vacDTP3 vacHEPB3_prev vacHEPB3 vacHEPBB_prev vacHEPBB vacHIB3_prev vacHIB3 vacIPV1_prev vacIPV1 vacMCV1_prev vacMCV1 vacMCV2_prev vacMCV2 vacPCV3_prev vacPCV3 vacPOL3_prev vacPOL3 vacROTAC_prev vacROTAC asr_f_y eap_2wap_mf_a_f_y eip_2plf_a_f_y eip_2plf_y_f_y eip_2wap_a_f_y eip_2wap_y_f_y eip_neet_mf_y_f_y emp_nifl_a_f_y emp_nifl_y_f_y eyrs_f_y hci_f_y hci_lower_f_y hci_upper_f_y lastnm_birth_reg_f_y lastnm_sec_ger_f_y lastnm_ter_ger_f_y luu_2lu4_mf_a_f_y luu_2lu4_mf_y_f_y nostu_f_y psurv_f_y qeyrs_f_y se_lpv_prim_f_y sp_dyn_le00_in_f_y test_f_y uiscr1_f_y uiscr2_f_y uisger02_f_y une_2eap_mf_a_f_y une_2eap_mf_y_f_y unicef_breastf_f_y unicef_diarrhoea_f_y unicef_mealfreq_f_y asr_m_y eap_2wap_mf_a_m_y eip_2plf_a_m_y eip_2plf_y_m_y eip_2wap_a_m_y eip_2wap_y_m_y eip_neet_mf_y_m_y emp_nifl_a_m_y emp_nifl_y_m_y eyrs_m_y hci_m_y hci_lower_m_y hci_upper_m_y lastnm_birth_reg_m_y lastnm_sec_ger_m_y lastnm_ter_ger_m_y luu_2lu4_mf_a_m_y luu_2lu4_mf_y_m_y nostu_m_y psurv_m_y qeyrs_m_y se_lpv_prim_m_y sp_dyn_le00_in_m_y test_m_y uiscr1_m_y uiscr2_m_y uisger02_m_y une_2eap_mf_a_m_y une_2eap_mf_y_m_y unicef_breastf_m_y unicef_diarrhoea_m_y unicef_mealfreq_m_y asr_y basic_hygiene_health_y basic_hygiene_schools_y basic_sanitation_health_y basic_sanitation_schools_y basic_water_health_y basic_water_schools_y eap_2wap_mf_a_y eip_2plf_a_y eip_2plf_y_y eip_2wap_a_y eip_2wap_y_y eip_neet_mf_y_y emp_nifl_a_y emp_nifl_y_y eyrs_y hci_y hci_lower_y hci_upper_y lastnm_afr_y lastnm_birth_reg_y lastnm_mmrt_y lastnm_probdeath_ncd_y lastnm_sec_ger_y lastnm_ter_ger_y luu_2lu4_mf_a_y luu_2lu4_mf_y_y nostu_y psurv_y qeyrs_y se_lpv_prim_y sp_dyn_le00_in_y test_y uiscr1_y uiscr2_y uiscr3_y uisger01_y uisger02_y uisoaepg1_y uisoaepg2gpv_y uisqutp1_y uisqutp2t3_y uisschbsp1welec_y uisxgdpfsgov_y uisxgovexpimf_y une_2eap_mf_a_y une_2eap_mf_y_y unicef_1524mort_y unicef_514mort_y unicef_breastf_y unicef_care_y unicef_caremother_y unicef_diarrhoea_y unicef_hygiene_y unicef_mealfreq_y unicef_neomort_y unicef_sanitation_y unicef_stillbirths_y unicef_stunting_y unicef_u5mort_y unicef_water_y vacBCG_y vacDTP1_y vacDTP3_y vacHEPB3_y vacHEPBB_y vacHIB3_y vacIPV1_y vacMCV1_y vacMCV2_y vacPCV3_y vacPOL3_y vacROTAC_y asr_f_y_prev eap_2wap_mf_a_f_y_prev eip_2plf_a_f_y_prev eip_2plf_y_f_y_prev eip_2wap_a_f_y_prev eip_2wap_y_f_y_prev eip_neet_mf_y_f_y_prev emp_nifl_a_f_y_prev emp_nifl_y_f_y_prev eyrs_f_y_prev hci_f_y_prev hci_lower_f_y_prev hci_upper_f_y_prev lastnm_birth_reg_f_y_prev lastnm_sec_ger_f_y_prev lastnm_ter_ger_f_y_prev luu_2lu4_mf_a_f_y_prev luu_2lu4_mf_y_f_y_prev nostu_f_y_prev psurv_f_y_prev qeyrs_f_y_prev se_lpv_prim_f_y_prev sp_dyn_le00_in_f_y_prev test_f_y_prev uiscr1_f_y_prev uiscr2_f_y_prev uisger02_f_y_prev une_2eap_mf_a_f_y_prev une_2eap_mf_y_f_y_prev unicef_breastf_f_y_prev unicef_diarrhoea_f_y_prev unicef_mealfreq_f_y_prev asr_m_y_prev eap_2wap_mf_a_m_y_prev eip_2plf_a_m_y_prev eip_2plf_y_m_y_prev eip_2wap_a_m_y_prev eip_2wap_y_m_y_prev eip_neet_mf_y_m_y_prev emp_nifl_a_m_y_prev emp_nifl_y_m_y_prev eyrs_m_y_prev hci_m_y_prev hci_lower_m_y_prev hci_upper_m_y_prev lastnm_birth_reg_m_y_prev lastnm_sec_ger_m_y_prev lastnm_ter_ger_m_y_prev luu_2lu4_mf_a_m_y_prev luu_2lu4_mf_y_m_y_prev nostu_m_y_prev psurv_m_y_prev qeyrs_m_y_prev se_lpv_prim_m_y_prev sp_dyn_le00_in_m_y_prev test_m_y_prev uiscr1_m_y_prev uiscr2_m_y_prev uisger02_m_y_prev une_2eap_mf_a_m_y_prev une_2eap_mf_y_m_y_prev unicef_breastf_m_y_prev unicef_diarrhoea_m_y_prev unicef_mealfreq_m_y_prev asr_y_prev basic_hygiene_health_y_prev basic_hygiene_schools_y_prev basic_sanitation_health_y_prev basic_sanitation_schools_y_prev basic_water_health_y_prev basic_water_schools_y_prev eap_2wap_mf_a_y_prev eip_2plf_a_y_prev eip_2plf_y_y_prev eip_2wap_a_y_prev eip_2wap_y_y_prev eip_neet_mf_y_y_prev emp_nifl_a_y_prev emp_nifl_y_y_prev eyrs_y_prev hci_y_prev hci_lower_y_prev hci_upper_y_prev lastnm_afr_y_prev lastnm_birth_reg_y_prev lastnm_mmrt_y_prev lastnm_probdeath_ncd_y_prev lastnm_sec_ger_y_prev lastnm_ter_ger_y_prev luu_2lu4_mf_a_y_prev luu_2lu4_mf_y_y_prev nostu_y_prev psurv_y_prev qeyrs_y_prev se_lpv_prim_y_prev sp_dyn_le00_in_y_prev test_y_prev uiscr1_y_prev uiscr2_y_prev uiscr3_y_prev uisger01_y_prev uisger02_y_prev uisoaepg1_y_prev uisoaepg2gpv_y_prev uisqutp1_y_prev uisqutp2t3_y_prev uisschbsp1welec_y_prev uisxgdpfsgov_y_prev uisxgovexpimf_y_prev une_2eap_mf_a_y_prev une_2eap_mf_y_y_prev unicef_1524mort_y_prev unicef_514mort_y_prev unicef_breastf_y_prev unicef_care_y_prev unicef_caremother_y_prev unicef_diarrhoea_y_prev unicef_hygiene_y_prev unicef_mealfreq_y_prev unicef_neomort_y_prev unicef_sanitation_y_prev unicef_stillbirths_y_prev unicef_stunting_y_prev unicef_u5mort_y_prev unicef_water_y_prev vacBCG_y_prev vacDTP1_y_prev vacDTP3_y_prev vacHEPB3_y_prev vacHEPBB_y_prev vacHIB3_y_prev vacIPV1_y_prev vacMCV1_y_prev vacMCV2_y_prev vacPCV3_y_prev vacPOL3_y_prev vacROTAC_y_prev, by(wbcode wbcountryname wbregion wbincome)
	
*---------------------------Replace country name---------------------------*
	
	replace wbcountryname = "Democratic Republic of the Congo" if wbcode=="COD"
	replace wbcountryname = "Republic of the Congo" if wbcode=="COG"
	replace wbcountryname = "Arab Republic of Egypt" if wbcode=="EGY"
	replace wbcountryname = "Islamic Republic of Iran" if wbcode=="IRN"
	replace wbcountryname = "Republic of Korea" if wbcode=="KOR"

*---------------------------Replace income name----------------------------*
	
	rename wbincome wbincomegroup
	gen incomegroup = wbincomegroup
	replace incomegroup = "High Income countries" if incomegroup == "High income"
	replace incomegroup = "Upper Middle Income countries" if incomegroup == "Upper middle income"
	replace incomegroup = "Lower Middle Income countries" if incomegroup == "Lower middle income"
	replace incomegroup = "Low Income countries" if incomegroup == "Low income"
	
*------------------------------Rename&recode-------------------------------*

	foreach var in asr asr_m asr_f hci hci_m hci_f hci_lower hci_lower_f hci_lower_m hci_upper hci_upper_m hci_upper_f nostu nostu_f nostu_m psurv psurv_m psurv_f asr_prev asr_m_prev asr_f_prev hci_prev hci_m_prev hci_f_prev hci_lower_prev hci_lower_f_prev hci_lower_m_prev hci_upper_prev hci_upper_m_prev hci_upper_f_prev nostu_prev nostu_f_prev nostu_m_prev psurv_prev psurv_m_prev psurv_f_prev {
	replace `var' = `var'*100
	}
	
*---------------------------------Averages---------------------------------*
	
	foreach var in asr_f eap_2wap_mf_a_f eip_2plf_a_f eip_2plf_y_f eip_2wap_a_f eip_2wap_y_f eip_neet_mf_y_f emp_nifl_a_f emp_nifl_y_f eyrs_f hci_f hci_lower_f hci_upper_f lastnm_birth_reg_f lastnm_sec_ger_f lastnm_ter_ger_f luu_2lu4_mf_a_f luu_2lu4_mf_y_f nostu_f psurv_f qeyrs_f se_lpv_prim_f sp_dyn_le00_in_f test_f uiscr1_f uiscr2_f uisger02_f une_2eap_mf_a_f une_2eap_mf_y_f unicef_breastf_f unicef_diarrhoea_f unicef_mealfreq_f asr_m eap_2wap_mf_a_m eip_2plf_a_m eip_2plf_y_m eip_2wap_a_m eip_2wap_y_m eip_neet_mf_y_m emp_nifl_a_m emp_nifl_y_m eyrs_m hci_m hci_lower_m hci_upper_m lastnm_birth_reg_m lastnm_sec_ger_m lastnm_ter_ger_m luu_2lu4_mf_a_m luu_2lu4_mf_y_m nostu_m psurv_m qeyrs_m se_lpv_prim_m sp_dyn_le00_in_m test_m uiscr1_m uiscr2_m uisger02_m une_2eap_mf_a_m une_2eap_mf_y_m unicef_breastf_m unicef_diarrhoea_m unicef_mealfreq_m asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC {
	bysort wbincome: egen `var'_inc = mean(`var')
	bysort wbregion: egen `var'_reg = mean(`var')
	}
	
*---------------------------------keep if----------------------------------*
	save "$data_output\data_briefs_allcountries_wprev", replace
	
*--------------------------------save data---------------------------------*
	keep if hci!=.
	
	save "$data_output\data_briefs_wprev", replace