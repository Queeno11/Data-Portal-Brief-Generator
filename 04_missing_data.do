*------------------------------------------------------------------------------*
*									Clean data						   
*------------------------------------------------------------------------------*

	****************************************************************************
	*Unique indicators (without gender disaggregation)
	****************************************************************************
	
	*----------------------------------last 5----------------------------------*
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	keep if inlist(year,2021,2020,2019,2018,2017)
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code)
	collapse (sum) n, by(wbcode)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code)
	collapse (sum) f, by(wbcode)
	rename f f5
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode using `tot', nogen
	merge m:1 wbcode using `ff', nogen
	
	collapse (mean) n f5, by(wbcode wbcountryname wbregion wbincome)
	gen share = f5/n
	gen data_scarcity_5 = 1-share
	
	bysort wbincome: egen data_scarcity_5_inc = mean(data_scarcity_5)
	bysort wbregion: egen data_scarcity_5_reg = mean(data_scarcity_5)
	drop n f5 share
	
	save "$data_processed\data_scarcity_5years", replace
	
	*----------------------------------last 10---------------------------------*
	
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	keep if inlist(year,2021,2020,2019,2018,2017,2016,2015,2014,2013,2012)
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code)
	collapse (sum) n, by(wbcode)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code)
	collapse (sum) f, by(wbcode)
	rename f f10
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode using `tot', nogen
	merge m:1 wbcode using `ff', nogen
	
	collapse (mean) n f10, by(wbcode wbcountryname wbregion wbincome)
	gen share = f10/n
	gen data_scarcity_10 = 1-share
	
	bysort wbincome: egen data_scarcity_10_inc = mean(data_scarcity_10)
	bysort wbregion: egen data_scarcity_10_reg = mean(data_scarcity_10)
	drop n f10 share
	
	save "$data_processed\data_scarcity_10years", replace
	
	*--------------------------------all years---------------------------------*
	
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code)
	collapse (sum) n, by(wbcode)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code)
	collapse (sum) f, by(wbcode)
	rename f fall
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode using `tot', nogen
	merge m:1 wbcode using `ff', nogen
	
	collapse (mean) n fall, by(wbcode wbcountryname wbregion wbincome)
	gen share = fall/n
	gen data_scarcity_all = 1-share
	
	bysort wbincome: egen data_scarcity_all_inc = mean(data_scarcity_all)
	bysort wbregion: egen data_scarcity_all_reg = mean(data_scarcity_all)
	drop n fall share
	
	save "$data_processed\data_scarcity_allyears", replace
	
	*--------------------------------merge all---------------------------------*
	
	use "$data_processed\data_scarcity_allyears", clear
	merge m:1 wbcode using "$data_processed\data_scarcity_10years", nogen
	merge m:1 wbcode using "$data_processed\data_scarcity_5years", nogen
	
	foreach var in 5 10 {
	lab var data_scarcity_`var' "Data scarcity in last `var' years"
	}
	lab var data_scarcity_all "Data scarcity in all available years"
	
	foreach var in 5 10 {
	lab var data_scarcity_`var'_inc "Data scarcity at income group level in last `var' years"
	}
	lab var data_scarcity_all_inc "Data scarcity at income group level in all available years"
	
	foreach var in 5 10 {
	lab var data_scarcity_`var'_reg "Data scarcity at regional level in last `var' years"
	}
	lab var data_scarcity_all_reg "Data scarcity at regional level in all available years"
	
	sort wbcode
	
	* Venezuela is not classified, replace with missing in the income group
	replace data_scarcity_all_inc=. if wbincome==""
    replace data_scarcity_10_inc=. if wbincome==""
	replace data_scarcity_5_inc=. if wbincome==""
	
	save "$data_output\data_scarcity", replace
	export excel "$data_output\data_scarcity.xlsx", firstrow(varlabels) replace
	
	****************************************************************************
	*Unique indicators by gender
	****************************************************************************
	
	*----------------------------------last 5----------------------------------*
	/*
	import excel "$data_output\complete_series_wmd_${date}.xlsx", firstrow clear
	save "$data_output\complete_series_wmd_${date}${extra}", replace
	*/
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	keep if inlist(year,2021,2020,2019,2018,2017)
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code gender)
	collapse (sum) n, by(wbcode gender)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code gender)
	collapse (sum) f, by(wbcode gender)
	rename f f5
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode gender using `tot', nogen
	merge m:1 wbcode gender using `ff', nogen
	
	collapse (mean) n f5, by(wbcode wbcountryname wbregion wbincome gender)
	gen share = f5/n
	gen data_scarcity_5 = 1-share
	
	bysort wbincome gender: egen data_scarcity_5_inc = mean(data_scarcity_5)
	bysort wbregion gender: egen data_scarcity_5_reg = mean(data_scarcity_5)
	drop n f5 share
	
	save "$data_processed\data_scarcity_5years", replace
	
	*----------------------------------last 10---------------------------------*
	
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	keep if inlist(year,2021,2020,2019,2018,2017,2016,2015,2014,2013,2012)
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code gender)
	collapse (sum) n, by(wbcode gender)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code gender)
	collapse (sum) f, by(wbcode gender)
	rename f f10
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode gender using `tot', nogen
	merge m:1 wbcode gender using `ff', nogen
	
	collapse (mean) n f10, by(wbcode wbcountryname wbregion wbincome gender)
	gen share = f10/n
	gen data_scarcity_10 = 1-share
	
	bysort wbincome gender: egen data_scarcity_10_inc = mean(data_scarcity_10)
	bysort wbregion gender: egen data_scarcity_10_reg = mean(data_scarcity_10)
	drop n f10 share
	
	save "$data_processed\data_scarcity_10years", replace
	
	*--------------------------------all years---------------------------------*
	
	use "$data_output\complete_series_wmd_${date}${extra}", clear
	drop description units scale update timespan data stage_life topic source download_link
	
	preserve
	gen n = 1
	collapse (max) n, by(wbcode code gender)
	collapse (sum) n, by(wbcode gender)
	tempfile tot
	save `tot'
	restore
	
	preserve
	gen f = 1 if value!=.
	collapse (max) f, by(wbcode code gender)
	collapse (sum) f, by(wbcode gender)
	rename f fall
	tempfile ff
	save `ff'
	restore
	
	merge m:1 wbcode gender using `tot', nogen
	merge m:1 wbcode gender using `ff', nogen
	
	collapse (mean) n fall, by(wbcode wbcountryname wbregion wbincome gender)
	gen share = fall/n
	gen data_scarcity_all = 1-share
	
	bysort wbincome gender: egen data_scarcity_all_inc = mean(data_scarcity_all)
	bysort wbregion gender: egen data_scarcity_all_reg = mean(data_scarcity_all)
	drop n fall share
	
	save "$data_processed\data_scarcity_allyears", replace
	
	*--------------------------------merge all---------------------------------*
	
	use "$data_processed\data_scarcity_allyears", clear
	merge m:1 wbcode gender using "$data_processed\data_scarcity_10years", nogen
	merge m:1 wbcode gender using "$data_processed\data_scarcity_5years", nogen
	
	foreach var in 5 10 {
	lab var data_scarcity_`var' "Data scarcity in last `var' years"
	}
	lab var data_scarcity_all "Data scarcity in all available years"
	
	foreach var in 5 10 {
	lab var data_scarcity_`var'_inc "Data scarcity at income group level in last `var' years"
	}
	lab var data_scarcity_all_inc "Data scarcity at income group level in all available years"
	
	foreach var in 5 10 {
	lab var data_scarcity_`var'_reg "Data scarcity at regional level in last `var' years"
	}
	lab var data_scarcity_all_reg "Data scarcity at regional level in all available years"
	
	sort wbcode
	
	save "$data_output\data_scarcity_gender", replace
	
	****************************************************************************
	*Income and region
	****************************************************************************
	
	use "$data_output\data_scarcity", clear 
	collapse (mean) data_scarcity_all data_scarcity_10 data_scarcity_5, by(wbincome)
	export excel "$data_output\data_scarcity_reg_inc.xlsx", sheetreplace firstrow(variables) sheet(general_income)
	
	use "$data_output\data_scarcity", clear 
	collapse (mean) data_scarcity_all data_scarcity_10 data_scarcity_5, by(wbregion)
	export excel "$data_output\data_scarcity_reg_inc.xlsx", sheetreplace firstrow(variables) sheet(general_region)
	
	use "$data_output\data_scarcity_gender", clear 
	collapse (mean) data_scarcity_all data_scarcity_10 data_scarcity_5, by(wbincome gender)
	export excel "$data_output\data_scarcity_reg_inc.xlsx", sheetreplace firstrow(variables) sheet(gender_income)
	
	use "$data_output\data_scarcity_gender", clear 
	collapse (mean) data_scarcity_all data_scarcity_10 data_scarcity_5, by(wbregion gender)
	export excel "$data_output\data_scarcity_reg_inc.xlsx", sheetreplace firstrow(variables) sheet(gender_region)