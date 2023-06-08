*------------------------------------------------------------------------------*
*---------------------------------Prepare data---------------------------------*
*------------------------------------------------------------------------------*

	*--------------------------------Directories-------------------------------*
		
		global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\HCI update\"
		global charts "${root}/Outputs/Update"
		global dhci "${root}/Data"
		global dport "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\Data"
		cd "${root}"		
		
	*--------------------------------Load data---------------------------------*
	
		clear all
		set more off
		set maxvar 32000
		use "$dport\complete_series_wmd_4april23", replace
		drop name description units scale update timespan minyear maxyear data stage_life topic source download_link note
		
	*--------------------------------keep years--------------------------------*
		
		gen year2 = year if value!=.
		bysort wbcode wbcountryname code gender: egen myear = max(year2)
		keep if year==myear
		drop myear year2
		drop if year<2015
		
	*---------------------------------Reshape----------------------------------*
				
		reshape wide value, i(wbcode wbcountryname wbregion wbincome year gender) j(code) string
		rename value* *
		
		global preselect asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC
		
		gen gend = "_t" if gender=="Total"
		replace gend = "_m" if gender=="Male"
		replace gend = "_f" if gender=="Female"
		drop gender
		
		reshape wide $preselect, i(wbcode wbcountryname wbregion wbincome year) j(gend) string
		rename *_t *
		
		foreach var of varlist _all {
		capture assert mi(`var')
		if !_rc {
		drop `var'
		}
		}
		
		global nselect asr_f eap_2wap_mf_a_f eip_2plf_a_f eip_2plf_y_f eip_2wap_a_f eip_2wap_y_f eip_neet_mf_y_f emp_nifl_a_f emp_nifl_y_f eyrs_f hci_f hci_lower_f hci_upper_f lastnm_birth_reg_f lastnm_sec_ger_f lastnm_ter_ger_f luu_2lu4_mf_a_f luu_2lu4_mf_y_f nostu_f psurv_f qeyrs_f se_lpv_prim_f sp_dyn_le00_in_f test_f uiscr1_f uiscr2_f uisger02_f une_2eap_mf_a_f une_2eap_mf_y_f unicef_breastf_f unicef_diarrhoea_f unicef_mealfreq_f asr_m eap_2wap_mf_a_m eip_2plf_a_m eip_2plf_y_m eip_2wap_a_m eip_2wap_y_m eip_neet_mf_y_m emp_nifl_a_m emp_nifl_y_m eyrs_m hci_m hci_lower_m hci_upper_m lastnm_birth_reg_m lastnm_sec_ger_m lastnm_ter_ger_m luu_2lu4_mf_a_m luu_2lu4_mf_y_m nostu_m psurv_m qeyrs_m se_lpv_prim_m sp_dyn_le00_in_m test_m uiscr1_m uiscr2_m uisger02_m une_2eap_mf_a_m une_2eap_mf_y_m unicef_breastf_m unicef_diarrhoea_m unicef_mealfreq_m asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC
		
		foreach var in $nselect {
		gen `var'_y = year if `var'!=.
		}
		drop year
		
		collapse (max) asr_f eap_2wap_mf_a_f eip_2plf_a_f eip_2plf_y_f eip_2wap_a_f eip_2wap_y_f eip_neet_mf_y_f emp_nifl_a_f emp_nifl_y_f eyrs_f hci_f hci_lower_f hci_upper_f lastnm_birth_reg_f lastnm_sec_ger_f lastnm_ter_ger_f luu_2lu4_mf_a_f luu_2lu4_mf_y_f nostu_f psurv_f qeyrs_f se_lpv_prim_f sp_dyn_le00_in_f test_f uiscr1_f uiscr2_f uisger02_f une_2eap_mf_a_f une_2eap_mf_y_f unicef_breastf_f unicef_diarrhoea_f unicef_mealfreq_f asr_m eap_2wap_mf_a_m eip_2plf_a_m eip_2plf_y_m eip_2wap_a_m eip_2wap_y_m eip_neet_mf_y_m emp_nifl_a_m emp_nifl_y_m eyrs_m hci_m hci_lower_m hci_upper_m lastnm_birth_reg_m lastnm_sec_ger_m lastnm_ter_ger_m luu_2lu4_mf_a_m luu_2lu4_mf_y_m nostu_m psurv_m qeyrs_m se_lpv_prim_m sp_dyn_le00_in_m test_m uiscr1_m uiscr2_m uisger02_m une_2eap_mf_a_m une_2eap_mf_y_m unicef_breastf_m unicef_diarrhoea_m unicef_mealfreq_m asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC asr_f_y eap_2wap_mf_a_f_y eip_2plf_a_f_y eip_2plf_y_f_y eip_2wap_a_f_y eip_2wap_y_f_y eip_neet_mf_y_f_y emp_nifl_a_f_y emp_nifl_y_f_y eyrs_f_y hci_f_y hci_lower_f_y hci_upper_f_y lastnm_birth_reg_f_y lastnm_sec_ger_f_y lastnm_ter_ger_f_y luu_2lu4_mf_a_f_y luu_2lu4_mf_y_f_y nostu_f_y psurv_f_y qeyrs_f_y se_lpv_prim_f_y sp_dyn_le00_in_f_y test_f_y uiscr1_f_y uiscr2_f_y uisger02_f_y une_2eap_mf_a_f_y une_2eap_mf_y_f_y unicef_breastf_f_y unicef_diarrhoea_f_y unicef_mealfreq_f_y asr_m_y eap_2wap_mf_a_m_y eip_2plf_a_m_y eip_2plf_y_m_y eip_2wap_a_m_y eip_2wap_y_m_y eip_neet_mf_y_m_y emp_nifl_a_m_y emp_nifl_y_m_y eyrs_m_y hci_m_y hci_lower_m_y hci_upper_m_y lastnm_birth_reg_m_y lastnm_sec_ger_m_y lastnm_ter_ger_m_y luu_2lu4_mf_a_m_y luu_2lu4_mf_y_m_y nostu_m_y psurv_m_y qeyrs_m_y se_lpv_prim_m_y sp_dyn_le00_in_m_y test_m_y uiscr1_m_y uiscr2_m_y uisger02_m_y une_2eap_mf_a_m_y une_2eap_mf_y_m_y unicef_breastf_m_y unicef_diarrhoea_m_y unicef_mealfreq_m_y asr_y basic_hygiene_health_y basic_hygiene_schools_y basic_sanitation_health_y basic_sanitation_schools_y basic_water_health_y basic_water_schools_y eap_2wap_mf_a_y eip_2plf_a_y eip_2plf_y_y eip_2wap_a_y eip_2wap_y_y eip_neet_mf_y_y emp_nifl_a_y emp_nifl_y_y eyrs_y hci_y hci_lower_y hci_upper_y lastnm_afr_y lastnm_birth_reg_y lastnm_mmrt_y lastnm_probdeath_ncd_y lastnm_sec_ger_y lastnm_ter_ger_y luu_2lu4_mf_a_y luu_2lu4_mf_y_y nostu_y psurv_y qeyrs_y se_lpv_prim_y sp_dyn_le00_in_y test_y uiscr1_y uiscr2_y uiscr3_y uisger01_y uisger02_y uisoaepg1_y uisoaepg2gpv_y uisqutp1_y uisqutp2t3_y uisschbsp1welec_y uisxgdpfsgov_y uisxgovexpimf_y une_2eap_mf_a_y une_2eap_mf_y_y unicef_1524mort_y unicef_514mort_y unicef_breastf_y unicef_care_y unicef_caremother_y unicef_diarrhoea_y unicef_hygiene_y unicef_mealfreq_y unicef_neomort_y unicef_sanitation_y unicef_stillbirths_y unicef_stunting_y unicef_u5mort_y unicef_water_y vacBCG_y vacDTP1_y vacDTP3_y vacHEPB3_y vacHEPBB_y vacHIB3_y vacIPV1_y vacMCV1_y vacMCV2_y vacPCV3_y vacPOL3_y vacROTAC_y, by(wbcode wbcountryname wbregion wbincome)
		
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
	
		foreach var in asr asr_m asr_f hci hci_m hci_f hci_lower hci_lower_f hci_lower_m hci_upper hci_upper_m hci_upper_f nostu nostu_f nostu_m psurv psurv_m psurv_f {
		replace `var' = `var'*100
		}
		
	*---------------------------------Averages---------------------------------*
		
		foreach var in asr_f eap_2wap_mf_a_f eip_2plf_a_f eip_2plf_y_f eip_2wap_a_f eip_2wap_y_f eip_neet_mf_y_f emp_nifl_a_f emp_nifl_y_f eyrs_f hci_f hci_lower_f hci_upper_f lastnm_birth_reg_f lastnm_sec_ger_f lastnm_ter_ger_f luu_2lu4_mf_a_f luu_2lu4_mf_y_f nostu_f psurv_f qeyrs_f se_lpv_prim_f sp_dyn_le00_in_f test_f uiscr1_f uiscr2_f uisger02_f une_2eap_mf_a_f une_2eap_mf_y_f unicef_breastf_f unicef_diarrhoea_f unicef_mealfreq_f asr_m eap_2wap_mf_a_m eip_2plf_a_m eip_2plf_y_m eip_2wap_a_m eip_2wap_y_m eip_neet_mf_y_m emp_nifl_a_m emp_nifl_y_m eyrs_m hci_m hci_lower_m hci_upper_m lastnm_birth_reg_m lastnm_sec_ger_m lastnm_ter_ger_m luu_2lu4_mf_a_m luu_2lu4_mf_y_m nostu_m psurv_m qeyrs_m se_lpv_prim_m sp_dyn_le00_in_m test_m uiscr1_m uiscr2_m uisger02_m une_2eap_mf_a_m une_2eap_mf_y_m unicef_breastf_m unicef_diarrhoea_m unicef_mealfreq_m asr basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a eip_2plf_a eip_2plf_y eip_2wap_a eip_2wap_y eip_neet_mf_y emp_nifl_a emp_nifl_y eyrs hci hci_lower hci_upper lastnm_afr lastnm_birth_reg lastnm_mmrt lastnm_probdeath_ncd lastnm_sec_ger lastnm_ter_ger luu_2lu4_mf_a luu_2lu4_mf_y nostu psurv qeyrs se_lpv_prim sp_dyn_le00_in test uiscr1 uiscr2 uiscr3 uisger01 uisger02 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf une_2eap_mf_a une_2eap_mf_y unicef_1524mort unicef_514mort unicef_breastf unicef_care unicef_caremother unicef_diarrhoea unicef_hygiene unicef_mealfreq unicef_neomort unicef_sanitation unicef_stillbirths unicef_stunting unicef_u5mort unicef_water vacBCG vacDTP1 vacDTP3 vacHEPB3 vacHEPBB vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC {
		bysort wbincomegroup: egen `var'_inc = mean(`var')
		bysort wbregion: egen `var'_reg = mean(`var')
		}
		
	*---------------------------------keep if----------------------------------*
		save "$dhci\data_briefs_allcountries", replace
		
	*--------------------------------save data---------------------------------*
		keep if hci!=.
		
		save "$dhci\data_briefs", replace