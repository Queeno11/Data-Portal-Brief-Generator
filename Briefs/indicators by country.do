*------------------------------------------------------------------------------*
*------------------------------Indicators by country---------------------------*
*---------------------------------for Data Portal------------------------------*
*------------------------------------------------------------------------------*

	*--------------------------------Directories-------------------------------*
		
		/* global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\HCI update\"
		global charts "${root}/Outputs/Update"
		global dhci "${root}/Data"
		global dport "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\Data"
		cd "${root}" */

		*----------------------------Load data---------------------------------*
		* FIXME: por qué no tengo esta base?
		use "$dhci\data_briefs_allcountries", clear
		keep wbcode unicef_neomort unicef_mealfreq uisger02 lastnm_mmrt unicef_care lastnm_birth_reg unicef_breastf unicef_diarrhoea vacBCG uiscr1 lastnm_sec_ger se_lpv_prim uiscr2 vacHEPBB eip_neet_mf_y lastnm_afr lastnm_ter_ger une_2eap_mf_y emp_nifl_y eap_2wap_mf_a eap_2wap_mf_a_f eap_2wap_mf_a_m sp_dyn_le00_in lastnm_probdeath_ncd une_2eap_mf_a emp_nifl_a uisger02_f uisger02_m uisger01 vacDTP1 vacDTP3 vacHEPB3 vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC uiscr1_f uiscr1_m se_lpv_prim_f se_lpv_prim_m eip_neet_mf_y_f eip_neet_mf_y_m une_2eap_mf_y_f une_2eap_mf_y_m emp_nifl_y_f emp_nifl_y_m sp_dyn_le00_in_f sp_dyn_le00_in_m une_2eap_mf_a_f une_2eap_mf_a_m_y emp_nifl_a_f emp_nifl_a_m unicef_neomort_y unicef_mealfreq_y uisger02_y lastnm_mmrt_y unicef_care_y lastnm_birth_reg_y unicef_breastf_y unicef_diarrhoea_y vacBCG_y uiscr1_y lastnm_sec_ger_y se_lpv_prim_y uiscr2_y vacHEPBB_y eip_neet_mf_y_y lastnm_afr_y lastnm_ter_ger_y une_2eap_mf_y_y emp_nifl_y_y eap_2wap_mf_a_f_y eap_2wap_mf_a_m_y sp_dyn_le00_in_y lastnm_probdeath_ncd_y une_2eap_mf_a_y emp_nifl_a_y uisger02_f_y uisger02_m_y uisger01_y vacDTP1_y vacDTP3_y vacHEPB3_y vacHIB3_y vacIPV1_y vacMCV1_y vacMCV2_y vacPCV3_y vacPOL3_y vacROTAC_y uiscr1_f_y uiscr1_m_y se_lpv_prim_f_y se_lpv_prim_m_y eip_neet_mf_y_f_y eip_neet_mf_y_m_y une_2eap_mf_y_f_y une_2eap_mf_y_m_y emp_nifl_y_f_y emp_nifl_y_m_y sp_dyn_le00_in_f_y sp_dyn_le00_in_m_y une_2eap_mf_a_f_y une_2eap_mf_a_m_y emp_nifl_a_f_y emp_nifl_a_m_y eap_2wap_mf_a_y
		
		rename * v_*
		rename (v_unicef_neomort_y v_eap_2wap_mf_a_y v_unicef_mealfreq_y v_uisger02_y v_lastnm_mmrt_y v_unicef_care_y v_lastnm_birth_reg_y v_unicef_breastf_y v_unicef_diarrhoea_y v_vacBCG_y v_uiscr1_y v_lastnm_sec_ger_y v_se_lpv_prim_y v_uiscr2_y v_vacHEPBB_y v_eip_neet_mf_y_y v_lastnm_afr_y v_lastnm_ter_ger_y v_une_2eap_mf_y_y v_emp_nifl_y_y v_eap_2wap_mf_a_f_y v_eap_2wap_mf_a_m_y v_sp_dyn_le00_in_y v_lastnm_probdeath_ncd_y v_une_2eap_mf_a_y v_emp_nifl_a_y v_uisger02_f_y v_uisger02_m_y v_uisger01_y v_vacDTP1_y v_vacDTP3_y v_vacHEPB3_y v_vacHIB3_y v_vacIPV1_y v_vacMCV1_y v_vacMCV2_y v_vacPCV3_y v_vacPOL3_y v_vacROTAC_y v_uiscr1_f_y v_uiscr1_m_y v_se_lpv_prim_f_y v_se_lpv_prim_m_y v_eip_neet_mf_y_f_y v_eip_neet_mf_y_m_y v_une_2eap_mf_y_f_y v_une_2eap_mf_y_m_y v_emp_nifl_y_f_y v_emp_nifl_y_m_y v_sp_dyn_le00_in_f_y v_sp_dyn_le00_in_m_y v_une_2eap_mf_a_f_y v_une_2eap_mf_a_m_y v_emp_nifl_a_f_y v_emp_nifl_a_m_y) (vy_unicef_neomort vy_eap_2wap_mf_a vy_unicef_mealfreq vy_uisger02 vy_lastnm_mmrt vy_unicef_care vy_lastnm_birth_reg vy_unicef_breastf vy_unicef_diarrhoea vy_vacBCG vy_uiscr1 vy_lastnm_sec_ger vy_se_lpv_prim vy_uiscr2 vy_vacHEPBB vy_eip_neet_mf_y vy_lastnm_afr vy_lastnm_ter_ger vy_une_2eap_mf_y vy_emp_nifl_y vy_eap_2wap_mf_a_f vy_eap_2wap_mf_a_m vy_sp_dyn_le00_in vy_lastnm_probdeath_ncd vy_une_2eap_mf_a vy_emp_nifl_a vy_uisger02_f vy_uisger02_m vy_uisger01 vy_vacDTP1 vy_vacDTP3 vy_vacHEPB3 vy_vacHIB3 vy_vacIPV1 vy_vacMCV1 vy_vacMCV2 vy_vacPCV3 vy_vacPOL3 vy_vacROTAC vy_uiscr1_f vy_uiscr1_m vy_se_lpv_prim_f vy_se_lpv_prim_m vy_eip_neet_mf_y_f vy_eip_neet_mf_y_m vy_une_2eap_mf_y_f vy_une_2eap_mf_y_m vy_emp_nifl_y_f vy_emp_nifl_y_m vy_sp_dyn_le00_in_f vy_sp_dyn_le00_in_m vy_une_2eap_mf_a_f vy_une_2eap_mf_a_m vy_emp_nifl_a_f vy_emp_nifl_a_m)
		rename v_wbcode wbcode
		
		reshape long v_ vy_, i(wbcode) string
		rename _j name
	
		*-----------------------Generate stage of life-------------------------*
		
		/* Acá la idea es dividir por stage of life (category) y poner si son de los primeros en prioridades o los no-priorizados */
		
		**-Prenatal & Early childhood-**
		gen category  = .
		gen prefered = .
		foreach sd in unicef_neomort unicef_mealfreq uisger02 lastnm_mmrt unicef_care lastnm_birth_reg unicef_breastf unicef_diarrhoea vacBCG {
		replace category = 1 if name=="`sd'"
		replace prefered = 1 if name=="`sd'"
		}
		
		foreach sd in uisger02_f uisger02_m vacDTP1 vacDTP3 vacHEPB3 vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC {	
		replace category = 1 if name=="`sd'"
		replace prefered = 0 if name=="`sd'"
		}
		
		**-Childhood-**
		foreach sd in uiscr1 lastnm_sec_ger se_lpv_prim uiscr2 vacHEPBB {
		replace category = 2 if name=="`sd'"
		replace prefered = 1 if name=="`sd'"
		}
		
		foreach sd in uiscr1_f uiscr1_m se_lpv_prim_f se_lpv_prim_m {	
		replace category = 2 if name=="`sd'"
		replace prefered = 0 if name=="`sd'"
		}
		
		*-Youth-*
		foreach sd in eip_neet_mf_y lastnm_afr lastnm_ter_ger une_2eap_mf_y {	
		replace category = 3 if name=="`sd'"
		replace prefered = 1 if name=="`sd'"
		}

		foreach sd in eip_neet_mf_y_f eip_neet_mf_y_m une_2eap_mf_y_f une_2eap_mf_y_m emp_nifl_y_f emp_nifl_y_m {	
		replace category = 3 if name=="`sd'"
		replace prefered = 0 if name=="`sd'"
		}	
			
		*--Adults & Elderly-*
		foreach sd in eap_2wap_mf_a sp_dyn_le00_in lastnm_probdeath_ncd une_2eap_mf_a{
		replace category = 4 if name=="`sd'"
		replace prefered = 1 if name=="`sd'"
		}
		
		foreach sd in sp_dyn_le00_in_f sp_dyn_le00_in_m une_2eap_mf_a_f une_2eap_mf_a_m emp_nifl_a_f emp_nifl_a_m {
		replace category = 4 if name=="`sd'"
		replace prefered = 0 if name=="`sd'"
		}		
		
		drop if category==. | prefered==.
		
		*------------------------Labels, info & rank---------------------------*
		
		/* Genero el ranking de prioridad entre los prioritarios */
		
		gen rank = .
		replace rank = 1 if name=="unicef_neomort"
		replace rank = 2 if name=="unicef_mealfreq"
		replace rank = 3 if name=="uisger02"
		replace rank = 4 if name=="lastnm_mmrt"
		replace rank = 5 if name=="unicef_care"
		replace rank = 6 if name=="lastnm_birth_reg"
		replace rank = 7 if name=="unicef_breastf"
		replace rank = 8 if name=="unicef_diarrhoea"
		replace rank = 9 if name=="vacBCG"
		replace rank = 10 if name=="vacHEPBB"
		
		replace rank = 1 if name=="uiscr1"
		replace rank = 2 if name=="lastnm_sec_ger"
		replace rank = 3 if name=="se_lpv_prim"
		replace rank = 4 if name=="uiscr2"
		
		*Cambio 1 con 2, para tener más completos
		replace rank = 2 if name=="eip_neet_mf_y"
		replace rank = 1 if name=="lastnm_afr"
		replace rank = 3 if name=="lastnm_ter_ger"
		replace rank = 4 if name=="une_2eap_mf_y"

		replace rank = 1 if name=="eap_2wap_mf_a"
		replace rank = 2 if name=="sp_dyn_le00_in"
		replace rank = 3 if name=="lastnm_probdeath_ncd"
		replace rank = 4 if name=="une_2eap_mf_a"
		
		drop if missing(v_) | v_==0
		sort wbcode category rank 
		bysort wbcode category: gen arank = _n
		replace arank = . if missing(rank)	
				
		*----------------------Selection of indicators-------------------------*
		
			*--------------------------Category I------------------------------*
			
			bysort wbcode category: egen max_indic = max(arank)
			replace max_indic = 1 if max_indic>1
			
			preserve
			duplicates drop wbcode category, force
			tab max_indic if category==1
			restore
			
			tab name if category==1 & prefered==1 & v_!=.
			drop max_indic
			*Basicamente, los que no tienen valor es porque directamente no tienen ninguna observación para esa categoría. 204 paises completos.
			
			*--------------------------Category II-----------------------------*
			
			bysort wbcode category: egen max_indic = max(arank)
			replace max_indic = 1 if max_indic>1
			
			preserve
			duplicates drop wbcode category, force
			tab max_indic if category==2
			restore 	
			
			drop max_indic
			*Basicamente, los que no tienen valor es porque directamente no tienen ninguna observación para esa categoría. 195 paises completos.
			
			*--------------------------Category III----------------------------*
			
			bysort wbcode category: egen max_indic = max(arank)
			replace max_indic = 1 if max_indic>1
			
			preserve
			duplicates drop wbcode category, force
			tab max_indic if category==3
			restore 		
			
			drop max_indic
			*Basicamente, los que no tienen valor es porque directamente no tienen ninguna observación para esa categoría. 204 paises completos.
			
			*--------------------------Category IV-----------------------------*
			
			bysort wbcode category: egen max_indic = max(arank)
			replace max_indic = 1 if max_indic>1
			
			preserve
			duplicates drop wbcode category, force
			tab max_indic if category==4
			restore 		
			
			drop max_indic
			*Basicamente, los que no tienen valor es porque directamente no tienen ninguna observación para esa categoría. 207 paises completos.
			
			*---------------------------collapse-------------------------------*
			
			collapse (mean) v_, by(arank name category wbcode vy)
			keep if arank==1
			bysort wbcode: egen comp = count(arank)
			
		*---------------------------Keep and reshape---------------------------*
		
		tostring vy_, gen(year)
		keep wbcode name category year
		rename (name year)(name_ year_)
		reshape wide name_ year_, i(wbcode) j(category)
		drop year*
		*Faltan: 6, 9, 8, 5
		foreach m in 1 2 3 4 {
		gen comp_`m' = (name_`m'!="")
		}
		egen complete = rowtotal(comp*)
		drop comp_*
		*202 paises completos, 5 paises con 3 categorias, 4 paises con 2 categorias, 5 paises con 1 sola (29 no completos)
		save "$dport\listing_forportal", replace
		export excel using "$dport\listing_forportal.xlsx", replace firstrow(variable)
		
		*cat 1 missing: CHI FRO GRL MAF NCL XKX
		*cat 2 missing: CHI FRO GRL GUM IMN MAF MCO NCL XKX
		*cat 3 missing: AND FRO GIB GRL IMN MAF MCO XKX
		*cat 4 missing: AND ASM MCO NRU SMR 
		
		*-------------------Check if we can complete countries-----------------*
		*Answer: algunos sí, otros no 
		
		preserve
		use "$dport\complete_series_wmd_4april23", clear
		replace stage_life = "Prenatal and Early Childhood " if code=="uisger02"
		replace stage_life = "Adulthood and Elderly" if code=="sp_dyn_le00_in"
		*replace stage_life = "School-aged Children" if code=="vacHPBB" * NO!
		*cat 1
		foreach cou in CHI FRO GRL MAF NCL XKX {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Prenatal and Early Childhood "
		}
		*replace name_1 = "psurv" if wbcode=="XKX"
		*cat 2 
		foreach cou in CHI FRO GRL GUM IMN MAF MCO NCL XKX {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="School-aged Children"
		}
		*replace name_2 = "unicef_514mort" if wbcode=="MCO"
		*replace name_2 = "eyrs" if wbcode=="XKX"
		*cat 3
		foreach cou in AND FRO GIB GRL IMN MAF MCO XKX {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Youth"
		}
		*replace name_3 = "unicef_514mort" if wbcode=="AND"
		*replace name_3 = "uisqutp2t3" if wbcode=="GIB"
		*replace name_3 = "unicef_514mort" if wbcode=="MCO"
		*cat 4
		foreach cou in AND ASM MCO NRU SMR {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Adulthood and Elderly"
		}
		restore
		*replace name_4 = "asr" if wbcode=="NRU"
		
		*----------------------Check at least 3 obs in time--------------------*
		
		reshape long name_, i(wbcode) j(stage)
		rename name code
		gen stage_life = "Prenatal and Early Childhood " if stage==1
		replace stage_life = "School-aged Children" if stage==2
		replace stage_life = "Youth" if stage==3
		replace stage_life = "Adulthood and Elderly" if stage==4
		drop stage
		save "$dport\check_time", replace
		
		use "$dport\complete_series_wmd_4april23", clear
		replace stage_life = "Prenatal and Early Childhood " if code=="uisger02"
		replace stage_life = "Adulthood and Elderly" if code=="sp_dyn_le00_in"
		*replace stage_life = "School-aged Children" if code=="vacHPBB" * NO!
		merge m:1 wbcode code stage using "$dport\check_time"
		drop if year==.
		keep if _m==3
		drop _m
		gen notmiss = (value!=.)
		keep if gender=="Total"
		bysort wbcode code stage: egen totyears = sum(notmiss)
		
		tab wbcode if totyears<3
		tab code if totyears<3
		
		br wbcode year code value complete totyears if totyears<3
		
		*Countries with complete indicators, but some have fewer than 3 obs in time (15)
		*ASM lastnm_ter_ger 1
		*CUW lastnm_sec_ger 2 / CUW uisger02 1
		*CYM sp_dyn_le00_in 1
		*GUM uisger02 1
		*IMN lastnm_birth_reg 1
		*MHL eip_neet_mf_y 1
		*NRU eip_neet_mf_y 1
		*PLW eip_neet_mf_y 2
		*PRK uiscr1 1
		*PYF uiscr1 1
		*SSD uiscr1 2
		*SXM uiscr1 2
		*TKM lastnm_sec_ger 2
		*TUV eip_neet_mf_y 1
		*VIR uiscr1 1
		
		*---------------------Manually find new indicators---------------------*
		
		use "$dport\complete_series_wmd_4april23", clear
		replace stage_life = "Prenatal and Early Childhood " if code=="uisger02"
		replace stage_life = "Adulthood and Elderly" if code=="sp_dyn_le00_in"
		*replace stage_life = "School-aged Children" if code=="vacHPBB" * NO!
		gen notmiss = (value!=.)
		keep if gender=="Total"
		bysort wbcode code stage: egen totyears = sum(notmiss)
		
		foreach cou in GUM PRK PYF SSD SXM TKM VIR CUW {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="School-aged Children"
		}
		*replace name_2 = "unicef_514mort" if wbcode=="PRK"
		*replace name_2 = "lastnm_sec_ger" if wbcode=="PYF"
		*replace name_2 = "unicef_514mort" if wbcode=="SSD"
		*replace name_2 = "unicef_514mort" if wbcode=="TKM"
		*replace name_2 = "lastnm_sec_ger" if wbcode=="VIR"
		foreach cou in CUW IMN {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Prenatal and Early Childhood "
		}
		*replace name_1 = "uisger01" if wbcode=="CUW"
		foreach cou in ASM MHL NRU PLW TUV {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Youth"
		}
		*replace name_3 = "unicef_1524mort" if wbcode=="MHL"
		*replace name_3 = "unicef_1524mort" if wbcode=="NRU"
		*replace name_3 = "unicef_1524mort" if wbcode=="PLW"
		*replace name_3 = "unicef_1524mort" if wbcode=="TUV"
		foreach cou in CYM {
		tab code wbcode if value!=. & wbcode=="`cou'" & stage=="Adulthood and Elderly"
		}
		
		*------------------Manually change for other indicator-----------------*
		
		use "$dport\listing_forportal", clear
		
		*Elijo entre los que no fueron rankeados
		replace name_1 = "psurv" if wbcode=="XKX"
		replace name_2 = "unicef_514mort" if wbcode=="MCO"
		replace name_2 = "eyrs" if wbcode=="XKX"
		replace name_3 = "unicef_1524mort" if wbcode=="AND"
		replace name_3 = "uisqutp2t3" if wbcode=="GIB"
		replace name_3 = "unicef_1524mort" if wbcode=="MCO"
		replace name_4 = "asr" if wbcode=="NRU"
		*Faltan: 5, 7, 5, 4
		
		*Reemplazo los que estan, pero tienen menos que 3 observaciones
		replace name_1 = "uisger01" if wbcode=="CUW"
		replace name_2 = "unicef_514mort" if wbcode=="PRK"
		replace name_2 = "lastnm_sec_ger" if wbcode=="PYF"
		replace name_2 = "unicef_514mort" if wbcode=="SSD"
		replace name_2 = "unicef_514mort" if wbcode=="TKM"
		replace name_2 = "lastnm_sec_ger" if wbcode=="VIR"
		replace name_3 = "unicef_1524mort" if wbcode=="MHL"
		replace name_3 = "unicef_1524mort" if wbcode=="NRU"
		replace name_3 = "unicef_1524mort" if wbcode=="PLW"
		replace name_3 = "unicef_1524mort" if wbcode=="TUV"
		*Faltan: 5, 7, 5, 4 (faltan los mismos, pero mejore algunos que ya estaban)
		
		drop complete
		foreach m in 1 2 3 4 {
		gen comp_`m' = (name_`m'!="")
		}
		egen complete = rowtotal(comp*)
		drop comp_*
		
		save "$dport\list_bycountry", replace
		export excel using "$dport\list_bycountry.xlsx", replace firstrow(variable)
		*204 paises completos, 6 paises con 3 categorias, 3 paises con 2 categorias, 3 paises con 1 sola (12 no completos)