*------------------------------------------------------------------------------*
*--------------------------------------Graphs----------------------------------*
*------------------------------------------------------------------------------*

* Fonts required; https://badnoise.net/TypeRip/
clear all
set more off	
set graph off

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

** Version 2024: Keep all countries 

* Remove observations with no HCCI
ds wbcode wbcountry* wbregion wbincomegroup incomegroup hci* psurv* eyrs* test* qeyrs* asr* nostu* uhci* *_reg *_inc, not
local hcci = r(varlist)
egen has_hcci = rownonmiss(`hcci')
// drop if has_hcci == 0 // Kosovo is the only case
drop has_hcci


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
graph set window fontface "Arial"
set scheme s2color
sort wbregion wbcode
gen onesvec=0

*--------------------------Locals for page 1--------------------------*

* Note: if you change the number of indicators (for example, add c9) you also need to:
*	1) Add the label on lc9
*	2) Add to the graph combine the new chart
*	3) Add the erase
local c1 hci
local c2 psurv
local c3 eyrs
local c4 qeyrs
local c5 test
local c6 asr
local c7 nostu
local c8 uhci

local lc1 "Human Capital Index"
local lc2 "Probability of Survival to Age 5 (%)"
local lc3 "Expected Years of School"
local lc4 "Learning-Adjusted Years of School"
local lc5 "Average Harmonized Test Scores" 
local lc6 "Survival Rate from Age 15-60 (%)"
local lc7 "Fraction of Children Under 5 Not Stunted (%)"
local lc8 "Utilization-Adjusted Human Capital Index"

local cc1 black // "15 119 157"
local cc2 black
local cc3 black
local cc4 black
local cc5 black
local cc6 black
local cc7 black
local cc8 black // "15 119 157"
	
	
*----------------------------Loop on countries-----------------------------*

*--------------------------Loop on countries---------------------------*

/* Loop with all countries */
foreach i of local obs {
	*Unmute to run only one or some countries /
//    	if !inlist(wbcode[`i'], "AUS", "ARG", "AFG", "ETH", "CAN", "JPN") continue
	qui capture {
	*Unmute if the code suddenly stop to avoid generating all again*
	local ct=wbcode[`i']
	local graph_file "$charts\p1_`ct'_all.pdf"
// 	capture confirm file "`graph_file'"
// 	if (_rc == 601 ) continue
	
	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	local income2=incomegroup in `i'
	local country=wbcountrynameb in `i'	
	noi display "`country'"
		
	*-------------------------------FORMATS--------------------------------*
	* Markers
	local reg_marker_fmt = "msymbol(D) mlc(black) mfcolor(reddish)"
	local inc_marker_fmt = "msymbol(S) mlc(black) mfcolor(orangebrown)"
	local country_marker_fmt = "mlabcolor(edkblue) mlabposition(12) mlc(black) mfcolor(sky)"
	local time_marker_fmt = "msymbol(S) mlc(black)"
	* Legendsize(size(12pt) 12pt) 
    local legend_text_ops = "linegap(1.9) placement(east) justification(left)"

    local country_pos = 0.6 // top - its y axis
    local reg_pos = 0 // bottom
    local inc_pos = 0 // bottom
	local time_pos = 0 // bottom
    local first_col_marker_pos = 0.05 // left - its x axis
    local first_col_text_pos = `first_col_marker_pos' + 0.055
    local second_col_marker_pos = `first_col_marker_pos' + 1.95
    local second_col_text_pos = `second_col_marker_pos' + 0.055


// 	*------------------------------First page------------------------------*
//	
// 	/* With available data - automatic */
//
// 	qui forvalues m = 1(1)`nc' {
//	
// 		qui sum `c`m'' if wbcode=="`ctry'"		
// 		scalar ctry_value = `=scalar(r(mean))'
// 		gen obs_`c`m'' = 1 if `=scalar(r(N))'>0
// 		replace obs_`c`m'' = 0 if `=scalar(r(N))'==0
// 		replace obs_`c`m'' = 0 if `c`m''[`i']==0
//
// 		qui su `c`m'', d
// 		scalar max`c`m'' = ceil(`=scalar(r(max))') 	
// 		scalar min`c`m'' = floor(`=scalar(r(min))') 
//					
// 		* --- Fix scale for...
// 		*	 health indicators
// 		if (`m'==2 | `m'==6 | `m'==7) & ((`=scalar(ctry_value)'<= 100) | (`=scalar(ctry_value)'==.)){
// 			scalar max`c`m'' = 100
// 			if `m'==6 {
// 				scalar min`c`m'' = 50
// 			}
// 		}
// 		*	 test scores
// 		if `m'==5 {
// 			scalar max`c`m'' = 625 	
// 			scalar min`c`m'' = 300 
// 		}
// 		*	 years of school
// 		if `m'==3 | `m'==4 {
// 			scalar max`c`m'' = 14	
// 			scalar min`c`m'' = 0
// 		}
//
// 		* --- Markers format...
// 		if `m'==1 | `m'==8 {
// 			local this_country_marker_fmt = "`country_marker_fmt' mlabformat(%8.2f)"
// 		}
// 		else{ // Why there's no elif in stata :(
// 			if `m'==3 | `m'==4 {
// 				local this_country_marker_fmt = "`country_marker_fmt' mlabformat(%8.1f)"
// 			}
// 			else {
// 				local this_country_marker_fmt = "`country_marker_fmt' mlabformat(%8.0f)"
// 			}
// 		}
//
//
// 		if obs_`c`m'' != 0 {
//	
// 			drop obs_`c`m''
// 			* If we have data for the hci
// 			twoway ///
// 			(scatter onesvec `c`m'' if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(32pt) mlabel(`c`m'') mlabsize(22pt) mlabgap(4pt) `this_country_marker_fmt') ///
// 			(scatter onesvec `c`m''_reg if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(16pt) `reg_marker_fmt') /// 
// 			(scatter onesvec `c`m''_inc if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(16pt) `inc_marker_fmt') /// 
// 			, legend(off) fysize(14) title("{fontface Utopia Semibold: `lc`m''}", color(`cc`m'') margin(b=10) size(21pt) pos(11)) xtitle("") ytitle("") yscale(range(0 0.25) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) labgap(2pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'')' `=scalar(max`c`m'')')) xlabel(`=scalar(min`c`m'')' `=scalar(max`c`m'')',labsize(17pt)) xsize(4.4) ysize(1) graphregion(margin(b=5 l=10 r=10)) plotregion(margin(0)) ///
// 			  name(graph_c`m')
// 		}
// 		else {
//	
// 			* If we dont have data, then plot only regional data
// 			twoway ///
// 			(scatter onesvec `c`m''_reg if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(16pt) `reg_marker_fmt') ///
// 			(scatter onesvec `c`m''_inc if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(16pt) `inc_marker_fmt') /// 
// 			, legend(off) fysize(14) title("{fontface Utopia Semibold: `lc`m''}", color(`cc`m'') margin(b=10) size(21pt) pos(11)) xtitle("") ytitle("") yscale(range(0 0.25) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) labgap(2pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'')' `=scalar(max`c`m'')')) xlabel(`=scalar(min`c`m'')' `=scalar(max`c`m'')',labsize(17pt)) xsize(4.4) ysize(1) graphregion(margin(b=5 l=10 r=10)) plotregion(margin(0)) ///
// 			  name(graph_c`m')
// 			drop obs_`c`m''
// 		}
// 	}	
//
//
//		
// 	/* Legend */ 
//	
// 	* Make abreaviation for the legend if it's too long
// 	local full_region_text = "Average for `region'"
// 	if length("`full_region_text'") > 35 {
// 		local region_text = "Avg. for `region'"
// 	}
// 	else {
// 		local region_text = "`full_region_text'"
// 	}
//
// 	local full_income_text = "Average for `income2'"
// 	if length("`full_income_text'") > 40 {
// 		local income_text = "Avg. for `income2'"
// 	}
// 	else {
// 		local income_text = "`full_income_text'"
// 	}
//
//	
//     twoway /// 
//     (scatteri `country_pos' `first_col_marker_pos', msize(11pt) `country_marker_fmt') ///
//     (scatteri `reg_pos'     `first_col_marker_pos', msize(10.2pt) `reg_marker_fmt') ///
//     (scatteri `inc_pos'     `second_col_marker_pos', msize(11pt) `inc_marker_fmt') ///
// 	, graphregion(color(white)) xscale(off) yscale(off) ylabel(0(0)1, nogrid) xlabel(0(0)4) legend(off) ysize(1) fysize(17) ///
// 	  text(`country_pos' `first_col_text_pos'  "{fontface Utopia: Latest Available Data for `country'}", size(16pt) `legend_text_ops') ///
// 	  text(`reg_pos'     `first_col_text_pos'  "{fontface Utopia: `region_text'}", size(16pt) `legend_text_ops') ///
// 	  text(`inc_pos'     `second_col_text_pos' "{fontface Utopia: `income_text'}", size(16pt) `legend_text_ops') ///
//       title("{fontface Utopia Semibold: HCI AND COMPONENTS}", span color("15 119 157") size(30pt) margin(b=3 t=5) pos(12)) ///
// 	  name(notes, replace)
//	
// 	/* Dummy graph */
// 	twoway (scatter onesvec onesvec if onesvec == -999)	, yline(0, lwidth(2pt) lp(solid) lc(black)) legend(off) xtitle("") ytitle("") yscale(off) ylabel(none) xscale(off) graphregion(margin(0)) xsize(4.4) ysize(1) plotregion(margin(0)) fysize(1) ///
// 		name(dummy, replace)
//
// 	/* Title for UHCI*/
//     twoway /// 
//     (scatter onesvec onesvec if hci==-999) ///
// 	, graphregion(color(white)) xscale(off) yscale(off) ylabel(0(0)1, nogrid) xlabel(0(0)4) legend(off) ysize(1) fysize(4) plotregion(margin(0)) ///
// 	  title("{fontface Utopia Semibold: U-HCI}", span color("15 119 157") size(30pt) margin(t=8 b=-5) pos(12)) ///
// 	  name(title2, replace)
//
// 	/* Full Graph */
// 	graph combine notes graph_c1  graph_c2  graph_c3  graph_c4 graph_c5 graph_c6 graph_c7 dummy title2 graph_c8, ///
// 		rows(11) cols(1) xsize(4.4) ysize(8.5) graphregion(fcolor(white) lcolor(black) lwidth(medium) margin(tiny)) 
// 	graph export "$charts\p1_`ctry'_all${extra}.jpg", replace width(3200)

	*------------------------------Second Page-----------------------------*
	local country_pos = 1 // top - its y axis
    local reg_pos = 0 // bottom
    local inc_pos = 0 // bottom
	local time_pos = 0 // bottom
    local first_col_marker_pos = 0.05 // left - its x axis
    local first_col_text_pos = `first_col_marker_pos' + 0.05
    local second_col_marker_pos = `first_col_marker_pos' + 1.85
    local second_col_text_pos = `second_col_marker_pos' + 0.05

	qui foreach x in e b h l {
		forvalues m = 1(1)`n`x'' {
// 			display "local `x'`m'_`ctry' ``x'`m'_`ctry''"
			qui tab ``x'`m'_`ctry'' if wbcode=="`ctry'"		
			gen obs_``x'`m''_`i' = 1 if `=scalar(r(N))'>0
			replace obs_``x'`m''_`i' = 0 if `=scalar(r(N))'==0
			replace obs_``x'`m''_`i' = 0 if ``x'`m'_`ctry''[`i']==0
			replace obs_``x'`m''_`i' = 1 if ``x'`m'_`ctry''[`i']==.
			if obs_``x'`m''_`i' == 0 continue
			drop obs_``x'`m''_`i'
			
			foreach suffix in "_prev" "" {
				capture {
					su ``x'`m'_`ctry''`suffix' if wbregion=="`region'", d
					scalar max``x'`m'_`ctry''`suffix' = ceil(`=scalar(r(max))') 	
					scalar min``x'`m'_`ctry''`suffix' = floor(`=scalar(r(min))') 
				}
				if _rc != 0 {
					* FIXME: aca esta el error de todos los casos. Hay alguna forma de evitar que entre acá?
					scalar max``x'`m'_`ctry''`suffix' = 0
					scalar min``x'`m'_`ctry''`suffix' = .
				}
// 				display "``x'`m'_`ctry''`suffix' `=scalar(max``x'`m'_`ctry''`suffix')'"
			}
			scalar min``x'`m'_`ctry'' = min(`=scalar(min``x'`m'_`ctry'')', `=scalar(min``x'`m'_`ctry''_prev)')
			scalar min``x'`m'_`ctry'' = floor(`=scalar(min``x'`m'_`ctry'')' / 10) * 10
			scalar max``x'`m'_`ctry'' = max(`=scalar(max``x'`m'_`ctry'')', `=scalar(max``x'`m'_`ctry''_prev)')
			scalar max``x'`m'_`ctry'' = ceil(`=scalar(max``x'`m'_`ctry'')' / 10) * 10

			*local xtitle``x'`m'_`ctry'' = "subinstr("`l`x'`m'_`ctry''", "(", ")")"
			twoway ///
			(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(40pt) mlabel(``x'`m'_`ctry'') mlabsize(33pt) mlabgap(6pt) `country_marker_fmt' mlabformat(%8.0f)) ///
			(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(22pt) `reg_marker_fmt') /// 
			(scatter onesvec ``x'`m'_`ctry''_prev if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(20pt) color("245 202 195") `time_marker_fmt') /// 
			, legend(off) title("{fontface Utopia Std Semibold: `l`x'`m'_`ctry''}", color(black) margin(b=11) size(30pt) pos(11))  xtitle("") ytitle("") ///
			  yscale(lcolor(white) range(0 0.5)) ylabel(none) xlabel(,labsize(24pt) labgap(4pt) format(%8.3g))  ///
			  xscale(lwidth(0.6pt) range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')',labsize(28pt)) ///
			  xsize(7) ysize(1.1) graphregion(color(white) margin(b=3)) plotregion(margin(0)) ///
			  name(graph_`ctry'_`x'`m')
		}

	* Make abreaviation for the legend if it's too long
	local full_region_text = "Average for `region'"
	if length("`full_region_text'") > 35 {
		local region_text = "Avg. for `region'"
	}
	else {
		local region_text = "`full_region_text'"
	}

	* Legend
	twoway /// 
		(scatteri `country_pos' `first_col_marker_pos', msize(12pt) `country_marker_fmt') ///
		(scatteri `time_pos'    `first_col_marker_pos', msize(12pt) color("245 202 195") `time_marker_fmt') ///
		(scatteri `reg_pos'     `second_col_marker_pos', msize(12pt) `reg_marker_fmt') ///
		, graphregion(color(white)) plotregion(margin(small)) xscale(off) yscale(off) ylabel(0(0)1, nogrid) xlabel(0(0)4) legend(off) fysize(14) ysize(1.5) ///
		title("{fontface Utopia Std Semibold: HUMAN CAPITAL}" "{fontface Utopia Std Semibold: COMPLEMENTARY INDICATORS}", span color("15 119 157") size(34pt) margin(b=-1 t=0) pos(12) yoffset(2)) ///
		text(`country_pos' `first_col_text_pos'  "{fontface Utopia: Latest available data for `country' (`ctry')}", size(21pt) `legend_text_ops') ///
		text(`time_pos'    `first_col_text_pos'  "{fontface Utopia: `ctry' approx. 5 years before}", size(21pt)  `legend_text_ops') ///
	  	text(`reg_pos'     `second_col_text_pos' "{fontface Utopia: `region_text'}", size(21pt)  `legend_text_ops') ///
		name(notes_`ctry', replace)

	}
	
	/* Combine all graphs by page and export */
	graph combine graph_`ctry'_l1 graph_`ctry'_l2 graph_`ctry'_l3, ///
		rows(3) cols(1) xsize(7) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Std Semibold: EARLY CHILDHOOD}", suffix color("15 119 157") size(23pt) linegap(1) pos(12) span) ///
		name(stage_1, replace)
	graph combine graph_`ctry'_e1 graph_`ctry'_e2 graph_`ctry'_e3, ///
		rows(3) cols(1) xsize(7) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Std Semibold: SCHOOL AGE}", suffix color("15 119 157") size(23pt) linegap(1) pos(12) span) /// 
		name(stage_2, replace)
	graph combine graph_`ctry'_h1 graph_`ctry'_h2 graph_`ctry'_h3, ///
		rows(3) cols(1) xsize(7) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Std Semibold: YOUTH}", suffix color("15 119 157") size(23pt) linegap(1) pos(12) span) ///
		name(stage_3, replace)
	graph combine graph_`ctry'_b1 graph_`ctry'_b2 graph_`ctry'_b3, ///
		rows(3) cols(1) xsize(7) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Std Semibold: ADULTS}", suffix color("15 119 157") size(23pt) linegap(1) pos(12) span) ///
		name(stage_4, replace)
	
	graph combine notes_`ctry' stage_1 stage_2 stage_3 stage_4, rows(5) cols(1) xsize(7) ysize(14) graphregion(fcolor(white) lcolor(black) lwidth(medium))
	/* graph export "$charts\p2_`ctry'_stages.pdf", replace */
	/* graph export "p2_`ctry'_stages.eps", replace */
	graph export "$charts\p2_`ctry'_stages${extra}.png", replace width(3200)
	graph drop _all
	}
	if (_rc == 601 ) display in red "ERROR CON `ct'"
break	
}


/* }	 */