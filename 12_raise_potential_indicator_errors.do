*------------------------------------------------------------------------------*
*-----------------------------------Raise Bugs---------------------------------*
*------------------------------------------------------------------------------*

* Creates excel file where, for the same indicator and the same country, the latest data differs from 5 years ago more
* than 20%.  

clear all
set more off	
set graph off

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
            if (`diff'/`ind_value_prev' > 0.2) & (`diff' != .) {
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
export excel "$data_output\potential_indicator_errors.xlsx", sheet("by country") firstrow(variables) replace

* Potential errors by indicator
gen difference = latest_value - previous_value
collapse (count) n=difference (p25) p25=difference (median) p50=difference (p75) p75=difference (mean) mean=difference, by(indicator_name)
gsort -n
export excel "$data_output\potential_indicator_errors.xlsx", sheet("by indicator") firstrow(variables)
