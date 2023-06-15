*------------------------------------------------------------------------------*
*--------------------------------------Graphs----------------------------------*
*------------------------------------------------------------------------------*
	
	*--------------------------------Load data---------------------------------*
	
		clear all
		set more off	
		set maxvar 32000
		use "$data_output\data_briefs_allcountries", replace
		
*------------------------------------------------------------------------------*
*-----------------------------------GRAPHS-------------------------------------*
*------------------------------------------------------------------------------*
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
		local nc 7
		
	*---------------------------Graphs configuration---------------------------*
	
		local date: disp %tdCY-m-D date("`c(current_date)'", "DMY")
		disp "`date'"
		local notetext "Data are preliminary and subject to revision (as of `date')."
		graph set window fontface "Baskerville Old Face"
		set scheme s2color
		sort wbregion wbcode
		gen onesvec=1
	
	*--------------------------Local names by country--------------------------*
		
		/**** Paste locals from do file 2 here ****/
		
		{
		
		local l1_AFG care
		local ll1_AFG "Postnatal contact with a health provider within 2 days of delivery"
		local l2_AFG neomort
		local ll2_AFG "Mortality rate, neonatal (per 1,000 live births)"
		local l3_AFG u5_anaemia
		local ll3_AFG "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_AFG mort514
		local le1_AFG "Mortality rate (children aged 5 to 14 years)"
		local e2_AFG Child labor (%), ages 5-17
		local le2_AFG "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_AFG uiscr1
		local le3_AFG "Primary school completion (%) "
		local h1_AFG lastnm_afr
		local lh1_AFG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AFG eip_neet_mf_y
		local lh2_AFG "Youth NEET (%), ages 15-24"
		local h3_AFG uiscr3
		local lh3_AFG "Completion rate, upper secondary education (%)"
		local b1_AFG sp_dyn_le00_in
		local lb1_AFG "Life expectancy at birth (years)"
		local b2_AFG emp_nifl_a
		local lb2_AFG "Adult informal employment rate (%), ages 25+"
		local b3_AFG une_2eap_mf_a
		local lb3_AFG "Unemployment (%), ages 25+"
		local l1_AGO u5_anaemia
		local ll1_AGO "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_AGO vacHEPB3
		local ll2_AGO "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l3_AGO neomort
		local ll3_AGO "Mortality rate, neonatal (per 1,000 live births)"
		local e1_AGO eyrs
		local le1_AGO "Expected Years of School"
		local e2_AGO uisxgdpfsgov
		local le2_AGO "Government expenditure on education (% GPD)"
		local e3_AGO mort514
		local le3_AGO "Mortality rate (children aged 5 to 14 years)"
		local h1_AGO lastnm_afr
		local lh1_AGO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AGO uiscr3
		local lh2_AGO "Completion rate, upper secondary education (%)"
		local h3_AGO une_2eap_mf_y
		local lh3_AGO "Youth unemployment (%), ages 15-24"
		local b1_AGO une_2eap_mf_a
		local lb1_AGO "Unemployment (%), ages 25+"
		local b2_AGO sp_dyn_le00_in
		local lb2_AGO "Life expectancy at birth (years)"
		local b3_AGO probdeath_ncd
		local lb3_AGO "Cause of death, by non-communicable diseases (% of total)"
		local l1_ALB neomort
		local ll1_ALB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ALB u5_anaemia
		local ll2_ALB "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_ALB uisger02
		local ll3_ALB "School enrollment, preprimary (% gross)"
		local e1_ALB se_lpv_prim
		local le1_ALB "Learning Poverty"
		local e2_ALB uiscr1
		local le2_ALB "Primary school completion (%) "
		local e3_ALB mort514
		local le3_ALB "Mortality rate (children aged 5 to 14 years)"
		local h1_ALB eip_neet_mf_y
		local lh1_ALB "Youth NEET (%), ages 15-24"
		local h2_ALB lastnm_afr
		local lh2_ALB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ALB lastnm_ter_ger
		local lh3_ALB "School enrollment, tertiary (% gross)"
		local b1_ALB sp_dyn_le00_in
		local lb1_ALB "Life expectancy at birth (years)"
		local b2_ALB probdeath_ncd
		local lb2_ALB "Cause of death, by non-communicable diseases (% of total)"
		local b3_ALB une_2eap_mf_a
		local lb3_ALB "Unemployment (%), ages 25+"
		local l1_ARE u5_anaemia
		local ll1_ARE "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_ARE uisger02
		local ll2_ARE "School enrollment, preprimary (% gross)"
		local l3_ARE neomort
		local ll3_ARE "Mortality rate, neonatal (per 1,000 live births)"
		local e1_ARE uiscr1
		local le1_ARE "Primary school completion (%) "
		local e2_ARE mort514
		local le2_ARE "Mortality rate (children aged 5 to 14 years)"
		local e3_ARE b_hygiene_sch
		local le3_ARE "Proportion of schools with basic hygiene services"
		local h1_ARE lastnm_afr
		local lh1_ARE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ARE lastnm_ter_ger
		local lh2_ARE "School enrollment, tertiary (% gross)"
		local h3_ARE une_2eap_mf_y
		local lh3_ARE "Youth unemployment (%), ages 15-24"
		local b1_ARE probdeath_ncd
		local lb1_ARE "Cause of death, by non-communicable diseases (% of total)"
		local b2_ARE sp_dyn_le00_in
		local lb2_ARE "Life expectancy at birth (years)"
		local b3_ARE une_2eap_mf_a
		local lb3_ARE "Unemployment (%), ages 25+"
		local l1_ARG u5_anaemia
		local ll1_ARG "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_ARG uisger02
		local ll2_ARG "School enrollment, preprimary (% gross)"
		local l3_ARG neomort
		local ll3_ARG "Mortality rate, neonatal (per 1,000 live births)"
		local e1_ARG uiscr1
		local le1_ARG "Primary school completion (%) "
		local e2_ARG mort514
		local le2_ARG "Mortality rate (children aged 5 to 14 years)"
		local e3_ARG se_lpv_prim
		local le3_ARG "Learning Poverty"
		local h1_ARG lastnm_afr
		local lh1_ARG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ARG eip_neet_mf_y
		local lh2_ARG "Youth NEET (%), ages 15-24"
		local h3_ARG uiscr3
		local lh3_ARG "Completion rate, upper secondary education (%)"
		local b1_ARG emp_nifl_a
		local lb1_ARG "Adult informal employment rate (%), ages 25+"
		local b2_ARG une_2eap_mf_a
		local lb2_ARG "Unemployment (%), ages 25+"
		local b3_ARG sp_dyn_le00_in
		local lb3_ARG "Life expectancy at birth (years)"
		local l1_ARM uisger02
		local ll1_ARM "School enrollment, preprimary (% gross)"
		local l2_ARM u5_anaemia
		local ll2_ARM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_ARM neomort
		local ll3_ARM "Mortality rate, neonatal (per 1,000 live births)"
		local e1_ARM mort514
		local le1_ARM "Mortality rate (children aged 5 to 14 years)"
		local e2_ARM se_lpv_prim
		local le2_ARM "Learning Poverty"
		local e3_ARM uiscr1
		local le3_ARM "Primary school completion (%) "
		local h1_ARM eip_neet_mf_y
		local lh1_ARM "Youth NEET (%), ages 15-24"
		local h2_ARM lastnm_afr
		local lh2_ARM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ARM uiscr3
		local lh3_ARM "Completion rate, upper secondary education (%)"
		local b1_ARM sp_dyn_le00_in
		local lb1_ARM "Life expectancy at birth (years)"
		local b2_ARM b_water_health
		local lb2_ARM "Proportion of health care facilities with basic water services"
		local b3_ARM une_2eap_mf_a
		local lb3_ARM "Unemployment (%), ages 25+"
		local l1_ATG uisger02
		local ll1_ATG "School enrollment, preprimary (% gross)"
		local l2_ATG neomort
		local ll2_ATG "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ATG u5_anaemia
		local ll3_ATG "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_ATG uiscr1
		local le1_ATG "Primary school completion (%) "
		local e2_ATG mort514
		local le2_ATG "Mortality rate (children aged 5 to 14 years)"
		local e3_ATG b_hygiene_sch
		local le3_ATG "Proportion of schools with basic hygiene services"
		local h1_ATG mort1524
		local lh1_ATG "Mortality rate (children aged 15 to 24 years)"
		local h2_ATG lastnm_afr
		local lh2_ATG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ATG uisqutp2t3
		local lh3_ATG "Qualified teachers in secondary education (%)"
		local b1_ATG refugees
		local lb1_ATG "Refugees under UNHCR’s mandate"
		local b2_ATG sp_dyn_le00_in
		local lb2_ATG "Life expectancy at birth (years)"
		local b3_ATG probdeath_ncd
		local lb3_ATG "Cause of death, by non-communicable diseases (% of total)"
		local l1_AUS u5_anaemia
		local ll1_AUS "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_AUS neomort
		local ll2_AUS "Mortality rate, neonatal (per 1,000 live births)"
		local l3_AUS uisger02
		local ll3_AUS "School enrollment, preprimary (% gross)"
		local e1_AUS mort514
		local le1_AUS "Mortality rate (children aged 5 to 14 years)"
		local e2_AUS lastnm_sec_ger
		local le2_AUS "School enrollment, secondary (% gross)"
		local e3_AUS b_hygiene_sch
		local le3_AUS "Proportion of schools with basic hygiene services"
		local h1_AUS une_2eap_mf_y
		local lh1_AUS "Youth unemployment (%), ages 15-24"
		local h2_AUS lastnm_ter_ger
		local lh2_AUS "School enrollment, tertiary (% gross)"
		local h3_AUS lastnm_afr
		local lh3_AUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_AUS sp_dyn_le00_in
		local lb1_AUS "Life expectancy at birth (years)"
		local b2_AUS une_2eap_mf_a
		local lb2_AUS "Unemployment (%), ages 25+"
		local b3_AUS emp_nifl_a
		local lb3_AUS "Adult informal employment rate (%), ages 25+"
		local l1_AUT u5_anaemia
		local ll1_AUT "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_AUT neomort
		local ll2_AUT "Mortality rate, neonatal (per 1,000 live births)"
		local l3_AUT uisger02
		local ll3_AUT "School enrollment, preprimary (% gross)"
		local e1_AUT lastnm_sec_ger
		local le1_AUT "School enrollment, secondary (% gross)"
		local e2_AUT mort514
		local le2_AUT "Mortality rate (children aged 5 to 14 years)"
		local e3_AUT uiscr1
		local le3_AUT "Primary school completion (%) "
		local h1_AUT lastnm_afr
		local lh1_AUT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AUT lastnm_ter_ger
		local lh2_AUT "School enrollment, tertiary (% gross)"
		local h3_AUT une_2eap_mf_y
		local lh3_AUT "Youth unemployment (%), ages 15-24"
		local b1_AUT une_2eap_mf_a
		local lb1_AUT "Unemployment (%), ages 25+"
		local b2_AUT probdeath_ncd
		local lb2_AUT "Cause of death, by non-communicable diseases (% of total)"
		local b3_AUT sp_dyn_le00_in
		local lb3_AUT "Life expectancy at birth (years)"
		local l1_AZE u5_anaemia
		local ll1_AZE "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_AZE neomort
		local ll2_AZE "Mortality rate, neonatal (per 1,000 live births)"
		local l3_AZE uisger02
		local ll3_AZE "School enrollment, preprimary (% gross)"
		local e1_AZE b_hygiene_sch
		local le1_AZE "Proportion of schools with basic hygiene services"
		local e2_AZE mort514
		local le2_AZE "Mortality rate (children aged 5 to 14 years)"
		local e3_AZE uiscr1
		local le3_AZE "Primary school completion (%) "
		local h1_AZE une_2eap_mf_y
		local lh1_AZE "Youth unemployment (%), ages 15-24"
		local h2_AZE lastnm_afr
		local lh2_AZE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_AZE uiscr3
		local lh3_AZE "Completion rate, upper secondary education (%)"
		local b1_AZE b_water_health
		local lb1_AZE "Proportion of health care facilities with basic water services"
		local b2_AZE une_2eap_mf_a
		local lb2_AZE "Unemployment (%), ages 25+"
		local b3_AZE sp_dyn_le00_in
		local lb3_AZE "Life expectancy at birth (years)"
		local l1_BDI uisger02
		local ll1_BDI "School enrollment, preprimary (% gross)"
		local l2_BDI neomort
		local ll2_BDI "Mortality rate, neonatal (per 1,000 live births)"
		local l3_BDI u5_anaemia
		local ll3_BDI "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_BDI uiscr1
		local le1_BDI "Primary school completion (%) "
		local e2_BDI se_lpv_prim
		local le2_BDI "Learning Poverty"
		local e3_BDI mort514
		local le3_BDI "Mortality rate (children aged 5 to 14 years)"
		local h1_BDI une_2eap_mf_y
		local lh1_BDI "Youth unemployment (%), ages 15-24"
		local h2_BDI uiscr3
		local lh2_BDI "Completion rate, upper secondary education (%)"
		local h3_BDI lastnm_afr
		local lh3_BDI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BDI une_2eap_mf_a
		local lb1_BDI "Unemployment (%), ages 25+"
		local b2_BDI probdeath_ncd
		local lb2_BDI "Cause of death, by non-communicable diseases (% of total)"
		local b3_BDI sp_dyn_le00_in
		local lb3_BDI "Life expectancy at birth (years)"
		local l1_BEL neomort
		local ll1_BEL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BEL uisger02
		local ll2_BEL "School enrollment, preprimary (% gross)"
		local l3_BEL u5_anaemia
		local ll3_BEL "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_BEL mort514
		local le1_BEL "Mortality rate (children aged 5 to 14 years)"
		local e2_BEL lastnm_sec_ger
		local le2_BEL "School enrollment, secondary (% gross)"
		local e3_BEL b_hygiene_sch
		local le3_BEL "Proportion of schools with basic hygiene services"
		local h1_BEL lastnm_ter_ger
		local lh1_BEL "School enrollment, tertiary (% gross)"
		local h2_BEL une_2eap_mf_y
		local lh2_BEL "Youth unemployment (%), ages 15-24"
		local h3_BEL lastnm_afr
		local lh3_BEL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BEL une_2eap_mf_a
		local lb1_BEL "Unemployment (%), ages 25+"
		local b2_BEL probdeath_ncd
		local lb2_BEL "Cause of death, by non-communicable diseases (% of total)"
		local b3_BEL sp_dyn_le00_in
		local lb3_BEL "Life expectancy at birth (years)"
		local l1_BEN neomort
		local ll1_BEN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BEN uisger02
		local ll2_BEN "School enrollment, preprimary (% gross)"
		local l3_BEN Minimum meal frequency (%), 6-23 months
		local ll3_BEN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_BEN mort514
		local le1_BEN "Mortality rate (children aged 5 to 14 years)"
		local e2_BEN se_lpv_prim
		local le2_BEN "Learning Poverty"
		local e3_BEN Child labor (%), ages 5-17
		local le3_BEN "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_BEN uiscr3
		local lh1_BEN "Completion rate, upper secondary education (%)"
		local h2_BEN lastnm_afr
		local lh2_BEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BEN eip_neet_mf_y
		local lh3_BEN "Youth NEET (%), ages 15-24"
		local b1_BEN une_2eap_mf_a
		local lb1_BEN "Unemployment (%), ages 25+"
		local b2_BEN probdeath_ncd
		local lb2_BEN "Cause of death, by non-communicable diseases (% of total)"
		local b3_BEN sp_dyn_le00_in
		local lb3_BEN "Life expectancy at birth (years)"
		local l1_BFA uisger02
		local ll1_BFA "School enrollment, preprimary (% gross)"
		local l2_BFA Minimum meal frequency (%), 6-23 months
		local ll2_BFA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BFA neomort
		local ll3_BFA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BFA mort514
		local le1_BFA "Mortality rate (children aged 5 to 14 years)"
		local e2_BFA se_lpv_prim
		local le2_BFA "Learning Poverty"
		local e3_BFA uiscr1
		local le3_BFA "Primary school completion (%) "
		local h1_BFA eip_neet_mf_y
		local lh1_BFA "Youth NEET (%), ages 15-24"
		local h2_BFA uiscr3
		local lh2_BFA "Completion rate, upper secondary education (%)"
		local h3_BFA lastnm_afr
		local lh3_BFA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BFA b_water_health
		local lb1_BFA "Proportion of health care facilities with basic water services"
		local b2_BFA sp_dyn_le00_in
		local lb2_BFA "Life expectancy at birth (years)"
		local b3_BFA une_2eap_mf_a
		local lb3_BFA "Unemployment (%), ages 25+"
		local l1_BGD uisger02
		local ll1_BGD "School enrollment, preprimary (% gross)"
		local l2_BGD Minimum meal frequency (%), 6-23 months
		local ll2_BGD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BGD neomort
		local ll3_BGD "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BGD Child labor (%), ages 5-17
		local le1_BGD "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_BGD uiscr1
		local le2_BGD "Primary school completion (%) "
		local e3_BGD mort514
		local le3_BGD "Mortality rate (children aged 5 to 14 years)"
		local h1_BGD lastnm_afr
		local lh1_BGD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BGD uiscr3
		local lh2_BGD "Completion rate, upper secondary education (%)"
		local h3_BGD une_2eap_mf_y
		local lh3_BGD "Youth unemployment (%), ages 15-24"
		local b1_BGD une_2eap_mf_a
		local lb1_BGD "Unemployment (%), ages 25+"
		local b2_BGD b_water_health
		local lb2_BGD "Proportion of health care facilities with basic water services"
		local b3_BGD sp_dyn_le00_in
		local lb3_BGD "Life expectancy at birth (years)"
		local l1_BGR neomort
		local ll1_BGR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BGR u5_anaemia
		local ll2_BGR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_BGR uisger02
		local ll3_BGR "School enrollment, preprimary (% gross)"
		local e1_BGR uiscr1
		local le1_BGR "Primary school completion (%) "
		local e2_BGR mort514
		local le2_BGR "Mortality rate (children aged 5 to 14 years)"
		local e3_BGR lastnm_sec_ger
		local le3_BGR "School enrollment, secondary (% gross)"
		local h1_BGR une_2eap_mf_y
		local lh1_BGR "Youth unemployment (%), ages 15-24"
		local h2_BGR lastnm_afr
		local lh2_BGR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BGR lastnm_ter_ger
		local lh3_BGR "School enrollment, tertiary (% gross)"
		local b1_BGR probdeath_ncd
		local lb1_BGR "Cause of death, by non-communicable diseases (% of total)"
		local b2_BGR sp_dyn_le00_in
		local lb2_BGR "Life expectancy at birth (years)"
		local b3_BGR une_2eap_mf_a
		local lb3_BGR "Unemployment (%), ages 25+"
		local l1_BHR u5_anaemia
		local ll1_BHR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_BHR neomort
		local ll2_BHR "Mortality rate, neonatal (per 1,000 live births)"
		local l3_BHR uisger02
		local ll3_BHR "School enrollment, preprimary (% gross)"
		local e1_BHR uiscr1
		local le1_BHR "Primary school completion (%) "
		local e2_BHR mort514
		local le2_BHR "Mortality rate (children aged 5 to 14 years)"
		local e3_BHR b_hygiene_sch
		local le3_BHR "Proportion of schools with basic hygiene services"
		local h1_BHR lastnm_ter_ger
		local lh1_BHR "School enrollment, tertiary (% gross)"
		local h2_BHR une_2eap_mf_y
		local lh2_BHR "Youth unemployment (%), ages 15-24"
		local h3_BHR lastnm_afr
		local lh3_BHR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BHR sp_dyn_le00_in
		local lb1_BHR "Life expectancy at birth (years)"
		local b2_BHR probdeath_ncd
		local lb2_BHR "Cause of death, by non-communicable diseases (% of total)"
		local b3_BHR une_2eap_mf_a
		local lb3_BHR "Unemployment (%), ages 25+"
		local l1_BIH uisger02
		local ll1_BIH "School enrollment, preprimary (% gross)"
		local l2_BIH u5_anaemia
		local ll2_BIH "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_BIH neomort
		local ll3_BIH "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BIH mort514
		local le1_BIH "Mortality rate (children aged 5 to 14 years)"
		local e2_BIH uiscr2
		local le2_BIH "Lower secondary completion rate (% of relevant age group)"
		local e3_BIH uiscr1
		local le3_BIH "Primary school completion (%) "
		local h1_BIH lastnm_afr
		local lh1_BIH "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BIH eip_neet_mf_y
		local lh2_BIH "Youth NEET (%), ages 15-24"
		local h3_BIH lastnm_ter_ger
		local lh3_BIH "School enrollment, tertiary (% gross)"
		local b1_BIH une_2eap_mf_a
		local lb1_BIH "Unemployment (%), ages 25+"
		local b2_BIH emp_nifl_a
		local lb2_BIH "Adult informal employment rate (%), ages 25+"
		local b3_BIH sp_dyn_le00_in
		local lb3_BIH "Life expectancy at birth (years)"
		local l1_BLR uisger02
		local ll1_BLR "School enrollment, preprimary (% gross)"
		local l2_BLR Minimum meal frequency (%), 6-23 months
		local ll2_BLR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BLR neomort
		local ll3_BLR "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BLR mort514
		local le1_BLR "Mortality rate (children aged 5 to 14 years)"
		local e2_BLR Child labor (%), ages 5-17
		local le2_BLR "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_BLR uiscr1
		local le3_BLR "Primary school completion (%) "
		local h1_BLR uiscr3
		local lh1_BLR "Completion rate, upper secondary education (%)"
		local h2_BLR eip_neet_mf_y
		local lh2_BLR "Youth NEET (%), ages 15-24"
		local h3_BLR lastnm_afr
		local lh3_BLR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BLR sp_dyn_le00_in
		local lb1_BLR "Life expectancy at birth (years)"
		local b2_BLR probdeath_ncd
		local lb2_BLR "Cause of death, by non-communicable diseases (% of total)"
		local b3_BLR une_2eap_mf_a
		local lb3_BLR "Unemployment (%), ages 25+"
		local l1_BRA uisger02
		local ll1_BRA "School enrollment, preprimary (% gross)"
		local l2_BRA u5_anaemia
		local ll2_BRA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_BRA neomort
		local ll3_BRA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BRA mort514
		local le1_BRA "Mortality rate (children aged 5 to 14 years)"
		local e2_BRA lastnm_sec_ger
		local le2_BRA "School enrollment, secondary (% gross)"
		local e3_BRA se_lpv_prim
		local le3_BRA "Learning Poverty"
		local h1_BRA uiscr3
		local lh1_BRA "Completion rate, upper secondary education (%)"
		local h2_BRA lastnm_afr
		local lh2_BRA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BRA eip_neet_mf_y
		local lh3_BRA "Youth NEET (%), ages 15-24"
		local b1_BRA emp_nifl_a
		local lb1_BRA "Adult informal employment rate (%), ages 25+"
		local b2_BRA sp_dyn_le00_in
		local lb2_BRA "Life expectancy at birth (years)"
		local b3_BRA une_2eap_mf_a
		local lb3_BRA "Unemployment (%), ages 25+"
		local l1_BRN uisger02
		local ll1_BRN "School enrollment, preprimary (% gross)"
		local l2_BRN neomort
		local ll2_BRN "Mortality rate, neonatal (per 1,000 live births)"
		local l3_BRN u5_anaemia
		local ll3_BRN "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_BRN b_hygiene_sch
		local le1_BRN "Proportion of schools with basic hygiene services"
		local e2_BRN mort514
		local le2_BRN "Mortality rate (children aged 5 to 14 years)"
		local e3_BRN uiscr1
		local le3_BRN "Primary school completion (%) "
		local h1_BRN eip_neet_mf_y
		local lh1_BRN "Youth NEET (%), ages 15-24"
		local h2_BRN lastnm_afr
		local lh2_BRN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BRN lastnm_ter_ger
		local lh3_BRN "School enrollment, tertiary (% gross)"
		local b1_BRN sp_dyn_le00_in
		local lb1_BRN "Life expectancy at birth (years)"
		local b2_BRN une_2eap_mf_a
		local lb2_BRN "Unemployment (%), ages 25+"
		local b3_BRN emp_nifl_a
		local lb3_BRN "Adult informal employment rate (%), ages 25+"
		local l1_BTN uisger02
		local ll1_BTN "School enrollment, preprimary (% gross)"
		local l2_BTN u5_anaemia
		local ll2_BTN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_BTN neomort
		local ll3_BTN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BTN lastnm_sec_ger
		local le1_BTN "School enrollment, secondary (% gross)"
		local e2_BTN mort514
		local le2_BTN "Mortality rate (children aged 5 to 14 years)"
		local e3_BTN uiscr1
		local le3_BTN "Primary school completion (%) "
		local h1_BTN une_2eap_mf_y
		local lh1_BTN "Youth unemployment (%), ages 15-24"
		local h2_BTN uiscr3
		local lh2_BTN "Completion rate, upper secondary education (%)"
		local h3_BTN lastnm_afr
		local lh3_BTN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_BTN une_2eap_mf_a
		local lb1_BTN "Unemployment (%), ages 25+"
		local b2_BTN sp_dyn_le00_in
		local lb2_BTN "Life expectancy at birth (years)"
		local b3_BTN b_water_health
		local lb3_BTN "Proportion of health care facilities with basic water services"
		local l1_BWA u5_anaemia
		local ll1_BWA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_BWA vacHEPB3
		local ll2_BWA "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l3_BWA neomort
		local ll3_BWA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_BWA mort514
		local le1_BWA "Mortality rate (children aged 5 to 14 years)"
		local e2_BWA lastnm_sec_ger
		local le2_BWA "School enrollment, secondary (% gross)"
		local e3_BWA uisxgdpfsgov
		local le3_BWA "Government expenditure on education (% GPD)"
		local h1_BWA uiscr3
		local lh1_BWA "Completion rate, upper secondary education (%)"
		local h2_BWA lastnm_afr
		local lh2_BWA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BWA eip_neet_mf_y
		local lh3_BWA "Youth NEET (%), ages 15-24"
		local b1_BWA une_2eap_mf_a
		local lb1_BWA "Unemployment (%), ages 25+"
		local b2_BWA emp_nifl_a
		local lb2_BWA "Adult informal employment rate (%), ages 25+"
		local b3_BWA sp_dyn_le00_in
		local lb3_BWA "Life expectancy at birth (years)"
		local l1_CAF Minimum meal frequency (%), 6-23 months
		local ll1_CAF "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_CAF u5_anaemia
		local ll2_CAF "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CAF neomort
		local ll3_CAF "Mortality rate, neonatal (per 1,000 live births)"
		local e1_CAF mort514
		local le1_CAF "Mortality rate (children aged 5 to 14 years)"
		local e2_CAF Child labor (%), ages 5-17
		local le2_CAF "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_CAF uisxgdpfsgov
		local le3_CAF "Government expenditure on education (% GPD)"
		local h1_CAF uiscr3
		local lh1_CAF "Completion rate, upper secondary education (%)"
		local h2_CAF une_2eap_mf_y
		local lh2_CAF "Youth unemployment (%), ages 15-24"
		local h3_CAF lastnm_afr
		local lh3_CAF "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_CAF probdeath_ncd
		local lb1_CAF "Cause of death, by non-communicable diseases (% of total)"
		local b2_CAF une_2eap_mf_a
		local lb2_CAF "Unemployment (%), ages 25+"
		local b3_CAF sp_dyn_le00_in
		local lb3_CAF "Life expectancy at birth (years)"
		local l1_CAN neomort
		local ll1_CAN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CAN u5_anaemia
		local ll2_CAN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CAN uisger02
		local ll3_CAN "School enrollment, preprimary (% gross)"
		local e1_CAN lastnm_sec_ger
		local le1_CAN "School enrollment, secondary (% gross)"
		local e2_CAN mort514
		local le2_CAN "Mortality rate (children aged 5 to 14 years)"
		local e3_CAN eyrs
		local le3_CAN "Expected Years of School"
		local h1_CAN eip_neet_mf_y
		local lh1_CAN "Youth NEET (%), ages 15-24"
		local h2_CAN lastnm_ter_ger
		local lh2_CAN "School enrollment, tertiary (% gross)"
		local h3_CAN lastnm_afr
		local lh3_CAN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_CAN sp_dyn_le00_in
		local lb1_CAN "Life expectancy at birth (years)"
		local b2_CAN une_2eap_mf_a
		local lb2_CAN "Unemployment (%), ages 25+"
		local b3_CAN probdeath_ncd
		local lb3_CAN "Cause of death, by non-communicable diseases (% of total)"
		local l1_CHE uisger02
		local ll1_CHE "School enrollment, preprimary (% gross)"
		local l2_CHE u5_anaemia
		local ll2_CHE "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CHE neomort
		local ll3_CHE "Mortality rate, neonatal (per 1,000 live births)"
		local e1_CHE b_hygiene_sch
		local le1_CHE "Proportion of schools with basic hygiene services"
		local e2_CHE mort514
		local le2_CHE "Mortality rate (children aged 5 to 14 years)"
		local e3_CHE uiscr1
		local le3_CHE "Primary school completion (%) "
		local h1_CHE lastnm_ter_ger
		local lh1_CHE "School enrollment, tertiary (% gross)"
		local h2_CHE lastnm_afr
		local lh2_CHE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CHE une_2eap_mf_y
		local lh3_CHE "Youth unemployment (%), ages 15-24"
		local b1_CHE une_2eap_mf_a
		local lb1_CHE "Unemployment (%), ages 25+"
		local b2_CHE probdeath_ncd
		local lb2_CHE "Cause of death, by non-communicable diseases (% of total)"
		local b3_CHE sp_dyn_le00_in
		local lb3_CHE "Life expectancy at birth (years)"
		local l1_CHL uisger02
		local ll1_CHL "School enrollment, preprimary (% gross)"
		local l2_CHL u5_anaemia
		local ll2_CHL "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CHL neomort
		local ll3_CHL "Mortality rate, neonatal (per 1,000 live births)"
		local e1_CHL se_lpv_prim
		local le1_CHL "Learning Poverty"
		local e2_CHL mort514
		local le2_CHL "Mortality rate (children aged 5 to 14 years)"
		local e3_CHL uiscr1
		local le3_CHL "Primary school completion (%) "
		local h1_CHL eip_neet_mf_y
		local lh1_CHL "Youth NEET (%), ages 15-24"
		local h2_CHL lastnm_afr
		local lh2_CHL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CHL lastnm_ter_ger
		local lh3_CHL "School enrollment, tertiary (% gross)"
		local b1_CHL une_2eap_mf_a
		local lb1_CHL "Unemployment (%), ages 25+"
		local b2_CHL emp_nifl_a
		local lb2_CHL "Adult informal employment rate (%), ages 25+"
		local b3_CHL sp_dyn_le00_in
		local lb3_CHL "Life expectancy at birth (years)"
		local l1_CHN neomort
		local ll1_CHN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CHN u5_anaemia
		local ll2_CHN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CHN uisger02
		local ll3_CHN "School enrollment, preprimary (% gross)"
		local e1_CHN mort514
		local le1_CHN "Mortality rate (children aged 5 to 14 years)"
		local e2_CHN uisxgdpfsgov
		local le2_CHN "Government expenditure on education (% GPD)"
		local e3_CHN eyrs
		local le3_CHN "Expected Years of School"
		local h1_CHN lastnm_afr
		local lh1_CHN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CHN une_2eap_mf_y
		local lh2_CHN "Youth unemployment (%), ages 15-24"
		local h3_CHN uiscr3
		local lh3_CHN "Completion rate, upper secondary education (%)"
		local b1_CHN sp_dyn_le00_in
		local lb1_CHN "Life expectancy at birth (years)"
		local b2_CHN b_water_health
		local lb2_CHN "Proportion of health care facilities with basic water services"
		local b3_CHN une_2eap_mf_a
		local lb3_CHN "Unemployment (%), ages 25+"
		local l1_CIV neomort
		local ll1_CIV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CIV u5_anaemia
		local ll2_CIV "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CIV uisger02
		local ll3_CIV "School enrollment, preprimary (% gross)"
		local e1_CIV uiscr1
		local le1_CIV "Primary school completion (%) "
		local e2_CIV se_lpv_prim
		local le2_CIV "Learning Poverty"
		local e3_CIV mort514
		local le3_CIV "Mortality rate (children aged 5 to 14 years)"
		local h1_CIV eip_neet_mf_y
		local lh1_CIV "Youth NEET (%), ages 15-24"
		local h2_CIV uiscr3
		local lh2_CIV "Completion rate, upper secondary education (%)"
		local h3_CIV lastnm_afr
		local lh3_CIV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_CIV b_water_health
		local lb1_CIV "Proportion of health care facilities with basic water services"
		local b2_CIV une_2eap_mf_a
		local lb2_CIV "Unemployment (%), ages 25+"
		local b3_CIV sp_dyn_le00_in
		local lb3_CIV "Life expectancy at birth (years)"
		local l1_CMR neomort
		local ll1_CMR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CMR uisger02
		local ll2_CMR "School enrollment, preprimary (% gross)"
		local l3_CMR Minimum meal frequency (%), 6-23 months
		local ll3_CMR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_CMR uiscr1
		local le1_CMR "Primary school completion (%) "
		local e2_CMR se_lpv_prim
		local le2_CMR "Learning Poverty"
		local e3_CMR mort514
		local le3_CMR "Mortality rate (children aged 5 to 14 years)"
		local h1_CMR une_2eap_mf_y
		local lh1_CMR "Youth unemployment (%), ages 15-24"
		local h2_CMR uiscr3
		local lh2_CMR "Completion rate, upper secondary education (%)"
		local h3_CMR lastnm_afr
		local lh3_CMR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_CMR probdeath_ncd
		local lb1_CMR "Cause of death, by non-communicable diseases (% of total)"
		local b2_CMR sp_dyn_le00_in
		local lb2_CMR "Life expectancy at birth (years)"
		local b3_CMR une_2eap_mf_a
		local lb3_CMR "Unemployment (%), ages 25+"
		local l1_COD uisger02
		local ll1_COD "School enrollment, preprimary (% gross)"
		local l2_COD neomort
		local ll2_COD "Mortality rate, neonatal (per 1,000 live births)"
		local l3_COD care
		local ll3_COD "Postnatal contact with a health provider within 2 days of delivery"
		local e1_COD se_lpv_prim
		local le1_COD "Learning Poverty"
		local e2_COD uisxgdpfsgov
		local le2_COD "Government expenditure on education (% GPD)"
		local e3_COD uiscr1
		local le3_COD "Primary school completion (%) "
		local h1_COD lastnm_afr
		local lh1_COD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_COD une_2eap_mf_y
		local lh2_COD "Youth unemployment (%), ages 15-24"
		local h3_COD uiscr3
		local lh3_COD "Completion rate, upper secondary education (%)"
		local b1_COD probdeath_ncd
		local lb1_COD "Cause of death, by non-communicable diseases (% of total)"
		local b2_COD sp_dyn_le00_in
		local lb2_COD "Life expectancy at birth (years)"
		local b3_COD une_2eap_mf_a
		local lb3_COD "Unemployment (%), ages 25+"
		local l1_COG neomort
		local ll1_COG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COG uisger02
		local ll2_COG "School enrollment, preprimary (% gross)"
		local l3_COG u5_anaemia
		local ll3_COG "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_COG uiscr1
		local le1_COG "Primary school completion (%) "
		local e2_COG mort514
		local le2_COG "Mortality rate (children aged 5 to 14 years)"
		local e3_COG se_lpv_prim
		local le3_COG "Learning Poverty"
		local h1_COG mort1524
		local lh1_COG "Mortality rate (children aged 15 to 24 years)"
		local h2_COG lastnm_afr
		local lh2_COG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_COG une_2eap_mf_y
		local lh3_COG "Youth unemployment (%), ages 15-24"
		local b1_COG sp_dyn_le00_in
		local lb1_COG "Life expectancy at birth (years)"
		local b2_COG b_water_health
		local lb2_COG "Proportion of health care facilities with basic water services"
		local b3_COG une_2eap_mf_a
		local lb3_COG "Unemployment (%), ages 25+"
		local l1_COL neomort
		local ll1_COL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COL u5_anaemia
		local ll2_COL "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_COL uisger02
		local ll3_COL "School enrollment, preprimary (% gross)"
		local e1_COL Child labor (%), ages 5-17
		local le1_COL "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_COL mort514
		local le2_COL "Mortality rate (children aged 5 to 14 years)"
		local e3_COL se_lpv_prim
		local le3_COL "Learning Poverty"
		local h1_COL uiscr3
		local lh1_COL "Completion rate, upper secondary education (%)"
		local h2_COL eip_neet_mf_y
		local lh2_COL "Youth NEET (%), ages 15-24"
		local h3_COL lastnm_afr
		local lh3_COL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_COL sp_dyn_le00_in
		local lb1_COL "Life expectancy at birth (years)"
		local b2_COL emp_nifl_a
		local lb2_COL "Adult informal employment rate (%), ages 25+"
		local b3_COL une_2eap_mf_a
		local lb3_COL "Unemployment (%), ages 25+"
		local l1_COM uisger02
		local ll1_COM "School enrollment, preprimary (% gross)"
		local l2_COM u5_anaemia
		local ll2_COM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_COM neomort
		local ll3_COM "Mortality rate, neonatal (per 1,000 live births)"
		local e1_COM eyrs
		local le1_COM "Expected Years of School"
		local e2_COM lastnm_sec_ger
		local le2_COM "School enrollment, secondary (% gross)"
		local e3_COM mort514
		local le3_COM "Mortality rate (children aged 5 to 14 years)"
		local h1_COM uiscr3
		local lh1_COM "Completion rate, upper secondary education (%)"
		local h2_COM lastnm_afr
		local lh2_COM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_COM une_2eap_mf_y
		local lh3_COM "Youth unemployment (%), ages 15-24"
		local b1_COM une_2eap_mf_a
		local lb1_COM "Unemployment (%), ages 25+"
		local b2_COM probdeath_ncd
		local lb2_COM "Cause of death, by non-communicable diseases (% of total)"
		local b3_COM sp_dyn_le00_in
		local lb3_COM "Life expectancy at birth (years)"
		local l1_CRI u5_anaemia
		local ll1_CRI "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_CRI neomort
		local ll2_CRI "Mortality rate, neonatal (per 1,000 live births)"
		local l3_CRI uisger02
		local ll3_CRI "School enrollment, preprimary (% gross)"
		local e1_CRI Child labor (%), ages 5-17
		local le1_CRI "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_CRI se_lpv_prim
		local le2_CRI "Learning Poverty"
		local e3_CRI mort514
		local le3_CRI "Mortality rate (children aged 5 to 14 years)"
		local h1_CRI eip_neet_mf_y
		local lh1_CRI "Youth NEET (%), ages 15-24"
		local h2_CRI lastnm_afr
		local lh2_CRI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CRI uiscr3
		local lh3_CRI "Completion rate, upper secondary education (%)"
		local b1_CRI b_water_health
		local lb1_CRI "Proportion of health care facilities with basic water services"
		local b2_CRI sp_dyn_le00_in
		local lb2_CRI "Life expectancy at birth (years)"
		local b3_CRI une_2eap_mf_a
		local lb3_CRI "Unemployment (%), ages 25+"
		local l1_CYP neomort
		local ll1_CYP "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CYP u5_anaemia
		local ll2_CYP "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_CYP uisger02
		local ll3_CYP "School enrollment, preprimary (% gross)"
		local e1_CYP mort514
		local le1_CYP "Mortality rate (children aged 5 to 14 years)"
		local e2_CYP uiscr1
		local le2_CYP "Primary school completion (%) "
		local e3_CYP se_lpv_prim
		local le3_CYP "Learning Poverty"
		local h1_CYP une_2eap_mf_y
		local lh1_CYP "Youth unemployment (%), ages 15-24"
		local h2_CYP lastnm_afr
		local lh2_CYP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CYP lastnm_ter_ger
		local lh3_CYP "School enrollment, tertiary (% gross)"
		local b1_CYP probdeath_ncd
		local lb1_CYP "Cause of death, by non-communicable diseases (% of total)"
		local b2_CYP sp_dyn_le00_in
		local lb2_CYP "Life expectancy at birth (years)"
		local b3_CYP une_2eap_mf_a
		local lb3_CYP "Unemployment (%), ages 25+"
		local l1_CZE u5_anaemia
		local ll1_CZE "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_CZE uisger02
		local ll2_CZE "School enrollment, preprimary (% gross)"
		local l3_CZE neomort
		local ll3_CZE "Mortality rate, neonatal (per 1,000 live births)"
		local e1_CZE lastnm_sec_ger
		local le1_CZE "School enrollment, secondary (% gross)"
		local e2_CZE uiscr1
		local le2_CZE "Primary school completion (%) "
		local e3_CZE mort514
		local le3_CZE "Mortality rate (children aged 5 to 14 years)"
		local h1_CZE lastnm_afr
		local lh1_CZE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CZE lastnm_ter_ger
		local lh2_CZE "School enrollment, tertiary (% gross)"
		local h3_CZE une_2eap_mf_y
		local lh3_CZE "Youth unemployment (%), ages 15-24"
		local b1_CZE sp_dyn_le00_in
		local lb1_CZE "Life expectancy at birth (years)"
		local b2_CZE b_water_health
		local lb2_CZE "Proportion of health care facilities with basic water services"
		local b3_CZE une_2eap_mf_a
		local lb3_CZE "Unemployment (%), ages 25+"
		local l1_DEU u5_anaemia
		local ll1_DEU "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_DEU neomort
		local ll2_DEU "Mortality rate, neonatal (per 1,000 live births)"
		local l3_DEU uisger02
		local ll3_DEU "School enrollment, preprimary (% gross)"
		local e1_DEU mort514
		local le1_DEU "Mortality rate (children aged 5 to 14 years)"
		local e2_DEU b_hygiene_sch
		local le2_DEU "Proportion of schools with basic hygiene services"
		local e3_DEU uiscr1
		local le3_DEU "Primary school completion (%) "
		local h1_DEU lastnm_afr
		local lh1_DEU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_DEU lastnm_ter_ger
		local lh2_DEU "School enrollment, tertiary (% gross)"
		local h3_DEU une_2eap_mf_y
		local lh3_DEU "Youth unemployment (%), ages 15-24"
		local b1_DEU une_2eap_mf_a
		local lb1_DEU "Unemployment (%), ages 25+"
		local b2_DEU probdeath_ncd
		local lb2_DEU "Cause of death, by non-communicable diseases (% of total)"
		local b3_DEU sp_dyn_le00_in
		local lb3_DEU "Life expectancy at birth (years)"
		local l1_DMA u5_anaemia
		local ll1_DMA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_DMA neomort
		local ll2_DMA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_DMA uisger02
		local ll3_DMA "School enrollment, preprimary (% gross)"
		local e1_DMA b_hygiene_sch
		local le1_DMA "Proportion of schools with basic hygiene services"
		local e2_DMA mort514
		local le2_DMA "Mortality rate (children aged 5 to 14 years)"
		local e3_DMA uiscr1
		local le3_DMA "Primary school completion (%) "
		local h1_DMA mort1524
		local lh1_DMA "Mortality rate (children aged 15 to 24 years)"
		local h2_DMA uisqutp2t3
		local lh2_DMA "Qualified teachers in secondary education (%)"
		local h3_DMA
		local lh3_DMA ""
		local b1_DMA A_seekers
		local lb1_DMA " "
		local b2_DMA hypertension
		local lb2_DMA "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local b3_DMA refugees
		local lb3_DMA "Refugees under UNHCR’s mandate"
		local l1_DNK u5_anaemia
		local ll1_DNK "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_DNK uisger02
		local ll2_DNK "School enrollment, preprimary (% gross)"
		local l3_DNK neomort
		local ll3_DNK "Mortality rate, neonatal (per 1,000 live births)"
		local e1_DNK b_hygiene_sch
		local le1_DNK "Proportion of schools with basic hygiene services"
		local e2_DNK uiscr1
		local le2_DNK "Primary school completion (%) "
		local e3_DNK mort514
		local le3_DNK "Mortality rate (children aged 5 to 14 years)"
		local h1_DNK lastnm_ter_ger
		local lh1_DNK "School enrollment, tertiary (% gross)"
		local h2_DNK une_2eap_mf_y
		local lh2_DNK "Youth unemployment (%), ages 15-24"
		local h3_DNK lastnm_afr
		local lh3_DNK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_DNK probdeath_ncd
		local lb1_DNK "Cause of death, by non-communicable diseases (% of total)"
		local b2_DNK une_2eap_mf_a
		local lb2_DNK "Unemployment (%), ages 25+"
		local b3_DNK sp_dyn_le00_in
		local lb3_DNK "Life expectancy at birth (years)"
		local l1_DOM neomort
		local ll1_DOM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DOM u5_anaemia
		local ll2_DOM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_DOM uisger02
		local ll3_DOM "School enrollment, preprimary (% gross)"
		local e1_DOM mort514
		local le1_DOM "Mortality rate (children aged 5 to 14 years)"
		local e2_DOM Child labor (%), ages 5-17
		local le2_DOM "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_DOM se_lpv_prim
		local le3_DOM "Learning Poverty"
		local h1_DOM uiscr3
		local lh1_DOM "Completion rate, upper secondary education (%)"
		local h2_DOM eip_neet_mf_y
		local lh2_DOM "Youth NEET (%), ages 15-24"
		local h3_DOM lastnm_afr
		local lh3_DOM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_DOM une_2eap_mf_a
		local lb1_DOM "Unemployment (%), ages 25+"
		local b2_DOM emp_nifl_a
		local lb2_DOM "Adult informal employment rate (%), ages 25+"
		local b3_DOM sp_dyn_le00_in
		local lb3_DOM "Life expectancy at birth (years)"
		local l1_DZA neomort
		local ll1_DZA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DZA u5_anaemia
		local ll2_DZA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_DZA Minimum meal frequency (%), 6-23 months
		local ll3_DZA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_DZA uiscr1
		local le1_DZA "Primary school completion (%) "
		local e2_DZA mort514
		local le2_DZA "Mortality rate (children aged 5 to 14 years)"
		local e3_DZA Child labor (%), ages 5-17
		local le3_DZA "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_DZA uiscr3
		local lh1_DZA "Completion rate, upper secondary education (%)"
		local h2_DZA lastnm_afr
		local lh2_DZA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_DZA une_2eap_mf_y
		local lh3_DZA "Youth unemployment (%), ages 15-24"
		local b1_DZA probdeath_ncd
		local lb1_DZA "Cause of death, by non-communicable diseases (% of total)"
		local b2_DZA une_2eap_mf_a
		local lb2_DZA "Unemployment (%), ages 25+"
		local b3_DZA sp_dyn_le00_in
		local lb3_DZA "Life expectancy at birth (years)"
		local l1_ECU uisger02
		local ll1_ECU "School enrollment, preprimary (% gross)"
		local l2_ECU neomort
		local ll2_ECU "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ECU Minimum meal frequency (%), 6-23 months
		local ll3_ECU "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_ECU se_lpv_prim
		local le1_ECU "Learning Poverty"
		local e2_ECU mort514
		local le2_ECU "Mortality rate (children aged 5 to 14 years)"
		local e3_ECU Child labor (%), ages 5-17
		local le3_ECU "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_ECU lastnm_afr
		local lh1_ECU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ECU eip_neet_mf_y
		local lh2_ECU "Youth NEET (%), ages 15-24"
		local h3_ECU uiscr3
		local lh3_ECU "Completion rate, upper secondary education (%)"
		local b1_ECU sp_dyn_le00_in
		local lb1_ECU "Life expectancy at birth (years)"
		local b2_ECU une_2eap_mf_a
		local lb2_ECU "Unemployment (%), ages 25+"
		local b3_ECU emp_nifl_a
		local lb3_ECU "Adult informal employment rate (%), ages 25+"
		local l1_EGY neomort
		local ll1_EGY "Mortality rate, neonatal (per 1,000 live births)"
		local l2_EGY u5_anaemia
		local ll2_EGY "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_EGY uisger02
		local ll3_EGY "School enrollment, preprimary (% gross)"
		local e1_EGY b_hygiene_sch
		local le1_EGY "Proportion of schools with basic hygiene services"
		local e2_EGY mort514
		local le2_EGY "Mortality rate (children aged 5 to 14 years)"
		local e3_EGY uiscr1
		local le3_EGY "Primary school completion (%) "
		local h1_EGY lastnm_ter_ger
		local lh1_EGY "School enrollment, tertiary (% gross)"
		local h2_EGY eip_neet_mf_y
		local lh2_EGY "Youth NEET (%), ages 15-24"
		local h3_EGY lastnm_afr
		local lh3_EGY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_EGY sp_dyn_le00_in
		local lb1_EGY "Life expectancy at birth (years)"
		local b2_EGY une_2eap_mf_a
		local lb2_EGY "Unemployment (%), ages 25+"
		local b3_EGY b_water_health
		local lb3_EGY "Proportion of health care facilities with basic water services"
		local l1_ESP neomort
		local ll1_ESP "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ESP uisger02
		local ll2_ESP "School enrollment, preprimary (% gross)"
		local l3_ESP u5_anaemia
		local ll3_ESP "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_ESP uiscr1
		local le1_ESP "Primary school completion (%) "
		local e2_ESP mort514
		local le2_ESP "Mortality rate (children aged 5 to 14 years)"
		local e3_ESP b_hygiene_sch
		local le3_ESP "Proportion of schools with basic hygiene services"
		local h1_ESP lastnm_afr
		local lh1_ESP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ESP lastnm_ter_ger
		local lh2_ESP "School enrollment, tertiary (% gross)"
		local h3_ESP une_2eap_mf_y
		local lh3_ESP "Youth unemployment (%), ages 15-24"
		local b1_ESP sp_dyn_le00_in
		local lb1_ESP "Life expectancy at birth (years)"
		local b2_ESP probdeath_ncd
		local lb2_ESP "Cause of death, by non-communicable diseases (% of total)"
		local b3_ESP une_2eap_mf_a
		local lb3_ESP "Unemployment (%), ages 25+"
		local l1_EST u5_anaemia
		local ll1_EST "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_EST uisger02
		local ll2_EST "School enrollment, preprimary (% gross)"
		local l3_EST neomort
		local ll3_EST "Mortality rate, neonatal (per 1,000 live births)"
		local e1_EST b_hygiene_sch
		local le1_EST "Proportion of schools with basic hygiene services"
		local e2_EST mort514
		local le2_EST "Mortality rate (children aged 5 to 14 years)"
		local e3_EST uiscr1
		local le3_EST "Primary school completion (%) "
		local h1_EST lastnm_ter_ger
		local lh1_EST "School enrollment, tertiary (% gross)"
		local h2_EST une_2eap_mf_y
		local lh2_EST "Youth unemployment (%), ages 15-24"
		local h3_EST lastnm_afr
		local lh3_EST "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_EST une_2eap_mf_a
		local lb1_EST "Unemployment (%), ages 25+"
		local b2_EST sp_dyn_le00_in
		local lb2_EST "Life expectancy at birth (years)"
		local b3_EST b_water_health
		local lb3_EST "Proportion of health care facilities with basic water services"
		local l1_ETH uisger02
		local ll1_ETH "School enrollment, preprimary (% gross)"
		local l2_ETH neomort
		local ll2_ETH "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ETH Minimum meal frequency (%), 6-23 months
		local ll3_ETH "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_ETH b_hygiene_sch
		local le1_ETH "Proportion of schools with basic hygiene services"
		local e2_ETH uiscr1
		local le2_ETH "Primary school completion (%) "
		local e3_ETH mort514
		local le3_ETH "Mortality rate (children aged 5 to 14 years)"
		local h1_ETH une_2eap_mf_y
		local lh1_ETH "Youth unemployment (%), ages 15-24"
		local h2_ETH uiscr3
		local lh2_ETH "Completion rate, upper secondary education (%)"
		local h3_ETH lastnm_afr
		local lh3_ETH "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_ETH une_2eap_mf_a
		local lb1_ETH "Unemployment (%), ages 25+"
		local b2_ETH b_water_health
		local lb2_ETH "Proportion of health care facilities with basic water services"
		local b3_ETH sp_dyn_le00_in
		local lb3_ETH "Life expectancy at birth (years)"
		local l1_FIN uisger02
		local ll1_FIN "School enrollment, preprimary (% gross)"
		local l2_FIN neomort
		local ll2_FIN "Mortality rate, neonatal (per 1,000 live births)"
		local l3_FIN u5_anaemia
		local ll3_FIN "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_FIN uiscr1
		local le1_FIN "Primary school completion (%) "
		local e2_FIN b_hygiene_sch
		local le2_FIN "Proportion of schools with basic hygiene services"
		local e3_FIN mort514
		local le3_FIN "Mortality rate (children aged 5 to 14 years)"
		local h1_FIN lastnm_ter_ger
		local lh1_FIN "School enrollment, tertiary (% gross)"
		local h2_FIN lastnm_afr
		local lh2_FIN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_FIN une_2eap_mf_y
		local lh3_FIN "Youth unemployment (%), ages 15-24"
		local b1_FIN probdeath_ncd
		local lb1_FIN "Cause of death, by non-communicable diseases (% of total)"
		local b2_FIN sp_dyn_le00_in
		local lb2_FIN "Life expectancy at birth (years)"
		local b3_FIN une_2eap_mf_a
		local lb3_FIN "Unemployment (%), ages 25+"
		local l1_FJI uisger02
		local ll1_FJI "School enrollment, preprimary (% gross)"
		local l2_FJI neomort
		local ll2_FJI "Mortality rate, neonatal (per 1,000 live births)"
		local l3_FJI u5_anaemia
		local ll3_FJI "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_FJI Child labor (%), ages 5-17
		local le1_FJI "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_FJI uiscr1
		local le2_FJI "Primary school completion (%) "
		local e3_FJI mort514
		local le3_FJI "Mortality rate (children aged 5 to 14 years)"
		local h1_FJI uiscr3
		local lh1_FJI "Completion rate, upper secondary education (%)"
		local h2_FJI une_2eap_mf_y
		local lh2_FJI "Youth unemployment (%), ages 15-24"
		local h3_FJI lastnm_afr
		local lh3_FJI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_FJI une_2eap_mf_a
		local lb1_FJI "Unemployment (%), ages 25+"
		local b2_FJI sp_dyn_le00_in
		local lb2_FJI "Life expectancy at birth (years)"
		local b3_FJI b_water_health
		local lb3_FJI "Proportion of health care facilities with basic water services"
		local l1_FRA uisger02
		local ll1_FRA "School enrollment, preprimary (% gross)"
		local l2_FRA neomort
		local ll2_FRA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_FRA u5_anaemia
		local ll3_FRA "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_FRA b_hygiene_sch
		local le1_FRA "Proportion of schools with basic hygiene services"
		local e2_FRA mort514
		local le2_FRA "Mortality rate (children aged 5 to 14 years)"
		local e3_FRA lastnm_sec_ger
		local le3_FRA "School enrollment, secondary (% gross)"
		local h1_FRA une_2eap_mf_y
		local lh1_FRA "Youth unemployment (%), ages 15-24"
		local h2_FRA lastnm_ter_ger
		local lh2_FRA "School enrollment, tertiary (% gross)"
		local h3_FRA lastnm_afr
		local lh3_FRA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_FRA sp_dyn_le00_in
		local lb1_FRA "Life expectancy at birth (years)"
		local b2_FRA une_2eap_mf_a
		local lb2_FRA "Unemployment (%), ages 25+"
		local b3_FRA probdeath_ncd
		local lb3_FRA "Cause of death, by non-communicable diseases (% of total)"
		local l1_FSM uisger02
		local ll1_FSM "School enrollment, preprimary (% gross)"
		local l2_FSM neomort
		local ll2_FSM "Mortality rate, neonatal (per 1,000 live births)"
		local l3_FSM u5_anaemia
		local ll3_FSM "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_FSM uiscr1
		local le1_FSM "Primary school completion (%) "
		local e2_FSM mort514
		local le2_FSM "Mortality rate (children aged 5 to 14 years)"
		local e3_FSM uisxgdpfsgov
		local le3_FSM "Government expenditure on education (% GPD)"
		local h1_FSM lastnm_afr
		local lh1_FSM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_FSM mort1524
		local lh2_FSM "Mortality rate (children aged 15 to 24 years)"
		local h3_FSM suicide_15_19
		local lh3_FSM "Crude suicide rates (per 100 000 population)"
		local b1_FSM b_water_health
		local lb1_FSM "Proportion of health care facilities with basic water services"
		local b2_FSM sp_dyn_le00_in
		local lb2_FSM "Life expectancy at birth (years)"
		local b3_FSM probdeath_ncd
		local lb3_FSM "Cause of death, by non-communicable diseases (% of total)"
		local l1_GAB uisger02
		local ll1_GAB "School enrollment, preprimary (% gross)"
		local l2_GAB u5_anaemia
		local ll2_GAB "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_GAB neomort
		local ll3_GAB "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GAB uiscr1
		local le1_GAB "Primary school completion (%) "
		local e2_GAB se_lpv_prim
		local le2_GAB "Learning Poverty"
		local e3_GAB mort514
		local le3_GAB "Mortality rate (children aged 5 to 14 years)"
		local h1_GAB uiscr3
		local lh1_GAB "Completion rate, upper secondary education (%)"
		local h2_GAB lastnm_afr
		local lh2_GAB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GAB une_2eap_mf_y
		local lh3_GAB "Youth unemployment (%), ages 15-24"
		local b1_GAB probdeath_ncd
		local lb1_GAB "Cause of death, by non-communicable diseases (% of total)"
		local b2_GAB une_2eap_mf_a
		local lb2_GAB "Unemployment (%), ages 25+"
		local b3_GAB sp_dyn_le00_in
		local lb3_GAB "Life expectancy at birth (years)"
		local l1_GBR u5_anaemia
		local ll1_GBR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_GBR uisger02
		local ll2_GBR "School enrollment, preprimary (% gross)"
		local l3_GBR neomort
		local ll3_GBR "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GBR uiscr1
		local le1_GBR "Primary school completion (%) "
		local e2_GBR lastnm_sec_ger
		local le2_GBR "School enrollment, secondary (% gross)"
		local e3_GBR mort514
		local le3_GBR "Mortality rate (children aged 5 to 14 years)"
		local h1_GBR lastnm_afr
		local lh1_GBR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GBR lastnm_ter_ger
		local lh2_GBR "School enrollment, tertiary (% gross)"
		local h3_GBR une_2eap_mf_y
		local lh3_GBR "Youth unemployment (%), ages 15-24"
		local b1_GBR une_2eap_mf_a
		local lb1_GBR "Unemployment (%), ages 25+"
		local b2_GBR probdeath_ncd
		local lb2_GBR "Cause of death, by non-communicable diseases (% of total)"
		local b3_GBR sp_dyn_le00_in
		local lb3_GBR "Life expectancy at birth (years)"
		local l1_GEO Minimum meal frequency (%), 6-23 months
		local ll1_GEO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_GEO uisger02
		local ll2_GEO "School enrollment, preprimary (% gross)"
		local l3_GEO neomort
		local ll3_GEO "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GEO lastnm_sec_ger
		local le1_GEO "School enrollment, secondary (% gross)"
		local e2_GEO uiscr1
		local le2_GEO "Primary school completion (%) "
		local e3_GEO mort514
		local le3_GEO "Mortality rate (children aged 5 to 14 years)"
		local h1_GEO uiscr3
		local lh1_GEO "Completion rate, upper secondary education (%)"
		local h2_GEO eip_neet_mf_y
		local lh2_GEO "Youth NEET (%), ages 15-24"
		local h3_GEO lastnm_afr
		local lh3_GEO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_GEO emp_nifl_a
		local lb1_GEO "Adult informal employment rate (%), ages 25+"
		local b2_GEO sp_dyn_le00_in
		local lb2_GEO "Life expectancy at birth (years)"
		local b3_GEO une_2eap_mf_a
		local lb3_GEO "Unemployment (%), ages 25+"
		local l1_GHA uisger02
		local ll1_GHA "School enrollment, preprimary (% gross)"
		local l2_GHA u5_anaemia
		local ll2_GHA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_GHA neomort
		local ll3_GHA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GHA Child labor (%), ages 5-17
		local le1_GHA "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_GHA uiscr1
		local le2_GHA "Primary school completion (%) "
		local e3_GHA mort514
		local le3_GHA "Mortality rate (children aged 5 to 14 years)"
		local h1_GHA uiscr3
		local lh1_GHA "Completion rate, upper secondary education (%)"
		local h2_GHA une_2eap_mf_y
		local lh2_GHA "Youth unemployment (%), ages 15-24"
		local h3_GHA lastnm_afr
		local lh3_GHA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_GHA une_2eap_mf_a
		local lb1_GHA "Unemployment (%), ages 25+"
		local b2_GHA sp_dyn_le00_in
		local lb2_GHA "Life expectancy at birth (years)"
		local b3_GHA b_water_health
		local lb3_GHA "Proportion of health care facilities with basic water services"
		local l1_GIN uisger02
		local ll1_GIN "School enrollment, preprimary (% gross)"
		local l2_GIN neomort
		local ll2_GIN "Mortality rate, neonatal (per 1,000 live births)"
		local l3_GIN Minimum meal frequency (%), 6-23 months
		local ll3_GIN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_GIN mort514
		local le1_GIN "Mortality rate (children aged 5 to 14 years)"
		local e2_GIN uiscr1
		local le2_GIN "Primary school completion (%) "
		local e3_GIN se_lpv_prim
		local le3_GIN "Learning Poverty"
		local h1_GIN lastnm_afr
		local lh1_GIN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GIN uiscr3
		local lh2_GIN "Completion rate, upper secondary education (%)"
		local h3_GIN eip_neet_mf_y
		local lh3_GIN "Youth NEET (%), ages 15-24"
		local b1_GIN probdeath_ncd
		local lb1_GIN "Cause of death, by non-communicable diseases (% of total)"
		local b2_GIN une_2eap_mf_a
		local lb2_GIN "Unemployment (%), ages 25+"
		local b3_GIN sp_dyn_le00_in
		local lb3_GIN "Life expectancy at birth (years)"
		local l1_GMB Minimum meal frequency (%), 6-23 months
		local ll1_GMB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_GMB uisger02
		local ll2_GMB "School enrollment, preprimary (% gross)"
		local l3_GMB neomort
		local ll3_GMB "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GMB uiscr1
		local le1_GMB "Primary school completion (%) "
		local e2_GMB Child labor (%), ages 5-17
		local le2_GMB "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_GMB mort514
		local le3_GMB "Mortality rate (children aged 5 to 14 years)"
		local h1_GMB uiscr3
		local lh1_GMB "Completion rate, upper secondary education (%)"
		local h2_GMB lastnm_afr
		local lh2_GMB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GMB eip_neet_mf_y
		local lh3_GMB "Youth NEET (%), ages 15-24"
		local b1_GMB une_2eap_mf_a
		local lb1_GMB "Unemployment (%), ages 25+"
		local b2_GMB sp_dyn_le00_in
		local lb2_GMB "Life expectancy at birth (years)"
		local b3_GMB probdeath_ncd
		local lb3_GMB "Cause of death, by non-communicable diseases (% of total)"
		local l1_GRC u5_anaemia
		local ll1_GRC "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_GRC uisger02
		local ll2_GRC "School enrollment, preprimary (% gross)"
		local l3_GRC neomort
		local ll3_GRC "Mortality rate, neonatal (per 1,000 live births)"
		local e1_GRC lastnm_sec_ger
		local le1_GRC "School enrollment, secondary (% gross)"
		local e2_GRC mort514
		local le2_GRC "Mortality rate (children aged 5 to 14 years)"
		local e3_GRC uiscr1
		local le3_GRC "Primary school completion (%) "
		local h1_GRC une_2eap_mf_y
		local lh1_GRC "Youth unemployment (%), ages 15-24"
		local h2_GRC lastnm_afr
		local lh2_GRC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GRC lastnm_ter_ger
		local lh3_GRC "School enrollment, tertiary (% gross)"
		local b1_GRC probdeath_ncd
		local lb1_GRC "Cause of death, by non-communicable diseases (% of total)"
		local b2_GRC une_2eap_mf_a
		local lb2_GRC "Unemployment (%), ages 25+"
		local b3_GRC sp_dyn_le00_in
		local lb3_GRC "Life expectancy at birth (years)"
		local l1_GRD uisger02
		local ll1_GRD "School enrollment, preprimary (% gross)"
		local l2_GRD neomort
		local ll2_GRD "Mortality rate, neonatal (per 1,000 live births)"
		local l3_GRD u5_anaemia
		local ll3_GRD "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_GRD mort514
		local le1_GRD "Mortality rate (children aged 5 to 14 years)"
		local e2_GRD uiscr1
		local le2_GRD "Primary school completion (%) "
		local e3_GRD b_hygiene_sch
		local le3_GRD "Proportion of schools with basic hygiene services"
		local h1_GRD lastnm_afr
		local lh1_GRD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GRD uisqutp2t3
		local lh2_GRD "Qualified teachers in secondary education (%)"
		local h3_GRD lastnm_ter_ger
		local lh3_GRD "School enrollment, tertiary (% gross)"
		local b1_GRD sp_dyn_le00_in
		local lb1_GRD "Life expectancy at birth (years)"
		local b2_GRD refugees
		local lb2_GRD "Refugees under UNHCR’s mandate"
		local b3_GRD probdeath_ncd
		local lb3_GRD "Cause of death, by non-communicable diseases (% of total)"
		local l1_GTM u5_anaemia
		local ll1_GTM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_GTM neomort
		local ll2_GTM "Mortality rate, neonatal (per 1,000 live births)"
		local l3_GTM uisger02
		local ll3_GTM "School enrollment, preprimary (% gross)"
		local e1_GTM mort514
		local le1_GTM "Mortality rate (children aged 5 to 14 years)"
		local e2_GTM se_lpv_prim
		local le2_GTM "Learning Poverty"
		local e3_GTM uiscr1
		local le3_GTM "Primary school completion (%) "
		local h1_GTM lastnm_afr
		local lh1_GTM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GTM uiscr3
		local lh2_GTM "Completion rate, upper secondary education (%)"
		local h3_GTM eip_neet_mf_y
		local lh3_GTM "Youth NEET (%), ages 15-24"
		local b1_GTM b_water_health
		local lb1_GTM "Proportion of health care facilities with basic water services"
		local b2_GTM sp_dyn_le00_in
		local lb2_GTM "Life expectancy at birth (years)"
		local b3_GTM une_2eap_mf_a
		local lb3_GTM "Unemployment (%), ages 25+"
		local l1_GUY u5_anaemia
		local ll1_GUY "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_GUY neomort
		local ll2_GUY "Mortality rate, neonatal (per 1,000 live births)"
		local l3_GUY care
		local ll3_GUY "Postnatal contact with a health provider within 2 days of delivery"
		local e1_GUY eyrs
		local le1_GUY "Expected Years of School"
		local e2_GUY uisxgdpfsgov
		local le2_GUY "Government expenditure on education (% GPD)"
		local e3_GUY mort514
		local le3_GUY "Mortality rate (children aged 5 to 14 years)"
		local h1_GUY uiscr3
		local lh1_GUY "Completion rate, upper secondary education (%)"
		local h2_GUY lastnm_afr
		local lh2_GUY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GUY eip_neet_mf_y
		local lh3_GUY "Youth NEET (%), ages 15-24"
		local b1_GUY sp_dyn_le00_in
		local lb1_GUY "Life expectancy at birth (years)"
		local b2_GUY une_2eap_mf_a
		local lb2_GUY "Unemployment (%), ages 25+"
		local b3_GUY emp_nifl_a
		local lb3_GUY "Adult informal employment rate (%), ages 25+"
		local l1_HKG uisger02
		local ll1_HKG "School enrollment, preprimary (% gross)"
		local l2_HKG psurv
		local ll2_HKG "Probability of Survival to Age 5"
		local l3_HKG
		local ll3_HKG ""
		local e1_HKG uiscr1
		local le1_HKG "Primary school completion (%) "
		local e2_HKG uisxgdpfsgov
		local le2_HKG "Government expenditure on education (% GPD)"
		local e3_HKG lastnm_sec_ger
		local le3_HKG "School enrollment, secondary (% gross)"
		local h1_HKG eip_neet_mf_y
		local lh1_HKG "Youth NEET (%), ages 15-24"
		local h2_HKG lastnm_afr
		local lh2_HKG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_HKG lastnm_ter_ger
		local lh3_HKG "School enrollment, tertiary (% gross)"
		local b1_HKG une_2eap_mf_a
		local lb1_HKG "Unemployment (%), ages 25+"
		local b2_HKG sp_dyn_le00_in
		local lb2_HKG "Life expectancy at birth (years)"
		local b3_HKG eap_2wap_mf_a
		local lb3_HKG "Labour force participation (%), ages 25+"
		local l1_HND u5_anaemia
		local ll1_HND "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_HND neomort
		local ll2_HND "Mortality rate, neonatal (per 1,000 live births)"
		local l3_HND uisger02
		local ll3_HND "School enrollment, preprimary (% gross)"
		local e1_HND Child labor (%), ages 5-17
		local le1_HND "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_HND se_lpv_prim
		local le2_HND "Learning Poverty"
		local e3_HND mort514
		local le3_HND "Mortality rate (children aged 5 to 14 years)"
		local h1_HND eip_neet_mf_y
		local lh1_HND "Youth NEET (%), ages 15-24"
		local h2_HND uiscr3
		local lh2_HND "Completion rate, upper secondary education (%)"
		local h3_HND lastnm_afr
		local lh3_HND "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_HND une_2eap_mf_a
		local lb1_HND "Unemployment (%), ages 25+"
		local b2_HND sp_dyn_le00_in
		local lb2_HND "Life expectancy at birth (years)"
		local b3_HND b_water_health
		local lb3_HND "Proportion of health care facilities with basic water services"
		local l1_HRV uisger02
		local ll1_HRV "School enrollment, preprimary (% gross)"
		local l2_HRV u5_anaemia
		local ll2_HRV "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_HRV neomort
		local ll3_HRV "Mortality rate, neonatal (per 1,000 live births)"
		local e1_HRV se_lpv_prim
		local le1_HRV "Learning Poverty"
		local e2_HRV mort514
		local le2_HRV "Mortality rate (children aged 5 to 14 years)"
		local e3_HRV uiscr1
		local le3_HRV "Primary school completion (%) "
		local h1_HRV lastnm_afr
		local lh1_HRV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_HRV une_2eap_mf_y
		local lh2_HRV "Youth unemployment (%), ages 15-24"
		local h3_HRV lastnm_ter_ger
		local lh3_HRV "School enrollment, tertiary (% gross)"
		local b1_HRV sp_dyn_le00_in
		local lb1_HRV "Life expectancy at birth (years)"
		local b2_HRV probdeath_ncd
		local lb2_HRV "Cause of death, by non-communicable diseases (% of total)"
		local b3_HRV une_2eap_mf_a
		local lb3_HRV "Unemployment (%), ages 25+"
		local l1_HTI vacHEPB3
		local ll1_HTI "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_HTI neomort
		local ll2_HTI "Mortality rate, neonatal (per 1,000 live births)"
		local l3_HTI u5_anaemia
		local ll3_HTI "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_HTI eyrs
		local le1_HTI "Expected Years of School"
		local e2_HTI mort514
		local le2_HTI "Mortality rate (children aged 5 to 14 years)"
		local e3_HTI uisxgdpfsgov
		local le3_HTI "Government expenditure on education (% GPD)"
		local h1_HTI lastnm_afr
		local lh1_HTI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_HTI uiscr3
		local lh2_HTI "Completion rate, upper secondary education (%)"
		local h3_HTI une_2eap_mf_y
		local lh3_HTI "Youth unemployment (%), ages 15-24"
		local b1_HTI b_water_health
		local lb1_HTI "Proportion of health care facilities with basic water services"
		local b2_HTI une_2eap_mf_a
		local lb2_HTI "Unemployment (%), ages 25+"
		local b3_HTI sp_dyn_le00_in
		local lb3_HTI "Life expectancy at birth (years)"
		local l1_HUN uisger02
		local ll1_HUN "School enrollment, preprimary (% gross)"
		local l2_HUN u5_anaemia
		local ll2_HUN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_HUN neomort
		local ll3_HUN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_HUN uiscr1
		local le1_HUN "Primary school completion (%) "
		local e2_HUN mort514
		local le2_HUN "Mortality rate (children aged 5 to 14 years)"
		local e3_HUN b_hygiene_sch
		local le3_HUN "Proportion of schools with basic hygiene services"
		local h1_HUN une_2eap_mf_y
		local lh1_HUN "Youth unemployment (%), ages 15-24"
		local h2_HUN lastnm_afr
		local lh2_HUN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_HUN lastnm_ter_ger
		local lh3_HUN "School enrollment, tertiary (% gross)"
		local b1_HUN sp_dyn_le00_in
		local lb1_HUN "Life expectancy at birth (years)"
		local b2_HUN une_2eap_mf_a
		local lb2_HUN "Unemployment (%), ages 25+"
		local b3_HUN probdeath_ncd
		local lb3_HUN "Cause of death, by non-communicable diseases (% of total)"
		local l1_IDN uisger02
		local ll1_IDN "School enrollment, preprimary (% gross)"
		local l2_IDN u5_anaemia
		local ll2_IDN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_IDN neomort
		local ll3_IDN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_IDN Child labor (%), ages 5-17
		local le1_IDN "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_IDN uiscr1
		local le2_IDN "Primary school completion (%) "
		local e3_IDN mort514
		local le3_IDN "Mortality rate (children aged 5 to 14 years)"
		local h1_IDN eip_neet_mf_y
		local lh1_IDN "Youth NEET (%), ages 15-24"
		local h2_IDN lastnm_afr
		local lh2_IDN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_IDN uiscr3
		local lh3_IDN "Completion rate, upper secondary education (%)"
		local b1_IDN sp_dyn_le00_in
		local lb1_IDN "Life expectancy at birth (years)"
		local b2_IDN b_water_health
		local lb2_IDN "Proportion of health care facilities with basic water services"
		local b3_IDN une_2eap_mf_a
		local lb3_IDN "Unemployment (%), ages 25+"
		local l1_IND uisger02
		local ll1_IND "School enrollment, preprimary (% gross)"
		local l2_IND neomort
		local ll2_IND "Mortality rate, neonatal (per 1,000 live births)"
		local l3_IND u5_anaemia
		local ll3_IND "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_IND uiscr1
		local le1_IND "Primary school completion (%) "
		local e2_IND mort514
		local le2_IND "Mortality rate (children aged 5 to 14 years)"
		local e3_IND b_hygiene_sch
		local le3_IND "Proportion of schools with basic hygiene services"
		local h1_IND uiscr3
		local lh1_IND "Completion rate, upper secondary education (%)"
		local h2_IND lastnm_afr
		local lh2_IND "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_IND une_2eap_mf_y
		local lh3_IND "Youth unemployment (%), ages 15-24"
		local b1_IND une_2eap_mf_a
		local lb1_IND "Unemployment (%), ages 25+"
		local b2_IND emp_nifl_a
		local lb2_IND "Adult informal employment rate (%), ages 25+"
		local b3_IND sp_dyn_le00_in
		local lb3_IND "Life expectancy at birth (years)"
		local l1_IRL u5_anaemia
		local ll1_IRL "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_IRL neomort
		local ll2_IRL "Mortality rate, neonatal (per 1,000 live births)"
		local l3_IRL uisger02
		local ll3_IRL "School enrollment, preprimary (% gross)"
		local e1_IRL mort514
		local le1_IRL "Mortality rate (children aged 5 to 14 years)"
		local e2_IRL lastnm_sec_ger
		local le2_IRL "School enrollment, secondary (% gross)"
		local e3_IRL uiscr1
		local le3_IRL "Primary school completion (%) "
		local h1_IRL lastnm_afr
		local lh1_IRL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_IRL lastnm_ter_ger
		local lh2_IRL "School enrollment, tertiary (% gross)"
		local h3_IRL une_2eap_mf_y
		local lh3_IRL "Youth unemployment (%), ages 15-24"
		local b1_IRL une_2eap_mf_a
		local lb1_IRL "Unemployment (%), ages 25+"
		local b2_IRL sp_dyn_le00_in
		local lb2_IRL "Life expectancy at birth (years)"
		local b3_IRL probdeath_ncd
		local lb3_IRL "Cause of death, by non-communicable diseases (% of total)"
		local l1_IRN neomort
		local ll1_IRN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IRN uisger02
		local ll2_IRN "School enrollment, preprimary (% gross)"
		local l3_IRN u5_anaemia
		local ll3_IRN "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_IRN mort514
		local le1_IRN "Mortality rate (children aged 5 to 14 years)"
		local e2_IRN uiscr1
		local le2_IRN "Primary school completion (%) "
		local e3_IRN lastnm_sec_ger
		local le3_IRN "School enrollment, secondary (% gross)"
		local h1_IRN uiscr3
		local lh1_IRN "Completion rate, upper secondary education (%)"
		local h2_IRN eip_neet_mf_y
		local lh2_IRN "Youth NEET (%), ages 15-24"
		local h3_IRN lastnm_afr
		local lh3_IRN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_IRN une_2eap_mf_a
		local lb1_IRN "Unemployment (%), ages 25+"
		local b2_IRN b_water_health
		local lb2_IRN "Proportion of health care facilities with basic water services"
		local b3_IRN sp_dyn_le00_in
		local lb3_IRN "Life expectancy at birth (years)"
		local l1_IRQ u5_anaemia
		local ll1_IRQ "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_IRQ Minimum meal frequency (%), 6-23 months
		local ll2_IRQ "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_IRQ neomort
		local ll3_IRQ "Mortality rate, neonatal (per 1,000 live births)"
		local e1_IRQ mort514
		local le1_IRQ "Mortality rate (children aged 5 to 14 years)"
		local e2_IRQ eyrs
		local le2_IRQ "Expected Years of School"
		local e3_IRQ Child labor (%), ages 5-17
		local le3_IRQ "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_IRQ une_2eap_mf_y
		local lh1_IRQ "Youth unemployment (%), ages 15-24"
		local h2_IRQ lastnm_afr
		local lh2_IRQ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_IRQ uiscr3
		local lh3_IRQ "Completion rate, upper secondary education (%)"
		local b1_IRQ une_2eap_mf_a
		local lb1_IRQ "Unemployment (%), ages 25+"
		local b2_IRQ sp_dyn_le00_in
		local lb2_IRQ "Life expectancy at birth (years)"
		local b3_IRQ b_water_health
		local lb3_IRQ "Proportion of health care facilities with basic water services"
		local l1_ISL uisger02
		local ll1_ISL "School enrollment, preprimary (% gross)"
		local l2_ISL neomort
		local ll2_ISL "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ISL u5_anaemia
		local ll3_ISL "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_ISL uiscr1
		local le1_ISL "Primary school completion (%) "
		local e2_ISL lastnm_sec_ger
		local le2_ISL "School enrollment, secondary (% gross)"
		local e3_ISL mort514
		local le3_ISL "Mortality rate (children aged 5 to 14 years)"
		local h1_ISL une_2eap_mf_y
		local lh1_ISL "Youth unemployment (%), ages 15-24"
		local h2_ISL lastnm_ter_ger
		local lh2_ISL "School enrollment, tertiary (% gross)"
		local h3_ISL lastnm_afr
		local lh3_ISL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_ISL probdeath_ncd
		local lb1_ISL "Cause of death, by non-communicable diseases (% of total)"
		local b2_ISL une_2eap_mf_a
		local lb2_ISL "Unemployment (%), ages 25+"
		local b3_ISL sp_dyn_le00_in
		local lb3_ISL "Life expectancy at birth (years)"
		local l1_ISR u5_anaemia
		local ll1_ISR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_ISR uisger02
		local ll2_ISR "School enrollment, preprimary (% gross)"
		local l3_ISR neomort
		local ll3_ISR "Mortality rate, neonatal (per 1,000 live births)"
		local e1_ISR uiscr1
		local le1_ISR "Primary school completion (%) "
		local e2_ISR b_hygiene_sch
		local le2_ISR "Proportion of schools with basic hygiene services"
		local e3_ISR mort514
		local le3_ISR "Mortality rate (children aged 5 to 14 years)"
		local h1_ISR lastnm_ter_ger
		local lh1_ISR "School enrollment, tertiary (% gross)"
		local h2_ISR lastnm_afr
		local lh2_ISR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ISR une_2eap_mf_y
		local lh3_ISR "Youth unemployment (%), ages 15-24"
		local b1_ISR probdeath_ncd
		local lb1_ISR "Cause of death, by non-communicable diseases (% of total)"
		local b2_ISR sp_dyn_le00_in
		local lb2_ISR "Life expectancy at birth (years)"
		local b3_ISR une_2eap_mf_a
		local lb3_ISR "Unemployment (%), ages 25+"
		local l1_ITA uisger02
		local ll1_ITA "School enrollment, preprimary (% gross)"
		local l2_ITA neomort
		local ll2_ITA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ITA u5_anaemia
		local ll3_ITA "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_ITA mort514
		local le1_ITA "Mortality rate (children aged 5 to 14 years)"
		local e2_ITA b_hygiene_sch
		local le2_ITA "Proportion of schools with basic hygiene services"
		local e3_ITA uiscr1
		local le3_ITA "Primary school completion (%) "
		local h1_ITA lastnm_ter_ger
		local lh1_ITA "School enrollment, tertiary (% gross)"
		local h2_ITA lastnm_afr
		local lh2_ITA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ITA une_2eap_mf_y
		local lh3_ITA "Youth unemployment (%), ages 15-24"
		local b1_ITA sp_dyn_le00_in
		local lb1_ITA "Life expectancy at birth (years)"
		local b2_ITA une_2eap_mf_a
		local lb2_ITA "Unemployment (%), ages 25+"
		local b3_ITA probdeath_ncd
		local lb3_ITA "Cause of death, by non-communicable diseases (% of total)"
		local l1_JAM vacHEPB3
		local ll1_JAM "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_JAM neomort
		local ll2_JAM "Mortality rate, neonatal (per 1,000 live births)"
		local l3_JAM u5_anaemia
		local ll3_JAM "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_JAM b_hygiene_sch
		local le1_JAM "Proportion of schools with basic hygiene services"
		local e2_JAM mort514
		local le2_JAM "Mortality rate (children aged 5 to 14 years)"
		local e3_JAM uiscr1
		local le3_JAM "Primary school completion (%) "
		local h1_JAM eip_neet_mf_y
		local lh1_JAM "Youth NEET (%), ages 15-24"
		local h2_JAM uiscr3
		local lh2_JAM "Completion rate, upper secondary education (%)"
		local h3_JAM lastnm_afr
		local lh3_JAM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_JAM emp_nifl_a
		local lb1_JAM "Adult informal employment rate (%), ages 25+"
		local b2_JAM sp_dyn_le00_in
		local lb2_JAM "Life expectancy at birth (years)"
		local b3_JAM une_2eap_mf_a
		local lb3_JAM "Unemployment (%), ages 25+"
		local l1_JOR uisger02
		local ll1_JOR "School enrollment, preprimary (% gross)"
		local l2_JOR u5_anaemia
		local ll2_JOR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_JOR neomort
		local ll3_JOR "Mortality rate, neonatal (per 1,000 live births)"
		local e1_JOR uiscr1
		local le1_JOR "Primary school completion (%) "
		local e2_JOR mort514
		local le2_JOR "Mortality rate (children aged 5 to 14 years)"
		local e3_JOR lastnm_sec_ger
		local le3_JOR "School enrollment, secondary (% gross)"
		local h1_JOR lastnm_afr
		local lh1_JOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_JOR uiscr3
		local lh2_JOR "Completion rate, upper secondary education (%)"
		local h3_JOR eip_neet_mf_y
		local lh3_JOR "Youth NEET (%), ages 15-24"
		local b1_JOR sp_dyn_le00_in
		local lb1_JOR "Life expectancy at birth (years)"
		local b2_JOR b_water_health
		local lb2_JOR "Proportion of health care facilities with basic water services"
		local b3_JOR une_2eap_mf_a
		local lb3_JOR "Unemployment (%), ages 25+"
		local l1_JPN u5_anaemia
		local ll1_JPN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_JPN vacHEPB3
		local ll2_JPN "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l3_JPN neomort
		local ll3_JPN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_JPN se_lpv_prim
		local le1_JPN "Learning Poverty"
		local e2_JPN lastnm_sec_ger
		local le2_JPN "School enrollment, secondary (% gross)"
		local e3_JPN mort514
		local le3_JPN "Mortality rate (children aged 5 to 14 years)"
		local h1_JPN lastnm_afr
		local lh1_JPN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_JPN une_2eap_mf_y
		local lh2_JPN "Youth unemployment (%), ages 15-24"
		local h3_JPN lastnm_ter_ger
		local lh3_JPN "School enrollment, tertiary (% gross)"
		local b1_JPN probdeath_ncd
		local lb1_JPN "Cause of death, by non-communicable diseases (% of total)"
		local b2_JPN sp_dyn_le00_in
		local lb2_JPN "Life expectancy at birth (years)"
		local b3_JPN une_2eap_mf_a
		local lb3_JPN "Unemployment (%), ages 25+"
		local l1_KAZ neomort
		local ll1_KAZ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KAZ u5_anaemia
		local ll2_KAZ "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_KAZ uisger02
		local ll3_KAZ "School enrollment, preprimary (% gross)"
		local e1_KAZ lastnm_sec_ger
		local le1_KAZ "School enrollment, secondary (% gross)"
		local e2_KAZ mort514
		local le2_KAZ "Mortality rate (children aged 5 to 14 years)"
		local e3_KAZ uiscr1
		local le3_KAZ "Primary school completion (%) "
		local h1_KAZ uiscr3
		local lh1_KAZ "Completion rate, upper secondary education (%)"
		local h2_KAZ une_2eap_mf_y
		local lh2_KAZ "Youth unemployment (%), ages 15-24"
		local h3_KAZ lastnm_afr
		local lh3_KAZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_KAZ sp_dyn_le00_in
		local lb1_KAZ "Life expectancy at birth (years)"
		local b2_KAZ une_2eap_mf_a
		local lb2_KAZ "Unemployment (%), ages 25+"
		local b3_KAZ probdeath_ncd
		local lb3_KAZ "Cause of death, by non-communicable diseases (% of total)"
		local l1_KEN neomort
		local ll1_KEN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KEN uisger02
		local ll2_KEN "School enrollment, preprimary (% gross)"
		local l3_KEN u5_anaemia
		local ll3_KEN "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_KEN Child labor (%), ages 5-17
		local le1_KEN "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_KEN mort514
		local le2_KEN "Mortality rate (children aged 5 to 14 years)"
		local e3_KEN uisxgdpfsgov
		local le3_KEN "Government expenditure on education (% GPD)"
		local h1_KEN lastnm_afr
		local lh1_KEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_KEN uiscr3
		local lh2_KEN "Completion rate, upper secondary education (%)"
		local h3_KEN eip_neet_mf_y
		local lh3_KEN "Youth NEET (%), ages 15-24"
		local b1_KEN une_2eap_mf_a
		local lb1_KEN "Unemployment (%), ages 25+"
		local b2_KEN sp_dyn_le00_in
		local lb2_KEN "Life expectancy at birth (years)"
		local b3_KEN b_water_health
		local lb3_KEN "Proportion of health care facilities with basic water services"
		local l1_KGZ uisger02
		local ll1_KGZ "School enrollment, preprimary (% gross)"
		local l2_KGZ Minimum meal frequency (%), 6-23 months
		local ll2_KGZ "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_KGZ neomort
		local ll3_KGZ "Mortality rate, neonatal (per 1,000 live births)"
		local e1_KGZ Child labor (%), ages 5-17
		local le1_KGZ "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_KGZ uiscr1
		local le2_KGZ "Primary school completion (%) "
		local e3_KGZ mort514
		local le3_KGZ "Mortality rate (children aged 5 to 14 years)"
		local h1_KGZ eip_neet_mf_y
		local lh1_KGZ "Youth NEET (%), ages 15-24"
		local h2_KGZ lastnm_afr
		local lh2_KGZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KGZ uiscr3
		local lh3_KGZ "Completion rate, upper secondary education (%)"
		local b1_KGZ une_2eap_mf_a
		local lb1_KGZ "Unemployment (%), ages 25+"
		local b2_KGZ sp_dyn_le00_in
		local lb2_KGZ "Life expectancy at birth (years)"
		local b3_KGZ b_water_health
		local lb3_KGZ "Proportion of health care facilities with basic water services"
		local l1_KHM neomort
		local ll1_KHM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KHM u5_anaemia
		local ll2_KHM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_KHM uisger02
		local ll3_KHM "School enrollment, preprimary (% gross)"
		local e1_KHM uiscr1
		local le1_KHM "Primary school completion (%) "
		local e2_KHM mort514
		local le2_KHM "Mortality rate (children aged 5 to 14 years)"
		local e3_KHM se_lpv_prim
		local le3_KHM "Learning Poverty"
		local h1_KHM eip_neet_mf_y
		local lh1_KHM "Youth NEET (%), ages 15-24"
		local h2_KHM lastnm_afr
		local lh2_KHM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KHM uiscr3
		local lh3_KHM "Completion rate, upper secondary education (%)"
		local b1_KHM emp_nifl_a
		local lb1_KHM "Adult informal employment rate (%), ages 25+"
		local b2_KHM une_2eap_mf_a
		local lb2_KHM "Unemployment (%), ages 25+"
		local b3_KHM sp_dyn_le00_in
		local lb3_KHM "Life expectancy at birth (years)"
		local l1_KIR neomort
		local ll1_KIR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KIR uisger02
		local ll2_KIR "School enrollment, preprimary (% gross)"
		local l3_KIR Minimum meal frequency (%), 6-23 months
		local ll3_KIR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_KIR mort514
		local le1_KIR "Mortality rate (children aged 5 to 14 years)"
		local e2_KIR Child labor (%), ages 5-17
		local le2_KIR "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_KIR uiscr1
		local le3_KIR "Primary school completion (%) "
		local h1_KIR uiscr3
		local lh1_KIR "Completion rate, upper secondary education (%)"
		local h2_KIR lastnm_afr
		local lh2_KIR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KIR eip_neet_mf_y
		local lh3_KIR "Youth NEET (%), ages 15-24"
		local b1_KIR b_water_health
		local lb1_KIR "Proportion of health care facilities with basic water services"
		local b2_KIR sp_dyn_le00_in
		local lb2_KIR "Life expectancy at birth (years)"
		local b3_KIR emp_nifl_a
		local lb3_KIR "Adult informal employment rate (%), ages 25+"
		local l1_KNA uisger02
		local ll1_KNA "School enrollment, preprimary (% gross)"
		local l2_KNA neomort
		local ll2_KNA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_KNA u5_anaemia
		local ll3_KNA "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_KNA uiscr1
		local le1_KNA "Primary school completion (%) "
		local e2_KNA lastnm_sec_ger
		local le2_KNA "School enrollment, secondary (% gross)"
		local e3_KNA mort514
		local le3_KNA "Mortality rate (children aged 5 to 14 years)"
		local h1_KNA mort1524
		local lh1_KNA "Mortality rate (children aged 15 to 24 years)"
		local h2_KNA uisqutp2t3
		local lh2_KNA "Qualified teachers in secondary education (%)"
		local h3_KNA lastnm_ter_ger
		local lh3_KNA "School enrollment, tertiary (% gross)"
		local b1_KNA refugees
		local lb1_KNA "Refugees under UNHCR’s mandate"
		local b2_KNA hypertension
		local lb2_KNA "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local b3_KNA A_seekers
		local lb3_KNA " "
		local l1_KOR neomort
		local ll1_KOR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KOR uisger02
		local ll2_KOR "School enrollment, preprimary (% gross)"
		local l3_KOR u5_anaemia
		local ll3_KOR "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_KOR uiscr1
		local le1_KOR "Primary school completion (%) "
		local e2_KOR se_lpv_prim
		local le2_KOR "Learning Poverty"
		local e3_KOR mort514
		local le3_KOR "Mortality rate (children aged 5 to 14 years)"
		local h1_KOR une_2eap_mf_y
		local lh1_KOR "Youth unemployment (%), ages 15-24"
		local h2_KOR lastnm_afr
		local lh2_KOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KOR lastnm_ter_ger
		local lh3_KOR "School enrollment, tertiary (% gross)"
		local b1_KOR une_2eap_mf_a
		local lb1_KOR "Unemployment (%), ages 25+"
		local b2_KOR sp_dyn_le00_in
		local lb2_KOR "Life expectancy at birth (years)"
		local b3_KOR probdeath_ncd
		local lb3_KOR "Cause of death, by non-communicable diseases (% of total)"
		local l1_KWT u5_anaemia
		local ll1_KWT "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_KWT uisger02
		local ll2_KWT "School enrollment, preprimary (% gross)"
		local l3_KWT neomort
		local ll3_KWT "Mortality rate, neonatal (per 1,000 live births)"
		local e1_KWT mort514
		local le1_KWT "Mortality rate (children aged 5 to 14 years)"
		local e2_KWT b_hygiene_sch
		local le2_KWT "Proportion of schools with basic hygiene services"
		local e3_KWT uiscr1
		local le3_KWT "Primary school completion (%) "
		local h1_KWT lastnm_ter_ger
		local lh1_KWT "School enrollment, tertiary (% gross)"
		local h2_KWT une_2eap_mf_y
		local lh2_KWT "Youth unemployment (%), ages 15-24"
		local h3_KWT lastnm_afr
		local lh3_KWT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_KWT sp_dyn_le00_in
		local lb1_KWT "Life expectancy at birth (years)"
		local b2_KWT b_water_health
		local lb2_KWT "Proportion of health care facilities with basic water services"
		local b3_KWT une_2eap_mf_a
		local lb3_KWT "Unemployment (%), ages 25+"
		local l1_LAO u5_anaemia
		local ll1_LAO "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_LAO neomort
		local ll2_LAO "Mortality rate, neonatal (per 1,000 live births)"
		local l3_LAO uisger02
		local ll3_LAO "School enrollment, preprimary (% gross)"
		local e1_LAO mort514
		local le1_LAO "Mortality rate (children aged 5 to 14 years)"
		local e2_LAO uiscr1
		local le2_LAO "Primary school completion (%) "
		local e3_LAO se_lpv_prim
		local le3_LAO "Learning Poverty"
		local h1_LAO une_2eap_mf_y
		local lh1_LAO "Youth unemployment (%), ages 15-24"
		local h2_LAO lastnm_afr
		local lh2_LAO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LAO uiscr3
		local lh3_LAO "Completion rate, upper secondary education (%)"
		local b1_LAO b_water_health
		local lb1_LAO "Proportion of health care facilities with basic water services"
		local b2_LAO une_2eap_mf_a
		local lb2_LAO "Unemployment (%), ages 25+"
		local b3_LAO sp_dyn_le00_in
		local lb3_LAO "Life expectancy at birth (years)"
		local l1_LBN neomort
		local ll1_LBN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LBN u5_anaemia
		local ll2_LBN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_LBN vacHEPB3
		local ll3_LBN "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local e1_LBN b_hygiene_sch
		local le1_LBN "Proportion of schools with basic hygiene services"
		local e2_LBN uisxgdpfsgov
		local le2_LBN "Government expenditure on education (% GPD)"
		local e3_LBN mort514
		local le3_LBN "Mortality rate (children aged 5 to 14 years)"
		local h1_LBN lastnm_afr
		local lh1_LBN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LBN eip_neet_mf_y
		local lh2_LBN "Youth NEET (%), ages 15-24"
		local h3_LBN une_2eap_mf_y
		local lh3_LBN "Youth unemployment (%), ages 15-24"
		local b1_LBN sp_dyn_le00_in
		local lb1_LBN "Life expectancy at birth (years)"
		local b2_LBN b_water_health
		local lb2_LBN "Proportion of health care facilities with basic water services"
		local b3_LBN une_2eap_mf_a
		local lb3_LBN "Unemployment (%), ages 25+"
		local l1_LBR neomort
		local ll1_LBR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LBR uisger02
		local ll2_LBR "School enrollment, preprimary (% gross)"
		local l3_LBR Minimum meal frequency (%), 6-23 months
		local ll3_LBR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_LBR lastnm_sec_ger
		local le1_LBR "School enrollment, secondary (% gross)"
		local e2_LBR mort514
		local le2_LBR "Mortality rate (children aged 5 to 14 years)"
		local e3_LBR Child labor (%), ages 5-17
		local le3_LBR "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_LBR lastnm_afr
		local lh1_LBR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LBR une_2eap_mf_y
		local lh2_LBR "Youth unemployment (%), ages 15-24"
		local h3_LBR uiscr3
		local lh3_LBR "Completion rate, upper secondary education (%)"
		local b1_LBR une_2eap_mf_a
		local lb1_LBR "Unemployment (%), ages 25+"
		local b2_LBR sp_dyn_le00_in
		local lb2_LBR "Life expectancy at birth (years)"
		local b3_LBR probdeath_ncd
		local lb3_LBR "Cause of death, by non-communicable diseases (% of total)"
		local l1_LCA neomort
		local ll1_LCA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LCA u5_anaemia
		local ll2_LCA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_LCA uisger02
		local ll3_LCA "School enrollment, preprimary (% gross)"
		local e1_LCA mort514
		local le1_LCA "Mortality rate (children aged 5 to 14 years)"
		local e2_LCA b_hygiene_sch
		local le2_LCA "Proportion of schools with basic hygiene services"
		local e3_LCA uiscr1
		local le3_LCA "Primary school completion (%) "
		local h1_LCA lastnm_afr
		local lh1_LCA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LCA eip_neet_mf_y
		local lh2_LCA "Youth NEET (%), ages 15-24"
		local h3_LCA uiscr3
		local lh3_LCA "Completion rate, upper secondary education (%)"
		local b1_LCA emp_nifl_a
		local lb1_LCA "Adult informal employment rate (%), ages 25+"
		local b2_LCA sp_dyn_le00_in
		local lb2_LCA "Life expectancy at birth (years)"
		local b3_LCA une_2eap_mf_a
		local lb3_LCA "Unemployment (%), ages 25+"
		local l1_LKA u5_anaemia
		local ll1_LKA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_LKA uisger02
		local ll2_LKA "School enrollment, preprimary (% gross)"
		local l3_LKA neomort
		local ll3_LKA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_LKA lastnm_sec_ger
		local le1_LKA "School enrollment, secondary (% gross)"
		local e2_LKA uiscr1
		local le2_LKA "Primary school completion (%) "
		local e3_LKA mort514
		local le3_LKA "Mortality rate (children aged 5 to 14 years)"
		local h1_LKA lastnm_ter_ger
		local lh1_LKA "School enrollment, tertiary (% gross)"
		local h2_LKA lastnm_afr
		local lh2_LKA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LKA eip_neet_mf_y
		local lh3_LKA "Youth NEET (%), ages 15-24"
		local b1_LKA sp_dyn_le00_in
		local lb1_LKA "Life expectancy at birth (years)"
		local b2_LKA une_2eap_mf_a
		local lb2_LKA "Unemployment (%), ages 25+"
		local b3_LKA b_water_health
		local lb3_LKA "Proportion of health care facilities with basic water services"
		local l1_LSO neomort
		local ll1_LSO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LSO Minimum meal frequency (%), 6-23 months
		local ll2_LSO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_LSO uisger02
		local ll3_LSO "School enrollment, preprimary (% gross)"
		local e1_LSO mort514
		local le1_LSO "Mortality rate (children aged 5 to 14 years)"
		local e2_LSO uiscr1
		local le2_LSO "Primary school completion (%) "
		local e3_LSO Child labor (%), ages 5-17
		local le3_LSO "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_LSO eip_neet_mf_y
		local lh1_LSO "Youth NEET (%), ages 15-24"
		local h2_LSO uiscr3
		local lh2_LSO "Completion rate, upper secondary education (%)"
		local h3_LSO lastnm_afr
		local lh3_LSO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_LSO une_2eap_mf_a
		local lb1_LSO "Unemployment (%), ages 25+"
		local b2_LSO probdeath_ncd
		local lb2_LSO "Cause of death, by non-communicable diseases (% of total)"
		local b3_LSO sp_dyn_le00_in
		local lb3_LSO "Life expectancy at birth (years)"
		local l1_LTU u5_anaemia
		local ll1_LTU "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_LTU neomort
		local ll2_LTU "Mortality rate, neonatal (per 1,000 live births)"
		local l3_LTU uisger02
		local ll3_LTU "School enrollment, preprimary (% gross)"
		local e1_LTU lastnm_sec_ger
		local le1_LTU "School enrollment, secondary (% gross)"
		local e2_LTU uiscr1
		local le2_LTU "Primary school completion (%) "
		local e3_LTU mort514
		local le3_LTU "Mortality rate (children aged 5 to 14 years)"
		local h1_LTU lastnm_ter_ger
		local lh1_LTU "School enrollment, tertiary (% gross)"
		local h2_LTU une_2eap_mf_y
		local lh2_LTU "Youth unemployment (%), ages 15-24"
		local h3_LTU lastnm_afr
		local lh3_LTU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_LTU b_water_health
		local lb1_LTU "Proportion of health care facilities with basic water services"
		local b2_LTU une_2eap_mf_a
		local lb2_LTU "Unemployment (%), ages 25+"
		local b3_LTU sp_dyn_le00_in
		local lb3_LTU "Life expectancy at birth (years)"
		local l1_LUX uisger02
		local ll1_LUX "School enrollment, preprimary (% gross)"
		local l2_LUX neomort
		local ll2_LUX "Mortality rate, neonatal (per 1,000 live births)"
		local l3_LUX u5_anaemia
		local ll3_LUX "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_LUX lastnm_sec_ger
		local le1_LUX "School enrollment, secondary (% gross)"
		local e2_LUX mort514
		local le2_LUX "Mortality rate (children aged 5 to 14 years)"
		local e3_LUX uiscr1
		local le3_LUX "Primary school completion (%) "
		local h1_LUX lastnm_ter_ger
		local lh1_LUX "School enrollment, tertiary (% gross)"
		local h2_LUX lastnm_afr
		local lh2_LUX "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LUX une_2eap_mf_y
		local lh3_LUX "Youth unemployment (%), ages 15-24"
		local b1_LUX une_2eap_mf_a
		local lb1_LUX "Unemployment (%), ages 25+"
		local b2_LUX probdeath_ncd
		local lb2_LUX "Cause of death, by non-communicable diseases (% of total)"
		local b3_LUX sp_dyn_le00_in
		local lb3_LUX "Life expectancy at birth (years)"
		local l1_LVA u5_anaemia
		local ll1_LVA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_LVA uisger02
		local ll2_LVA "School enrollment, preprimary (% gross)"
		local l3_LVA neomort
		local ll3_LVA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_LVA mort514
		local le1_LVA "Mortality rate (children aged 5 to 14 years)"
		local e2_LVA uiscr1
		local le2_LVA "Primary school completion (%) "
		local e3_LVA b_hygiene_sch
		local le3_LVA "Proportion of schools with basic hygiene services"
		local h1_LVA lastnm_ter_ger
		local lh1_LVA "School enrollment, tertiary (% gross)"
		local h2_LVA une_2eap_mf_y
		local lh2_LVA "Youth unemployment (%), ages 15-24"
		local h3_LVA lastnm_afr
		local lh3_LVA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_LVA sp_dyn_le00_in
		local lb1_LVA "Life expectancy at birth (years)"
		local b2_LVA une_2eap_mf_a
		local lb2_LVA "Unemployment (%), ages 25+"
		local b3_LVA probdeath_ncd
		local lb3_LVA "Cause of death, by non-communicable diseases (% of total)"
		local l1_MAC uisger02
		local ll1_MAC "School enrollment, preprimary (% gross)"
		local l2_MAC psurv
		local ll2_MAC "Probability of Survival to Age 5"
		local l3_MAC
		local ll3_MAC ""
		local e1_MAC uiscr1
		local le1_MAC "Primary school completion (%) "
		local e2_MAC lastnm_sec_ger
		local le2_MAC "School enrollment, secondary (% gross)"
		local e3_MAC uisxgdpfsgov
		local le3_MAC "Government expenditure on education (% GPD)"
		local h1_MAC lastnm_ter_ger
		local lh1_MAC "School enrollment, tertiary (% gross)"
		local h2_MAC une_2eap_mf_y
		local lh2_MAC "Youth unemployment (%), ages 15-24"
		local h3_MAC lastnm_afr
		local lh3_MAC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MAC eap_2wap_mf_a
		local lb1_MAC "Labour force participation (%), ages 25+"
		local b2_MAC une_2eap_mf_a
		local lb2_MAC "Unemployment (%), ages 25+"
		local b3_MAC sp_dyn_le00_in
		local lb3_MAC "Life expectancy at birth (years)"
		local l1_MAR u5_anaemia
		local ll1_MAR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_MAR uisger02
		local ll2_MAR "School enrollment, preprimary (% gross)"
		local l3_MAR neomort
		local ll3_MAR "Mortality rate, neonatal (per 1,000 live births)"
		local e1_MAR mort514
		local le1_MAR "Mortality rate (children aged 5 to 14 years)"
		local e2_MAR uiscr1
		local le2_MAR "Primary school completion (%) "
		local e3_MAR lastnm_sec_ger
		local le3_MAR "School enrollment, secondary (% gross)"
		local h1_MAR une_2eap_mf_y
		local lh1_MAR "Youth unemployment (%), ages 15-24"
		local h2_MAR lastnm_afr
		local lh2_MAR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MAR uiscr3
		local lh3_MAR "Completion rate, upper secondary education (%)"
		local b1_MAR une_2eap_mf_a
		local lb1_MAR "Unemployment (%), ages 25+"
		local b2_MAR sp_dyn_le00_in
		local lb2_MAR "Life expectancy at birth (years)"
		local b3_MAR probdeath_ncd
		local lb3_MAR "Cause of death, by non-communicable diseases (% of total)"
		local l1_MDA uisger02
		local ll1_MDA "School enrollment, preprimary (% gross)"
		local l2_MDA neomort
		local ll2_MDA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MDA u5_anaemia
		local ll3_MDA "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_MDA b_hygiene_sch
		local le1_MDA "Proportion of schools with basic hygiene services"
		local e2_MDA uiscr1
		local le2_MDA "Primary school completion (%) "
		local e3_MDA mort514
		local le3_MDA "Mortality rate (children aged 5 to 14 years)"
		local h1_MDA lastnm_afr
		local lh1_MDA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MDA uiscr3
		local lh2_MDA "Completion rate, upper secondary education (%)"
		local h3_MDA une_2eap_mf_y
		local lh3_MDA "Youth unemployment (%), ages 15-24"
		local b1_MDA une_2eap_mf_a
		local lb1_MDA "Unemployment (%), ages 25+"
		local b2_MDA probdeath_ncd
		local lb2_MDA "Cause of death, by non-communicable diseases (% of total)"
		local b3_MDA sp_dyn_le00_in
		local lb3_MDA "Life expectancy at birth (years)"
		local l1_MDG Minimum meal frequency (%), 6-23 months
		local ll1_MDG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_MDG neomort
		local ll2_MDG "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MDG uisger02
		local ll3_MDG "School enrollment, preprimary (% gross)"
		local e1_MDG Child labor (%), ages 5-17
		local le1_MDG "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_MDG mort514
		local le2_MDG "Mortality rate (children aged 5 to 14 years)"
		local e3_MDG se_lpv_prim
		local le3_MDG "Learning Poverty"
		local h1_MDG une_2eap_mf_y
		local lh1_MDG "Youth unemployment (%), ages 15-24"
		local h2_MDG lastnm_afr
		local lh2_MDG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MDG uiscr3
		local lh3_MDG "Completion rate, upper secondary education (%)"
		local b1_MDG probdeath_ncd
		local lb1_MDG "Cause of death, by non-communicable diseases (% of total)"
		local b2_MDG une_2eap_mf_a
		local lb2_MDG "Unemployment (%), ages 25+"
		local b3_MDG sp_dyn_le00_in
		local lb3_MDG "Life expectancy at birth (years)"
		local l1_MEX uisger02
		local ll1_MEX "School enrollment, preprimary (% gross)"
		local l2_MEX neomort
		local ll2_MEX "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MEX u5_anaemia
		local ll3_MEX "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_MEX mort514
		local le1_MEX "Mortality rate (children aged 5 to 14 years)"
		local e2_MEX se_lpv_prim
		local le2_MEX "Learning Poverty"
		local e3_MEX Child labor (%), ages 5-17
		local le3_MEX "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_MEX uiscr3
		local lh1_MEX "Completion rate, upper secondary education (%)"
		local h2_MEX eip_neet_mf_y
		local lh2_MEX "Youth NEET (%), ages 15-24"
		local h3_MEX lastnm_afr
		local lh3_MEX "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MEX une_2eap_mf_a
		local lb1_MEX "Unemployment (%), ages 25+"
		local b2_MEX emp_nifl_a
		local lb2_MEX "Adult informal employment rate (%), ages 25+"
		local b3_MEX sp_dyn_le00_in
		local lb3_MEX "Life expectancy at birth (years)"
		local l1_MHL neomort
		local ll1_MHL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MHL u5_anaemia
		local ll2_MHL "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_MHL uisger02
		local ll3_MHL "School enrollment, preprimary (% gross)"
		local e1_MHL uiscr1
		local le1_MHL "Primary school completion (%) "
		local e2_MHL mort514
		local le2_MHL "Mortality rate (children aged 5 to 14 years)"
		local e3_MHL lastnm_sec_ger
		local le3_MHL "School enrollment, secondary (% gross)"
		local h1_MHL eip_neet_mf_y
		local lh1_MHL "Youth NEET (%), ages 15-24"
		local h2_MHL lastnm_ter_ger
		local lh2_MHL "School enrollment, tertiary (% gross)"
		local h3_MHL mort1524
		local lh3_MHL "Mortality rate (children aged 15 to 24 years)"
		local b1_MHL refugees
		local lb1_MHL "Refugees under UNHCR’s mandate"
		local b2_MHL emp_nifl_a
		local lb2_MHL "Adult informal employment rate (%), ages 25+"
		local b3_MHL hypertension
		local lb3_MHL "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local l1_MKD Minimum meal frequency (%), 6-23 months
		local ll1_MKD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_MKD uisger02
		local ll2_MKD "School enrollment, preprimary (% gross)"
		local l3_MKD neomort
		local ll3_MKD "Mortality rate, neonatal (per 1,000 live births)"
		local e1_MKD Child labor (%), ages 5-17
		local le1_MKD "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_MKD se_lpv_prim
		local le2_MKD "Learning Poverty"
		local e3_MKD mort514
		local le3_MKD "Mortality rate (children aged 5 to 14 years)"
		local h1_MKD eip_neet_mf_y
		local lh1_MKD "Youth NEET (%), ages 15-24"
		local h2_MKD lastnm_afr
		local lh2_MKD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MKD uiscr3
		local lh3_MKD "Completion rate, upper secondary education (%)"
		local b1_MKD une_2eap_mf_a
		local lb1_MKD "Unemployment (%), ages 25+"
		local b2_MKD sp_dyn_le00_in
		local lb2_MKD "Life expectancy at birth (years)"
		local b3_MKD b_water_health
		local lb3_MKD "Proportion of health care facilities with basic water services"
		local l1_MLI neomort
		local ll1_MLI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MLI Minimum meal frequency (%), 6-23 months
		local ll2_MLI "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MLI uisger02
		local ll3_MLI "School enrollment, preprimary (% gross)"
		local e1_MLI mort514
		local le1_MLI "Mortality rate (children aged 5 to 14 years)"
		local e2_MLI lastnm_sec_ger
		local le2_MLI "School enrollment, secondary (% gross)"
		local e3_MLI b_hygiene_sch
		local le3_MLI "Proportion of schools with basic hygiene services"
		local h1_MLI uiscr3
		local lh1_MLI "Completion rate, upper secondary education (%)"
		local h2_MLI eip_neet_mf_y
		local lh2_MLI "Youth NEET (%), ages 15-24"
		local h3_MLI lastnm_afr
		local lh3_MLI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MLI sp_dyn_le00_in
		local lb1_MLI "Life expectancy at birth (years)"
		local b2_MLI emp_nifl_a
		local lb2_MLI "Adult informal employment rate (%), ages 25+"
		local b3_MLI une_2eap_mf_a
		local lb3_MLI "Unemployment (%), ages 25+"
		local l1_MLT uisger02
		local ll1_MLT "School enrollment, preprimary (% gross)"
		local l2_MLT neomort
		local ll2_MLT "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MLT u5_anaemia
		local ll3_MLT "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_MLT lastnm_sec_ger
		local le1_MLT "School enrollment, secondary (% gross)"
		local e2_MLT mort514
		local le2_MLT "Mortality rate (children aged 5 to 14 years)"
		local e3_MLT uiscr1
		local le3_MLT "Primary school completion (%) "
		local h1_MLT lastnm_afr
		local lh1_MLT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MLT lastnm_ter_ger
		local lh2_MLT "School enrollment, tertiary (% gross)"
		local h3_MLT une_2eap_mf_y
		local lh3_MLT "Youth unemployment (%), ages 15-24"
		local b1_MLT probdeath_ncd
		local lb1_MLT "Cause of death, by non-communicable diseases (% of total)"
		local b2_MLT sp_dyn_le00_in
		local lb2_MLT "Life expectancy at birth (years)"
		local b3_MLT une_2eap_mf_a
		local lb3_MLT "Unemployment (%), ages 25+"
		local l1_MMR u5_anaemia
		local ll1_MMR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_MMR neomort
		local ll2_MMR "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MMR uisger02
		local ll3_MMR "School enrollment, preprimary (% gross)"
		local e1_MMR mort514
		local le1_MMR "Mortality rate (children aged 5 to 14 years)"
		local e2_MMR uiscr1
		local le2_MMR "Primary school completion (%) "
		local e3_MMR se_lpv_prim
		local le3_MMR "Learning Poverty"
		local h1_MMR eip_neet_mf_y
		local lh1_MMR "Youth NEET (%), ages 15-24"
		local h2_MMR lastnm_afr
		local lh2_MMR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MMR uiscr3
		local lh3_MMR "Completion rate, upper secondary education (%)"
		local b1_MMR sp_dyn_le00_in
		local lb1_MMR "Life expectancy at birth (years)"
		local b2_MMR emp_nifl_a
		local lb2_MMR "Adult informal employment rate (%), ages 25+"
		local b3_MMR une_2eap_mf_a
		local lb3_MMR "Unemployment (%), ages 25+"
		local l1_MNE Minimum meal frequency (%), 6-23 months
		local ll1_MNE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_MNE neomort
		local ll2_MNE "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MNE uisger02
		local ll3_MNE "School enrollment, preprimary (% gross)"
		local e1_MNE se_lpv_prim
		local le1_MNE "Learning Poverty"
		local e2_MNE lastnm_sec_ger
		local le2_MNE "School enrollment, secondary (% gross)"
		local e3_MNE uiscr1
		local le3_MNE "Primary school completion (%) "
		local h1_MNE uiscr3
		local lh1_MNE "Completion rate, upper secondary education (%)"
		local h2_MNE eip_neet_mf_y
		local lh2_MNE "Youth NEET (%), ages 15-24"
		local h3_MNE lastnm_afr
		local lh3_MNE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MNE probdeath_ncd
		local lb1_MNE "Cause of death, by non-communicable diseases (% of total)"
		local b2_MNE sp_dyn_le00_in
		local lb2_MNE "Life expectancy at birth (years)"
		local b3_MNE une_2eap_mf_a
		local lb3_MNE "Unemployment (%), ages 25+"
		local l1_MNG Minimum meal frequency (%), 6-23 months
		local ll1_MNG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_MNG uisger02
		local ll2_MNG "School enrollment, preprimary (% gross)"
		local l3_MNG neomort
		local ll3_MNG "Mortality rate, neonatal (per 1,000 live births)"
		local e1_MNG uiscr1
		local le1_MNG "Primary school completion (%) "
		local e2_MNG Child labor (%), ages 5-17
		local le2_MNG "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_MNG mort514
		local le3_MNG "Mortality rate (children aged 5 to 14 years)"
		local h1_MNG eip_neet_mf_y
		local lh1_MNG "Youth NEET (%), ages 15-24"
		local h2_MNG uiscr3
		local lh2_MNG "Completion rate, upper secondary education (%)"
		local h3_MNG lastnm_afr
		local lh3_MNG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MNG emp_nifl_a
		local lb1_MNG "Adult informal employment rate (%), ages 25+"
		local b2_MNG une_2eap_mf_a
		local lb2_MNG "Unemployment (%), ages 25+"
		local b3_MNG sp_dyn_le00_in
		local lb3_MNG "Life expectancy at birth (years)"
		local l1_MOZ vacHEPB3
		local ll1_MOZ "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_MOZ neomort
		local ll2_MOZ "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MOZ u5_anaemia
		local ll3_MOZ "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_MOZ uiscr1
		local le1_MOZ "Primary school completion (%) "
		local e2_MOZ mort514
		local le2_MOZ "Mortality rate (children aged 5 to 14 years)"
		local e3_MOZ lastnm_sec_ger
		local le3_MOZ "School enrollment, secondary (% gross)"
		local h1_MOZ une_2eap_mf_y
		local lh1_MOZ "Youth unemployment (%), ages 15-24"
		local h2_MOZ lastnm_afr
		local lh2_MOZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MOZ uiscr3
		local lh3_MOZ "Completion rate, upper secondary education (%)"
		local b1_MOZ b_water_health
		local lb1_MOZ "Proportion of health care facilities with basic water services"
		local b2_MOZ sp_dyn_le00_in
		local lb2_MOZ "Life expectancy at birth (years)"
		local b3_MOZ une_2eap_mf_a
		local lb3_MOZ "Unemployment (%), ages 25+"
		local l1_MRT lastnm_birth_reg
		local ll1_MRT "Completeness of birth registration (%)"
		local l2_MRT neomort
		local ll2_MRT "Mortality rate, neonatal (per 1,000 live births)"
		local l3_MRT u5_anaemia
		local ll3_MRT "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_MRT lastnm_sec_ger
		local le1_MRT "School enrollment, secondary (% gross)"
		local e2_MRT uiscr1
		local le2_MRT "Primary school completion (%) "
		local e3_MRT mort514
		local le3_MRT "Mortality rate (children aged 5 to 14 years)"
		local h1_MRT uiscr3
		local lh1_MRT "Completion rate, upper secondary education (%)"
		local h2_MRT une_2eap_mf_y
		local lh2_MRT "Youth unemployment (%), ages 15-24"
		local h3_MRT lastnm_afr
		local lh3_MRT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MRT sp_dyn_le00_in
		local lb1_MRT "Life expectancy at birth (years)"
		local b2_MRT probdeath_ncd
		local lb2_MRT "Cause of death, by non-communicable diseases (% of total)"
		local b3_MRT une_2eap_mf_a
		local lb3_MRT "Unemployment (%), ages 25+"
		local l1_MUS u5_anaemia
		local ll1_MUS "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_MUS uisger02
		local ll2_MUS "School enrollment, preprimary (% gross)"
		local l3_MUS neomort
		local ll3_MUS "Mortality rate, neonatal (per 1,000 live births)"
		local e1_MUS b_hygiene_sch
		local le1_MUS "Proportion of schools with basic hygiene services"
		local e2_MUS uiscr1
		local le2_MUS "Primary school completion (%) "
		local e3_MUS mort514
		local le3_MUS "Mortality rate (children aged 5 to 14 years)"
		local h1_MUS lastnm_afr
		local lh1_MUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MUS uiscr3
		local lh2_MUS "Completion rate, upper secondary education (%)"
		local h3_MUS eip_neet_mf_y
		local lh3_MUS "Youth NEET (%), ages 15-24"
		local b1_MUS sp_dyn_le00_in
		local lb1_MUS "Life expectancy at birth (years)"
		local b2_MUS probdeath_ncd
		local lb2_MUS "Cause of death, by non-communicable diseases (% of total)"
		local b3_MUS une_2eap_mf_a
		local lb3_MUS "Unemployment (%), ages 25+"
		local l1_MWI neomort
		local ll1_MWI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MWI u5_anaemia
		local ll2_MWI "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_MWI care
		local ll3_MWI "Postnatal contact with a health provider within 2 days of delivery"
		local e1_MWI Child labor (%), ages 5-17
		local le1_MWI "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_MWI uiscr1
		local le2_MWI "Primary school completion (%) "
		local e3_MWI mort514
		local le3_MWI "Mortality rate (children aged 5 to 14 years)"
		local h1_MWI uiscr3
		local lh1_MWI "Completion rate, upper secondary education (%)"
		local h2_MWI eip_neet_mf_y
		local lh2_MWI "Youth NEET (%), ages 15-24"
		local h3_MWI lastnm_afr
		local lh3_MWI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_MWI b_water_health
		local lb1_MWI "Proportion of health care facilities with basic water services"
		local b2_MWI une_2eap_mf_a
		local lb2_MWI "Unemployment (%), ages 25+"
		local b3_MWI sp_dyn_le00_in
		local lb3_MWI "Life expectancy at birth (years)"
		local l1_MYS uisger02
		local ll1_MYS "School enrollment, preprimary (% gross)"
		local l2_MYS u5_anaemia
		local ll2_MYS "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_MYS neomort
		local ll3_MYS "Mortality rate, neonatal (per 1,000 live births)"
		local e1_MYS mort514
		local le1_MYS "Mortality rate (children aged 5 to 14 years)"
		local e2_MYS uiscr1
		local le2_MYS "Primary school completion (%) "
		local e3_MYS se_lpv_prim
		local le3_MYS "Learning Poverty"
		local h1_MYS lastnm_afr
		local lh1_MYS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MYS une_2eap_mf_y
		local lh2_MYS "Youth unemployment (%), ages 15-24"
		local h3_MYS uiscr3
		local lh3_MYS "Completion rate, upper secondary education (%)"
		local b1_MYS sp_dyn_le00_in
		local lb1_MYS "Life expectancy at birth (years)"
		local b2_MYS une_2eap_mf_a
		local lb2_MYS "Unemployment (%), ages 25+"
		local b3_MYS probdeath_ncd
		local lb3_MYS "Cause of death, by non-communicable diseases (% of total)"
		local l1_NAM neomort
		local ll1_NAM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NAM uisger02
		local ll2_NAM "School enrollment, preprimary (% gross)"
		local l3_NAM u5_anaemia
		local ll3_NAM "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_NAM mort514
		local le1_NAM "Mortality rate (children aged 5 to 14 years)"
		local e2_NAM uisxgdpfsgov
		local le2_NAM "Government expenditure on education (% GPD)"
		local e3_NAM uiscr1
		local le3_NAM "Primary school completion (%) "
		local h1_NAM eip_neet_mf_y
		local lh1_NAM "Youth NEET (%), ages 15-24"
		local h2_NAM uiscr3
		local lh2_NAM "Completion rate, upper secondary education (%)"
		local h3_NAM lastnm_afr
		local lh3_NAM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_NAM probdeath_ncd
		local lb1_NAM "Cause of death, by non-communicable diseases (% of total)"
		local b2_NAM sp_dyn_le00_in
		local lb2_NAM "Life expectancy at birth (years)"
		local b3_NAM une_2eap_mf_a
		local lb3_NAM "Unemployment (%), ages 25+"
		local l1_NER Minimum meal frequency (%), 6-23 months
		local ll1_NER "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_NER neomort
		local ll2_NER "Mortality rate, neonatal (per 1,000 live births)"
		local l3_NER uisger02
		local ll3_NER "School enrollment, preprimary (% gross)"
		local e1_NER se_lpv_prim
		local le1_NER "Learning Poverty"
		local e2_NER mort514
		local le2_NER "Mortality rate (children aged 5 to 14 years)"
		local e3_NER uiscr1
		local le3_NER "Primary school completion (%) "
		local h1_NER une_2eap_mf_y
		local lh1_NER "Youth unemployment (%), ages 15-24"
		local h2_NER lastnm_afr
		local lh2_NER "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NER uiscr3
		local lh3_NER "Completion rate, upper secondary education (%)"
		local b1_NER sp_dyn_le00_in
		local lb1_NER "Life expectancy at birth (years)"
		local b2_NER une_2eap_mf_a
		local lb2_NER "Unemployment (%), ages 25+"
		local b3_NER b_water_health
		local lb3_NER "Proportion of health care facilities with basic water services"
		local l1_NGA Minimum meal frequency (%), 6-23 months
		local ll1_NGA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_NGA uisger02
		local ll2_NGA "School enrollment, preprimary (% gross)"
		local l3_NGA neomort
		local ll3_NGA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_NGA lastnm_sec_ger
		local le1_NGA "School enrollment, secondary (% gross)"
		local e2_NGA mort514
		local le2_NGA "Mortality rate (children aged 5 to 14 years)"
		local e3_NGA Child labor (%), ages 5-17
		local le3_NGA "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_NGA uiscr3
		local lh1_NGA "Completion rate, upper secondary education (%)"
		local h2_NGA lastnm_afr
		local lh2_NGA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NGA eip_neet_mf_y
		local lh3_NGA "Youth NEET (%), ages 15-24"
		local b1_NGA une_2eap_mf_a
		local lb1_NGA "Unemployment (%), ages 25+"
		local b2_NGA sp_dyn_le00_in
		local lb2_NGA "Life expectancy at birth (years)"
		local b3_NGA b_water_health
		local lb3_NGA "Proportion of health care facilities with basic water services"
		local l1_NIC u5_anaemia
		local ll1_NIC "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_NIC uisger02
		local ll2_NIC "School enrollment, preprimary (% gross)"
		local l3_NIC neomort
		local ll3_NIC "Mortality rate, neonatal (per 1,000 live births)"
		local e1_NIC se_lpv_prim
		local le1_NIC "Learning Poverty"
		local e2_NIC b_hygiene_sch
		local le2_NIC "Proportion of schools with basic hygiene services"
		local e3_NIC mort514
		local le3_NIC "Mortality rate (children aged 5 to 14 years)"
		local h1_NIC lastnm_afr
		local lh1_NIC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_NIC uiscr3
		local lh2_NIC "Completion rate, upper secondary education (%)"
		local h3_NIC une_2eap_mf_y
		local lh3_NIC "Youth unemployment (%), ages 15-24"
		local b1_NIC sp_dyn_le00_in
		local lb1_NIC "Life expectancy at birth (years)"
		local b2_NIC b_water_health
		local lb2_NIC "Proportion of health care facilities with basic water services"
		local b3_NIC une_2eap_mf_a
		local lb3_NIC "Unemployment (%), ages 25+"
		local l1_NLD u5_anaemia
		local ll1_NLD "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_NLD uisger02
		local ll2_NLD "School enrollment, preprimary (% gross)"
		local l3_NLD neomort
		local ll3_NLD "Mortality rate, neonatal (per 1,000 live births)"
		local e1_NLD lastnm_sec_ger
		local le1_NLD "School enrollment, secondary (% gross)"
		local e2_NLD mort514
		local le2_NLD "Mortality rate (children aged 5 to 14 years)"
		local e3_NLD b_hygiene_sch
		local le3_NLD "Proportion of schools with basic hygiene services"
		local h1_NLD une_2eap_mf_y
		local lh1_NLD "Youth unemployment (%), ages 15-24"
		local h2_NLD lastnm_afr
		local lh2_NLD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NLD lastnm_ter_ger
		local lh3_NLD "School enrollment, tertiary (% gross)"
		local b1_NLD probdeath_ncd
		local lb1_NLD "Cause of death, by non-communicable diseases (% of total)"
		local b2_NLD une_2eap_mf_a
		local lb2_NLD "Unemployment (%), ages 25+"
		local b3_NLD sp_dyn_le00_in
		local lb3_NLD "Life expectancy at birth (years)"
		local l1_NOR neomort
		local ll1_NOR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NOR u5_anaemia
		local ll2_NOR "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_NOR uisger02
		local ll3_NOR "School enrollment, preprimary (% gross)"
		local e1_NOR mort514
		local le1_NOR "Mortality rate (children aged 5 to 14 years)"
		local e2_NOR uiscr1
		local le2_NOR "Primary school completion (%) "
		local e3_NOR b_hygiene_sch
		local le3_NOR "Proportion of schools with basic hygiene services"
		local h1_NOR une_2eap_mf_y
		local lh1_NOR "Youth unemployment (%), ages 15-24"
		local h2_NOR lastnm_afr
		local lh2_NOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NOR lastnm_ter_ger
		local lh3_NOR "School enrollment, tertiary (% gross)"
		local b1_NOR probdeath_ncd
		local lb1_NOR "Cause of death, by non-communicable diseases (% of total)"
		local b2_NOR sp_dyn_le00_in
		local lb2_NOR "Life expectancy at birth (years)"
		local b3_NOR une_2eap_mf_a
		local lb3_NOR "Unemployment (%), ages 25+"
		local l1_NPL Minimum meal frequency (%), 6-23 months
		local ll1_NPL "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_NPL uisger02
		local ll2_NPL "School enrollment, preprimary (% gross)"
		local l3_NPL neomort
		local ll3_NPL "Mortality rate, neonatal (per 1,000 live births)"
		local e1_NPL uiscr1
		local le1_NPL "Primary school completion (%) "
		local e2_NPL lastnm_sec_ger
		local le2_NPL "School enrollment, secondary (% gross)"
		local e3_NPL mort514
		local le3_NPL "Mortality rate (children aged 5 to 14 years)"
		local h1_NPL uiscr3
		local lh1_NPL "Completion rate, upper secondary education (%)"
		local h2_NPL lastnm_afr
		local lh2_NPL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NPL une_2eap_mf_y
		local lh3_NPL "Youth unemployment (%), ages 15-24"
		local b1_NPL une_2eap_mf_a
		local lb1_NPL "Unemployment (%), ages 25+"
		local b2_NPL sp_dyn_le00_in
		local lb2_NPL "Life expectancy at birth (years)"
		local b3_NPL probdeath_ncd
		local lb3_NPL "Cause of death, by non-communicable diseases (% of total)"
		local l1_NRU uisger02
		local ll1_NRU "School enrollment, preprimary (% gross)"
		local l2_NRU u5_anaemia
		local ll2_NRU "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_NRU neomort
		local ll3_NRU "Mortality rate, neonatal (per 1,000 live births)"
		local e1_NRU uiscr1
		local le1_NRU "Primary school completion (%) "
		local e2_NRU b_hygiene_sch
		local le2_NRU "Proportion of schools with basic hygiene services"
		local e3_NRU mort514
		local le3_NRU "Mortality rate (children aged 5 to 14 years)"
		local h1_NRU uisqutp2t3
		local lh1_NRU "Qualified teachers in secondary education (%)"
		local h2_NRU mort1524
		local lh2_NRU "Mortality rate (children aged 15 to 24 years)"
		local h3_NRU
		local lh3_NRU ""
		local b1_NRU hypertension
		local lb1_NRU "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local b2_NRU refugees
		local lb2_NRU "Refugees under UNHCR’s mandate"
		local b3_NRU A_seekers
		local lb3_NRU " "
		local l1_NZL neomort
		local ll1_NZL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NZL uisger02
		local ll2_NZL "School enrollment, preprimary (% gross)"
		local l3_NZL u5_anaemia
		local ll3_NZL "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_NZL mort514
		local le1_NZL "Mortality rate (children aged 5 to 14 years)"
		local e2_NZL uisxgdpfsgov
		local le2_NZL "Government expenditure on education (% GPD)"
		local e3_NZL lastnm_sec_ger
		local le3_NZL "School enrollment, secondary (% gross)"
		local h1_NZL une_2eap_mf_y
		local lh1_NZL "Youth unemployment (%), ages 15-24"
		local h2_NZL lastnm_ter_ger
		local lh2_NZL "School enrollment, tertiary (% gross)"
		local h3_NZL lastnm_afr
		local lh3_NZL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_NZL probdeath_ncd
		local lb1_NZL "Cause of death, by non-communicable diseases (% of total)"
		local b2_NZL une_2eap_mf_a
		local lb2_NZL "Unemployment (%), ages 25+"
		local b3_NZL sp_dyn_le00_in
		local lb3_NZL "Life expectancy at birth (years)"
		local l1_OMN uisger02
		local ll1_OMN "School enrollment, preprimary (% gross)"
		local l2_OMN u5_anaemia
		local ll2_OMN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_OMN neomort
		local ll3_OMN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_OMN lastnm_sec_ger
		local le1_OMN "School enrollment, secondary (% gross)"
		local e2_OMN mort514
		local le2_OMN "Mortality rate (children aged 5 to 14 years)"
		local e3_OMN uiscr1
		local le3_OMN "Primary school completion (%) "
		local h1_OMN lastnm_ter_ger
		local lh1_OMN "School enrollment, tertiary (% gross)"
		local h2_OMN lastnm_afr
		local lh2_OMN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_OMN une_2eap_mf_y
		local lh3_OMN "Youth unemployment (%), ages 15-24"
		local b1_OMN b_water_health
		local lb1_OMN "Proportion of health care facilities with basic water services"
		local b2_OMN une_2eap_mf_a
		local lb2_OMN "Unemployment (%), ages 25+"
		local b3_OMN sp_dyn_le00_in
		local lb3_OMN "Life expectancy at birth (years)"
		local l1_PAK neomort
		local ll1_PAK "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PAK Minimum meal frequency (%), 6-23 months
		local ll2_PAK "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_PAK uisger02
		local ll3_PAK "School enrollment, preprimary (% gross)"
		local e1_PAK Child labor (%), ages 5-17
		local le1_PAK "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_PAK uiscr1
		local le2_PAK "Primary school completion (%) "
		local e3_PAK mort514
		local le3_PAK "Mortality rate (children aged 5 to 14 years)"
		local h1_PAK lastnm_afr
		local lh1_PAK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PAK uiscr3
		local lh2_PAK "Completion rate, upper secondary education (%)"
		local h3_PAK eip_neet_mf_y
		local lh3_PAK "Youth NEET (%), ages 15-24"
		local b1_PAK sp_dyn_le00_in
		local lb1_PAK "Life expectancy at birth (years)"
		local b2_PAK emp_nifl_a
		local lb2_PAK "Adult informal employment rate (%), ages 25+"
		local b3_PAK une_2eap_mf_a
		local lb3_PAK "Unemployment (%), ages 25+"
		local l1_PAN u5_anaemia
		local ll1_PAN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_PAN uisger02
		local ll2_PAN "School enrollment, preprimary (% gross)"
		local l3_PAN neomort
		local ll3_PAN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_PAN se_lpv_prim
		local le1_PAN "Learning Poverty"
		local e2_PAN mort514
		local le2_PAN "Mortality rate (children aged 5 to 14 years)"
		local e3_PAN uiscr1
		local le3_PAN "Primary school completion (%) "
		local h1_PAN eip_neet_mf_y
		local lh1_PAN "Youth NEET (%), ages 15-24"
		local h2_PAN lastnm_afr
		local lh2_PAN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PAN uiscr3
		local lh3_PAN "Completion rate, upper secondary education (%)"
		local b1_PAN sp_dyn_le00_in
		local lb1_PAN "Life expectancy at birth (years)"
		local b2_PAN une_2eap_mf_a
		local lb2_PAN "Unemployment (%), ages 25+"
		local b3_PAN emp_nifl_a
		local lb3_PAN "Adult informal employment rate (%), ages 25+"
		local l1_PER u5_anaemia
		local ll1_PER "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_PER neomort
		local ll2_PER "Mortality rate, neonatal (per 1,000 live births)"
		local l3_PER uisger02
		local ll3_PER "School enrollment, preprimary (% gross)"
		local e1_PER mort514
		local le1_PER "Mortality rate (children aged 5 to 14 years)"
		local e2_PER se_lpv_prim
		local le2_PER "Learning Poverty"
		local e3_PER Child labor (%), ages 5-17
		local le3_PER "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_PER lastnm_afr
		local lh1_PER "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PER uiscr3
		local lh2_PER "Completion rate, upper secondary education (%)"
		local h3_PER eip_neet_mf_y
		local lh3_PER "Youth NEET (%), ages 15-24"
		local b1_PER une_2eap_mf_a
		local lb1_PER "Unemployment (%), ages 25+"
		local b2_PER b_water_health
		local lb2_PER "Proportion of health care facilities with basic water services"
		local b3_PER sp_dyn_le00_in
		local lb3_PER "Life expectancy at birth (years)"
		local l1_PHL uisger02
		local ll1_PHL "School enrollment, preprimary (% gross)"
		local l2_PHL neomort
		local ll2_PHL "Mortality rate, neonatal (per 1,000 live births)"
		local l3_PHL u5_anaemia
		local ll3_PHL "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_PHL Child labor (%), ages 5-17
		local le1_PHL "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_PHL mort514
		local le2_PHL "Mortality rate (children aged 5 to 14 years)"
		local e3_PHL se_lpv_prim
		local le3_PHL "Learning Poverty"
		local h1_PHL uiscr3
		local lh1_PHL "Completion rate, upper secondary education (%)"
		local h2_PHL lastnm_afr
		local lh2_PHL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PHL eip_neet_mf_y
		local lh3_PHL "Youth NEET (%), ages 15-24"
		local b1_PHL sp_dyn_le00_in
		local lb1_PHL "Life expectancy at birth (years)"
		local b2_PHL une_2eap_mf_a
		local lb2_PHL "Unemployment (%), ages 25+"
		local b3_PHL probdeath_ncd
		local lb3_PHL "Cause of death, by non-communicable diseases (% of total)"
		local l1_PLW neomort
		local ll1_PLW "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PLW u5_anaemia
		local ll2_PLW "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_PLW uisger02
		local ll3_PLW "School enrollment, preprimary (% gross)"
		local e1_PLW mort514
		local le1_PLW "Mortality rate (children aged 5 to 14 years)"
		local e2_PLW b_hygiene_sch
		local le2_PLW "Proportion of schools with basic hygiene services"
		local e3_PLW uiscr1
		local le3_PLW "Primary school completion (%) "
		local h1_PLW mort1524
		local lh1_PLW "Mortality rate (children aged 15 to 24 years)"
		local h2_PLW
		local lh2_PLW ""
		local h3_PLW
		local lh3_PLW ""
		local b1_PLW asr
		local lb1_PLW "Survival Rate from Age 15-60"
		local b2_PLW hci_lower
		local lb2_PLW "Human Capital Index, Lower Bound (scale 0-1)"
		local b3_PLW hypertension
		local lb3_PLW "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local l1_PNG uisger02
		local ll1_PNG "School enrollment, preprimary (% gross)"
		local l2_PNG u5_anaemia
		local ll2_PNG "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_PNG neomort
		local ll3_PNG "Mortality rate, neonatal (per 1,000 live births)"
		local e1_PNG lastnm_sec_ger
		local le1_PNG "School enrollment, secondary (% gross)"
		local e2_PNG b_hygiene_sch
		local le2_PNG "Proportion of schools with basic hygiene services"
		local e3_PNG mort514
		local le3_PNG "Mortality rate (children aged 5 to 14 years)"
		local h1_PNG lastnm_afr
		local lh1_PNG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PNG une_2eap_mf_y
		local lh2_PNG "Youth unemployment (%), ages 15-24"
		local h3_PNG uiscr3
		local lh3_PNG "Completion rate, upper secondary education (%)"
		local b1_PNG sp_dyn_le00_in
		local lb1_PNG "Life expectancy at birth (years)"
		local b2_PNG une_2eap_mf_a
		local lb2_PNG "Unemployment (%), ages 25+"
		local b3_PNG b_water_health
		local lb3_PNG "Proportion of health care facilities with basic water services"
		local l1_POL vacHEPB3
		local ll1_POL "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_POL uisger02
		local ll2_POL "School enrollment, preprimary (% gross)"
		local l3_POL neomort
		local ll3_POL "Mortality rate, neonatal (per 1,000 live births)"
		local e1_POL uiscr1
		local le1_POL "Primary school completion (%) "
		local e2_POL mort514
		local le2_POL "Mortality rate (children aged 5 to 14 years)"
		local e3_POL b_hygiene_sch
		local le3_POL "Proportion of schools with basic hygiene services"
		local h1_POL lastnm_ter_ger
		local lh1_POL "School enrollment, tertiary (% gross)"
		local h2_POL lastnm_afr
		local lh2_POL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_POL une_2eap_mf_y
		local lh3_POL "Youth unemployment (%), ages 15-24"
		local b1_POL sp_dyn_le00_in
		local lb1_POL "Life expectancy at birth (years)"
		local b2_POL probdeath_ncd
		local lb2_POL "Cause of death, by non-communicable diseases (% of total)"
		local b3_POL une_2eap_mf_a
		local lb3_POL "Unemployment (%), ages 25+"
		local l1_PRT u5_anaemia
		local ll1_PRT "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_PRT uisger02
		local ll2_PRT "School enrollment, preprimary (% gross)"
		local l3_PRT neomort
		local ll3_PRT "Mortality rate, neonatal (per 1,000 live births)"
		local e1_PRT mort514
		local le1_PRT "Mortality rate (children aged 5 to 14 years)"
		local e2_PRT uiscr1
		local le2_PRT "Primary school completion (%) "
		local e3_PRT b_hygiene_sch
		local le3_PRT "Proportion of schools with basic hygiene services"
		local h1_PRT une_2eap_mf_y
		local lh1_PRT "Youth unemployment (%), ages 15-24"
		local h2_PRT lastnm_ter_ger
		local lh2_PRT "School enrollment, tertiary (% gross)"
		local h3_PRT lastnm_afr
		local lh3_PRT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_PRT probdeath_ncd
		local lb1_PRT "Cause of death, by non-communicable diseases (% of total)"
		local b2_PRT une_2eap_mf_a
		local lb2_PRT "Unemployment (%), ages 25+"
		local b3_PRT sp_dyn_le00_in
		local lb3_PRT "Life expectancy at birth (years)"
		local l1_PRY u5_anaemia
		local ll1_PRY "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_PRY uisger02
		local ll2_PRY "School enrollment, preprimary (% gross)"
		local l3_PRY neomort
		local ll3_PRY "Mortality rate, neonatal (per 1,000 live births)"
		local e1_PRY mort514
		local le1_PRY "Mortality rate (children aged 5 to 14 years)"
		local e2_PRY se_lpv_prim
		local le2_PRY "Learning Poverty"
		local e3_PRY b_hygiene_sch
		local le3_PRY "Proportion of schools with basic hygiene services"
		local h1_PRY lastnm_afr
		local lh1_PRY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PRY uiscr3
		local lh2_PRY "Completion rate, upper secondary education (%)"
		local h3_PRY une_2eap_mf_y
		local lh3_PRY "Youth unemployment (%), ages 15-24"
		local b1_PRY b_water_health
		local lb1_PRY "Proportion of health care facilities with basic water services"
		local b2_PRY une_2eap_mf_a
		local lb2_PRY "Unemployment (%), ages 25+"
		local b3_PRY sp_dyn_le00_in
		local lb3_PRY "Life expectancy at birth (years)"
		local l1_PSE Minimum meal frequency (%), 6-23 months
		local ll1_PSE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_PSE neomort
		local ll2_PSE "Mortality rate, neonatal (per 1,000 live births)"
		local l3_PSE uisger02
		local ll3_PSE "School enrollment, preprimary (% gross)"
		local e1_PSE uiscr1
		local le1_PSE "Primary school completion (%) "
		local e2_PSE mort514
		local le2_PSE "Mortality rate (children aged 5 to 14 years)"
		local e3_PSE Child labor (%), ages 5-17
		local le3_PSE "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_PSE lastnm_afr
		local lh1_PSE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PSE uiscr3
		local lh2_PSE "Completion rate, upper secondary education (%)"
		local h3_PSE eip_neet_mf_y
		local lh3_PSE "Youth NEET (%), ages 15-24"
		local b1_PSE sp_dyn_le00_in
		local lb1_PSE "Life expectancy at birth (years)"
		local b2_PSE b_water_health
		local lb2_PSE "Proportion of health care facilities with basic water services"
		local b3_PSE une_2eap_mf_a
		local lb3_PSE "Unemployment (%), ages 25+"
		local l1_QAT u5_anaemia
		local ll1_QAT "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_QAT uisger02
		local ll2_QAT "School enrollment, preprimary (% gross)"
		local l3_QAT neomort
		local ll3_QAT "Mortality rate, neonatal (per 1,000 live births)"
		local e1_QAT mort514
		local le1_QAT "Mortality rate (children aged 5 to 14 years)"
		local e2_QAT b_hygiene_sch
		local le2_QAT "Proportion of schools with basic hygiene services"
		local e3_QAT uiscr1
		local le3_QAT "Primary school completion (%) "
		local h1_QAT lastnm_ter_ger
		local lh1_QAT "School enrollment, tertiary (% gross)"
		local h2_QAT une_2eap_mf_y
		local lh2_QAT "Youth unemployment (%), ages 15-24"
		local h3_QAT lastnm_afr
		local lh3_QAT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_QAT sp_dyn_le00_in
		local lb1_QAT "Life expectancy at birth (years)"
		local b2_QAT probdeath_ncd
		local lb2_QAT "Cause of death, by non-communicable diseases (% of total)"
		local b3_QAT une_2eap_mf_a
		local lb3_QAT "Unemployment (%), ages 25+"
		local l1_ROU uisger02
		local ll1_ROU "School enrollment, preprimary (% gross)"
		local l2_ROU neomort
		local ll2_ROU "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ROU lastnm_birth_reg
		local ll3_ROU "Completeness of birth registration (%)"
		local e1_ROU lastnm_sec_ger
		local le1_ROU "School enrollment, secondary (% gross)"
		local e2_ROU uisxgdpfsgov
		local le2_ROU "Government expenditure on education (% GPD)"
		local e3_ROU uiscr1
		local le3_ROU "Primary school completion (%) "
		local h1_ROU une_2eap_mf_y
		local lh1_ROU "Youth unemployment (%), ages 15-24"
		local h2_ROU lastnm_afr
		local lh2_ROU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ROU lastnm_ter_ger
		local lh3_ROU "School enrollment, tertiary (% gross)"
		local b1_ROU une_2eap_mf_a
		local lb1_ROU "Unemployment (%), ages 25+"
		local b2_ROU sp_dyn_le00_in
		local lb2_ROU "Life expectancy at birth (years)"
		local b3_ROU probdeath_ncd
		local lb3_ROU "Cause of death, by non-communicable diseases (% of total)"
		local l1_RUS neomort
		local ll1_RUS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_RUS uisger02
		local ll2_RUS "School enrollment, preprimary (% gross)"
		local l3_RUS u5_anaemia
		local ll3_RUS "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_RUS uiscr1
		local le1_RUS "Primary school completion (%) "
		local e2_RUS mort514
		local le2_RUS "Mortality rate (children aged 5 to 14 years)"
		local e3_RUS lastnm_sec_ger
		local le3_RUS "School enrollment, secondary (% gross)"
		local h1_RUS une_2eap_mf_y
		local lh1_RUS "Youth unemployment (%), ages 15-24"
		local h2_RUS lastnm_afr
		local lh2_RUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_RUS uiscr3
		local lh3_RUS "Completion rate, upper secondary education (%)"
		local b1_RUS sp_dyn_le00_in
		local lb1_RUS "Life expectancy at birth (years)"
		local b2_RUS probdeath_ncd
		local lb2_RUS "Cause of death, by non-communicable diseases (% of total)"
		local b3_RUS une_2eap_mf_a
		local lb3_RUS "Unemployment (%), ages 25+"
		local l1_RWA neomort
		local ll1_RWA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_RWA uisger02
		local ll2_RWA "School enrollment, preprimary (% gross)"
		local l3_RWA u5_anaemia
		local ll3_RWA "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_RWA lastnm_sec_ger
		local le1_RWA "School enrollment, secondary (% gross)"
		local e2_RWA uiscr1
		local le2_RWA "Primary school completion (%) "
		local e3_RWA mort514
		local le3_RWA "Mortality rate (children aged 5 to 14 years)"
		local h1_RWA eip_neet_mf_y
		local lh1_RWA "Youth NEET (%), ages 15-24"
		local h2_RWA lastnm_afr
		local lh2_RWA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_RWA uiscr3
		local lh3_RWA "Completion rate, upper secondary education (%)"
		local b1_RWA sp_dyn_le00_in
		local lb1_RWA "Life expectancy at birth (years)"
		local b2_RWA une_2eap_mf_a
		local lb2_RWA "Unemployment (%), ages 25+"
		local b3_RWA b_water_health
		local lb3_RWA "Proportion of health care facilities with basic water services"
		local l1_SAU uisger02
		local ll1_SAU "School enrollment, preprimary (% gross)"
		local l2_SAU neomort
		local ll2_SAU "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SAU u5_anaemia
		local ll3_SAU "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_SAU lastnm_sec_ger
		local le1_SAU "School enrollment, secondary (% gross)"
		local e2_SAU uiscr1
		local le2_SAU "Primary school completion (%) "
		local e3_SAU mort514
		local le3_SAU "Mortality rate (children aged 5 to 14 years)"
		local h1_SAU une_2eap_mf_y
		local lh1_SAU "Youth unemployment (%), ages 15-24"
		local h2_SAU lastnm_afr
		local lh2_SAU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SAU lastnm_ter_ger
		local lh3_SAU "School enrollment, tertiary (% gross)"
		local b1_SAU une_2eap_mf_a
		local lb1_SAU "Unemployment (%), ages 25+"
		local b2_SAU sp_dyn_le00_in
		local lb2_SAU "Life expectancy at birth (years)"
		local b3_SAU probdeath_ncd
		local lb3_SAU "Cause of death, by non-communicable diseases (% of total)"
		local l1_SDN neomort
		local ll1_SDN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SDN uisger02
		local ll2_SDN "School enrollment, preprimary (% gross)"
		local l3_SDN u5_anaemia
		local ll3_SDN "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_SDN mort514
		local le1_SDN "Mortality rate (children aged 5 to 14 years)"
		local e2_SDN b_hygiene_sch
		local le2_SDN "Proportion of schools with basic hygiene services"
		local e3_SDN uiscr1
		local le3_SDN "Primary school completion (%) "
		local h1_SDN lastnm_afr
		local lh1_SDN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SDN une_2eap_mf_y
		local lh2_SDN "Youth unemployment (%), ages 15-24"
		local h3_SDN uiscr3
		local lh3_SDN "Completion rate, upper secondary education (%)"
		local b1_SDN sp_dyn_le00_in
		local lb1_SDN "Life expectancy at birth (years)"
		local b2_SDN une_2eap_mf_a
		local lb2_SDN "Unemployment (%), ages 25+"
		local b3_SDN b_water_health
		local lb3_SDN "Proportion of health care facilities with basic water services"
		local l1_SEN Minimum meal frequency (%), 6-23 months
		local ll1_SEN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_SEN uisger02
		local ll2_SEN "School enrollment, preprimary (% gross)"
		local l3_SEN neomort
		local ll3_SEN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_SEN se_lpv_prim
		local le1_SEN "Learning Poverty"
		local e2_SEN uiscr1
		local le2_SEN "Primary school completion (%) "
		local e3_SEN mort514
		local le3_SEN "Mortality rate (children aged 5 to 14 years)"
		local h1_SEN eip_neet_mf_y
		local lh1_SEN "Youth NEET (%), ages 15-24"
		local h2_SEN lastnm_afr
		local lh2_SEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SEN uiscr3
		local lh3_SEN "Completion rate, upper secondary education (%)"
		local b1_SEN une_2eap_mf_a
		local lb1_SEN "Unemployment (%), ages 25+"
		local b2_SEN b_water_health
		local lb2_SEN "Proportion of health care facilities with basic water services"
		local b3_SEN sp_dyn_le00_in
		local lb3_SEN "Life expectancy at birth (years)"
		local l1_SGP u5_anaemia
		local ll1_SGP "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_SGP neomort
		local ll2_SGP "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SGP uisger02
		local ll3_SGP "School enrollment, preprimary (% gross)"
		local e1_SGP b_hygiene_sch
		local le1_SGP "Proportion of schools with basic hygiene services"
		local e2_SGP mort514
		local le2_SGP "Mortality rate (children aged 5 to 14 years)"
		local e3_SGP uiscr1
		local le3_SGP "Primary school completion (%) "
		local h1_SGP une_2eap_mf_y
		local lh1_SGP "Youth unemployment (%), ages 15-24"
		local h2_SGP lastnm_ter_ger
		local lh2_SGP "School enrollment, tertiary (% gross)"
		local h3_SGP lastnm_afr
		local lh3_SGP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SGP probdeath_ncd
		local lb1_SGP "Cause of death, by non-communicable diseases (% of total)"
		local b2_SGP sp_dyn_le00_in
		local lb2_SGP "Life expectancy at birth (years)"
		local b3_SGP une_2eap_mf_a
		local lb3_SGP "Unemployment (%), ages 25+"
		local l1_SLB uisger02
		local ll1_SLB "School enrollment, preprimary (% gross)"
		local l2_SLB u5_anaemia
		local ll2_SLB "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_SLB neomort
		local ll3_SLB "Mortality rate, neonatal (per 1,000 live births)"
		local e1_SLB mort514
		local le1_SLB "Mortality rate (children aged 5 to 14 years)"
		local e2_SLB uiscr1
		local le2_SLB "Primary school completion (%) "
		local e3_SLB b_hygiene_sch
		local le3_SLB "Proportion of schools with basic hygiene services"
		local h1_SLB uisqutp2t3
		local lh1_SLB "Qualified teachers in secondary education (%)"
		local h2_SLB une_2eap_mf_y
		local lh2_SLB "Youth unemployment (%), ages 15-24"
		local h3_SLB lastnm_afr
		local lh3_SLB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SLB une_2eap_mf_a
		local lb1_SLB "Unemployment (%), ages 25+"
		local b2_SLB sp_dyn_le00_in
		local lb2_SLB "Life expectancy at birth (years)"
		local b3_SLB b_water_health
		local lb3_SLB "Proportion of health care facilities with basic water services"
		local l1_SLE Minimum meal frequency (%), 6-23 months
		local ll1_SLE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_SLE neomort
		local ll2_SLE "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SLE uisger02
		local ll3_SLE "School enrollment, preprimary (% gross)"
		local e1_SLE b_sanitation_sch
		local le1_SLE "Proportion of schools with basic sanitation services"
		local e2_SLE uiscr1
		local le2_SLE "Primary school completion (%) "
		local e3_SLE mort514
		local le3_SLE "Mortality rate (children aged 5 to 14 years)"
		local h1_SLE uiscr3
		local lh1_SLE "Completion rate, upper secondary education (%)"
		local h2_SLE lastnm_afr
		local lh2_SLE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SLE eip_neet_mf_y
		local lh3_SLE "Youth NEET (%), ages 15-24"
		local b1_SLE sp_dyn_le00_in
		local lb1_SLE "Life expectancy at birth (years)"
		local b2_SLE b_water_health
		local lb2_SLE "Proportion of health care facilities with basic water services"
		local b3_SLE une_2eap_mf_a
		local lb3_SLE "Unemployment (%), ages 25+"
		local l1_SLV u5_anaemia
		local ll1_SLV "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_SLV neomort
		local ll2_SLV "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SLV lastnm_birth_reg
		local ll3_SLV "Completeness of birth registration (%)"
		local e1_SLV uisxgdpfsgov
		local le1_SLV "Government expenditure on education (% GPD)"
		local e2_SLV Child labor (%), ages 5-17
		local le2_SLV "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_SLV mort514
		local le3_SLV "Mortality rate (children aged 5 to 14 years)"
		local h1_SLV lastnm_afr
		local lh1_SLV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SLV uiscr3
		local lh2_SLV "Completion rate, upper secondary education (%)"
		local h3_SLV eip_neet_mf_y
		local lh3_SLV "Youth NEET (%), ages 15-24"
		local b1_SLV une_2eap_mf_a
		local lb1_SLV "Unemployment (%), ages 25+"
		local b2_SLV sp_dyn_le00_in
		local lb2_SLV "Life expectancy at birth (years)"
		local b3_SLV emp_nifl_a
		local lb3_SLV "Adult informal employment rate (%), ages 25+"
		local l1_SRB Minimum meal frequency (%), 6-23 months
		local ll1_SRB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_SRB neomort
		local ll2_SRB "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SRB uisger02
		local ll3_SRB "School enrollment, preprimary (% gross)"
		local e1_SRB mort514
		local le1_SRB "Mortality rate (children aged 5 to 14 years)"
		local e2_SRB se_lpv_prim
		local le2_SRB "Learning Poverty"
		local e3_SRB Child labor (%), ages 5-17
		local le3_SRB "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_SRB eip_neet_mf_y
		local lh1_SRB "Youth NEET (%), ages 15-24"
		local h2_SRB uiscr3
		local lh2_SRB "Completion rate, upper secondary education (%)"
		local h3_SRB lastnm_afr
		local lh3_SRB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SRB une_2eap_mf_a
		local lb1_SRB "Unemployment (%), ages 25+"
		local b2_SRB b_water_health
		local lb2_SRB "Proportion of health care facilities with basic water services"
		local b3_SRB sp_dyn_le00_in
		local lb3_SRB "Life expectancy at birth (years)"
		local l1_SSD u5_anaemia
		local ll1_SSD "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_SSD uisger02
		local ll2_SSD "School enrollment, preprimary (% gross)"
		local l3_SSD neomort
		local ll3_SSD "Mortality rate, neonatal (per 1,000 live births)"
		local e1_SSD mort514
		local le1_SSD "Mortality rate (children aged 5 to 14 years)"
		local e2_SSD b_hygiene_sch
		local le2_SSD "Proportion of schools with basic hygiene services"
		local e3_SSD eyrs
		local le3_SSD "Expected Years of School"
		local h1_SSD uiscr3
		local lh1_SSD "Completion rate, upper secondary education (%)"
		local h2_SSD une_2eap_mf_y
		local lh2_SSD "Youth unemployment (%), ages 15-24"
		local h3_SSD lastnm_afr
		local lh3_SSD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SSD sp_dyn_le00_in
		local lb1_SSD "Life expectancy at birth (years)"
		local b2_SSD une_2eap_mf_a
		local lb2_SSD "Unemployment (%), ages 25+"
		local b3_SSD probdeath_ncd
		local lb3_SSD "Cause of death, by non-communicable diseases (% of total)"
		local l1_SVK uisger02
		local ll1_SVK "School enrollment, preprimary (% gross)"
		local l2_SVK u5_anaemia
		local ll2_SVK "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_SVK neomort
		local ll3_SVK "Mortality rate, neonatal (per 1,000 live births)"
		local e1_SVK uiscr1
		local le1_SVK "Primary school completion (%) "
		local e2_SVK mort514
		local le2_SVK "Mortality rate (children aged 5 to 14 years)"
		local e3_SVK b_hygiene_sch
		local le3_SVK "Proportion of schools with basic hygiene services"
		local h1_SVK une_2eap_mf_y
		local lh1_SVK "Youth unemployment (%), ages 15-24"
		local h2_SVK lastnm_afr
		local lh2_SVK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SVK lastnm_ter_ger
		local lh3_SVK "School enrollment, tertiary (% gross)"
		local b1_SVK une_2eap_mf_a
		local lb1_SVK "Unemployment (%), ages 25+"
		local b2_SVK probdeath_ncd
		local lb2_SVK "Cause of death, by non-communicable diseases (% of total)"
		local b3_SVK sp_dyn_le00_in
		local lb3_SVK "Life expectancy at birth (years)"
		local l1_SVN uisger02
		local ll1_SVN "School enrollment, preprimary (% gross)"
		local l2_SVN u5_anaemia
		local ll2_SVN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_SVN neomort
		local ll3_SVN "Mortality rate, neonatal (per 1,000 live births)"
		local e1_SVN mort514
		local le1_SVN "Mortality rate (children aged 5 to 14 years)"
		local e2_SVN uiscr1
		local le2_SVN "Primary school completion (%) "
		local e3_SVN b_hygiene_sch
		local le3_SVN "Proportion of schools with basic hygiene services"
		local h1_SVN une_2eap_mf_y
		local lh1_SVN "Youth unemployment (%), ages 15-24"
		local h2_SVN lastnm_ter_ger
		local lh2_SVN "School enrollment, tertiary (% gross)"
		local h3_SVN lastnm_afr
		local lh3_SVN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SVN probdeath_ncd
		local lb1_SVN "Cause of death, by non-communicable diseases (% of total)"
		local b2_SVN une_2eap_mf_a
		local lb2_SVN "Unemployment (%), ages 25+"
		local b3_SVN sp_dyn_le00_in
		local lb3_SVN "Life expectancy at birth (years)"
		local l1_SWE neomort
		local ll1_SWE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SWE uisger02
		local ll2_SWE "School enrollment, preprimary (% gross)"
		local l3_SWE u5_anaemia
		local ll3_SWE "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_SWE mort514
		local le1_SWE "Mortality rate (children aged 5 to 14 years)"
		local e2_SWE uiscr1
		local le2_SWE "Primary school completion (%) "
		local e3_SWE lastnm_sec_ger
		local le3_SWE "School enrollment, secondary (% gross)"
		local h1_SWE lastnm_ter_ger
		local lh1_SWE "School enrollment, tertiary (% gross)"
		local h2_SWE une_2eap_mf_y
		local lh2_SWE "Youth unemployment (%), ages 15-24"
		local h3_SWE lastnm_afr
		local lh3_SWE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SWE une_2eap_mf_a
		local lb1_SWE "Unemployment (%), ages 25+"
		local b2_SWE probdeath_ncd
		local lb2_SWE "Cause of death, by non-communicable diseases (% of total)"
		local b3_SWE sp_dyn_le00_in
		local lb3_SWE "Life expectancy at birth (years)"
		local l1_SWZ vacHEPB3
		local ll1_SWZ "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_SWZ neomort
		local ll2_SWZ "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SWZ u5_anaemia
		local ll3_SWZ "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_SWZ mort514
		local le1_SWZ "Mortality rate (children aged 5 to 14 years)"
		local e2_SWZ uiscr1
		local le2_SWZ "Primary school completion (%) "
		local e3_SWZ uisxgdpfsgov
		local le3_SWZ "Government expenditure on education (% GPD)"
		local h1_SWZ uiscr3
		local lh1_SWZ "Completion rate, upper secondary education (%)"
		local h2_SWZ lastnm_afr
		local lh2_SWZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SWZ une_2eap_mf_y
		local lh3_SWZ "Youth unemployment (%), ages 15-24"
		local b1_SWZ probdeath_ncd
		local lb1_SWZ "Cause of death, by non-communicable diseases (% of total)"
		local b2_SWZ une_2eap_mf_a
		local lb2_SWZ "Unemployment (%), ages 25+"
		local b3_SWZ sp_dyn_le00_in
		local lb3_SWZ "Life expectancy at birth (years)"
		local l1_SYC u5_anaemia
		local ll1_SYC "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_SYC neomort
		local ll2_SYC "Mortality rate, neonatal (per 1,000 live births)"
		local l3_SYC uisger02
		local ll3_SYC "School enrollment, preprimary (% gross)"
		local e1_SYC b_hygiene_sch
		local le1_SYC "Proportion of schools with basic hygiene services"
		local e2_SYC uiscr1
		local le2_SYC "Primary school completion (%) "
		local e3_SYC mort514
		local le3_SYC "Mortality rate (children aged 5 to 14 years)"
		local h1_SYC lastnm_ter_ger
		local lh1_SYC "School enrollment, tertiary (% gross)"
		local h2_SYC eip_neet_mf_y
		local lh2_SYC "Youth NEET (%), ages 15-24"
		local h3_SYC lastnm_afr
		local lh3_SYC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_SYC probdeath_ncd
		local lb1_SYC "Cause of death, by non-communicable diseases (% of total)"
		local b2_SYC emp_nifl_a
		local lb2_SYC "Adult informal employment rate (%), ages 25+"
		local b3_SYC sp_dyn_le00_in
		local lb3_SYC "Life expectancy at birth (years)"
		local l1_TCD uisger02
		local ll1_TCD "School enrollment, preprimary (% gross)"
		local l2_TCD Minimum meal frequency (%), 6-23 months
		local ll2_TCD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TCD neomort
		local ll3_TCD "Mortality rate, neonatal (per 1,000 live births)"
		local e1_TCD mort514
		local le1_TCD "Mortality rate (children aged 5 to 14 years)"
		local e2_TCD se_lpv_prim
		local le2_TCD "Learning Poverty"
		local e3_TCD Child labor (%), ages 5-17
		local le3_TCD "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_TCD lastnm_afr
		local lh1_TCD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TCD uiscr3
		local lh2_TCD "Completion rate, upper secondary education (%)"
		local h3_TCD eip_neet_mf_y
		local lh3_TCD "Youth NEET (%), ages 15-24"
		local b1_TCD sp_dyn_le00_in
		local lb1_TCD "Life expectancy at birth (years)"
		local b2_TCD probdeath_ncd
		local lb2_TCD "Cause of death, by non-communicable diseases (% of total)"
		local b3_TCD une_2eap_mf_a
		local lb3_TCD "Unemployment (%), ages 25+"
		local l1_TGO u5_anaemia
		local ll1_TGO "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_TGO neomort
		local ll2_TGO "Mortality rate, neonatal (per 1,000 live births)"
		local l3_TGO uisger02
		local ll3_TGO "School enrollment, preprimary (% gross)"
		local e1_TGO uiscr1
		local le1_TGO "Primary school completion (%) "
		local e2_TGO se_lpv_prim
		local le2_TGO "Learning Poverty"
		local e3_TGO mort514
		local le3_TGO "Mortality rate (children aged 5 to 14 years)"
		local h1_TGO uiscr3
		local lh1_TGO "Completion rate, upper secondary education (%)"
		local h2_TGO une_2eap_mf_y
		local lh2_TGO "Youth unemployment (%), ages 15-24"
		local h3_TGO lastnm_afr
		local lh3_TGO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_TGO une_2eap_mf_a
		local lb1_TGO "Unemployment (%), ages 25+"
		local b2_TGO sp_dyn_le00_in
		local lb2_TGO "Life expectancy at birth (years)"
		local b3_TGO probdeath_ncd
		local lb3_TGO "Cause of death, by non-communicable diseases (% of total)"
		local l1_THA Minimum meal frequency (%), 6-23 months
		local ll1_THA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_THA neomort
		local ll2_THA "Mortality rate, neonatal (per 1,000 live births)"
		local l3_THA uisger02
		local ll3_THA "School enrollment, preprimary (% gross)"
		local e1_THA lastnm_sec_ger
		local le1_THA "School enrollment, secondary (% gross)"
		local e2_THA mort514
		local le2_THA "Mortality rate (children aged 5 to 14 years)"
		local e3_THA uiscr1
		local le3_THA "Primary school completion (%) "
		local h1_THA uiscr3
		local lh1_THA "Completion rate, upper secondary education (%)"
		local h2_THA eip_neet_mf_y
		local lh2_THA "Youth NEET (%), ages 15-24"
		local h3_THA lastnm_afr
		local lh3_THA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_THA sp_dyn_le00_in
		local lb1_THA "Life expectancy at birth (years)"
		local b2_THA b_water_health
		local lb2_THA "Proportion of health care facilities with basic water services"
		local b3_THA une_2eap_mf_a
		local lb3_THA "Unemployment (%), ages 25+"
		local l1_TJK u5_anaemia
		local ll1_TJK "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_TJK neomort
		local ll2_TJK "Mortality rate, neonatal (per 1,000 live births)"
		local l3_TJK vacHEPB3
		local ll3_TJK "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local e1_TJK b_hygiene_sch
		local le1_TJK "Proportion of schools with basic hygiene services"
		local e2_TJK mort514
		local le2_TJK "Mortality rate (children aged 5 to 14 years)"
		local e3_TJK uisxgdpfsgov
		local le3_TJK "Government expenditure on education (% GPD)"
		local h1_TJK une_2eap_mf_y
		local lh1_TJK "Youth unemployment (%), ages 15-24"
		local h2_TJK lastnm_afr
		local lh2_TJK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TJK uiscr3
		local lh3_TJK "Completion rate, upper secondary education (%)"
		local b1_TJK probdeath_ncd
		local lb1_TJK "Cause of death, by non-communicable diseases (% of total)"
		local b2_TJK sp_dyn_le00_in
		local lb2_TJK "Life expectancy at birth (years)"
		local b3_TJK une_2eap_mf_a
		local lb3_TJK "Unemployment (%), ages 25+"
		local l1_TLS uisger02
		local ll1_TLS "School enrollment, preprimary (% gross)"
		local l2_TLS neomort
		local ll2_TLS "Mortality rate, neonatal (per 1,000 live births)"
		local l3_TLS Minimum meal frequency (%), 6-23 months
		local ll3_TLS "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_TLS b_hygiene_sch
		local le1_TLS "Proportion of schools with basic hygiene services"
		local e2_TLS uiscr1
		local le2_TLS "Primary school completion (%) "
		local e3_TLS mort514
		local le3_TLS "Mortality rate (children aged 5 to 14 years)"
		local h1_TLS uisqutp2t3
		local lh1_TLS "Qualified teachers in secondary education (%)"
		local h2_TLS lastnm_afr
		local lh2_TLS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TLS une_2eap_mf_y
		local lh3_TLS "Youth unemployment (%), ages 15-24"
		local b1_TLS sp_dyn_le00_in
		local lb1_TLS "Life expectancy at birth (years)"
		local b2_TLS probdeath_ncd
		local lb2_TLS "Cause of death, by non-communicable diseases (% of total)"
		local b3_TLS une_2eap_mf_a
		local lb3_TLS "Unemployment (%), ages 25+"
		local l1_TON Minimum meal frequency (%), 6-23 months
		local ll1_TON "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_TON neomort
		local ll2_TON "Mortality rate, neonatal (per 1,000 live births)"
		local l3_TON uisger02
		local ll3_TON "School enrollment, preprimary (% gross)"
		local e1_TON mort514
		local le1_TON "Mortality rate (children aged 5 to 14 years)"
		local e2_TON uiscr1
		local le2_TON "Primary school completion (%) "
		local e3_TON Child labor (%), ages 5-17
		local le3_TON "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local h1_TON lastnm_afr
		local lh1_TON "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TON uiscr3
		local lh2_TON "Completion rate, upper secondary education (%)"
		local h3_TON eip_neet_mf_y
		local lh3_TON "Youth NEET (%), ages 15-24"
		local b1_TON sp_dyn_le00_in
		local lb1_TON "Life expectancy at birth (years)"
		local b2_TON une_2eap_mf_a
		local lb2_TON "Unemployment (%), ages 25+"
		local b3_TON b_water_health
		local lb3_TON "Proportion of health care facilities with basic water services"
		local l1_TTO neomort
		local ll1_TTO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TTO uisger02
		local ll2_TTO "School enrollment, preprimary (% gross)"
		local l3_TTO u5_anaemia
		local ll3_TTO "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_TTO uisxgdpfsgov
		local le1_TTO "Government expenditure on education (% GPD)"
		local e2_TTO mort514
		local le2_TTO "Mortality rate (children aged 5 to 14 years)"
		local e3_TTO eyrs
		local le3_TTO "Expected Years of School"
		local h1_TTO uiscr3
		local lh1_TTO "Completion rate, upper secondary education (%)"
		local h2_TTO une_2eap_mf_y
		local lh2_TTO "Youth unemployment (%), ages 15-24"
		local h3_TTO lastnm_afr
		local lh3_TTO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_TTO sp_dyn_le00_in
		local lb1_TTO "Life expectancy at birth (years)"
		local b2_TTO une_2eap_mf_a
		local lb2_TTO "Unemployment (%), ages 25+"
		local b3_TTO probdeath_ncd
		local lb3_TTO "Cause of death, by non-communicable diseases (% of total)"
		local l1_TUN neomort
		local ll1_TUN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUN u5_anaemia
		local ll2_TUN "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_TUN Minimum meal frequency (%), 6-23 months
		local ll3_TUN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_TUN uiscr1
		local le1_TUN "Primary school completion (%) "
		local e2_TUN b_hygiene_sch
		local le2_TUN "Proportion of schools with basic hygiene services"
		local e3_TUN mort514
		local le3_TUN "Mortality rate (children aged 5 to 14 years)"
		local h1_TUN lastnm_afr
		local lh1_TUN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TUN une_2eap_mf_y
		local lh2_TUN "Youth unemployment (%), ages 15-24"
		local h3_TUN uiscr3
		local lh3_TUN "Completion rate, upper secondary education (%)"
		local b1_TUN sp_dyn_le00_in
		local lb1_TUN "Life expectancy at birth (years)"
		local b2_TUN une_2eap_mf_a
		local lb2_TUN "Unemployment (%), ages 25+"
		local b3_TUN probdeath_ncd
		local lb3_TUN "Cause of death, by non-communicable diseases (% of total)"
		local l1_TUR neomort
		local ll1_TUR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUR uisger02
		local ll2_TUR "School enrollment, preprimary (% gross)"
		local l3_TUR care
		local ll3_TUR "Postnatal contact with a health provider within 2 days of delivery"
		local e1_TUR Child labor (%), ages 5-17
		local le1_TUR "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_TUR se_lpv_prim
		local le2_TUR "Learning Poverty"
		local e3_TUR mort514
		local le3_TUR "Mortality rate (children aged 5 to 14 years)"
		local h1_TUR eip_neet_mf_y
		local lh1_TUR "Youth NEET (%), ages 15-24"
		local h2_TUR lastnm_ter_ger
		local lh2_TUR "School enrollment, tertiary (% gross)"
		local h3_TUR lastnm_afr
		local lh3_TUR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_TUR sp_dyn_le00_in
		local lb1_TUR "Life expectancy at birth (years)"
		local b2_TUR emp_nifl_a
		local lb2_TUR "Adult informal employment rate (%), ages 25+"
		local b3_TUR une_2eap_mf_a
		local lb3_TUR "Unemployment (%), ages 25+"
		local l1_TUV neomort
		local ll1_TUV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUV uisger02
		local ll2_TUV "School enrollment, preprimary (% gross)"
		local l3_TUV u5_anaemia
		local ll3_TUV "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_TUV uiscr1
		local le1_TUV "Primary school completion (%) "
		local e2_TUV Child labor (%), ages 5-17
		local le2_TUV "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_TUV mort514
		local le3_TUV "Mortality rate (children aged 5 to 14 years)"
		local h1_TUV caremother
		local lh1_TUV "Postnatal care for newborns - percentage of newborns who have a postnatal contact with a health provider within 2 days of delivery"
		local h2_TUV uiscr3
		local lh2_TUV "Completion rate, upper secondary education (%)"
		local h3_TUV uisqutp2t3
		local lh3_TUV "Qualified teachers in secondary education (%)"
		local b1_TUV hypertension
		local lb1_TUV "Prevalence of hypertension among adults aged 30-79 years, age-standarized"
		local b2_TUV hci_upper
		local lb2_TUV "Human Capital Index, Upper Bound (scale 0-1)"
		local b3_TUV sp_dyn_le00_in
		local lb3_TUV "Life expectancy at birth (years)"
		local l1_TZA neomort
		local ll1_TZA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TZA u5_anaemia
		local ll2_TZA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_TZA uisger02
		local ll3_TZA "School enrollment, preprimary (% gross)"
		local e1_TZA Child labor (%), ages 5-17
		local le1_TZA "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_TZA uiscr1
		local le2_TZA "Primary school completion (%) "
		local e3_TZA mort514
		local le3_TZA "Mortality rate (children aged 5 to 14 years)"
		local h1_TZA uiscr3
		local lh1_TZA "Completion rate, upper secondary education (%)"
		local h2_TZA une_2eap_mf_y
		local lh2_TZA "Youth unemployment (%), ages 15-24"
		local h3_TZA lastnm_afr
		local lh3_TZA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_TZA une_2eap_mf_a
		local lb1_TZA "Unemployment (%), ages 25+"
		local b2_TZA b_water_health
		local lb2_TZA "Proportion of health care facilities with basic water services"
		local b3_TZA sp_dyn_le00_in
		local lb3_TZA "Life expectancy at birth (years)"
		local l1_UGA u5_anaemia
		local ll1_UGA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_UGA vacHEPB3
		local ll2_UGA "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l3_UGA neomort
		local ll3_UGA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_UGA b_hygiene_sch
		local le1_UGA "Proportion of schools with basic hygiene services"
		local e2_UGA mort514
		local le2_UGA "Mortality rate (children aged 5 to 14 years)"
		local e3_UGA uisxgdpfsgov
		local le3_UGA "Government expenditure on education (% GPD)"
		local h1_UGA lastnm_afr
		local lh1_UGA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_UGA uiscr3
		local lh2_UGA "Completion rate, upper secondary education (%)"
		local h3_UGA une_2eap_mf_y
		local lh3_UGA "Youth unemployment (%), ages 15-24"
		local b1_UGA sp_dyn_le00_in
		local lb1_UGA "Life expectancy at birth (years)"
		local b2_UGA une_2eap_mf_a
		local lb2_UGA "Unemployment (%), ages 25+"
		local b3_UGA b_water_health
		local lb3_UGA "Proportion of health care facilities with basic water services"
		local l1_UKR uisger02
		local ll1_UKR "School enrollment, preprimary (% gross)"
		local l2_UKR neomort
		local ll2_UKR "Mortality rate, neonatal (per 1,000 live births)"
		local l3_UKR u5_anaemia
		local ll3_UKR "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_UKR b_hygiene_sch
		local le1_UKR "Proportion of schools with basic hygiene services"
		local e2_UKR uisxgdpfsgov
		local le2_UKR "Government expenditure on education (% GPD)"
		local e3_UKR mort514
		local le3_UKR "Mortality rate (children aged 5 to 14 years)"
		local h1_UKR lastnm_afr
		local lh1_UKR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_UKR uiscr3
		local lh2_UKR "Completion rate, upper secondary education (%)"
		local h3_UKR une_2eap_mf_y
		local lh3_UKR "Youth unemployment (%), ages 15-24"
		local b1_UKR une_2eap_mf_a
		local lb1_UKR "Unemployment (%), ages 25+"
		local b2_UKR probdeath_ncd
		local lb2_UKR "Cause of death, by non-communicable diseases (% of total)"
		local b3_UKR sp_dyn_le00_in
		local lb3_UKR "Life expectancy at birth (years)"
		local l1_URY u5_anaemia
		local ll1_URY "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_URY neomort
		local ll2_URY "Mortality rate, neonatal (per 1,000 live births)"
		local l3_URY uisger02
		local ll3_URY "School enrollment, preprimary (% gross)"
		local e1_URY mort514
		local le1_URY "Mortality rate (children aged 5 to 14 years)"
		local e2_URY uiscr1
		local le2_URY "Primary school completion (%) "
		local e3_URY se_lpv_prim
		local le3_URY "Learning Poverty"
		local h1_URY eip_neet_mf_y
		local lh1_URY "Youth NEET (%), ages 15-24"
		local h2_URY uiscr3
		local lh2_URY "Completion rate, upper secondary education (%)"
		local h3_URY lastnm_afr
		local lh3_URY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_URY une_2eap_mf_a
		local lb1_URY "Unemployment (%), ages 25+"
		local b2_URY sp_dyn_le00_in
		local lb2_URY "Life expectancy at birth (years)"
		local b3_URY emp_nifl_a
		local lb3_URY "Adult informal employment rate (%), ages 25+"
		local l1_USA uisger02
		local ll1_USA "School enrollment, preprimary (% gross)"
		local l2_USA u5_anaemia
		local ll2_USA "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_USA neomort
		local ll3_USA "Mortality rate, neonatal (per 1,000 live births)"
		local e1_USA uiscr1
		local le1_USA "Primary school completion (%) "
		local e2_USA b_hygiene_sch
		local le2_USA "Proportion of schools with basic hygiene services"
		local e3_USA mort514
		local le3_USA "Mortality rate (children aged 5 to 14 years)"
		local h1_USA eip_neet_mf_y
		local lh1_USA "Youth NEET (%), ages 15-24"
		local h2_USA lastnm_ter_ger
		local lh2_USA "School enrollment, tertiary (% gross)"
		local h3_USA lastnm_afr
		local lh3_USA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_USA une_2eap_mf_a
		local lb1_USA "Unemployment (%), ages 25+"
		local b2_USA probdeath_ncd
		local lb2_USA "Cause of death, by non-communicable diseases (% of total)"
		local b3_USA sp_dyn_le00_in
		local lb3_USA "Life expectancy at birth (years)"
		local l1_UZB u5_anaemia
		local ll1_UZB "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_UZB neomort
		local ll2_UZB "Mortality rate, neonatal (per 1,000 live births)"
		local l3_UZB uisger02
		local ll3_UZB "School enrollment, preprimary (% gross)"
		local e1_UZB uiscr1
		local le1_UZB "Primary school completion (%) "
		local e2_UZB lastnm_sec_ger
		local le2_UZB "School enrollment, secondary (% gross)"
		local e3_UZB mort514
		local le3_UZB "Mortality rate (children aged 5 to 14 years)"
		local h1_UZB lastnm_afr
		local lh1_UZB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_UZB uiscr3
		local lh2_UZB "Completion rate, upper secondary education (%)"
		local h3_UZB une_2eap_mf_y
		local lh3_UZB "Youth unemployment (%), ages 15-24"
		local b1_UZB probdeath_ncd
		local lb1_UZB "Cause of death, by non-communicable diseases (% of total)"
		local b2_UZB sp_dyn_le00_in
		local lb2_UZB "Life expectancy at birth (years)"
		local b3_UZB une_2eap_mf_a
		local lb3_UZB "Unemployment (%), ages 25+"
		local l1_VCT u5_anaemia
		local ll1_VCT "Prevalence of anaemia in children aged 6–59 months (%)"
		local l2_VCT uisger02
		local ll2_VCT "School enrollment, preprimary (% gross)"
		local l3_VCT neomort
		local ll3_VCT "Mortality rate, neonatal (per 1,000 live births)"
		local e1_VCT b_hygiene_sch
		local le1_VCT "Proportion of schools with basic hygiene services"
		local e2_VCT uiscr1
		local le2_VCT "Primary school completion (%) "
		local e3_VCT mort514
		local le3_VCT "Mortality rate (children aged 5 to 14 years)"
		local h1_VCT lastnm_afr
		local lh1_VCT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_VCT une_2eap_mf_y
		local lh2_VCT "Youth unemployment (%), ages 15-24"
		local h3_VCT lastnm_ter_ger
		local lh3_VCT "School enrollment, tertiary (% gross)"
		local b1_VCT une_2eap_mf_a
		local lb1_VCT "Unemployment (%), ages 25+"
		local b2_VCT probdeath_ncd
		local lb2_VCT "Cause of death, by non-communicable diseases (% of total)"
		local b3_VCT sp_dyn_le00_in
		local lb3_VCT "Life expectancy at birth (years)"
		local l1_VNM neomort
		local ll1_VNM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_VNM u5_anaemia
		local ll2_VNM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_VNM uisger02
		local ll3_VNM "School enrollment, preprimary (% gross)"
		local e1_VNM mort514
		local le1_VNM "Mortality rate (children aged 5 to 14 years)"
		local e2_VNM Child labor (%), ages 5-17
		local le2_VNM "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e3_VNM se_lpv_prim
		local le3_VNM "Learning Poverty"
		local h1_VNM uiscr3
		local lh1_VNM "Completion rate, upper secondary education (%)"
		local h2_VNM lastnm_afr
		local lh2_VNM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_VNM eip_neet_mf_y
		local lh3_VNM "Youth NEET (%), ages 15-24"
		local b1_VNM une_2eap_mf_a
		local lb1_VNM "Unemployment (%), ages 25+"
		local b2_VNM b_water_health
		local lb2_VNM "Proportion of health care facilities with basic water services"
		local b3_VNM sp_dyn_le00_in
		local lb3_VNM "Life expectancy at birth (years)"
		local l1_VUT uisger02
		local ll1_VUT "School enrollment, preprimary (% gross)"
		local l2_VUT neomort
		local ll2_VUT "Mortality rate, neonatal (per 1,000 live births)"
		local l3_VUT u5_anaemia
		local ll3_VUT "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_VUT mort514
		local le1_VUT "Mortality rate (children aged 5 to 14 years)"
		local e2_VUT lastnm_sec_ger
		local le2_VUT "School enrollment, secondary (% gross)"
		local e3_VUT uiscr1
		local le3_VUT "Primary school completion (%) "
		local h1_VUT lastnm_afr
		local lh1_VUT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_VUT uiscr3
		local lh2_VUT "Completion rate, upper secondary education (%)"
		local h3_VUT eip_neet_mf_y
		local lh3_VUT "Youth NEET (%), ages 15-24"
		local b1_VUT sp_dyn_le00_in
		local lb1_VUT "Life expectancy at birth (years)"
		local b2_VUT une_2eap_mf_a
		local lb2_VUT "Unemployment (%), ages 25+"
		local b3_VUT b_water_health
		local lb3_VUT "Proportion of health care facilities with basic water services"
		local l1_WSM uisger02
		local ll1_WSM "School enrollment, preprimary (% gross)"
		local l2_WSM u5_anaemia
		local ll2_WSM "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_WSM neomort
		local ll3_WSM "Mortality rate, neonatal (per 1,000 live births)"
		local e1_WSM Child labor (%), ages 5-17
		local le1_WSM "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_WSM uiscr1
		local le2_WSM "Primary school completion (%) "
		local e3_WSM mort514
		local le3_WSM "Mortality rate (children aged 5 to 14 years)"
		local h1_WSM lastnm_afr
		local lh1_WSM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_WSM uiscr3
		local lh2_WSM "Completion rate, upper secondary education (%)"
		local h3_WSM une_2eap_mf_y
		local lh3_WSM "Youth unemployment (%), ages 15-24"
		local b1_WSM sp_dyn_le00_in
		local lb1_WSM "Life expectancy at birth (years)"
		local b2_WSM une_2eap_mf_a
		local lb2_WSM "Unemployment (%), ages 25+"
		local b3_WSM probdeath_ncd
		local lb3_WSM "Cause of death, by non-communicable diseases (% of total)"
		local l1_XKX psurv
		local ll1_XKX "Probability of Survival to Age 5"
		local l2_XKX
		local ll2_XKX ""
		local l3_XKX
		local ll3_XKX ""
		local e1_XKX test
		local le1_XKX "Harmonized Test Scores"
		local e2_XKX qeyrs
		local le2_XKX "Learning-Adjusted Years of School"
		local e3_XKX eyrs
		local le3_XKX "Expected Years of School"
		local h1_XKX
		local lh1_XKX ""
		local h2_XKX
		local lh2_XKX ""
		local h3_XKX
		local lh3_XKX ""
		local b1_XKX hci_upper
		local lb1_XKX "Human Capital Index, Upper Bound (scale 0-1)"
		local b2_XKX sp_dyn_le00_in
		local lb2_XKX "Life expectancy at birth (years)"
		local b3_XKX
		local lb3_XKX ""
		local l1_YEM vacHEPB3
		local ll1_YEM "Percentage of surviving infants who received the third dose of hep B-containing vaccine"
		local l2_YEM neomort
		local ll2_YEM "Mortality rate, neonatal (per 1,000 live births)"
		local l3_YEM u5_anaemia
		local ll3_YEM "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_YEM mort514
		local le1_YEM "Mortality rate (children aged 5 to 14 years)"
		local e2_YEM eyrs
		local le2_YEM "Expected Years of School"
		local e3_YEM test
		local le3_YEM "Harmonized Test Scores"
		local h1_YEM lastnm_afr
		local lh1_YEM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_YEM uiscr3
		local lh2_YEM "Completion rate, upper secondary education (%)"
		local h3_YEM une_2eap_mf_y
		local lh3_YEM "Youth unemployment (%), ages 15-24"
		local b1_YEM sp_dyn_le00_in
		local lb1_YEM "Life expectancy at birth (years)"
		local b2_YEM probdeath_ncd
		local lb2_YEM "Cause of death, by non-communicable diseases (% of total)"
		local b3_YEM une_2eap_mf_a
		local lb3_YEM "Unemployment (%), ages 25+"
		local l1_ZAF uisger02
		local ll1_ZAF "School enrollment, preprimary (% gross)"
		local l2_ZAF u5_anaemia
		local ll2_ZAF "Prevalence of anaemia in children aged 6–59 months (%)"
		local l3_ZAF neomort
		local ll3_ZAF "Mortality rate, neonatal (per 1,000 live births)"
		local e1_ZAF lastnm_sec_ger
		local le1_ZAF "School enrollment, secondary (% gross)"
		local e2_ZAF uiscr1
		local le2_ZAF "Primary school completion (%) "
		local e3_ZAF mort514
		local le3_ZAF "Mortality rate (children aged 5 to 14 years)"
		local h1_ZAF eip_neet_mf_y
		local lh1_ZAF "Youth NEET (%), ages 15-24"
		local h2_ZAF uiscr3
		local lh2_ZAF "Completion rate, upper secondary education (%)"
		local h3_ZAF lastnm_afr
		local lh3_ZAF "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local b1_ZAF une_2eap_mf_a
		local lb1_ZAF "Unemployment (%), ages 25+"
		local b2_ZAF emp_nifl_a
		local lb2_ZAF "Adult informal employment rate (%), ages 25+"
		local b3_ZAF sp_dyn_le00_in
		local lb3_ZAF "Life expectancy at birth (years)"
		local l1_ZMB Minimum meal frequency (%), 6-23 months
		local ll1_ZMB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l2_ZMB neomort
		local ll2_ZMB "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ZMB u5_anaemia
		local ll3_ZMB "Prevalence of anaemia in children aged 6–59 months (%)"
		local e1_ZMB b_hygiene_sch
		local le1_ZMB "Proportion of schools with basic hygiene services"
		local e2_ZMB uisxgdpfsgov
		local le2_ZMB "Government expenditure on education (% GPD)"
		local e3_ZMB mort514
		local le3_ZMB "Mortality rate (children aged 5 to 14 years)"
		local h1_ZMB uiscr3
		local lh1_ZMB "Completion rate, upper secondary education (%)"
		local h2_ZMB lastnm_afr
		local lh2_ZMB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ZMB eip_neet_mf_y
		local lh3_ZMB "Youth NEET (%), ages 15-24"
		local b1_ZMB une_2eap_mf_a
		local lb1_ZMB "Unemployment (%), ages 25+"
		local b2_ZMB emp_nifl_a
		local lb2_ZMB "Adult informal employment rate (%), ages 25+"
		local b3_ZMB sp_dyn_le00_in
		local lb3_ZMB "Life expectancy at birth (years)"
		local l1_ZWE uisger02
		local ll1_ZWE "School enrollment, preprimary (% gross)"
		local l2_ZWE neomort
		local ll2_ZWE "Mortality rate, neonatal (per 1,000 live births)"
		local l3_ZWE Minimum meal frequency (%), 6-23 months
		local ll3_ZWE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local e1_ZWE Child labor (%), ages 5-17
		local le1_ZWE "Percentage of children (aged 5-17 years) engaged in child labour (economic activities)"
		local e2_ZWE uiscr1
		local le2_ZWE "Primary school completion (%) "
		local e3_ZWE mort514
		local le3_ZWE "Mortality rate (children aged 5 to 14 years)"
		local h1_ZWE lastnm_afr
		local lh1_ZWE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ZWE eip_neet_mf_y
		local lh2_ZWE "Youth NEET (%), ages 15-24"
		local h3_ZWE uiscr3
		local lh3_ZWE "Completion rate, upper secondary education (%)"
		local b1_ZWE b_water_health
		local lb1_ZWE "Proportion of health care facilities with basic water services"
		local b2_ZWE sp_dyn_le00_in
		local lb2_ZWE "Life expectancy at birth (years)"
		local b3_ZWE une_2eap_mf_a
		local lb3_ZWE "Unemployment (%), ages 25+"



		}
		

		foreach c in AFG AGO ALB ARE ARG ARM ATG AUS AUT AZE BDI BEL BEN BFA BGD BGR BHR BIH BLR BRA BRN BTN BWA CAF CAN CHE CHL CHN CIV CMR COD COG COL COM CRI CUB CYP CZE DEU DMA DNK DOM DZA ECU EGY ESP EST ETH FIN FJI FRA FSM GAB GBR GEO GHA GIN GMB GRC GRD GTM GUY HKG HND HRV HTI HUN IDN IND IRL IRN IRQ ISL ISR ITA JAM JOR JPN KAZ KEN KGZ KHM KIR KNA KOR KWT LAO LBN LBR LCA LIE LKA LSO LTU LUX LVA MAC MAR MDA MDG MEX MHL MKD MLI MLT MMR MNE MNG MOZ MRT MUS MWI MYS NAM NER NGA NIC NLD NOR NPL NRU NZL OMN PAK PAN PER PHL PLW PNG POL PRT PRY PSE QAT ROU RUS RWA SAU SDN SEN SGP SLB SLE SLV SRB SSD SVK SVN SWE SWZ SYC SYR TCD TGO THA TJK TLS TON TTO TUN TUR TUV TZA UGA UKR URY USA UZB VCT VEN VNM VUT WSM XKX YEM ZAF ZMB ZWE {
		
		local c1_`c' hci
		local c2_`c' psurv
		local c3_`c' eyrs
		local c4_`c' test
		local c5_`c' qeyrs
		local c6_`c' asr
		local c7_`c' nostu
		
		local lc1_`c' "Human Capital Index"
		local lc2_`c' "Probability of Survival to Age 5"
		local lc3_`c' "Expected Years of School"
		local lc4_`c' "Harmonized Test Scores"
		local lc5_`c' "Learning-adjusted Years of School"
		local lc6_`c' "Adult Survival Rate"
		local lc7_`c' "Fraction of Children Under 5 Not Stunted"
		
		}
		
	*----------------------------Loop on countries-----------------------------*
	
		/* Loop with all countries */
foreach i of local obs {
		capture {
		/* Unmute to run only one or some countries */
// 		if (wbcode[`i'] != "ARG") continue 
		
		local ctry=wbcode in `i'
		local region=wbregion in `i'
		local income=wbincomegroup in `i'
		local income2=incomegroup in `i'
		local country=wbcountryname in `i'	
		display "`country'"
		*------------------------------First page------------------------------*
		
		/* With available data - automatic */
		
	qui foreach x in c {
		forvalues m = 1(1)`n`x'' {
		qui tab ``x'`m'_`ctry'' if wbcode=="`ctry'"		
		gen obs_``x'`m''_`i' = 1 if `=scalar(r(N))'>0
		replace obs_``x'`m''_`i' = 0 if `=scalar(r(N))'==0
		replace obs_``x'`m''_`i' = 0 if ``x'`m'_`ctry''[`i']==0
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
		
		twoway ///
		(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
		(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
		(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
		(scatter onesvec ``x'`m'_`ctry''_prev if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(Oh) mlcolor(reddish) mcolor(reddish) mlwidth(thick)) ///   
		(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(10pt) mlc(black) mfcolor(reddish)) ///
		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(18pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(small))
		graph save "$charts\graph_`ctry'_`x'`m'.gph", replace
	
	}	
}
		
		/* With missing data - automatic */
		
foreach x in c {
	forvalues m = 1(1)`n`x'' {
		if ``x'`m'_`ctry''[`i']==. {
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
		twoway ///
		(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(8pt) mcolor(dimgray*1.5)) ///
		(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(D) mlc(black) mfcolor(sky)) ///
		(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(18pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(small))
		graph save "$charts\graph_`ctry'_`x'`m'.gph", replace
		drop obs_``x'`m''_`i'
		}
		else {
		
		}
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
		*graph export "$charts\notes_`ctry'.png", replace
		
		drop m 

		graph combine "$charts\graph_`ctry'_c1.gph"  "$charts\graph_`ctry'_c2.gph"  "$charts\graph_`ctry'_c3.gph"  "$charts\graph_`ctry'_c4.gph" "$charts\graph_`ctry'_c5.gph" "$charts\graph_`ctry'_c6.gph" "$charts\graph_`ctry'_c7.gph" "$charts\notes_`ctry'.gph", rows(8) cols(1) xsize(4.4) ysize(8.8) graphregion(margin(vsmall) fcolor(black)) 
		graph export "$charts\p1_`ctry'_all.pdf", replace	
		graph export "$charts\p1_`ctry'_all.png", replace
		
		erase "$charts\graph_`ctry'_c1.gph"
		erase "$charts\graph_`ctry'_c2.gph"
		erase "$charts\graph_`ctry'_c3.gph"
		erase "$charts\graph_`ctry'_c4.gph"
		erase "$charts\graph_`ctry'_c5.gph"
		erase "$charts\graph_`ctry'_c6.gph"
		erase "$charts\graph_`ctry'_c7.gph"
		erase "$charts\notes_`ctry'.gph"
		
		*------------------------------Second Page-----------------------------*
		
foreach x in e b h l {
	forvalues m = 1(1)`n`x'' {
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

		capture {
			twoway ///
			(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
			(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			(scatter onesvec ``x'`m'_`ctry''_prev if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(Oh) mlcolor(reddish) mcolor(reddish) mlwidth(thick)) /// 
			(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
			, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
			graph save "$charts\graph_`ctry'_`x'`m'.gph", replace		
		}
		
		if _rc != 0 { 
			twoway ///
			(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
			(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
			(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
			(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
			, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
			graph save "$charts\graph_`ctry'_`x'`m'.gph", replace	
		}
	}
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
		
		graph combine "$charts\stage_1.gph" "$charts\stage_2.gph" "$charts\stage_3.gph" "$charts\stage_4.gph", rows(4) cols(1) xsize(6) ysize(14) graphregion(margin(vsmall) fcolor(black))
		graph export "$charts\p2_`ctry'_stages.pdf", replace
		graph export "$charts\p2_`ctry'_stages.png", replace
		
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
}	