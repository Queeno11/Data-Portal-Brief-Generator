*------------------------------------------------------------------------------*
*--------------------------------------Graphs----------------------------------*
*------------------------------------------------------------------------------*

clear all
set more off	
set maxvar 32000

*--------------------------Local for page 2--------------------------*
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

*------------------------------------------------------------------------------*
*-----------------------------------GRAPHS-------------------------------------*
*------------------------------------------------------------------------------*
use "$data_output\data_briefs_allcountries", replace

sort wbcode
count
numlist "1/`r(N)'"
local obs = "`r(numlist)'"
display "`obs'"

local nb 3
local ne 3
local nh 3
local nl 3
local no 3
local nc 8

*---------------------------Graphs configuration---------------------------*

local date: disp %tdCY-m-D date("`c(current_date)'", "DMY")
disp "`date'"
local notetext "Data are preliminary and subject to revision (as of `date')."
graph set window fontface "Baskerville Old Face"
set scheme s2color
sort wbregion wbcode
gen onesvec=1

*--------------------------Locals for page 1--------------------------*

levelsof wbcode, local(wb_country_codes) 
foreach c in `wb_country_codes' {
	* Note: if you change the number of indicators (for example, add c9) you also need to:
	*	1) Add the label on lc9
	*	2) Add to the graph combine the new chart
	*	3) Add the erase
	local c1_`c' hci
	local c2_`c' psurv
	local c3_`c' eyrs
	local c4_`c' test
	local c5_`c' qeyrs
	local c6_`c' asr
	local c7_`c' nostu
	local c8_`c' uhci
	
	local lc1_`c' "Human Capital Index"
	local lc2_`c' "Probability of Survival to Age 5"
	local lc3_`c' "Expected Years of School"
	local lc4_`c' "Harmonized Test Scores"
	local lc5_`c' "Learning-adjusted Years of School"
	local lc6_`c' "Adult Survival Rate"
	local lc7_`c' "Fraction of Children Under 5 Not Stunted"
	local lc8_`c' "Utilization of Human Capital Index"
	
	}
	
*----------------------------Loop on countries-----------------------------*

/* Loop with all countries */
foreach i of local obs {
	/* capture { */
	/* Unmute to run only one or some countries */
	/* if (wbcode[`i'] != "GUM") continue  */
	
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	local income2=incomegroup in `i'
	local country=wbcountryname in `i'	
	display "`country'"
	*------------------------------First page------------------------------*
	
	/* With available data - automatic */

	forvalues m = 1(1)`nc' {
	
		display "obs_`c`m'_`ctry'' c`m'_`ctry'"
		display "local c`m'_`ctry' `c`m'_`ctry''"
		qui tab `c`m'_`ctry'' if wbcode=="`ctry'"		
		gen obs_`c`m'_`ctry'' = 1 if `=scalar(r(N))'>0
		replace obs_`c`m'_`ctry'' = 0 if `=scalar(r(N))'==0
		replace obs_`c`m'_`ctry'' = 0 if `c`m'_`ctry''[`i']==0
		if obs_`c`m'_`ctry'' != 0 {
			* If we have data for the hci
			drop obs_`c`m'_`ctry''
			qui su `c`m'_`ctry'', d
			scalar m1`c`m'_`ctry'' = `=scalar(r(max))'
			scalar m2`c`m'_`ctry'' = `=scalar(r(min))'
			scalar m25`c`m'_`ctry'' = `=scalar(r(p25))'
			scalar m50`c`m'_`ctry'' = `=scalar(r(p50))'
			scalar m75`c`m'_`ctry'' = `=scalar(r(p75))'
			scalar m100`c`m'_`ctry'' = `=scalar(r(p100))'
			scalar dif`c`m'_`ctry'' = `=scalar(m1`c`m'_`ctry'')' - `=scalar(m2`c`m'_`ctry'')'
			scalar max`c`m'_`ctry'' = 20 * ceil(`=scalar(m1`c`m'_`ctry'')'/20) 	
			scalar min`c`m'_`ctry'' = 20 * floor(`=scalar(m2`c`m'_`ctry'')'/20) 
			scalar inter`c`m'_`ctry'' = (`=scalar(max`c`m'_`ctry'')'-`=scalar(min`c`m'_`ctry'')')/2
			
			twoway ///
			(scatter onesvec `c`m'_`ctry'' if `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec `c`m'_`ctry''_reg if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
			(scatter onesvec `c`m'_`ctry''_inc if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			(scatter onesvec `c`m'_`ctry''_prev if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(Oh) mlcolor(reddish) mcolor(reddish) mlwidth(thick)) ///   
			(scatter onesvec `c`m'_`ctry'' if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(solid) mlabel(`c`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(10pt) mlc(black) mfcolor(reddish)) ///
			, legend(off) title("`lc`m'_`ctry''", margin(b=5) size(18pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'_`ctry'')' `=scalar(max`c`m'_`ctry'')')) xlabel(`=scalar(min`c`m'_`ctry'')' (`=scalar(inter`c`m'_`ctry'')') `=scalar(max`c`m'_`ctry'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(small))
			graph save "$charts\graph_`ctry'_c`m'.gph", replace
		}
		else {
			* If we dont have data, then plot only regional data
			qui su `c`m'_`ctry'', d
			scalar m1`c`m'_`ctry'' = `=scalar(r(max))'
			scalar m2`c`m'_`ctry'' = `=scalar(r(min))'
			scalar m25`c`m'_`ctry'' = `=scalar(r(p25))'
			scalar m50`c`m'_`ctry'' = `=scalar(r(p50))'
			scalar m75`c`m'_`ctry'' = `=scalar(r(p75))'
			scalar m100`c`m'_`ctry'' = `=scalar(r(p100))'
			scalar dif`c`m'_`ctry'' = `=scalar(m1`c`m'_`ctry'')' - `=scalar(m2`c`m'_`ctry'')'
			scalar max`c`m'_`ctry'' = 20 * ceil(`=scalar(m1`c`m'_`ctry'')'/20) 	
			scalar min`c`m'_`ctry'' = 20 * floor(`=scalar(m2`c`m'_`ctry'')'/20) 
			scalar inter`c`m'_`ctry'' = (`=scalar(max`c`m'_`ctry'')'-`=scalar(min`c`m'_`ctry'')')/2
			twoway ///
			(scatter onesvec `c`m'_`ctry'' if `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec `c`m'_`ctry''_reg if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(D) mlc(black) mfcolor(sky)) ///
			(scatter onesvec `c`m'_`ctry''_inc if wbcode=="`ctry'" & `c`m'_`ctry'' > 0 & `c`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			, legend(off) title("`lc`m'_`ctry''", margin(b=5) size(18pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'_`ctry'')' `=scalar(max`c`m'_`ctry'')')) xlabel(`=scalar(min`c`m'_`ctry'')' (`=scalar(inter`c`m'_`ctry'')') `=scalar(max`c`m'_`ctry'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(small))
			graph save "$charts\graph_`ctry'_c`m'.gph", replace
			drop obs_`c`m'_`ctry''
		}
	}	
		
	/* Legend */ 
	
	gen m = 0.1
	gen f_`ctry' = 1
	gen g_`ctry' = 1.08 
	gen h_`ctry' = 1.16
	gen i_`ctry' = 1.24
	gen j_`ctry' = 1.32
	gen k_`ctry' = 1.4
	
	/*
	gen m = 0.1
	gen f_`ctry' = 1
	gen g_`ctry' = 1.04 
	gen h_`ctry' = 1.08
	gen i_`ctry' = 1.12
	gen j_`ctry' = 1.16
	gen k_`ctry' = 1.2
	*/
	
	twoway /// 
	(scatter f_`ctry' m, msymbol(Oh) mlabcolor(black) mlabsize(11pt) msymbol(Oh) msize(vlarge) mcolor(dimgray*1.5) mlabposition(3) mlabgap(8pt)) ///
	(scatter g_`ctry' m, msymbol(D) mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(D) msize(vlarge) mcolor(sky) mlabposition(3) mlabgap(8pt)) ///
	(scatter h_`ctry' m, msymbol(s)  mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(S) msize(vlarge) mcolor(orangebrown) mlabposition(3) mlabgap(8pt)) ///
	(scatter i_`ctry' m, msymbol(Oh) mlabcolor(black) mlabsize(11pt) mlc(reddish) msymbol(Oh) msize(vlarge) mlwidth(thick) mlabposition(3) mlabgap(8pt)) ///
	(scatter j_`ctry' m, msymbol(Oh) mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(solid) msize(vlarge) mcolor(reddish) mlabposition(3) mlabgap(6pt)) ///
	(scatter k_`ctry' m, msymbol(Oh) msize(vtiny) mcolor(white) mlabcolor(black) mlabsize(11pt) mlabgap(12pt)), ///
	graphregion(color(white)) xscale(off) yscale(off) xlabel(0(0)4) legend(off) ylabel(,nogrid) ysize(1.8) text(1.205 1.65 "Notes for all figures in this brief:" "represents `country'." "represents `country' approximately 5 years earlier." "represents the average for `income2'." "represents the average for `region'." "represent other countries in the World.", size(12pt) linegap(1.7) justification(left)) 		
	graph save "$charts\notes_`ctry'.gph", replace	
	*graph export "$charts\notes_`ctry'.eps", replace
	
	drop m 

	graph combine "$charts\notes_`ctry'.gph" "$charts\graph_`ctry'_c1.gph"  "$charts\graph_`ctry'_c2.gph"  "$charts\graph_`ctry'_c3.gph"  "$charts\graph_`ctry'_c4.gph" "$charts\graph_`ctry'_c5.gph" "$charts\graph_`ctry'_c6.gph" "$charts\graph_`ctry'_c7.gph" "$charts\graph_`ctry'_c8.gph", rows(9) cols(1) xsize(4.4) ysize(8.8) graphregion(fcolor(white) lcolor(black) lwidth(medium)) 
	graph export "$charts\p1_`ctry'_all.pdf", replace	
	graph export "$charts\p1_`ctry'_all.eps", replace
	graph export "$charts\p1_`ctry'_all.jpg", replace width(1600)

	erase "$charts\graph_`ctry'_c1.gph"
	erase "$charts\graph_`ctry'_c2.gph"
	erase "$charts\graph_`ctry'_c3.gph"
	erase "$charts\graph_`ctry'_c4.gph"
	erase "$charts\graph_`ctry'_c5.gph"
	erase "$charts\graph_`ctry'_c6.gph"
	erase "$charts\graph_`ctry'_c7.gph"
	erase "$charts\graph_`ctry'_c8.gph"
	erase "$charts\notes_`ctry'.gph"

	*------------------------------Second Page-----------------------------*
	
	foreach x in e b h l {
		forvalues m = 1(1)`n`x'' {
			display "local `x'`m'_`ctry' ``x'`m'_`ctry''"
			qui tab ``x'`m'_`ctry'' if wbcode=="`ctry'"		
			gen obs_``x'`m''_`i' = 1 if `=scalar(r(N))'>0
			replace obs_``x'`m''_`i' = 0 if `=scalar(r(N))'==0
			replace obs_``x'`m''_`i' = 0 if ``x'`m'_`ctry''[`i']==0
			replace obs_``x'`m''_`i' = 1 if ``x'`m'_`ctry''[`i']==.
			if obs_``x'`m''_`i' == 0 continue
			drop obs_``x'`m''_`i'
			qui su ``x'`m'_`ctry'', d
			scalar m1``x'`m'_`ctry'' = `=scalar(r(max))'
			scalar m2``x'`m'_`ctry'' = `=scalar(r(min))'
			scalar m25``x'`m'_`ctry'' = `=scalar(r(p25))'
			scalar m50``x'`m'_`ctry'' = `=scalar(r(p50))'
			scalar m75``x'`m'_`ctry'' = `=scalar(r(p75))'
			scalar m100``x'`m'_`ctry'' = `=scalar(r(p100))'
			scalar dif``x'`m'_`ctry'' = `=scalar(m1``x'`m'_`ctry'')' - `=scalar(m2``x'`m'_`ctry'')'
			scalar max``x'`m'_`ctry'' = 20 * ceil(`=scalar(m1``x'`m'_`ctry'')'/20) 	
			scalar min``x'`m'_`ctry'' = 20 * floor(`=scalar(m2``x'`m'_`ctry'')'/20) 
			scalar inter``x'`m'_`ctry'' = (`=scalar(max``x'`m'_`ctry'')'-`=scalar(min``x'`m'_`ctry'')')/2

		// 	capture {
			twoway ///
			(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
			(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			(scatter onesvec ``x'`m'_`ctry''_prev if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(Oh) mlcolor(reddish) mcolor(reddish) mlwidth(thick)) /// 
			(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
			, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
			graph save "$charts\graph_`ctry'_`x'`m'.gph", replace		
		}
		
	// 	if _rc != 0 { 
	// 		twoway ///
	// 		(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
	// 		(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
	// 		(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
	// 		(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
	// 		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
	// 		graph save "$charts\graph_`ctry'_`x'`m'.gph", replace	
	}
	
	/* Combine all graphs by page and export */
	graph combine "$charts\graph_`ctry'_l1.gph" "$charts\graph_`ctry'_l2.gph" "$charts\graph_`ctry'_l3.gph", rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Early Childhood", suffix color(black) size(vlarge) linegap(3) pos(11) span)
	graph save "$charts\stage_1.gph", replace
	graph combine "$charts\graph_`ctry'_e1.gph" "$charts\graph_`ctry'_e2.gph" "$charts\graph_`ctry'_e3.gph", rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("School Age", suffix color(black) size(vlarge) linegap(3) pos(11) span) 
	graph save "$charts\stage_2.gph", replace
	graph combine "$charts\graph_`ctry'_h1.gph" "$charts\graph_`ctry'_h2.gph" "$charts\graph_`ctry'_h3.gph", rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Youth", suffix color(black) size(vlarge) linegap(3) pos(11) span)
	graph save "$charts\stage_3.gph", replace
	graph combine "$charts\graph_`ctry'_b1.gph" "$charts\graph_`ctry'_b2.gph" "$charts\graph_`ctry'_b3.gph", rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Adults & Elderly", suffix color(black) size(vlarge) linegap(3) pos(11) span)
	graph save "$charts\stage_4.gph", replace	
	
	graph combine "$charts\stage_1.gph" "$charts\stage_2.gph" "$charts\stage_3.gph" "$charts\stage_4.gph", rows(4) cols(1) xsize(6) ysize(14) graphregion(fcolor(white) lcolor(black) lwidth(medium))
	graph export "$charts\p2_`ctry'_stages.pdf", replace
	graph export "$charts\p2_`ctry'_stages.eps", replace
	graph export "$charts\p2_`ctry'_stages.jpg", replace width(1600)

	erase "$charts\graph_`ctry'_l1.gph"
	erase "$charts\graph_`ctry'_l2.gph"
	erase "$charts\graph_`ctry'_l3.gph"		
	erase "$charts\graph_`ctry'_e1.gph"
	erase "$charts\graph_`ctry'_e2.gph"
	erase "$charts\graph_`ctry'_e3.gph"		
	erase "$charts\graph_`ctry'_h1.gph"
	erase "$charts\graph_`ctry'_h2.gph"
	erase "$charts\graph_`ctry'_h3.gph"		
	erase "$charts\graph_`ctry'_b1.gph"
	erase "$charts\graph_`ctry'_b2.gph"
	erase "$charts\graph_`ctry'_b3.gph"

	erase "$charts\stage_1.gph" 
	erase "$charts\stage_2.gph" 
	erase "$charts\stage_3.gph"
	erase "$charts\stage_4.gph"

}
/* }	 */