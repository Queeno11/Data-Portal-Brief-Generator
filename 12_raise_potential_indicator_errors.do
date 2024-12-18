*------------------------------------------------------------------------------*
*-----------------------------------Raise Bugs---------------------------------*
*------------------------------------------------------------------------------*

* Creates excel file where, for the same indicator and the same country, the latest data differs from 5 years ago more
* than 20%.  

clear all
set more off	
set graph off

gl data_output "C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator\Data\Data_Output"
gl data_processed "C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator\Data\Data_Processed"
gl date "26_jul_2024"
*--------------------------Get selected indicators--------------------------*
* This locals are the selected indicators for each country based on the availability of data
* and the indicators ranking. They come from the previous do file.
use "$data_output\new_locals", clear
local n_locals = _N
split locals, limit(1) // Create a column with only the local names
gen is_local = .
display "Generating indicator locals, please wait..."
qui forvalues i  = 1(1)`n_locals' {
	gen selected = .
	replace selected = 1 if _n==`i'
	sort selected is_local
	local name = locals1
	replace locals = subinstr(locals, "`name'", "", .) if selected==1 
	local value = locals
	local `name' `value'
	replace is_local = 1 if selected==1
	drop selected
}
assert mi(is_local)==0
display "Done!"

*--------------------------Start analysis--------------------------*
use "$data_output\data_briefs_allcountries", replace

* Remove observations with no HCI
drop if hci==.
* Remove observations with no HCCI
ds wbcode wbcountryname wbcountrynameb wbcountrynameB wbregion wbincomegroup incomegroup hci* psurv* eyrs* test* qeyrs* asr* nostu* uhci* *_reg *_inc, not
local hcci = r(varlist)
egen has_hcci = rownonmiss(`hcci')
drop if has_hcci == 0 // Kosovo is the only case
drop has_hcci

frame create myexcel
frame change myexcel
gen country = ""
gen indicator_name = ""
gen latest_value = .
gen latest_value_year = .
gen previous_value = .
gen previous_value_year = .
frame change default 

sort wbcode
levelsof wbcode, local(country_list)

levelsof wbcode, local(wb_country_codes) 
display "Generating texts, please wait..."
qui foreach ctry in `wb_country_codes' {
	foreach x in e b h l { // x represents each stage of life
		forvalues m = 1(1)3 { // m represents the number of the indicator

            local indicator ``x'`m'_`ctry''

            gen selected = 1 if wbcode=="`ctry'"
			sort selected // Put current country first so locals are from the current country

            local ind_value = `indicator'
            local ind_value_year = `indicator'_year
			local ind_value_prev = `indicator'_prev
            local ind_value_year_prev = `indicator'_year_prev

            * Compute if the difference is greater than 20%
            local diff = abs(`ind_value' - `ind_value_prev')
            if (`diff'/`ind_value_prev' > 0.5) & (`diff' != .) {
                noi display in red "`ctry': The value of `indicator' for `wbcountryname' in `year' is `ind_value' and the value for `year_prev' is `ind_value_prev'."

                * Store in excel file
                frame change myexcel
                count
                local new_q_obs = r(N) + 1
                set obs `new_q_obs'
                replace country = "`ctry'" if _n==_N
                replace indicator_name = "`indicator'" if _n==_N
                replace latest_value = `ind_value' if _n==_N
                replace latest_value_year = `ind_value_year' if _n==_N
                replace previous_value = `ind_value_prev' if _n==_N
                replace previous_value_year = `ind_value_year_prev' if _n==_N
                frame change default
            }

            drop selected
        }
    }
}

* Potential errors by country
frame change myexcel
export excel "$data_output\potential_indicator_errors_50.xlsx", sheet("by country") firstrow(variables) replace

* Potential errors by indicator
gen difference = latest_value - previous_value
collapse (count) n=difference (p25) p25=difference (median) p50=difference (p75) p75=difference (mean) mean=difference, by(indicator_name)
gsort -n
export excel "$data_output\potential_indicator_errors_50.xlsx", sheet("by indicator") firstrow(variables)


*------------------------------------------------------------------------------*
*------------------------Compare with previous version-------------------------*
*------------------------------------------------------------------------------*


use "$data_output/new_locals_23.dta", clear
split local, gen(code)
split code1, p(_) gen(country)
drop code1
rename (code2 country1 country2) (code position wbcode)
keep wbcode position code
drop if (position=="lb1"|position=="lb2"|position=="lb3"|position=="le1"|position=="le2"|position=="le3"|position=="lh1"|position=="lh2"|position=="lh3"|position=="ll1"|position=="ll2"|position=="ll3")
order wbcode position code
sort wbcode position code
save "$data_output/new_locals_23_clean_${date}.dta", replace

use "$data_output/new_locals.dta", clear
split local, gen(code)
split code1, p(_) gen(country)
drop code1
rename (code2 country1 country2) (code position wbcode)
keep wbcode position code
drop if (position=="lb1"|position=="lb2"|position=="lb3"|position=="le1"|position=="le2"|position=="le3"|position=="lh1"|position=="lh2"|position=="lh3"|position=="ll1"|position=="ll2"|position=="ll3")
order wbcode position code
sort wbcode position code
save "$data_output/new_locals_24_clean_${date}.dta", replace

use "$data_output/new_locals_23_clean_${date}.dta", clear
merge 1:1 wbcode code using "$data_output/new_locals_24_clean_${date}.dta", keep(1 2)
merge m:1 wbcode using "$data_output/data_briefs", keep(3) nogen
rename _merge m
keep wbcode wbcountryname position code m
rename code name_portal
merge m:1 name_portal using "$data_processed/metadata_processed", keep(3) nogen
keep wbcode wbcountryname position m name
reshape wide name, i(wbcode wbcountryname position) j(m)
rename (name1 name2) (v2023 v2024) 
order wbcode wbcountryname position v2023 v2024
foreach num in 1 2 3{
replace position="Early childhood - `num'" if position=="l`num'"
replace position="School age - `num'" if position=="e`num'"
replace position="Youth - `num'" if position=="h`num'"
replace position="Adults - `num'" if position=="b`num'"
}
export excel "$data_output/changes_briefs_${date}.xlsx", first(variables) replace 
* Chequear si hay algun indicador en particular con problemas:
tab code 
* Ver cambios que no se relacionan a emp_2wap:
gen lfp=1 if (code=="emp_2wap_f_a"|code=="emp_2wap_m_a"|code=="emp_2wap_mf_a")
egen has_lfp=sum(lfp), by(wbcode)
keep if has_lfp==0
