*------------------------------------------------------------------------------*
*---------------------------------Prepare data---------------------------------*
*------------------------------------------------------------------------------*

	
*--------------------------------Load data---------------------------------*

	clear all
	set more off
	set maxvar 32000
	use "$data_output\complete_series_wmd_${date}${extra}", replace
	drop name description units scale update timespan minyear maxyear data source download_link note
	replace code="netenr_ls" if code=="netenrolment_lowersec"

	** Remove gender from variables
	* Familiy Planning
	drop if gender!=2 & code=="met_fam_plan"
	replace gender=0 if code=="met_fam_plan"
	* HCI
	replace code="hci_f" if code=="hci" & gender==2
	replace code="hci_m" if code=="hci" & gender==1
	replace code="uhci_f" if code=="uhci" & gender==2
	replace code="uhci_m" if code=="uhci" & gender==1

	replace gender=0 if code=="hci_f" & gender==2
	replace gender=0 if code=="hci_m" & gender==1
	replace gender=0 if code=="uhci_f" & gender==2
	replace gender=0 if code=="uhci_m" & gender==1

	drop if gender!=0
	drop if missing(gender)
*--------------------------------keep years--------------------------------*

	/* Me quedo con último año disponible */
	gen year2 = year if value!=.
	bysort wbcode wbcountryname code: egen myear = max(year2)
	forvalues m = 1(1)9 {
	gen year_`m' = myear - `m'
	}
	
	/* Chequeo si hay valor para el indicador 1 año atrás, 2 años atrás, etc */
	forvalues m = 1(1)9 {
	gen o = 1 if value!=. & year==year_`m'
	bysort wbcode code: egen ok`m' = max(o) 
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
	replace rank=0 if code=="eyrs"
	replace rank=0 if code=="qeyrs"
	replace rank=0 if code=="test"
	keep if rank != .
	keep if stage_life != ""
	keep if topic != ""
	drop topic stage_life rank
	
	*FIXME
// 	drop if (code=="se_lpv_prim" & missing(value))
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
	*gen gend = "_t" if gender==0
	gen gend = "_t"
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
// 	rename *_prev_f *_f_prev
// 	rename *_prev_m *_m_prev
	
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
// 	rename *_f_year *_f_year
// 	rename *_m_year *_m_year
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

*---------------------------Replace income name----------------------------*
	
	rename wbincome wbincomegroup
	gen incomegroup = wbincomegroup
	replace incomegroup = "High Income countries" if incomegroup == "High income"
	replace incomegroup = "Upper Middle Income countries" if incomegroup == "Upper middle income"
	replace incomegroup = "Lower Middle Income countries" if incomegroup == "Lower middle income"
	replace incomegroup = "Low Income countries" if incomegroup == "Low income"
	
*------------------------------Rename&recode-------------------------------*
	foreach var in asr nostu psurv asr_prev nostu_prev psurv_prev {
		replace `var' = `var'*100
	}
	
*---------------------------------Averages---------------------------------*
	
	foreach var in $nselect { 
	bysort wbincome: egen `var'_inc = mean(`var')
	bysort wbregion: egen `var'_reg = mean(`var')
	}

*------------------------------Clean redundant variables------------------------------*
* Dropeo todas las variables que tienen todo missing
// foreach var of varlist $nselect {
// 	capture assert mi(`var')
// 	if !_rc {
// 	drop `var'
// // 	drop `var'_prev
// // 	drop `var'_year
// // 	drop `var'_yearprev
// 	}
// }
//	
*---------------------------------keep if----------------------------------*
	save "$data_output\data_briefs_allcountries", replace
	
*--------------------------------save data---------------------------------*
	keep if hci!=.
	
	save "$data_output\data_briefs", replace