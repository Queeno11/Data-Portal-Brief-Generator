*------------------------------------------------------------------------------*
*					 RUN ALL - SCRIPT for FULL PROCESSING					   
*------------------------------------------------------------------------------*

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
	

	*Gender: 0=total, 1=male, 2=female	
	replace code = code + "_m" if gender==1
	replace code = code + "_f" if gender==2
	
	keep wbcode code name year source description units rank gender topic stage_life
	
	rename name lbl
	rename code name
	rename units age
	rename description def
	
	collapse (mean) year, by(wbcode name lbl age def source rank gender topic stage_life)
	save "$data_processed\metadata_briefs", replace

	
*---------------------------Best ranked indicators------------------------------*	

	frame create top_ranked_indicators
	frame change top_ranked_indicators
	use "$data_processed\metadata_processed", replace

	keep if rank==1 | (stage_life=="Adulthood and Elderly" & dimension=="Labor" & rank==2)  | (stage_life=="Prenatal and Early Childhood" & dimension=="Health" & rank==2)
	duplicates drop name_portal, force
	gen category = 1 if stage_life == "Prenatal and Early Childhood"
	replace category = 2 if stage_life == "School-aged Children"
	replace category = 3 if stage_life == "Youth"
	replace category = 4 if stage_life == "Adulthood and Elderly"
	save "$data_processed\top_ranked_indicators", replace

	frame change default
	
*-----------------------------Stages of life-------------------------------*	
	*FIXME: ESTO YA ESTÁ DIRECTAMENTE EN EL EXCEL. CHEQUEAR QUE COINCIDAN CON LAS DE ACÁ UNA POR UNA:

	*replace stage_life = "Adulthood and Elderly" if strpos(code,"sp_dyn")
	*replace stage_life = "Adulthood and Elderly" if strpos(code,"ncd")
	*replace stage_life = "Prenatal and Early Childhood " if strpos(code,"uisger02")
	*replace stage_life = "School-aged Children" if strpos(code,"uisxg")
	*replace stage_life = "Youth" if strpos(code,"caremother")
	*replace stage_life = "Youth" if strpos(code,"mmrt")
	*replace stage_life = "Youth" if strpos(code,"uiscr3")
	*replace stage_life = "Adulthood and Elderly" if strpos(code,"_health") & strpos(code,"basic_")
	*replace stage_life = "Prenatal and Early Childhood " if code=="unicef_sanitation"|code=="unicef_water"|code=="unicef_hygiene"
	
	*replace topic = "Health" if strpos(code,"_school") & strpos(code,"basic_")
	
	*replace name = "Teachers with at least minimum academic qualifications, primary (%)" if code=="uisqutp1"
	*replace name = "Teachers with at least minimum academic qualifications, secondary (%)" if code=="uisqutp2t3"
	
	*--Eliminar los que no quedaron seleccionados en la lista--*
	*drop if inlist(code,"uisger01","unicef_stunting","unicef_u5mort","psurv")
	*drop if inlist(code,"test","qeyrs","eyrs","test_m","test_f","qeyrs_m","qeyrs_f","eyrs_m","eyrs_f")
	*drop if inlist(code,"nostu","psruv","nostu_m","nostu_f","psurv_m","psurv_f")
	*drop if inlist(code,"eip_2wap_y","eip_2wap_y_m","eip_2wap_y_f","eip_2plf_y","eip_2plf_y_m","eip_2plf_y_f","luu_2lu4_mf_y","luu_2lu4_mf_y_m","luu_2lu4_mf_y_f")
	*drop if inlist(code,"eip_2wap_a","eip_2wap_a_m","eip_2wap_a_f","eip_2plf_a","eip_2plf_a_m","eip_2plf_a_f","luu_2lu4_mf_a","luu_2lu4_mf_a_m","luu_2lu4_mf_a_f")
	*drop if inlist(code,"asr","asr_m","asr_f","hci","hci_m","hci_f")
	*drop if inlist(code,"hci_upper","hci_upper_m","hci_upper_f","hci_lower","hci_lower_m","hci_lower_f")
	
	

	**********************************2) INDICATORS*********************************

	/* This section aims to rank and assign indicators to countries. */

	*----------------------------Load data---------------------------------*
	
	/**** Agregar vars nuevas acá ****/
	
	use "$data_output\data_briefs_allcountries", clear

	* Genero lista con las variables "indicadores" y "indicadores_year" 
	global indicyear ""
	global indic ""
	foreach var of varlist * {
		if strpos("`var'", "_year") > 0 {
			global indicyear "$indicyear `var'" // Adds to prev global
			local var_no_year : subinstr local var "_year" "" // Removes _prev from name
			global indic "$indic `var_no_year'" // Adds to nselect global
		}
	}

	keep wbcode $indic $indicyear

	rename * v_*
	/* Para 3 variables lo hago manualmente, porque el codigo del indicador termina en _y, y se confunde con el _y del año
	rename (v_eip_neet_mf_y_y v_emp_nifl_y_y v_une_2eap_mf_y_y)(vy_eip_neet_mf_y vy_emp_nifl_y vy_une_2eap_mf_y)
	rename (v_eip_neet_mf_y v_emp_nifl_y v_une_2eap_mf_y)(v_eip_neet_mf_xx v_emp_nifl_xx v_une_2eap_mf_xx) */
	rename v_*_year vy_*
	rename v_*_year_prev py_* 
	rename v_*_prev p_*

	* rename (v_eip_neet_mf_xx v_emp_nifl_xx v_une_2eap_mf_xx)(v_eip_neet_mf_y v_emp_nifl_y v_une_2eap_mf_y)
	rename v_wbcode wbcode

	reshape long v_ vy_ p_ py_, i(wbcode) string
	
	rename _j name

	*------------------------Labels, info & rank---------------------------*
	
	merge m:1 wbcode name using "$data_processed\metadata_briefs", keep(1 3) nogen
	gen category = 1 if stage_life=="Prenatal and Early Childhood"
	replace category = 2 if stage_life=="School-aged Children"
	replace category = 3 if stage_life=="Youth"
	replace category = 4 if stage_life=="Adulthood and Elderly"
				
	drop if missing(v_) | v_==0
	replace rank=. if rank==0 // rank==0 means HCI indicator, that should not be shown in second page brief
	replace rank=. if vy_<2018 // FIXME: ver de agregar que haya también dato previo para comparar
	sort wbcode category topic gender rank 
	bysort wbcode category topic gender: gen arank = _n + rank - rank // (+ rank - rank) to make arank missing when rank is missing
	
	*----------------------Selection of indicators-------------------------*
	
	/*
	Para cada stage y topic:
	1) Si tenemos todos los indicadores, entonces elegimos el mejor para ese stage y topic (min(arank))
	2) Si no hay indicadores, paso el loop al siguiente topic del MISMO STAGE:
		2.A) Si encuentra para los otros topic del mismo stage, elijo el mejor indicador de entre los otros topic (p. ej. si falta en "Labor", elijo el de menor rank entre "Health" y "Education"). Si empatan, elijo Health que es la que más tiene.
			3.A) Si siguen faltando indicadores, voy a las aperturas por género.
		2.B) Si encuentra para solo uno de los otros topic, elige 3 según arank del unico topic disponible
			3.B) Si siguen faltando indicadores, voy a las aperturas por género.
		2.C) Si no hay indicadores para el stage. Hago un display en rojo (espero que no pase)
	*/
	

	*** Selecting main indicator for each stage and dimension
	**Arank == 1 means that such indicator is the selected one for that country, stage_life and topic (with gender==0).	
	
	* Create duumy to flag selected indicators
	bysort wbcode category topic gender: gen selected_indicator = 1 if arank==1 & gender==0
	
	*Check which countries has indicators for each dimension-topic.
	bysort wbcode category topic: egen has_indic = min(selected_indicator) 
	// If has_indic==., then such country has no indicator for that dimension-topic pair.
	
	gen inv_year = 2500-vy_
	
	*** Selecting second best indicator for each stage (taking from other dimensions of the same stage)
	* Create dataset to store the countries not fulfilling the 3 indicators per stage_life
	frame create no_data_countries  
	frame change no_data_countries
	set obs 1
	gen wbcode = ""
	gen stage_of_life = .
	gen selected_indicators = .
	frame change default

	
	* Loop for each country and stage. 
	* Explanaiton: The loop tries to get the top ranked indicator for each dimension in a stage of life (for a certain country). If the
	*	country doesnt have any indicator for that dimension, then select the best ranked indicator for that stage of life among the other
	*	dimensions. If no result comes from that, adds the top indicator for the dimension with a missing value (no country value will be 
	*	shown in the graphs)
	levelsof(wbcode), local(countries)
	levelsof(category), local(categories)
	levelsof(topic), local(topics)
	foreach country in `countries' {
		display "`country'"
		foreach category in `categories' {
			foreach topic in `topics' {
				qui count if wbcode=="`country'" & category==`category' & topic=="`topic'" & selected_indicator==1
				local selected_indicators = r(N)
				qui count if wbcode=="`country'" & category==`category' & selected_indicator!=1
				local available_indicators = r(N)
				if `selected_indicators'==0 & `available_indicators'>=1 {
					// In this case, the dimension-topic has no indicator and we have other indicators available, 				
					// therefore we complete the brief with the best ranked indicator of the hole stage

					// Little trick to get the position of the best ranked indicator 
					//	(best ranked of every other topic, if tie, then the newer)
					sort rank inv_year
					gen position = _n if wbcode=="`country'" & category==`category' & selected_indicator!=1 & gender==0
					egen min_position = min(position) if wbcode=="`country'" & category==`category' & selected_indicator!=1 & gender==0
					replace selected_indicator = 1 if min_position == position & position !=.
					drop position min_position
				}
			}
			// Verificación sobre si tenemos todo o si sigubeen faltando indicadores
			qui count if wbcode=="`country'" & category==`category' & selected_indicator==1
			local selected_indicators = r(N)
			qui count if wbcode=="`country'" & category==`category' & selected_indicator!=1
			local available_indicators = r(N)

			if `selected_indicators' !=3 {
				// When not enought indicators store the country name and the stage with lack of data in an alternative dataframe - only for reporting
				display in red "Para `country' no hay 3 indicadores para la stage `category'"

				frame change no_data_countries
				expand 2 in 1
				replace wbcode = "`country'" in 1
				replace stage_of_life = `category' in 1 
				replace selected_indicators = `selected_indicators' in 1
				frame change default
	
			}

			local i = 1

			while `selected_indicators' <3  {
				// Create observation with one of the best ranked indicators for the dimension	
				// FIXME: now it only choses one arbitrarily, but it should chose an indicator from the other dimensions of the same stage
				frame change top_ranked_indicators
				use "$data_processed\top_ranked_indicators", clear
				keep if category==`category'
			
				sort rank
				local name = name_portal[`i']
				local lbl = name[`i']
				local rank = rank[`i']
				frame change default
				display "`name' `lbl' `rank'"

				count
				local new_q_obs   = r(N) + 1
				set obs `new_q_obs'
				replace name = "`name'" if _n==_N
				replace lbl = "`lbl'" if _n==_N
				replace rank = `rank' if _n==_N
				replace gender = 0 if _n==_N
				replace wbcode = "`country'" if _n==_N
				replace year = 2023 if _n==_N
				replace category = `category' if _n==_N
				replace selected_indicator = 1 if _n==_N
				display "`name' `lbl' `rank'"
				local i = `i' + 1
				local selected_indicators = `selected_indicators' + 1
			}	
		}
	}
	
	* Save report on data scarcity
	frame change no_data_countries
	drop if selected_indicators == .
	save "${data_output}\briefs_countries_with_no_data_${date}", replace
	frame change default

	* FIXME: Reemplazar por columna en metadata que tenga esta info...
	replace lbl = "Child labor (%), ages 5-17" if name=="child_labor"
	replace lbl = "Minimum meal frequency (%), 6-23 months" if name=="mealfreq"

		
	*---------------------------Keep and reshape---------------------------*
	
	/**** Si los labels llegan a quedar demasiado largos para los gráficos, ir al principio de este do file y editar (con replace) los labels para que sean más cortos --> no cambiar en la data original del data portal. La gracia es que los labels nuevos queden en el dta metadata, así más adelante cuando mergamos ese dta, nos pasa bien los labels que queremos.  ****/
	
	drop if selected_indicator!=1
	drop year py_
	tostring vy_, gen(year)
	
	* Create show order based on main rank (more relevant indicators shown first)
	sort rank
	bysort wbcode category: gen show_order = _n

	
	keep wbcode name lbl category year age sou def show_order
	rename (name lbl year  age sou def)(name_ lbl_ year_ age_ sou_ def_)
	reshape wide name_ lbl_ year_ age_ sou_ def_, i(wbcode show_order) j(category)
	rename * *_
	rename (wbcode_ show_order_)(wbcode show_order)
	reshape wide name_1_ year_1_ lbl_1_ age_1_ sou_1_ def_1_ name_2_ year_2_ lbl_2_ age_2_ sou_2_ def_2_ name_3_ year_3_ lbl_3_ age_3_ sou_3_ def_3_ name_4_ year_4_ lbl_4_ age_4_ sou_4_ def_4_, i(wbcode) j(show_order)	
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
	gen lc = ""
	gen lcl = "l"
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
	rename l locals
	save "$data_output\new_locals", replace
	br 
	
	/* Copiar todos los locals y pegar en el siguiente do file */ 
			
* FIXME: Este análisis guardarlo aparte para que corra más prolijo.
			
/*			
			
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
				
				
					
									