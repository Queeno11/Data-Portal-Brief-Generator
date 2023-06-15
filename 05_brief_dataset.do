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
	drop topic stage_life rank
	
	/* Hago el reshape para que quede en variables separadas y así poder usar los mismos locals del do file de gráficos */
	reshape wide year value, i(wbcode wbcountryname wbregion wbincome gender code) j(orderr)
	collapse (max) year0 value0 year1 value1, by(wbcode wbcountryname wbregion wbincome gender code)
	drop if year1<2015
	rename year1 year
	rename year0 prevyear
	rename value1 value
	rename value0 pv

*---------------------------------Reshape----------------------------------*

	/* Hago reshape por código (me quedan los códigos como variables) */		
	reshape wide value pv, i(wbcode wbcountryname wbregion wbincome year prevyear gender) j(code) string
	rename value* * 
	rename pv* *_prev
		
	/* Hago reshape por género */ 
	* Seteo variable genero para tener el sufijo despues del reshape
	gen gend = "_t" if gender==0
	replace gend = "_m" if gender==1
	replace gend = "_f" if gender==2
	drop gender
	
	* Genero lista con las variables que quiero mantener para los briefs
	qui describe, varlist
	local vars `r(varlist)'
	local exclude_vars wbcode wbcountryname wbregion wbincome year prevyear gend
	global indicators : list vars - exclude_vars
	
	reshape wide $indicators, i(wbcode wbcountryname wbregion wbincome year prevyear) j(gend) string
	rename *_t *
	rename *_prev_f *_f_prev
	rename *_prev_m *_m_prev
	


	* Genero lista con las variables "prev" y "nselect" (no prev)
	global prev ""
	global nselect ""
	foreach var of varlist * {
		if strpos("`var'", "_prev") > 0 {
			global prev "$prev `var'" // Adds to prev global
			local var_no_prev : subinstr local var "_prev" "" // Removes _prev from name
			global nselect "$nselect `var_no_prev'" // Adds to nselect global
		}
	}
		
	/* Genero variables de año */
	foreach var in $nselect {
		gen `var'_year = year if `var'!=.
	}
	drop year
	
	foreach var in $prev {
		gen `var'_year = prevyear if `var'!=.
	}
	rename *_prev_year *_year_prev
	
	* Genero global con todos los indicadores + años
	global indicator_years = ""
	foreach var of varlist * {
		if strpos("`var'", "_year") > 0 {
			global indicator_years "$indicator_years `var'" 
		}
	}
	drop prevyear
	global all_indicators_years = "$indicator_years $nselect $prev"
	
	/* Así me queda solo 1 obs por cada wbcode wbcountryname wbregion wbincome */
	collapse (max) $all_indicators_years, by(wbcode wbcountryname wbregion wbincome)


*---------------------------Replace country name---------------------------*
	// FIXME: this can be probably corrected directly on the countries data
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
	// FIXME: check if this can be done without hardcoding
	foreach var in asr asr_m asr_f hci hci_m hci_f hci_lower hci_lower_f hci_lower_m hci_upper hci_upper_m hci_upper_f nostu nostu_f nostu_m psurv psurv_m psurv_f asr_prev asr_m_prev asr_f_prev hci_prev hci_m_prev hci_f_prev hci_lower_prev hci_lower_f_prev hci_lower_m_prev hci_upper_prev hci_upper_m_prev hci_upper_f_prev nostu_prev nostu_f_prev nostu_m_prev psurv_prev psurv_m_prev psurv_f_prev {
		replace `var' = `var'*100
	}
	
*---------------------------------Averages---------------------------------*
	
	foreach var in $nselect { 
	bysort wbincome: egen `var'_inc = mean(`var')
	bysort wbregion: egen `var'_reg = mean(`var')
	}

*------------------------------Clean redundant variables------------------------------*
* Dropeo todas las variables que tienen todo missing
	foreach var of varlist _all {
		capture assert mi(`var')
		if !_rc {
		drop `var'
		}
	}
	
*---------------------------------keep if----------------------------------*
	save "$data_output\data_briefs_allcountries", replace
	
*--------------------------------save data---------------------------------*
	keep if hci!=.
	
	save "$data_output\data_briefs", replace