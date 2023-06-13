*------------------------------------------------------------------------------*
*------------------------------Indicators by country---------------------------*
*------------------------------------------------------------------------------*

*--------------------------------Metadata----------------------------------*	
	
	clear all
	set more off	
	set maxvar 32000
	use "$data_output\complete_series_wmd_${date}", replace
	
	gen year2 = year if value!=.
	bysort wbcode wbcountryname code gender: egen myear = max(year2)
	keep if year==myear
	drop myear year2
	drop if year<2015
	
	replace code = code + "_m" if gender=="Male"
	replace code = code + "_f" if gender=="Female"
	
	keep wbcode code name year source description units
	
	rename name lbl
	rename code name
	rename units age
	rename description def
	
	collapse (mean) year, by(wbcode name lbl age def source)
	
	save "$data_processed\metadata_briefs", replace
	
*-----------------------------Stages of life-------------------------------*
	
	use "$data_output\complete_series_wmd_${date}", clear	
	gen year2 = year if value!=.
	bysort wbcode wbcountryname code gender: egen myear = max(year2)
	keep if year==myear
	drop myear year2
	drop if year<2015
	replace code = code + "_m" if gender=="Male"
	replace code = code + "_f" if gender=="Female"
	
	keep code name stage_life topic
	duplicates drop code name stage_life topic, force
	
	replace stage_life = "Adulthood and Elderly" if strpos(code,"sp_dyn")
	replace stage_life = "Adulthood and Elderly" if strpos(code,"ncd")
	replace stage_life = "Prenatal and Early Childhood " if strpos(code,"uisger02")
	replace stage_life = "School-aged Children" if strpos(code,"uisxg")
	replace stage_life = "Youth" if strpos(code,"caremother")
	replace stage_life = "Youth" if strpos(code,"mmrt")
	replace stage_life = "Youth" if strpos(code,"uiscr3")
	replace stage_life = "Adulthood and Elderly" if strpos(code,"_health") & strpos(code,"basic_")
	replace stage_life = "Prenatal and Early Childhood " if code=="unicef_sanitation"|code=="unicef_water"|code=="unicef_hygiene"
	
	replace topic = "Health" if strpos(code,"_school") & strpos(code,"basic_")
	
	replace name = "Teachers with at least minimum academic qualifications, primary (%)" if code=="uisqutp1"
	replace name = "Teachers with at least minimum academic qualifications, secondary (%)" if code=="uisqutp2t3"
	
	*--Eliminar los que no quedaron seleccionados en la lista--*
	drop if inlist(code,"uisger01","unicef_stunting","unicef_u5mort","psurv")
	drop if inlist(code,"test","qeyrs","eyrs","test_m","test_f","qeyrs_m","qeyrs_f","eyrs_m","eyrs_f")
	drop if inlist(code,"nostu","psruv","nostu_m","nostu_f","psurv_m","psurv_f")
	drop if inlist(code,"eip_2wap_y","eip_2wap_y_m","eip_2wap_y_f","eip_2plf_y","eip_2plf_y_m","eip_2plf_y_f","luu_2lu4_mf_y","luu_2lu4_mf_y_m","luu_2lu4_mf_y_f")
	drop if inlist(code,"eip_2wap_a","eip_2wap_a_m","eip_2wap_a_f","eip_2plf_a","eip_2plf_a_m","eip_2plf_a_f","luu_2lu4_mf_a","luu_2lu4_mf_a_m","luu_2lu4_mf_a_f")
	drop if inlist(code,"asr","asr_m","asr_f","hci","hci_m","hci_f")
	drop if inlist(code,"hci_upper","hci_upper_m","hci_upper_f","hci_lower","hci_lower_m","hci_lower_f")
	
	sort stage topic code
	keep code stage topic
	rename code name
	rename stage category
	save "$data_processed\stages_life_briefs", replace
	
**********************************2) INDICATORS*********************************

	/* This section aims to rank and assign indicators to countries. */

	*----------------------------Load data---------------------------------*
	
	/**** Agregar vars nuevas acá ****/
	
	use "$data_output\data_briefs", clear
	gl indic unicef_neomort unicef_mealfreq uisger02 lastnm_mmrt unicef_care lastnm_birth_reg unicef_breastf unicef_diarrhoea vacBCG uiscr1 lastnm_sec_ger se_lpv_prim uiscr2 vacHEPBB eip_neet_mf_y lastnm_afr lastnm_ter_ger une_2eap_mf_y emp_nifl_y eap_2wap_mf_a_f eap_2wap_mf_a_m sp_dyn_le00_in lastnm_probdeath_ncd une_2eap_mf_a emp_nifl_a uisger02_f uisger02_m vacDTP1 vacDTP3 vacHEPB3 vacHIB3 vacIPV1 vacMCV1 vacMCV2 vacPCV3 vacPOL3 vacROTAC uiscr1_f uiscr1_m se_lpv_prim_f se_lpv_prim_m eip_neet_mf_y_f eip_neet_mf_y_m une_2eap_mf_y_f une_2eap_mf_y_m emp_nifl_y_f emp_nifl_y_m sp_dyn_le00_in_f sp_dyn_le00_in_m une_2eap_mf_a_f une_2eap_mf_a_m emp_nifl_a_f emp_nifl_a_m
	gl indicyear unicef_neomort_y unicef_mealfreq_y uisger02_y lastnm_mmrt_y unicef_care_y lastnm_birth_reg_y unicef_breastf_y unicef_diarrhoea_y vacBCG_y uiscr1_y lastnm_sec_ger_y se_lpv_prim_y uiscr2_y vacHEPBB_y eip_neet_mf_y_y lastnm_afr_y lastnm_ter_ger_y une_2eap_mf_y_y emp_nifl_y_y eap_2wap_mf_a_f_y eap_2wap_mf_a_m_y sp_dyn_le00_in_y lastnm_probdeath_ncd_y une_2eap_mf_a_y emp_nifl_a_y uisger02_f_y uisger02_m_y vacDTP1_y vacDTP3_y vacHEPB3_y vacHIB3_y vacIPV1_y vacMCV1_y vacMCV2_y vacPCV3_y vacPOL3_y vacROTAC_y uiscr1_f_y uiscr1_m_y se_lpv_prim_f_y se_lpv_prim_m_y eip_neet_mf_y_f_y eip_neet_mf_y_m_y une_2eap_mf_y_f_y une_2eap_mf_y_m_y emp_nifl_y_f_y emp_nifl_y_m_y sp_dyn_le00_in_f_y sp_dyn_le00_in_m_y une_2eap_mf_a_f_y une_2eap_mf_a_m_y emp_nifl_a_f_y emp_nifl_a_m_y
	gl indicnew basic_hygiene_health basic_hygiene_schools basic_sanitation_health basic_sanitation_schools basic_water_health basic_water_schools eap_2wap_mf_a lastnm_birth_reg_f lastnm_birth_reg_m lastnm_sec_ger_f lastnm_sec_ger_m lastnm_ter_ger_f lastnm_ter_ger_m uiscr2_f uiscr2_m uiscr3 uisoaepg1 uisoaepg2gpv uisqutp1 uisqutp2t3 uisschbsp1welec uisxgdpfsgov uisxgovexpimf unicef_1524mort unicef_514mort unicef_breastf_f unicef_breastf_m unicef_caremother unicef_diarrhoea_f unicef_diarrhoea_m unicef_hygiene unicef_mealfreq_f unicef_mealfreq_m unicef_sanitation unicef_stillbirths unicef_water
	gl indicnewyear basic_hygiene_health_y basic_hygiene_schools_y basic_sanitation_health_y basic_sanitation_schools_y basic_water_health_y basic_water_schools_y eap_2wap_mf_a_y lastnm_birth_reg_f_y lastnm_birth_reg_m_y lastnm_sec_ger_f_y lastnm_sec_ger_m_y lastnm_ter_ger_f_y lastnm_ter_ger_m_y uiscr2_f_y uiscr2_m_y uiscr3_y uisoaepg1_y uisoaepg2gpv_y uisqutp1_y uisqutp2t3_y uisschbsp1welec_y uisxgdpfsgov_y uisxgovexpimf_y unicef_1524mort_y unicef_514mort_y unicef_breastf_f_y unicef_breastf_m_y unicef_caremother_y unicef_diarrhoea_f_y unicef_diarrhoea_m_y unicef_hygiene_y unicef_mealfreq_f_y unicef_mealfreq_m_y unicef_sanitation_y unicef_stillbirths_y unicef_water_y
	keep wbcode $indic $indicyear $indicnew $indicnewyear  	 

	rename * v_*
	/* Para 3 variables lo hago manualmente, porque el codigo del indicador termina en _y, y se confunde con el _y del año */
	rename (v_eip_neet_mf_y_y v_emp_nifl_y_y v_une_2eap_mf_y_y)(vy_eip_neet_mf_y vy_emp_nifl_y vy_une_2eap_mf_y)
	rename (v_eip_neet_mf_y v_emp_nifl_y v_une_2eap_mf_y)(v_eip_neet_mf_xx v_emp_nifl_xx v_une_2eap_mf_xx)
	rename v_*_y vy_*
	rename (v_eip_neet_mf_xx v_emp_nifl_xx v_une_2eap_mf_xx)(v_eip_neet_mf_y v_emp_nifl_y v_une_2eap_mf_y)
	rename v_wbcode wbcode
	
	reshape long v_ vy_, i(wbcode) string
	rename _j name

	*-----------------------Generate stage of life-------------------------*
	
	/**** Mayo 16: El dataset "$data_processed\stages_life_briefs" contiene todos los cambios que hablamos en la última reunión. A diferencia de como se hacía antes, armé un dataset que clasifica a los indicadores por stage of life y dimensión, a diferencia de antes, que se generaban las categorías manualmente en esta sección. ****/
	merge m:1 name using "$data_processed\stages_life_briefs", nogen
	
	{
	/*
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
	foreach sd in eap_2wap_mf_a_f eap_2wap_mf_a_m sp_dyn_le00_in lastnm_probdeath_ncd une_2eap_mf_a{
	replace category = 4 if name=="`sd'"
	replace prefered = 1 if name=="`sd'"
	}
	
	foreach sd in sp_dyn_le00_in_f sp_dyn_le00_in_m une_2eap_mf_a_f une_2eap_mf_a_m emp_nifl_a_f emp_nifl_a_m {
	replace category = 4 if name=="`sd'"
	replace prefered = 0 if name=="`sd'"
	}		
	*/
	}
	*------------------------Labels, info & rank---------------------------*
	
	merge m:1 wbcode name using "$data_processed\metadata_briefs", keep(1 3) nogen
	rename category stage
	gen category = 1 if stage=="Prenatal and Early Childhood "
	replace category = 2 if stage=="School-aged Children"
	replace category = 3 if stage=="Youth"
	replace category = 4 if stage=="Adulthood and Elderly"
	
	gen prefered = 1
	
	/**** Se genera el ranking de prioridad --> considerar armar ranking por stage of life & dimensión. Agregar las vars nuevas ****/
	
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
	
	replace rank = 1 if name=="uiscr1"
	replace rank = 2 if name=="lastnm_sec_ger"
	replace rank = 3 if name=="se_lpv_prim"
	replace rank = 4 if name=="uiscr2"
	replace rank = 5 if name=="vacHEPBB"
	
	replace rank = 1 if name=="eip_neet_mf_y"
	replace rank = 2 if name=="lastnm_afr"
	replace rank = 3 if name=="lastnm_ter_ger"
	replace rank = 4 if name=="une_2eap_mf_y"

	replace rank = 1 if name=="eap_2wap_mf_a_f"
	replace rank = 2 if name=="eap_2wap_mf_a_m"
	replace rank = 3 if name=="sp_dyn_le00_in"
	replace rank = 4 if name=="lastnm_probdeath_ncd"
	replace rank = 5 if name=="une_2eap_mf_a"
	
	drop if missing(v_) | v_==0
	sort wbcode category rank 
	bysort wbcode category: gen arank = _n
	replace arank = . if missing(rank)	
	
	*----------------------Selection of indicators-------------------------*
	
	/**** Considerar automatizar esto según stage of life & dimension, para evitar asignar cosas manualmente. Desagregar automáticamente por género cuando no hay más indicadores. ****/
	
		*--------------------------Category I------------------------------*
		
		*Iteration 1*
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==1
		restore
		
		tab name if category==1 & prefered==0 & max_indic<3
		
		/* Condicional a no completar los 3 indicadores, acá se saca el indicador general de la lista, para meter el mismo indicador por género (por lo tanto son 2 en lugar de 1) */
		gen bygender = 1 if name=="uisger02_f"
		bysort wbcode: egen bygend = max(bygender)
		replace rank = . if  max_indic<3 & name=="uisger02" & bygend==1
		replace rank = 10 if  max_indic<3 & name=="uisger02_f" & bygend==1
		replace rank = 11 if  max_indic<3 & name=="uisger02_m" & bygend==1
		drop bygend*
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
		drop max_indic arank2
		
		*Iteration 2*
		/* Acá se chequea si con el cambio que se hizo alcanza, o si hay que seguir reemplazando cosas */
		
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==1
		restore 	
		
		tab wbcode if category==1 & max_indic<3
		tab name if category==1 & prefered==0 & max_indic<3
		tab name if !missing(arank) & category==1 & wbcode=="SWZ"
		tab name if category==1 & prefered==0 & max_indic<3 & wbcode=="SWZ"
		tab name if !missing(arank) & category==1 & wbcode=="MAC"
		tab name if category==1 & prefered==0 & max_indic<3 & wbcode=="MAC"
		tab name if !missing(arank) & category==1 & wbcode=="HKG"
		tab name if category==1 & prefered==0 & max_indic<3 & wbcode=="HKG"
		
		drop max_indic
		
		*CRITERIO: si ya tiene algo de education por gender, ponerle otro tipo de indicador. Por ejemplo, MAC y HKG tienen uisger02_f y uisger02_m, entonces le ponemos como missing el siguiente en la lista que es unicef_neomort. En cambio, SWZ tiene unicef_neomort y vacBCG, por lo que se completa con el de education.
		
		*Las líneas de acá abajo las copio para una parte de más abajo del do file
		/*
		"uisger02" if category==1 & pos==3 & wbcode=="SWZ"
		"unicef_neomort" if category==1 & pos==3 & wbcode=="MAC"
		"unicef_neomort" if category==1 & pos==3 & wbcode=="HKG"
		*/
		
		*--------------------------Category II-----------------------------*
		
		*Iteration 1*
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==2
		restore 	
		
		tab name if category==2 & prefered==0 & max_indic<3	
		gen bygender = 1 if name=="se_lpv_prim_f"
		bysort wbcode: egen bygend = max(bygender)
		/* Agregué este bygender para que solo me reemplace cuando hay por gender. Así, si no tenés la división por género, no perdés un indicador. */
		replace rank = . if  max_indic<3 & name=="se_lpv_prim" & bygend==1
		replace rank = 6 if  max_indic<3 & name=="se_lpv_prim_f" & bygend==1
		replace rank = 7 if  max_indic<3 & name=="se_lpv_prim_m" & bygend==1
		drop bygend*
		
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
		drop max_indic arank2

		*Iteration 2*			
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==2
		restore 		
		
		tab name if category==2 & prefered==0 & max_indic<3
		gen bygender = 1 if name=="uiscr1_f"
		bysort wbcode: egen bygend = max(bygender)
		replace rank = . if  max_indic<3 & name=="uiscr1" & bygend==1
		replace rank = 8 if  max_indic<3 & name=="uiscr1_f"  & bygend==1
		replace rank = 9 if  max_indic<3 & name=="uiscr1_m"	 & bygend==1
		drop bygend*
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
					
		drop max_indic arank2
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		tab wbcode max_indic if category==2 & max_indic<3
		
		*1 indicator: AGO GUY IRQ LBN NIC UKR*	
		*2 indicators: CHN HND NGA SLV TTO*
		
		/* Entre lo del bygender y la actualización de la data pasamos de 15 países sin completar 3 indicadores, a solamente 11 países que no llegan a 3 */
		
		foreach cod in AGO CHN GUY HND IRQ LBN NGA NIC SLV TTO UKR {	
		tab wbcode if wbcode=="`cod'"
		tab name if !missing(arank) & category==2 & wbcode=="`cod'"
		tab name if category==2 & prefered==0 & max_indic<3 & wbcode=="`cod'"
		}
		
		drop max_indic
		
		*CRITERIO: para cada país, miro cuáles son los indicadores que tiene y si es que tiene alguno extra que no metí. Después, si no hay nada que corregir, le meto el primero en prioridad de la lista, siempre que no se repita con los que ya tiene el país.  
		/*
		"uiscr1" if category==2 & pos==2 & wbcode=="AGO"
		"se_lpv_prim" if category==2 & pos==3 & wbcode=="AGO"	
		"uiscr1" if category==2 & pos==3 & wbcode=="CHN"
		"uiscr1" if category==2 & pos==2 & wbcode=="GUY"
		"se_lpv_prim" if category==2 & pos==3 & wbcode=="GUY"		
		"uiscr1" if category==2 & pos==3 & wbcode=="HND"
		"uiscr1" if category==2 & pos==2 & wbcode=="IRQ"
		"se_lpv_prim" if category==2 & pos==3 & wbcode=="IRQ"	
		"uiscr1" if category==2 & pos==2 & wbcode=="LBN"
		"se_lpv_prim" if category==2 & pos==3 & wbcode=="LBN"		
		"uiscr1" if category==2 & pos==3 & wbcode=="NGA"
		"uiscr1" if category==2 & pos==2 & wbcode=="NIC"
		"lastnm_sec_ger" if category==2 & pos==3 & wbcode=="NIC"
		"uiscr1" if category==2 & pos==3 & wbcode=="SLV"	
		"uiscr1" if category==2 & pos==3 & wbcode=="TTO"
		"uiscr1" if category==2 & pos==2 & wbcode=="UKR"
		"se_lpv_prim" if category==2 & pos==3 & wbcode=="UKR"	
		*/
		
		*--------------------------Category III----------------------------*
		
		*Iteration 1*
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		bysort category: tab max_indic
		restore 	
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==3
		restore 		
		
		tab name if category==3 & prefered==0 & max_indic<3	
		gen bygender = 1 if name=="eip_neet_mf_y_f"
		bysort wbcode: egen bygend = max(bygender)
		replace rank = . if  max_indic<3 & name=="eip_neet_mf_y" & bygend==1	
		replace rank = 5 if  max_indic<3 & name=="eip_neet_mf_y_f" & bygend==1
		replace rank = 6 if  max_indic<3 & name=="eip_neet_mf_y_m" & bygend==1
		drop bygend*
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
		drop max_indic arank2	
		
		*Iteration 2*		
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==3
		restore 			
		
		tab name if category==3 & prefered==0 & max_indic<3
		gen bygender = 1 if name=="une_2eap_mf_y_f"
		bysort wbcode: egen bygend = max(bygender)
		replace rank = . if  max_indic<3 & name=="une_2eap_mf_y" & bygend==1	
		replace rank = 7 if  max_indic<3 & name=="une_2eap_mf_y_f" & bygend==1
		replace rank = 8 if  max_indic<3 & name=="une_2eap_mf_y_m" & bygend==1
		drop bygend*
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
		
		drop max_indic arank2
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		tab wbcode max_indic if category==3 & max_indic<3
		
		*1 indicator: ATG FSM KNA*
		*2 indicators: GRD TUV*	
		
		foreach cod in ATG FSM GRD KNA TUV{	
		tab wbcode if wbcode=="`cod'"
		tab name if !missing(arank) & category==3 & wbcode=="`cod'"
		tab name if category==3 & prefered==0 & max_indic<3 & wbcode=="`cod'"
		}	
		
		drop max_indic

		/*
		"eip_neet_mf_y" if category==3 & pos==2 & wbcode=="ATG"
		"lastnm_ter_ger" if category==3 & pos==3 & wbcode=="ATG"	
		"eip_neet_mf_y" if category==3 & pos==2 & wbcode=="FSM"
		"lastnm_ter_ger" if category==3 & pos==3 & wbcode=="FSM"
		"eip_neet_mf_y" if category==3 & pos==3 & wbcode=="GRD"
		"eip_neet_mf_y" if category==3 & pos==2 & wbcode=="KNA"
		"lastnm_afr" if category==3 & pos==3 & wbcode=="KNA"
		"lastnm_afr" if category==3 & pos==3 & wbcode=="TUV"
		*/	

		
		*--------------------------Category IV-----------------------------*
		
		*Iteration 1*
		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		
		preserve
		duplicates drop wbcode category, force
		tab max_indic if category==4
		restore 		
		
		tab name if category==4 & prefered==0 & max_indic<3	
		gen bygender = 1 if name=="sp_dyn_le00_in_f"
		bysort wbcode: egen bygend = max(bygender)
		replace rank = . if  max_indic<3 & name=="sp_dyn_le00_in" & bygend==1	
		replace rank = 6 if  max_indic<3 & name=="sp_dyn_le00_in_f" & bygend==1
		replace rank = 7 if  max_indic<3 & name=="sp_dyn_le00_in_m" & bygend==1
		drop bygend*
		sort wbcode category rank 
		bysort wbcode category: gen arank2 = _n
		replace arank2 = . if missing(rank)	
		replace arank = arank2 if max_indic<3	
		drop max_indic arank2		

		bysort wbcode category: egen max_indic = max(arank)
		replace max_indic = 3 if max_indic>3
		tab wbcode max_indic if category==4 & max_indic<3
		
		*2 indicators: TUV XKX*
		
		tab wbcode if category==4 & max_indic<3
		foreach cod in TUV XKX{	
		tab wbcode if wbcode=="`cod'"
		tab name if !missing(arank) & category==4 & wbcode=="`cod'"
		tab name if category==4 & prefered==0 & max_indic<3 & wbcode=="`cod'"
		}
		
		/*
		"eap_2wap_mf_a_f" if category==4 & pos==3 & wbcode=="TUV"
		"eap_2wap_mf_a_f" if category==4 & pos==3 & wbcode=="KXK"
		*/
		
		drop max_indic
		
	*---------------------------Keep and reshape---------------------------*
	
	/**** Si los labels llegan a quedar demasiado largos para los gráficos, ir al principio de este do file y editar (con replace) los labels para que sean más cortos --> no cambiar en la data original del data portal. La gracia es que los labels nuevos queden en el dta metadata, así más adelante cuando mergamos ese dta, nos pasa bien los labels que queremos.  ****/
	
	drop if arank>3
	drop year
	tostring vy_, gen(year)
	keep wbcode name lbl category arank year age sou def
	rename (name lbl year age sou def)(name_ lbl_ year_ age_ sou_ def_)
	reshape wide name_ lbl_ year_ age_ sou_ def_, i(wbcode arank) j(category)
	rename * *_
	rename (wbcode_ arank_)(wbcode arank)
	reshape wide name_1_ year_1_ lbl_1_ age_1_ sou_1_ def_1_ name_2_ year_2_ lbl_2_ age_2_ sou_2_ def_2_ name_3_ year_3_ lbl_3_ age_3_ sou_3_ def_3_ name_4_ year_4_ lbl_4_ age_4_ sou_4_ def_4_, i(wbcode) j(arank)	
	forvalues cat = 1(1)4{
	forvalues ara = 1(1)3{
	gen com_`cat'_`ara' = (name_`cat'_`ara'!="")
	}
	egen com_`cat' = rowtotal(com_`cat'*)
	gen comp_`cat' = (com_`cat'==3)
	drop com_*
	}
	egen complete = rowtotal(comp*)
	aorder
	order wbcode complete comp_* 
	save "$data_output\listing", replace
	export excel using "$data_output\listing.xlsx", replace firstrow(variable)
	
	*-----------------------------Gen do file------------------------------*	
	
	use "$data_output\listing", clear
	drop year*
	drop com*
	reshape long lbl_1_ lbl_2_ lbl_3_ lbl_4_ name_1_ name_2_ name_3_ name_4_ age_1_ age_2_ age_3_ age_4_ sou_1_ sou_2_ sou_3_ sou_4_ def_1_ def_2_ def_3_ def_4_, i(wbcode)
	lab val _j 
	rename _j pos	
	rename *_ *
	reshape long name_ lbl_ age_ sou_ def_, i(wbcode pos)	
	rename _j category
	rename *_ *
	
	replace name = "uisger02" if category==1 & pos==3 & wbcode=="SWZ"
	replace name = "unicef_neomort" if category==1 & pos==3 & wbcode=="MAC"
	replace name = "unicef_neomort" if category==1 & pos==3 & wbcode=="HKG"
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="AGO"
	replace name = "se_lpv_prim" if category==2 & pos==3 & wbcode=="AGO"	
	replace name = "uiscr1" if category==2 & pos==3 & wbcode=="CHN"
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="GUY"
	replace name = "se_lpv_prim" if category==2 & pos==3 & wbcode=="GUY"		
	replace name = "uiscr1" if category==2 & pos==3 & wbcode=="HND"
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="IRQ"
	replace name = "se_lpv_prim" if category==2 & pos==3 & wbcode=="IRQ"	
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="LBN"
	replace name = "se_lpv_prim" if category==2 & pos==3 & wbcode=="LBN"		
	replace name = "uiscr1" if category==2 & pos==3 & wbcode=="NGA"
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="NIC"
	replace name = "lastnm_sec_ger" if category==2 & pos==3 & wbcode=="NIC"
	replace name = "uiscr1" if category==2 & pos==3 & wbcode=="SLV"	
	replace name = "uiscr1" if category==2 & pos==3 & wbcode=="TTO"
	replace name = "uiscr1" if category==2 & pos==2 & wbcode=="UKR"
	replace name = "se_lpv_prim" if category==2 & pos==3 & wbcode=="UKR"
	replace name = "eip_neet_mf_y" if category==3 & pos==2 & wbcode=="ATG"
	replace name = "lastnm_ter_ger" if category==3 & pos==3 & wbcode=="ATG"	
	replace name = "eip_neet_mf_y" if category==3 & pos==2 & wbcode=="FSM"
	replace name = "lastnm_ter_ger" if category==3 & pos==3 & wbcode=="FSM"
	replace name = "eip_neet_mf_y" if category==3 & pos==3 & wbcode=="GRD"
	replace name = "eip_neet_mf_y" if category==3 & pos==2 & wbcode=="KNA"
	replace name = "lastnm_afr" if category==3 & pos==3 & wbcode=="KNA"
	replace name = "lastnm_afr" if category==3 & pos==3 & wbcode=="TUV"
	replace name = "eap_2wap_mf_a_f" if category==4 & pos==3 & wbcode=="TUV"
	replace name = "eap_2wap_mf_a_f" if category==4 & pos==3 & wbcode=="XKX"
	
	preserve
	use "$data_processed\metadata_briefs", clear
	duplicates drop name lbl, force
	drop year wbcode
	rename * *_met
	rename name_met name
	tempfile met
	save `met'
	restore
	merge m:1 name using `met'
	
	tab wbcode category if _m==1
	
	*Category 1: XKX*
	*Category 2: HTI (SLV) XKX ZMB*
	*Category 3: DMA NRU PLW XKX*
	*Category 4: DMA KNA MHL NRU PLW*
	
	drop *_met _merge
	drop if wbcode==""
	
	/* Esto pasa con los países a los que les falta una categoría ENTERA */
	replace name = "unicef_neomort" if category==1 & pos==1 & wbcode=="XKX"
	replace name = "unicef_mealfreq" if category==1 & pos==2 & wbcode=="XKX"
	replace name = "uisger02" if category==1 & pos==3 & wbcode=="XKX"	
	replace name = "uiscr1" if category==2 & pos==1 & inlist(wbcode,"HTI","XKX","ZMB")
	replace name = "lastnm_sec_ger" if category==2 & pos==2 & inlist(wbcode,"HTI","XKX","ZMB")
	replace name = "se_lpv_prim" if category==2 & pos==3 & inlist(wbcode,"HTI","XKX","ZMB")
	replace name = "eip_neet_mf_y" if category==3 & pos==1 & inlist(wbcode,"DMA","NRU","PLW","XKX")
	replace name = "lastnm_afr" if category==3 & pos==2 & inlist(wbcode,"DMA","NRU","PLW","XKX")
	replace name = "lastnm_ter_ger" if category==3 & pos==3 & inlist(wbcode,"DMA","NRU","PLW","XKX")
	replace name = "eap_2wap_mf_a_f" if category==4 & pos==1 & inlist(wbcode,"DMA","KNA","MHL","NRU","PLW")
	replace name = "eap_2wap_mf_a_m" if category==4 & pos==2 & inlist(wbcode,"DMA","KNA","MHL","NRU","PLW")
	replace name = "sp_dyn_le00_in" if category==4 & pos==3 & inlist(wbcode,"DMA","KNA","MHL","NRU","PLW")

	preserve
	use "$data_processed\metadata_briefs", clear
	duplicates drop name lbl, force
	drop year wbcode
	rename * *_met
	rename name_met name
	tempfile met
	save `met'
	restore
	merge m:1 name using `met', nogen
	
	gen catt = ""
	replace catt = "l" if category==1
	replace catt = "e" if category==2
	replace catt = "h" if category==3
	replace catt = "b" if category==4
	tostring pos, gen(rank)
	
	drop if wbcode==""
	gen lc = "local "
	gen lcl = "local l"
	gen esp = " "
	gen equ = "="
	gen uss = "_"
	gen blt = "_y[1]"
	gen quo = `"""'
	gen l1 = lc+catt+rank+uss+wbcode+esp+name	
	gen l2 = lcl+catt+rank+uss+wbcode+esp+quo+lbl+quo
	
	keep wbcode l1 l2 category pos 
	reshape long l, i(wbcode category pos) 
	sort wbcode category pos _j
	keep l
	save "$data_output\new_locals", replace
	br 
	
	/* Copiar todos los locals y pegar en el siguiente do file */ 
			
			
***************************************3) YEARS*********************************	

/* This section aims to understand which share of the indicators has been updated during the last 3 years (2020-2022), or before. The output is an excel file. Just informative. */	
/**** De acá sale una de las tablas del PPT. Agregar todos los indicadores. ****/
	
*--------------------------------Upload years------------------------------*

/**** Agregar vars nuevas ****/

	use "$data_output\data_briefs", clear
	rename lastnm_birth_reg lastnm_birth_reg_t
	drop *_reg *_inc
	rename lastnm_birth_reg_t lastnm_birth_reg
	keep unicef_neomort_y unicef_mealfreq_y uisger02_y lastnm_mmrt_y unicef_care_y lastnm_birth_reg_y unicef_breastf_y unicef_diarrhoea_y vacBCG_y uiscr1_y lastnm_sec_ger_y se_lpv_prim_y uiscr2_y vacHEPBB_y eip_neet_mf_y_y lastnm_afr_y lastnm_ter_ger_y une_2eap_mf_y_y emp_nifl_y_y eap_2wap_mf_a_f_y eap_2wap_mf_a_m_y sp_dyn_le00_in_y lastnm_probdeath_ncd_y une_2eap_mf_a_y emp_nifl_a_y uisger02_f_y uisger02_m_y uisger01_y vacDTP1_y vacDTP3_y vacHEPB3_y vacHIB3_y vacIPV1_y vacMCV1_y vacMCV2_y vacPCV3_y vacPOL3_y vacROTAC_y uiscr1_f_y uiscr1_m_y se_lpv_prim_f_y se_lpv_prim_m_y eip_neet_mf_y_f_y eip_neet_mf_y_m_y une_2eap_mf_y_f_y une_2eap_mf_y_m_y emp_nifl_y_f_y emp_nifl_y_m_y sp_dyn_le00_in_f_y sp_dyn_le00_in_m_y une_2eap_mf_a_f_y une_2eap_mf_a_m_y emp_nifl_a_f_y emp_nifl_a_m_y
	rename *_y *
	
*---------------------------------Prefered---------------------------------*

	rename unicef_neomort l1		
	rename unicef_mealfreq l2		
	rename uisger02 l3
	rename lastnm_mmrt l4
	rename unicef_care l5
	rename lastnm_birth_reg l6
	rename unicef_breastf l7
	rename unicef_diarrhoea l8
	rename vacBCG l9
	
	rename uiscr1 e1
	rename lastnm_sec_ger e2		
	rename se_lpv_prim e3 
	rename uiscr2 e4
	rename vacHEPBB e5
	
	rename eip_neet_mf_y h1 
	rename lastnm_afr h2	
	rename lastnm_ter_ger h3
	rename une_2eap_mf_y h4
	rename emp_nifl_y h5 
	
	rename eap_2wap_mf_a_f b1
	rename eap_2wap_mf_a_m b2
	rename sp_dyn_le00_in b3
	rename lastnm_probdeath_ncd b4
	rename une_2eap_mf_a b5
	rename emp_nifl_a b6
	
	*-----------------------------Complementary----------------------------*
	
	*Los indicadores que están comentados son los que NO están en el dataset del DP y sí estaban antes.
	
	rename uisger02_f l3_a1
	rename uisger02_m l3_a2
	*rename uisger0 l3_a3
	*rename uisger0f l3_a4
	*rename uisger0m l3_a5
	rename uisger01 l3_a6
	*rename uisger01f l3_a7
	*rename uisger01m l3_a8
	
	rename vacDTP1 l9_a1
	rename vacDTP3 l9_a2 
	rename vacHEPB3 l9_a3 
	rename vacHIB3 l9_a4
	rename vacIPV1 l9_a5 
	rename vacMCV1 l9_a6 
	rename vacMCV2 l9_a7
	rename vacPCV3 l9_a8
	rename vacPOL3 l9_a9
	*rename vacRCV1 l9_a10
	rename vacROTAC l9_a11
	*rename vacyfv l9_a12	
			
	rename uiscr1_f e1_a1
	rename uiscr1_m e1_a2
	rename se_lpv_prim_f e3_a1 
	rename se_lpv_prim_m e3_a2 

	rename eip_neet_mf_y_f h1_a1
	rename eip_neet_mf_y_m h1_a2	
	rename une_2eap_mf_y_f h4_a1
	rename une_2eap_mf_y_m h4_a2
	rename emp_nifl_y_f h5_a1
	rename emp_nifl_y_m h5_a2	
	
	rename sp_dyn_le00_in_f b3_a1
	rename sp_dyn_le00_in_m b3_a2
	rename une_2eap_mf_a_f b5_a1 	
	rename une_2eap_mf_a_m b5_a2	
	rename emp_nifl_a_f b6_a1
	rename emp_nifl_a_m b6_a2
	
	*------------------------------New or old------------------------------*
	
	foreach var in b1 b2 b3 b3_a1 b3_a2 b4 b5 b5_a1 b5_a2 b6 b6_a1 b6_a2 e1 e1_a1 e1_a2 e2 e3 e3_a1 e3_a2 e4 e5 h1 h1_a1 h1_a2 h2 h3 h4 h4_a1 h4_a2 h5 h5_a1 h5_a2 l1 l2 l3 l3_a1 l3_a2 l3_a6 l4 l5 l6 l7 l8 l9 l9_a1 l9_a2 l9_a3 l9_a4 l9_a5 l9_a6 l9_a7 l9_a8 l9_a9 l9_a11 {
	*foreach var in b1 b2 b3 b3_a1 b3_a2 b4 b5 b5_a1 b5_a2 b6 b6_a1 b6_a2 e1 e1_a1 e1_a2 e2 e3 e3_a1 e3_a2 e4 e5 h1 h1_a1 h1_a2 h2 h3 h4 h4_a1 h4_a2 h5 h5_a1 h5_a2 l1 l2 l3 l3_a1 l3_a2 l3_a3 l3_a4 l3_a5 l3_a6 l3_a7 l3_a8 l4 l5 l6 l7 l8 l9 l9_a1 l9_a2 l9_a3 l9_a4 l9_a5 l9_a6 l9_a7 l9_a8 l9_a9 l9_a10 l9_a11 l9_a12 o1 o2 o2_a1 o2_a2 o3 o4 o4_a1 o4_a2 o4_a3 o4_a4 o5 o6 o6_a1 o6_a2 o6_a3 o6_a4 {
	gen `var'_x = 0 
	replace `var'_x = 1 if inrange(`var',2021,2023)	
	gen `var'_l = 0 
	replace `var'_l = 1 if inrange(`var',2019,2020)		
	gen `var'_m = 0 
	replace `var'_m = 1 if inrange(`var',2017,2018)
	gen `var'_f = 0 
	replace `var'_f = 1 if inrange(`var',2015,2016)		
	drop `var'
	}
	
	collapse _all
	
	gen m = 1
	rename *_x *4
	rename *_l *3
	rename *_m *2
	rename *_f *1
	
	reshape long b1 b2 b3 b3_a1 b3_a2 b4 b5 b5_a1 b5_a2 b6 b6_a1 b6_a2 e1 e1_a1 e1_a2 e2 e3 e3_a1 e3_a2 e4 e5 h1 h1_a1 h1_a2 h2 h3 h4 h4_a1 h4_a2 h5 h5_a1 h5_a2 l1 l2 l3 l3_a1 l3_a2 l3_a6 l4 l5 l6 l7 l8 l9 l9_a1 l9_a2 l9_a3 l9_a4 l9_a5 l9_a6 l9_a7 l9_a8 l9_a9 l9_a11 , i(m)
	lab val _j
	
	/* Acá eventualmente hay que poner exactamente los mismos labels que en el dataset original del Data Portal. Hasta el momento dejé los que quedaron de los briefs anteriores (que son correctos, dado que son exactamente los mismos indicadores, pero la descripción no sería consistente). Para la parte de generar los locals ahí sí le hice un merge con la data original, para tener el label correcto. */
	
	lab var l1 "Neonatal mortality rate"
	lab var l2 "Children 6-23mo who received minimum meal frequency (%)"		
	lab var l3 "Pre-primary gross enrollment ratio (%)"
	lab var l4 "Maternal survival rate (per 100,000 live births)"
	lab var l5 "Newborns who have postnatal contact with health provider (within 2 days) (%)"
	lab var l6 "Completeness of birth registration (%)"
	lab var l7 "Infants 0–5 months who are fed exclusively with breast milk (%)"
	lab var l8 "Children (age<5) with diarrhea who attended health facility (%)"
	lab var l9 "BCG vaccination rate"
	
	lab var e1 "Primary completion rate (%)"
	lab var e2 "Gross secondary enrollment (%)"
	lab var e3 "Learning poverty (%)"
	lab var e4 "Lower secondary completion rate (%)"
	lab var e5 "Hepatitis b vaccination (%)"
	
	lab var h1 "Youth NEET (% ages 15-24)"	
	lab var h2 "Adolescent fertility rate (births/1000 women ages 15-19)"
	lab var h3 "Gross tertiary enrollment (%)"
	lab var h4 "Youth unemployment (% ages 15-24)"
	lab var h5 "Youth informal employment (% ages 15-24)"

	lab var b1 "Female labour force participation (% ages 25+)"
	lab var b2 "Male labour force participation (% ages 25+)"
	lab var b3 "Life expectancy at birth"
	lab var b4 "Probability of dying from NCDs (ages 30-70)"	
	lab var b5 "Adult unemployment (% ages 25+)"	
	lab var b6 "Adult informal employment (% ages 25+)"
		
	lab var l3_a1 "Pre-primary gross enrollment ratio (%), Female"
	lab var l3_a2 "Pre-primary gross enrollment ratio (%), Male"
	lab var l3_a6 "Gross enrolment ratio, early childhood educational development programmes (%)"
	
	lab var l9_a1 "DTP1 vaccination rate"
	lab var l9_a2 "DTP3 vaccination rate"
	lab var l9_a3 "HEPB3 vaccination rate"
	lab var l9_a4 "HIB3 vaccination rate"
	lab var l9_a5 "IPV1 vaccination rate"
	lab var l9_a6 "MCV1 vaccination rate"
	lab var l9_a7 "MCV2 vaccination rate"
	lab var l9_a8 "PCV3 vaccination rate"
	lab var l9_a9 "POL3 vaccination rate"
	lab var l9_a11 "ROTAC vaccination rate"
	
	lab var e1_a1 "Primary completion rate (%), female"
	lab var e1_a2 "Primary completion rate (%), male"
	lab var e3_a1 "Learning poverty (%), female"
	lab var e3_a2 "Learning poverty (%), male"
	
	lab var h1_a1 "Youth NEET (% ages 15-24), female"	
	lab var h1_a2 "Youth NEET (% ages 15-24), male"	
	lab var h4_a1 "Youth unemployment (% ages 15-24), female"
	lab var h4_a2 "Youth unemployment (% ages 15-24), male"
	lab var h5_a1 "Youth informal employment (% ages 15-24), male"
	lab var h5_a2 "Youth informal employment (% ages 15-24), female"
	
	lab var b3_a1 "Life expectancy at birth, female"
	lab var b3_a2 "Life expectancy at birth, male"
	lab var b5_a1 "Adult unemployment (% ages 25+), female"
	lab var b5_a2 "Adult unemployment (% ages 25+), male"
	lab var b6_a1 "Adult informal employment (% ages 25+), female"
	lab var b6_a2 "Adult informal employment (% ages 25+), male"	
	
	drop m 
	rename _j gyear
	aorder 
	order gyear l* e* h* b*	
	
	/* Guarda excel para tener a mano de qué años son los indicadores */
	
	export excel using "$data_output\frequency_latest.xlsx", replace firstrow(varlabels)				
				
				
					
									