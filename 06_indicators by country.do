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
	use "$data_output\complete_series_wmd_${date}${extra}", replace
	
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

	gen dim_rank=.
	* Early childhood
	replace dim_rank = 1 if category==1 & rank!=. & dimension=="Health"
	replace dim_rank = 2 if category==1 & rank!=. & dimension=="Education"
	replace dim_rank = 3 if category==1 & rank!=. & dimension=="Labor"
	* School-aged children
	replace dim_rank = 1 if category==2 & rank!=. & dimension=="Education"
	replace dim_rank = 2 if category==2 & rank!=. & dimension=="Labor"
	replace dim_rank = 3 if category==2 & rank!=. & dimension=="Health"
	* Youth 
	replace dim_rank = 1 if category==3 & rank!=. & dimension=="Labor"
	replace dim_rank = 2 if category==3 & rank!=. & dimension=="Education"
	replace dim_rank = 3 if category==3 & rank!=. & dimension=="Health"
	* Adulthood and elderly
	replace dim_rank = 1 if category==4 & rank!=. & dimension=="Labor"
	replace dim_rank = 2 if category==4 & rank!=. & dimension=="Health"
	replace dim_rank = 3 if category==4 & rank!=. & dimension=="Education"

	save "$data_processed\top_ranked_indicators", replace
	frame change default


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
	
	merge m:m wbcode name using "$data_processed\metadata_briefs", keep(1 3) nogen
	gen category = 1 if stage_life=="Prenatal and Early Childhood"
	replace category = 2 if stage_life=="School-aged Children"
	replace category = 3 if stage_life=="Youth"
	replace category = 4 if stage_life=="Adulthood and Elderly"
				
	drop if missing(v_) | v_==0
	replace rank=. if rank==0 // rank==0 means HCI indicator, that should not be shown in second page brief
	replace rank=. if vy_<2018 // FIXME: ver de agregar que haya también dato previo para comparar
	sort wbcode category topic gender rank 
	bysort wbcode category topic gender: gen arank = _n + rank - rank if rank!=. // (+ rank - rank) to make arank missing when rank is missing
	gen dim_rank = .
	* Early childhood
	replace dim_rank = 1 if category==1 & rank!=. & topic=="Health"
	replace dim_rank = 2 if category==1 & rank!=. & topic=="Education"
	replace dim_rank = 3 if category==1 & rank!=. & topic=="Labor"
	* School-aged children
	replace dim_rank = 1 if category==2 & rank!=. & topic=="Education"
	replace dim_rank = 2 if category==2 & rank!=. & topic=="Labor"
	replace dim_rank = 3 if category==2 & rank!=. & topic=="Health"
	* Youth 
	replace dim_rank = 1 if category==3 & rank!=. & topic=="Labor"
	replace dim_rank = 2 if category==3 & rank!=. & topic=="Education"
	replace dim_rank = 3 if category==3 & rank!=. & topic=="Health"
	* Adulthood and elderly
	replace dim_rank = 1 if category==4 & rank!=. & topic=="Labor"
	replace dim_rank = 2 if category==4 & rank!=. & topic=="Health"
	replace dim_rank = 3 if category==4 & rank!=. & topic=="Education"
	
	keep if rank!=.
	*----------------------Selection of indicators-------------------------*
	
	gen selected_indicators = .
	gen inv_year = 2500-vy_
	
	frame change default


	* Loop Explanaition:
	* 	For each country and category (stage of life):
	* 	 - Loop over each topic (dimension) and select the highest ranked indicator for such country-category-topic
	*	 - In some cases, there will not be three indicators selected with such loop (there could be lack of data or a stage that only has two dimensions):
	*		- First try to select the highest ranked indicators for the remaining dimensions (sorted by dim_rank)
	*		- Then, if there is no data for the country-category, then populate with the top ranked indicators for the category


	levelsof(wbcode), local(countries)
	levelsof(category), local(categories)
	levelsof(topic), local(topics)

	foreach country in `countries' {
		display "`country'"
		foreach category in `categories' {

			local selected_indicators = ""
			local remaining_indicators = 3

			foreach topic in `topics' {
				
				preserve
				keep if category==`category' & wbcode=="`country'" 

				qui count if topic=="`topic'" & selected_indicator!=1
				local available_indicators = r(N)

				if `available_indicators'>=1 {
					keep if topic=="`topic'"
					sort rank inv_year
					local this_selected_indicator = name // The first position is the highest ranked
					
					local selected_indicators = "`selected_indicators' `this_selected_indicator',"
					local remaining_indicators = `remaining_indicators' - 1

					restore
					
					replace selected_indicators = 1 if category==`category' & wbcode=="`country'" & name=="`this_selected_indicator'"
				}
				else restore
			}

			if `remaining_indicators'!=0 {
				
				*** 1) Si hay data: busco completar con otros indicadores de la misma stage, hasta que se me acaben los indicadores o complete los 3 de la stage
				count if category==`category' & wbcode=="`country'" & selected_indicators!=1
				local available_indicators = r(N)
				while `available_indicators'>0 & `remaining_indicators'>0{
					preserve

					keep if category==`category' & wbcode=="`country'" & selected_indicators!=1 
					sort dim_rank rank inv_year

					local this_selected_indicator = name // The first position is the highest ranked
					local remaining_indicators = `remaining_indicators' - 1
					restore
					
					replace selected_indicators = 1 if category==`category' & wbcode=="`country'" & name=="`this_selected_indicator'"
					count if category==`category' & wbcode=="`country'" & selected_indicators!=1
					local available_indicators = r(N)

				}

				
				***  2) Si no hay data suficiente: completo con el top ranked indicator de las topics que faltan
				if `remaining_indicators'>0 {
					* Store selected indicators in local so they won't be selected in step 2
					levelsof name if category==`category' & wbcode=="`country'" & selected_indicators==1, local(already_selected) separate(,)
					
					frame change top_ranked_indicators
					use "$data_processed\top_ranked_indicators", replace
										
					keep if category==`category'
					if `remaining_indicators'<3 {
						drop if inlist(name_portal, `already_selected')
					}
					local name = ""
					while `remaining_indicators'>0 {
						frame change top_ranked_indicators
						sort dim_rank rank 
						local prev_name = "`name'"
						local name = name_portal
						assert "`name'" != "`prev_name'"
						local lbl = name
						local rank = rank
						drop if name_portal == "`name'"	
						
						* Create new observation with the data of the top_ranked indicator
						frame change default
						display "`name' `lbl' `rank'"
						count
						local new_q_obs = r(N) + 1
						set obs `new_q_obs'
						replace name = "`name'" if _n==_N
						replace lbl = "`lbl'" if _n==_N
						replace rank = `rank' if _n==_N
						replace gender = 0 if _n==_N
						replace wbcode = "`country'" if _n==_N
						replace year = 2023 if _n==_N
						replace category = `category' if _n==_N
						replace selected_indicators = 1 if _n==_N
						display "`name' `lbl' `rank'"
						frame change top_ranked_indicators

						local remaining_indicators = `remaining_indicators' - 1

					}
					
					frame change default
					count if category==`category' & wbcode=="`country'" & selected_indicators==1
					assert r(N)==3
				}
			}
		}
	}
	
	replace py_ = 2015 if py_==.
	replace vy_ = 2020 if vy_==.
	
	*---------------------------Keep and reshape---------------------------*
	
	/**** Si los labels llegan a quedar demasiado largos para los gráficos, ir al principio de este do file y editar (con replace) los labels para que sean más cortos --> no cambiar en la data original del data portal. La gracia es que los labels nuevos queden en el dta metadata, así más adelante cuando mergamos ese dta, nos pasa bien los labels que queremos.  ****/
	
	drop if selected_indicator!=1
	drop year py_
	tostring vy_, gen(year)
	
	* Create show order based on main rank (more relevant indicators shown first)
	gen is_missing = (v_==.)
	sort wbcode category is_missing rank 
	by wbcode category: gen show_order = _n
	
// 		*** Export liststing for data_portal
// 		preserve
// 		keep if show_order==1
// 		keep wbcode name category
// 		reshape wide name, i(wbcode) j(category)
// 		rename (name1 name2 name3 name4) (Prenatal_and_Early_Childhood Schoolaged_Children Youth Adulthood_and_Elderly)
// 		export excel "$data_output/list_bycountry_share.xlsx", replace
// 		restore
// 		****************************************
	
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
	
	/* Copiar todos los locals y pegar en el siguiente do file */ 
		