*------------------------------------------------------------------------------*
*--------------------------------------Graphs----------------------------------*
*------------------------------------------------------------------------------*

* Fonts required; https://freefontsdownload.net/free-utopia-boldosf-font-149354.htm
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
gen onesvec=0

*--------------------------Locals for page 1--------------------------*

* Note: if you change the number of indicators (for example, add c9) you also need to:
*	1) Add the label on lc9
*	2) Add to the graph combine the new chart
*	3) Add the erase
local c1 hci
local c2 psurv
local c3 eyrs
local c4 test
local c5 qeyrs
local c6 asr
local c7 nostu
local c8 uhci

local lc1 "HUMAN CAPITAL INDEX"
local lc2 "Fraction of live births that will survive until age 5"
local lc3 "Expected Years of School"
local lc4 "Average Harmonized Test Score"
local lc5 "Learning-Adjusted Years of School"
local lc6 "Fraction of 15-year-olds that will survive until age 60"
local lc7 "Fraction of Children Under 5 Not Stunted"
local lc8 "UTILIZATION-ADJUSTED HUMAN CAPITAL INDEX"

local cc1 "15 119 157"
local cc2 black
local cc3 black
local cc4 black
local cc5 black
local cc6 black
local cc7 black
local cc8 "15 119 157"
	
	
*----------------------------Loop on countries-----------------------------*

*--------------------------Loop on countries---------------------------*

/* Loop with all countries */
foreach i of local obs {
	*Unmute to run only one or some countries /
	/* if !inlist(wbcode[`i'], "AFG", "AUS", "ESP", "ISL", "ARG") continue  */
	*Unmute if the code suddenly stop to avoid generating all again*
	local ct=wbcode[`i']
	local graph_file "$charts\p1_`ct'_all.pdf"
// 	capture confirm file "`graph_file'"
// 	if (_rc == 601 ) continue

	local ctry=wbcode in `i'
	local region=wbregion in `i'
	local income=wbincomegroup in `i'
	local income2=incomegroup in `i'
	local country=wbcountryname in `i'	
	display "`country'"
		
	*-------------------------------FORMATS--------------------------------*
	* Markers
	local reg_marker_fmt = "msymbol(D) mlc(black) mfcolor(sky)"
	local inc_marker_fmt = "msymbol(S) mlc(black) mfcolor(orangebrown)"
	local country_marker_fmt = "mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlc(black) mfcolor(reddish)"
	local time_marker_fmt = "msymbol(S) mlc(black)"
	* Legendsize(size(12pt) 12pt) 
    local legend_text_ops = "linegap(1.9) placement(east) justification(left)"

    local country_pos = 1 // top - its y axis
    local reg_pos = 0 // bottom
    local inc_pos = 0 // bottom
	local time_pos = 0 // bottom
    local first_col_marker_pos = 0 // left - its x axis
    local first_col_text_pos = `first_col_marker_pos' + 0.07
    local second_col_marker_pos = `first_col_marker_pos' + 2.1
    local second_col_text_pos = `first_col_marker_pos' + 2.17


	*------------------------------First page------------------------------*
	
	/* With available data - automatic */

	qui forvalues m = 1(1)`nc' {
	
		qui tab `c`m'' if wbcode=="`ctry'"		
		gen obs_`c`m'' = 1 if `=scalar(r(N))'>0
		replace obs_`c`m'' = 0 if `=scalar(r(N))'==0
		replace obs_`c`m'' = 0 if `c`m''[`i']==0
		if obs_`c`m'' != 0 {
			* If we have data for the hci
			drop obs_`c`m''
			qui su `c`m'', d
			scalar m1`c`m'' = `=scalar(r(max))'
			scalar m2`c`m'' = `=scalar(r(min))'
			scalar m25`c`m'' = `=scalar(r(p25))'
			scalar m50`c`m'' = `=scalar(r(p50))'
			scalar m75`c`m'' = `=scalar(r(p75))'
			scalar m100`c`m'' = `=scalar(r(p100))'
			scalar dif`c`m'' = `=scalar(m1`c`m'')' - `=scalar(m2`c`m'')'
			scalar max`c`m'' = ceil(`=scalar(m1`c`m'')') 	
			scalar min`c`m'' = floor(`=scalar(m2`c`m'')') 
			scalar inter`c`m'' = (`=scalar(max`c`m'')'-`=scalar(min`c`m'')')/2
			
			if `m'==1 | `m'==8 {
				local country_marker_fmt = "mlabcolor(reddish) mlabposition(12) mlabformat(%8.2f) mlc(black) mfcolor(reddish)"
			}
			else {
				local country_marker_fmt = "mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlc(black) mfcolor(reddish)"
			}

			twoway ///
			/// (scatter onesvec `c`m'' if `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec `c`m'' if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(20pt) mlabel(`c`m'') mlabsize(12pt) `country_marker_fmt') ///
			(scatter onesvec `c`m''_reg if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(12pt) `reg_marker_fmt') /// 
			(scatter onesvec `c`m''_inc if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(12pt) `inc_marker_fmt') /// 
			/// (scatter onesvec `c`m''_prev if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(13pt) msymbol(Oh) mlcolor(reddish) mcolor(reddish) mlwidth(thick)) ///   
			, legend(off) title("{fontface Utopia Semibold: `lc`m''}", color(`cc`m'') margin(b=0) size(15pt) pos(11)) xtitle("") ytitle("") yscale(range(0 0.25) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) labgap(2pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'')' `=scalar(max`c`m'')')) xlabel(`=scalar(min`c`m'')' `=scalar(max`c`m'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(b=5)) plotregion(margin(0)) ///
			  name(graph_c`m')
		}
		else {
			* If we dont have data, then plot only regional data
			qui su `c`m'', d
			scalar m1`c`m'' = `=scalar(r(max))'
			scalar m2`c`m'' = `=scalar(r(min))'
			scalar m25`c`m'' = `=scalar(r(p25))'
			scalar m50`c`m'' = `=scalar(r(p50))'
			scalar m75`c`m'' = `=scalar(r(p75))'
			scalar m100`c`m'' = `=scalar(r(p100))'
			scalar dif`c`m'' = `=scalar(m1`c`m'')' - `=scalar(m2`c`m'')'
			scalar max`c`m'' = 20 * ceil(`=scalar(m1`c`m'')'/20) 	
			scalar min`c`m'' = 20 * floor(`=scalar(m2`c`m'')'/20) 
			scalar inter`c`m'' = (`=scalar(max`c`m'')'-`=scalar(min`c`m'')')/2
			twoway ///
			/// (scatter onesvec `c`m'' if `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec `c`m''_reg if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(13pt) msymbol(D) mlc(black) mfcolor(sky)) ///
			(scatter onesvec `c`m''_inc if wbcode=="`ctry'" & `c`m'' > 0 & `c`m'' <=`=scalar(r(p100))', msize(13pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			, legend(off) title("{fontface Utopia Semibold: `lc`m''}", color(`cc`m'') margin(b=0) size(15pt) pos(11)) xtitle("") ytitle("") yscale(range(0 0.25) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) labgap(2pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min`c`m'')' `=scalar(max`c`m'')')) xlabel(`=scalar(min`c`m'')' `=scalar(max`c`m'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(b=5)) plotregion(margin(0)) ///
			  name(graph_c`m')
			drop obs_`c`m''
		}
	}	
		
	/* Legend */ 
	
	* Make abreaviation for the legend if it's too long
	local full_region_text = "Average for `region'."
	if length("`full_region_text'") > 35 {
		local region_text = "Avg. for `region'."
	}
	else {
		local region_text = "`full_region_text'"
	}

	local full_income_text = "Average for `income2'."
	if length("`full_income_text'") > 40 {
		local income_text = "Avg. for `income2'."
	}
	else {
		local income_text = "`full_income_text'"
	}

	
    twoway /// 
    (scatteri `country_pos' `first_col_marker_pos', msize(8pt) `country_marker_fmt') ///
    (scatteri `reg_pos'     `first_col_marker_pos', msize(8pt) `reg_marker_fmt') ///
    (scatteri `inc_pos'     `second_col_marker_pos', msize(8pt) `inc_marker_fmt') ///
	, graphregion(color(white)) xscale(off) yscale(off) ylabel(0(0)1, nogrid) xlabel(0(0)4) legend(off) ysize(1) fysize(14) ///
	  text(`country_pos' `first_col_text_pos'  "{fontface Utopia: Latest Available Data for `country'.}", size(11pt) `legend_text_ops') ///
	  text(`reg_pos'     `first_col_text_pos'  "{fontface Utopia: `region_text'}", size(11pt) `legend_text_ops') ///
	  text(`inc_pos'     `second_col_text_pos' "{fontface Utopia: `income_text'}", size(11pt) `legend_text_ops') ///
      title("{fontface Utopia Semibold: HCI AND COMPONENTS}", span color("15 119 157") size(22pt) margin(b=3) pos(12)) ///
	  name(notes, replace)
	
	graph combine notes graph_c1  graph_c2  graph_c3  graph_c4 graph_c5 graph_c6 graph_c7 graph_c8, ///
		rows(9) cols(1) xsize(4.4) ysize(8.3) graphregion(fcolor(white) lcolor(black) lwidth(medium)) 
	/* graph export "$charts\p1_`ctry'_all.pdf", replace	 */
	graph export "$charts\p1_`ctry'_all${extra}.jpg", replace width(3200)

	*------------------------------Second Page-----------------------------*
	
	local country_marker_fmt = "mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlc(black) mfcolor(reddish)"

	qui foreach x in e b h l {
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
			
			*local xtitle``x'`m'_`ctry'' = "subinstr("`l`x'`m'_`ctry''", "(", ")")"
			twoway ///
			(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(36pt) mlabel(``x'`m'_`ctry'') mlabsize(23pt) `country_marker_fmt') ///
			(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(20pt) `reg_marker_fmt') /// 
			/// (scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
			/// (scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			(scatter onesvec ``x'`m'_`ctry''_prev if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(20pt) color("245 202 195") `time_marker_fmt') /// 
			, legend(off) title("{fontface Utopia Semibold: `l`x'`m'_`ctry''}", color(black) margin(b=0) size(24pt) pos(11))  xtitle("") ytitle("") yscale(range(0 0.5) lcolor(white)) ylabel(none) xlabel(,labsize(19pt) labgap(4pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(b=3)) plotregion(margin(0)) ///
			  name(graph_`ctry'_`x'`m')
		}

	* Make abreaviation for the legend if it's too long
	local full_region_text = "Average for `region'."
	if length("`full_region_text'") > 35 {
		local region_text = "Avg. for `region'."
	}
	else {
		local region_text = "`full_region_text'"
	}

	* Legend
	twoway /// 
		(scatteri `country_pos' `first_col_marker_pos', msize(12pt) `country_marker_fmt') ///
		(scatteri `time_pos'    `first_col_marker_pos', msize(12pt) color("245 202 195") `time_marker_fmt') ///
		(scatteri `reg_pos'     `second_col_marker_pos', msize(12pt) `reg_marker_fmt') ///
		, graphregion(color(white)) xscale(off) yscale(off) ylabel(0(0)1, nogrid) xlabel(0(0)4) legend(off) fysize(14) ysize(1) ///
		text(`country_pos' `first_col_text_pos'  "{fontface Utopia: Latest Available Data for `country'.}", size(15pt) `legend_text_ops') ///
		text(`time_pos'    `first_col_text_pos'  "{fontface Utopia: Country ~5 years before.}", size(15pt)  `legend_text_ops') ///
	  	text(`reg_pos'     `second_col_text_pos' "{fontface Utopia: `region_text'}", size(15pt)  `legend_text_ops') ///
		title("{fontface Utopia Semibold: HC COMPLEMENTARY INDICATORS}", span color("15 119 157") size(30pt) margin(b=3) pos(12)) ///
		name(notes_`ctry', replace)

		
	// 	if _rc != 0 { 
	// 		twoway ///
	// 		(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
	// 		(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
	// 		(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
	// 		(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
	// 		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
	// 		graph save "$charts\graph_`ctry'_`x'`m'.gph", replace	
	}
	
	/* Combine all graphs by page and export */
	graph combine graph_`ctry'_l1 graph_`ctry'_l2 graph_`ctry'_l3, ///
		rows(5) cols(1) xsize(6) ysize(5) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Semibold: EARLY CHILDHOOD}", suffix color("15 119 157") size(18pt) linegap(3) pos(12) span) ///
		name(stage_1, replace)
	graph combine graph_`ctry'_e1 graph_`ctry'_e2 graph_`ctry'_e3, ///
		rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Semibold: SCHOOL AGE}", suffix color("15 119 157") size(18pt) linegap(3) pos(12) span) /// 
		name(stage_2, replace)
	graph combine graph_`ctry'_h1 graph_`ctry'_h2 graph_`ctry'_h3, ///
		rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Semibold: YOUTH}", suffix color("15 119 157") size(18pt) linegap(3) pos(12) span) ///
		name(stage_3, replace)
	graph combine graph_`ctry'_b1 graph_`ctry'_b2 graph_`ctry'_b3, ///
		rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) ///
		title("{fontface Utopia Semibold: ADULTS & ELDERLY}", suffix color("15 119 157") size(18pt) linegap(3) pos(12) span) ///
		name(stage_4, replace)
	
	graph combine notes_`ctry' stage_1 stage_2 stage_3 stage_4, rows(5) cols(1) xsize(6) ysize(14) graphregion(fcolor(white) lcolor(black) lwidth(medium))
	/* graph export "$charts\p2_`ctry'_stages.pdf", replace */
	/* graph export "p2_`ctry'_stages.eps", replace */
	graph export "$charts\p2_`ctry'_stages${extra}.jpg", replace width(3200) quality(100)
	graph drop _all
}


/* }	 */