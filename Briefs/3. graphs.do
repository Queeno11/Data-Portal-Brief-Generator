*------------------------------------------------------------------------------*
*--------------------------------------Graphs----------------------------------*
*------------------------------------------------------------------------------*

	*--------------------------------Directories-------------------------------*
		
		global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\HCI update\"
		global charts "${root}/Outputs/Update"
		global dhci "${root}/Data"
		global dport "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\Data"
		cd "${root}"
		
	*--------------------------------Load data---------------------------------*
	
		clear all
		set more off	
		set maxvar 32000
		use "$dhci\data_briefs", replace
			
*------------------------------------------------------------------------------*
*-----------------------------------GRAPHS-------------------------------------*
*------------------------------------------------------------------------------*

		count
		numlist "1/`r(N)'"
		local obs = "`r(numlist)'"
		
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
		
		/**** Pegar los locals acá ****/
		
		{
		
		local l1_AFG unicef_neomort
		local ll1_AFG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_AFG unicef_mealfreq
		local ll2_AFG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_AFG lastnm_mmrt
		local ll3_AFG "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_AFG uiscr1
		local le1_AFG "Primary completion rate (% of relevant age group)"
		local e2_AFG lastnm_sec_ger
		local le2_AFG "School enrollment, secondary (% gross)"
		local e3_AFG uiscr2
		local le3_AFG "Lower secondary completion rate (% of relevant age group)"
		local h1_AFG eip_neet_mf_y
		local lh1_AFG "Youth NEET (%), ages 15-24"
		local h2_AFG lastnm_afr
		local lh2_AFG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_AFG lastnm_ter_ger
		local lh3_AFG "School enrollment, tertiary (% gross)"
		local b1_AFG eap_2wap_mf_a_f
		local lb1_AFG "Labour force participation (%), ages 25+, Female"
		local b2_AFG eap_2wap_mf_a_m
		local lb2_AFG "Labour force participation (%), ages 25+, Male"
		local b3_AFG sp_dyn_le00_in
		local lb3_AFG "Life expectancy at birth (years)"
		local l1_AGO unicef_neomort
		local ll1_AGO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_AGO unicef_mealfreq
		local ll2_AGO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_AGO uisger02
		local ll3_AGO "School enrollment, preprimary (% gross)"
		local e1_AGO lastnm_sec_ger
		local le1_AGO "School enrollment, secondary (% gross)"
		local e2_AGO uiscr1
		local le2_AGO ""
		local e3_AGO se_lpv_prim
		local le3_AGO ""
		local h1_AGO lastnm_afr
		local lh1_AGO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AGO lastnm_ter_ger
		local lh2_AGO "School enrollment, tertiary (% gross)"
		local h3_AGO une_2eap_mf_y
		local lh3_AGO "Youth unemployment (%), ages 15-24"
		local b1_AGO eap_2wap_mf_a_f
		local lb1_AGO "Labour force participation (%), ages 25+, Female"
		local b2_AGO eap_2wap_mf_a_m
		local lb2_AGO "Labour force participation (%), ages 25+, Male"
		local b3_AGO sp_dyn_le00_in
		local lb3_AGO "Life expectancy at birth (years)"
		local l1_ALB unicef_neomort
		local ll1_ALB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ALB unicef_mealfreq
		local ll2_ALB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ALB uisger02
		local ll3_ALB "School enrollment, preprimary (% gross)"
		local e1_ALB uiscr1
		local le1_ALB "Primary completion rate (% of relevant age group)"
		local e2_ALB lastnm_sec_ger
		local le2_ALB "School enrollment, secondary (% gross)"
		local e3_ALB se_lpv_prim
		local le3_ALB "Learning Poverty"
		local h1_ALB eip_neet_mf_y
		local lh1_ALB "Youth NEET (%), ages 15-24"
		local h2_ALB lastnm_afr
		local lh2_ALB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ALB lastnm_ter_ger
		local lh3_ALB "School enrollment, tertiary (% gross)"
		local b1_ALB eap_2wap_mf_a_f
		local lb1_ALB "Labour force participation (%), ages 25+, Female"
		local b2_ALB eap_2wap_mf_a_m
		local lb2_ALB "Labour force participation (%), ages 25+, Male"
		local b3_ALB sp_dyn_le00_in
		local lb3_ALB "Life expectancy at birth (years)"
		local l1_ARE unicef_neomort
		local ll1_ARE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ARE uisger02
		local ll2_ARE "School enrollment, preprimary (% gross)"
		local l3_ARE lastnm_birth_reg
		local ll3_ARE "Completeness of birth registration (%)"
		local e1_ARE uiscr1
		local le1_ARE "Primary completion rate (% of relevant age group)"
		local e2_ARE lastnm_sec_ger
		local le2_ARE "School enrollment, secondary (% gross)"
		local e3_ARE se_lpv_prim
		local le3_ARE "Learning Poverty"
		local h1_ARE lastnm_afr
		local lh1_ARE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ARE lastnm_ter_ger
		local lh2_ARE "School enrollment, tertiary (% gross)"
		local h3_ARE une_2eap_mf_y
		local lh3_ARE "Youth unemployment (%), ages 15-24"
		local b1_ARE eap_2wap_mf_a_f
		local lb1_ARE "Labour force participation (%), ages 25+, Female"
		local b2_ARE eap_2wap_mf_a_m
		local lb2_ARE "Labour force participation (%), ages 25+, Male"
		local b3_ARE sp_dyn_le00_in
		local lb3_ARE "Life expectancy at birth (years)"
		local l1_ARG unicef_neomort
		local ll1_ARG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ARG uisger02
		local ll2_ARG "School enrollment, preprimary (% gross)"
		local l3_ARG lastnm_mmrt
		local ll3_ARG "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_ARG uiscr1
		local le1_ARG "Primary completion rate (% of relevant age group)"
		local e2_ARG lastnm_sec_ger
		local le2_ARG "School enrollment, secondary (% gross)"
		local e3_ARG se_lpv_prim
		local le3_ARG "Learning Poverty"
		local h1_ARG eip_neet_mf_y
		local lh1_ARG "Youth NEET (%), ages 15-24"
		local h2_ARG lastnm_afr
		local lh2_ARG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ARG lastnm_ter_ger
		local lh3_ARG "School enrollment, tertiary (% gross)"
		local b1_ARG eap_2wap_mf_a_f
		local lb1_ARG "Labour force participation (%), ages 25+, Female"
		local b2_ARG eap_2wap_mf_a_m
		local lb2_ARG "Labour force participation (%), ages 25+, Male"
		local b3_ARG sp_dyn_le00_in
		local lb3_ARG "Life expectancy at birth (years)"
		local l1_ARM unicef_neomort
		local ll1_ARM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ARM unicef_mealfreq
		local ll2_ARM "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ARM uisger02
		local ll3_ARM "School enrollment, preprimary (% gross)"
		local e1_ARM uiscr1
		local le1_ARM "Primary completion rate (% of relevant age group)"
		local e2_ARM lastnm_sec_ger
		local le2_ARM "School enrollment, secondary (% gross)"
		local e3_ARM se_lpv_prim
		local le3_ARM "Learning Poverty"
		local h1_ARM eip_neet_mf_y
		local lh1_ARM "Youth NEET (%), ages 15-24"
		local h2_ARM lastnm_afr
		local lh2_ARM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ARM lastnm_ter_ger
		local lh3_ARM "School enrollment, tertiary (% gross)"
		local b1_ARM eap_2wap_mf_a_f
		local lb1_ARM "Labour force participation (%), ages 25+, Female"
		local b2_ARM eap_2wap_mf_a_m
		local lb2_ARM "Labour force participation (%), ages 25+, Male"
		local b3_ARM sp_dyn_le00_in
		local lb3_ARM "Life expectancy at birth (years)"
		local l1_ATG unicef_neomort
		local ll1_ATG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ATG uisger02_f
		local ll2_ATG "School enrollment, preprimary (% gross), Female"
		local l3_ATG uisger02_m
		local ll3_ATG "School enrollment, preprimary (% gross), Male"
		local e1_ATG uiscr1
		local le1_ATG "Primary completion rate (% of relevant age group)"
		local e2_ATG lastnm_sec_ger
		local le2_ATG "School enrollment, secondary (% gross)"
		local e3_ATG uiscr2
		local le3_ATG "Lower secondary completion rate (% of relevant age group)"
		local h1_ATG lastnm_afr
		local lh1_ATG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ATG eip_neet_mf_y
		local lh2_ATG ""
		local h3_ATG lastnm_ter_ger
		local lh3_ATG ""
		local b1_ATG lastnm_probdeath_ncd
		local lb1_ATG "Cause of death, by non-communicable diseases (% of total)"
		local b2_ATG sp_dyn_le00_in_f
		local lb2_ATG "Life expectancy at birth (years), Female"
		local b3_ATG sp_dyn_le00_in_m
		local lb3_ATG "Life expectancy at birth (years), Male"
		local l1_AUS unicef_neomort
		local ll1_AUS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_AUS uisger02
		local ll2_AUS "School enrollment, preprimary (% gross)"
		local l3_AUS lastnm_mmrt
		local ll3_AUS "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_AUS lastnm_sec_ger
		local le1_AUS "School enrollment, secondary (% gross)"
		local e2_AUS se_lpv_prim_f
		local le2_AUS "Learning Poverty, Female"
		local e3_AUS se_lpv_prim_m
		local le3_AUS "Learning Poverty, Male"
		local h1_AUS lastnm_afr
		local lh1_AUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AUS lastnm_ter_ger
		local lh2_AUS "School enrollment, tertiary (% gross)"
		local h3_AUS une_2eap_mf_y
		local lh3_AUS "Youth unemployment (%), ages 15-24"
		local b1_AUS eap_2wap_mf_a_f
		local lb1_AUS "Labour force participation (%), ages 25+, Female"
		local b2_AUS eap_2wap_mf_a_m
		local lb2_AUS "Labour force participation (%), ages 25+, Male"
		local b3_AUS sp_dyn_le00_in
		local lb3_AUS "Life expectancy at birth (years)"
		local l1_AUT unicef_neomort
		local ll1_AUT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_AUT uisger02
		local ll2_AUT "School enrollment, preprimary (% gross)"
		local l3_AUT lastnm_mmrt
		local ll3_AUT "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_AUT uiscr1
		local le1_AUT "Primary completion rate (% of relevant age group)"
		local e2_AUT lastnm_sec_ger
		local le2_AUT "School enrollment, secondary (% gross)"
		local e3_AUT se_lpv_prim
		local le3_AUT "Learning Poverty"
		local h1_AUT lastnm_afr
		local lh1_AUT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AUT lastnm_ter_ger
		local lh2_AUT "School enrollment, tertiary (% gross)"
		local h3_AUT une_2eap_mf_y
		local lh3_AUT "Youth unemployment (%), ages 15-24"
		local b1_AUT eap_2wap_mf_a_f
		local lb1_AUT "Labour force participation (%), ages 25+, Female"
		local b2_AUT eap_2wap_mf_a_m
		local lb2_AUT "Labour force participation (%), ages 25+, Male"
		local b3_AUT sp_dyn_le00_in
		local lb3_AUT "Life expectancy at birth (years)"
		local l1_AZE unicef_neomort
		local ll1_AZE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_AZE uisger02
		local ll2_AZE "School enrollment, preprimary (% gross)"
		local l3_AZE lastnm_mmrt
		local ll3_AZE "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_AZE uiscr1
		local le1_AZE "Primary completion rate (% of relevant age group)"
		local e2_AZE lastnm_sec_ger
		local le2_AZE "School enrollment, secondary (% gross)"
		local e3_AZE se_lpv_prim
		local le3_AZE "Learning Poverty"
		local h1_AZE lastnm_afr
		local lh1_AZE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_AZE lastnm_ter_ger
		local lh2_AZE "School enrollment, tertiary (% gross)"
		local h3_AZE une_2eap_mf_y
		local lh3_AZE "Youth unemployment (%), ages 15-24"
		local b1_AZE eap_2wap_mf_a_f
		local lb1_AZE "Labour force participation (%), ages 25+, Female"
		local b2_AZE eap_2wap_mf_a_m
		local lb2_AZE "Labour force participation (%), ages 25+, Male"
		local b3_AZE sp_dyn_le00_in
		local lb3_AZE "Life expectancy at birth (years)"
		local l1_BDI unicef_neomort
		local ll1_BDI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BDI unicef_mealfreq
		local ll2_BDI "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BDI uisger02
		local ll3_BDI "School enrollment, preprimary (% gross)"
		local e1_BDI uiscr1
		local le1_BDI "Primary completion rate (% of relevant age group)"
		local e2_BDI lastnm_sec_ger
		local le2_BDI "School enrollment, secondary (% gross)"
		local e3_BDI se_lpv_prim
		local le3_BDI "Learning Poverty"
		local h1_BDI lastnm_afr
		local lh1_BDI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BDI lastnm_ter_ger
		local lh2_BDI "School enrollment, tertiary (% gross)"
		local h3_BDI une_2eap_mf_y
		local lh3_BDI "Youth unemployment (%), ages 15-24"
		local b1_BDI eap_2wap_mf_a_f
		local lb1_BDI "Labour force participation (%), ages 25+, Female"
		local b2_BDI eap_2wap_mf_a_m
		local lb2_BDI "Labour force participation (%), ages 25+, Male"
		local b3_BDI sp_dyn_le00_in
		local lb3_BDI "Life expectancy at birth (years)"
		local l1_BEL unicef_neomort
		local ll1_BEL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BEL uisger02
		local ll2_BEL "School enrollment, preprimary (% gross)"
		local l3_BEL lastnm_mmrt
		local ll3_BEL "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_BEL lastnm_sec_ger
		local le1_BEL "School enrollment, secondary (% gross)"
		local e2_BEL se_lpv_prim
		local le2_BEL "Learning Poverty"
		local e3_BEL uiscr2
		local le3_BEL "Lower secondary completion rate (% of relevant age group)"
		local h1_BEL lastnm_afr
		local lh1_BEL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BEL lastnm_ter_ger
		local lh2_BEL "School enrollment, tertiary (% gross)"
		local h3_BEL une_2eap_mf_y
		local lh3_BEL "Youth unemployment (%), ages 15-24"
		local b1_BEL eap_2wap_mf_a_f
		local lb1_BEL "Labour force participation (%), ages 25+, Female"
		local b2_BEL eap_2wap_mf_a_m
		local lb2_BEL "Labour force participation (%), ages 25+, Male"
		local b3_BEL sp_dyn_le00_in
		local lb3_BEL "Life expectancy at birth (years)"
		local l1_BEN unicef_neomort
		local ll1_BEN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BEN unicef_mealfreq
		local ll2_BEN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BEN uisger02
		local ll3_BEN "School enrollment, preprimary (% gross)"
		local e1_BEN uiscr1
		local le1_BEN "Primary completion rate (% of relevant age group)"
		local e2_BEN lastnm_sec_ger
		local le2_BEN "School enrollment, secondary (% gross)"
		local e3_BEN se_lpv_prim
		local le3_BEN "Learning Poverty"
		local h1_BEN eip_neet_mf_y
		local lh1_BEN "Youth NEET (%), ages 15-24"
		local h2_BEN lastnm_afr
		local lh2_BEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BEN lastnm_ter_ger
		local lh3_BEN "School enrollment, tertiary (% gross)"
		local b1_BEN eap_2wap_mf_a_f
		local lb1_BEN "Labour force participation (%), ages 25+, Female"
		local b2_BEN eap_2wap_mf_a_m
		local lb2_BEN "Labour force participation (%), ages 25+, Male"
		local b3_BEN sp_dyn_le00_in
		local lb3_BEN "Life expectancy at birth (years)"
		local l1_BFA unicef_neomort
		local ll1_BFA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BFA unicef_mealfreq
		local ll2_BFA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BFA uisger02
		local ll3_BFA "School enrollment, preprimary (% gross)"
		local e1_BFA uiscr1
		local le1_BFA "Primary completion rate (% of relevant age group)"
		local e2_BFA lastnm_sec_ger
		local le2_BFA "School enrollment, secondary (% gross)"
		local e3_BFA se_lpv_prim
		local le3_BFA "Learning Poverty"
		local h1_BFA eip_neet_mf_y
		local lh1_BFA "Youth NEET (%), ages 15-24"
		local h2_BFA lastnm_afr
		local lh2_BFA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BFA lastnm_ter_ger
		local lh3_BFA "School enrollment, tertiary (% gross)"
		local b1_BFA eap_2wap_mf_a_f
		local lb1_BFA "Labour force participation (%), ages 25+, Female"
		local b2_BFA eap_2wap_mf_a_m
		local lb2_BFA "Labour force participation (%), ages 25+, Male"
		local b3_BFA sp_dyn_le00_in
		local lb3_BFA "Life expectancy at birth (years)"
		local l1_BGD unicef_neomort
		local ll1_BGD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BGD unicef_mealfreq
		local ll2_BGD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BGD uisger02
		local ll3_BGD "School enrollment, preprimary (% gross)"
		local e1_BGD uiscr1
		local le1_BGD "Primary completion rate (% of relevant age group)"
		local e2_BGD lastnm_sec_ger
		local le2_BGD "School enrollment, secondary (% gross)"
		local e3_BGD se_lpv_prim
		local le3_BGD "Learning Poverty"
		local h1_BGD eip_neet_mf_y
		local lh1_BGD "Youth NEET (%), ages 15-24"
		local h2_BGD lastnm_afr
		local lh2_BGD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BGD lastnm_ter_ger
		local lh3_BGD "School enrollment, tertiary (% gross)"
		local b1_BGD eap_2wap_mf_a_f
		local lb1_BGD "Labour force participation (%), ages 25+, Female"
		local b2_BGD eap_2wap_mf_a_m
		local lb2_BGD "Labour force participation (%), ages 25+, Male"
		local b3_BGD sp_dyn_le00_in
		local lb3_BGD "Life expectancy at birth (years)"
		local l1_BGR unicef_neomort
		local ll1_BGR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BGR uisger02
		local ll2_BGR "School enrollment, preprimary (% gross)"
		local l3_BGR vacBCG
		local ll3_BGR "Vaccine coverage - BCG"
		local e1_BGR uiscr1
		local le1_BGR "Primary completion rate (% of relevant age group)"
		local e2_BGR lastnm_sec_ger
		local le2_BGR "School enrollment, secondary (% gross)"
		local e3_BGR se_lpv_prim
		local le3_BGR "Learning Poverty"
		local h1_BGR lastnm_afr
		local lh1_BGR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BGR lastnm_ter_ger
		local lh2_BGR "School enrollment, tertiary (% gross)"
		local h3_BGR une_2eap_mf_y
		local lh3_BGR "Youth unemployment (%), ages 15-24"
		local b1_BGR eap_2wap_mf_a_f
		local lb1_BGR "Labour force participation (%), ages 25+, Female"
		local b2_BGR eap_2wap_mf_a_m
		local lb2_BGR "Labour force participation (%), ages 25+, Male"
		local b3_BGR sp_dyn_le00_in
		local lb3_BGR "Life expectancy at birth (years)"
		local l1_BHR unicef_neomort
		local ll1_BHR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BHR uisger02
		local ll2_BHR "School enrollment, preprimary (% gross)"
		local l3_BHR lastnm_birth_reg
		local ll3_BHR "Completeness of birth registration (%)"
		local e1_BHR uiscr1
		local le1_BHR "Primary completion rate (% of relevant age group)"
		local e2_BHR lastnm_sec_ger
		local le2_BHR "School enrollment, secondary (% gross)"
		local e3_BHR se_lpv_prim
		local le3_BHR "Learning Poverty"
		local h1_BHR lastnm_afr
		local lh1_BHR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BHR lastnm_ter_ger
		local lh2_BHR "School enrollment, tertiary (% gross)"
		local h3_BHR une_2eap_mf_y
		local lh3_BHR "Youth unemployment (%), ages 15-24"
		local b1_BHR eap_2wap_mf_a_f
		local lb1_BHR "Labour force participation (%), ages 25+, Female"
		local b2_BHR eap_2wap_mf_a_m
		local lb2_BHR "Labour force participation (%), ages 25+, Male"
		local b3_BHR sp_dyn_le00_in
		local lb3_BHR "Life expectancy at birth (years)"
		local l1_BIH unicef_neomort
		local ll1_BIH "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BIH uisger02
		local ll2_BIH "School enrollment, preprimary (% gross)"
		local l3_BIH vacBCG
		local ll3_BIH "Vaccine coverage - BCG"
		local e1_BIH uiscr2
		local le1_BIH "Lower secondary completion rate (% of relevant age group)"
		local e2_BIH uiscr1_f
		local le2_BIH "Primary completion rate (% of relevant age group), Female"
		local e3_BIH uiscr1_m
		local le3_BIH "Primary completion rate (% of relevant age group), Male"
		local h1_BIH eip_neet_mf_y
		local lh1_BIH "Youth NEET (%), ages 15-24"
		local h2_BIH lastnm_afr
		local lh2_BIH "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BIH lastnm_ter_ger
		local lh3_BIH "School enrollment, tertiary (% gross)"
		local b1_BIH eap_2wap_mf_a_f
		local lb1_BIH "Labour force participation (%), ages 25+, Female"
		local b2_BIH eap_2wap_mf_a_m
		local lb2_BIH "Labour force participation (%), ages 25+, Male"
		local b3_BIH sp_dyn_le00_in
		local lb3_BIH "Life expectancy at birth (years)"
		local l1_BLR unicef_neomort
		local ll1_BLR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BLR unicef_mealfreq
		local ll2_BLR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_BLR uisger02
		local ll3_BLR "School enrollment, preprimary (% gross)"
		local e1_BLR uiscr1
		local le1_BLR "Primary completion rate (% of relevant age group)"
		local e2_BLR lastnm_sec_ger
		local le2_BLR "School enrollment, secondary (% gross)"
		local e3_BLR uiscr2
		local le3_BLR "Lower secondary completion rate (% of relevant age group)"
		local h1_BLR eip_neet_mf_y
		local lh1_BLR "Youth NEET (%), ages 15-24"
		local h2_BLR lastnm_afr
		local lh2_BLR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BLR lastnm_ter_ger
		local lh3_BLR "School enrollment, tertiary (% gross)"
		local b1_BLR eap_2wap_mf_a_f
		local lb1_BLR "Labour force participation (%), ages 25+, Female"
		local b2_BLR eap_2wap_mf_a_m
		local lb2_BLR "Labour force participation (%), ages 25+, Male"
		local b3_BLR sp_dyn_le00_in
		local lb3_BLR "Life expectancy at birth (years)"
		local l1_BRA unicef_neomort
		local ll1_BRA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BRA uisger02
		local ll2_BRA "School enrollment, preprimary (% gross)"
		local l3_BRA lastnm_mmrt
		local ll3_BRA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_BRA lastnm_sec_ger
		local le1_BRA "School enrollment, secondary (% gross)"
		local e2_BRA se_lpv_prim
		local le2_BRA "Learning Poverty"
		local e3_BRA vacHEPBB
		local le3_BRA "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_BRA eip_neet_mf_y
		local lh1_BRA "Youth NEET (%), ages 15-24"
		local h2_BRA lastnm_afr
		local lh2_BRA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BRA lastnm_ter_ger
		local lh3_BRA "School enrollment, tertiary (% gross)"
		local b1_BRA eap_2wap_mf_a_f
		local lb1_BRA "Labour force participation (%), ages 25+, Female"
		local b2_BRA eap_2wap_mf_a_m
		local lb2_BRA "Labour force participation (%), ages 25+, Male"
		local b3_BRA sp_dyn_le00_in
		local lb3_BRA "Life expectancy at birth (years)"
		local l1_BRN unicef_neomort
		local ll1_BRN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BRN uisger02
		local ll2_BRN "School enrollment, preprimary (% gross)"
		local l3_BRN lastnm_birth_reg
		local ll3_BRN "Completeness of birth registration (%)"
		local e1_BRN uiscr1
		local le1_BRN "Primary completion rate (% of relevant age group)"
		local e2_BRN lastnm_sec_ger
		local le2_BRN "School enrollment, secondary (% gross)"
		local e3_BRN uiscr2
		local le3_BRN "Lower secondary completion rate (% of relevant age group)"
		local h1_BRN eip_neet_mf_y
		local lh1_BRN "Youth NEET (%), ages 15-24"
		local h2_BRN lastnm_afr
		local lh2_BRN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BRN lastnm_ter_ger
		local lh3_BRN "School enrollment, tertiary (% gross)"
		local b1_BRN eap_2wap_mf_a_f
		local lb1_BRN "Labour force participation (%), ages 25+, Female"
		local b2_BRN eap_2wap_mf_a_m
		local lb2_BRN "Labour force participation (%), ages 25+, Male"
		local b3_BRN sp_dyn_le00_in
		local lb3_BRN "Life expectancy at birth (years)"
		local l1_BTN unicef_neomort
		local ll1_BTN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BTN uisger02
		local ll2_BTN "School enrollment, preprimary (% gross)"
		local l3_BTN unicef_breastf
		local ll3_BTN "Exclusive breastfeeding (%)"
		local e1_BTN uiscr1
		local le1_BTN "Primary completion rate (% of relevant age group)"
		local e2_BTN lastnm_sec_ger
		local le2_BTN "School enrollment, secondary (% gross)"
		local e3_BTN uiscr2
		local le3_BTN "Lower secondary completion rate (% of relevant age group)"
		local h1_BTN lastnm_afr
		local lh1_BTN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_BTN lastnm_ter_ger
		local lh2_BTN "School enrollment, tertiary (% gross)"
		local h3_BTN une_2eap_mf_y
		local lh3_BTN "Youth unemployment (%), ages 15-24"
		local b1_BTN eap_2wap_mf_a_f
		local lb1_BTN "Labour force participation (%), ages 25+, Female"
		local b2_BTN eap_2wap_mf_a_m
		local lb2_BTN "Labour force participation (%), ages 25+, Male"
		local b3_BTN sp_dyn_le00_in
		local lb3_BTN "Life expectancy at birth (years)"
		local l1_BWA unicef_neomort
		local ll1_BWA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_BWA uisger02
		local ll2_BWA "School enrollment, preprimary (% gross)"
		local l3_BWA lastnm_mmrt
		local ll3_BWA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_BWA uiscr1
		local le1_BWA "Primary completion rate (% of relevant age group)"
		local e2_BWA lastnm_sec_ger
		local le2_BWA "School enrollment, secondary (% gross)"
		local e3_BWA uiscr2
		local le3_BWA "Lower secondary completion rate (% of relevant age group)"
		local h1_BWA eip_neet_mf_y
		local lh1_BWA "Youth NEET (%), ages 15-24"
		local h2_BWA lastnm_afr
		local lh2_BWA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_BWA lastnm_ter_ger
		local lh3_BWA "School enrollment, tertiary (% gross)"
		local b1_BWA eap_2wap_mf_a_f
		local lb1_BWA "Labour force participation (%), ages 25+, Female"
		local b2_BWA eap_2wap_mf_a_m
		local lb2_BWA "Labour force participation (%), ages 25+, Male"
		local b3_BWA sp_dyn_le00_in
		local lb3_BWA "Life expectancy at birth (years)"
		local l1_CAF unicef_neomort
		local ll1_CAF "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CAF unicef_mealfreq
		local ll2_CAF "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_CAF uisger02
		local ll3_CAF "School enrollment, preprimary (% gross)"
		local e1_CAF uiscr1
		local le1_CAF "Primary completion rate (% of relevant age group)"
		local e2_CAF lastnm_sec_ger
		local le2_CAF "School enrollment, secondary (% gross)"
		local e3_CAF uiscr2
		local le3_CAF "Lower secondary completion rate (% of relevant age group)"
		local h1_CAF lastnm_afr
		local lh1_CAF "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CAF une_2eap_mf_y_f
		local lh2_CAF "Youth unemployment (%), ages 15-24, Female"
		local h3_CAF une_2eap_mf_y_m
		local lh3_CAF "Youth unemployment (%), ages 15-24, Male"
		local b1_CAF eap_2wap_mf_a_f
		local lb1_CAF "Labour force participation (%), ages 25+, Female"
		local b2_CAF eap_2wap_mf_a_m
		local lb2_CAF "Labour force participation (%), ages 25+, Male"
		local b3_CAF sp_dyn_le00_in
		local lb3_CAF "Life expectancy at birth (years)"
		local l1_CAN unicef_neomort
		local ll1_CAN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CAN uisger02
		local ll2_CAN "School enrollment, preprimary (% gross)"
		local l3_CAN lastnm_mmrt
		local ll3_CAN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_CAN lastnm_sec_ger
		local le1_CAN "School enrollment, secondary (% gross)"
		local e2_CAN se_lpv_prim_f
		local le2_CAN "Learning Poverty, Female"
		local e3_CAN se_lpv_prim_m
		local le3_CAN "Learning Poverty, Male"
		local h1_CAN eip_neet_mf_y
		local lh1_CAN "Youth NEET (%), ages 15-24"
		local h2_CAN lastnm_afr
		local lh2_CAN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CAN lastnm_ter_ger
		local lh3_CAN "School enrollment, tertiary (% gross)"
		local b1_CAN eap_2wap_mf_a_f
		local lb1_CAN "Labour force participation (%), ages 25+, Female"
		local b2_CAN eap_2wap_mf_a_m
		local lb2_CAN "Labour force participation (%), ages 25+, Male"
		local b3_CAN sp_dyn_le00_in
		local lb3_CAN "Life expectancy at birth (years)"
		local l1_CHE unicef_neomort
		local ll1_CHE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CHE uisger02
		local ll2_CHE "School enrollment, preprimary (% gross)"
		local l3_CHE lastnm_mmrt
		local ll3_CHE "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_CHE uiscr1
		local le1_CHE "Primary completion rate (% of relevant age group)"
		local e2_CHE lastnm_sec_ger
		local le2_CHE "School enrollment, secondary (% gross)"
		local e3_CHE uiscr2
		local le3_CHE "Lower secondary completion rate (% of relevant age group)"
		local h1_CHE lastnm_afr
		local lh1_CHE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CHE lastnm_ter_ger
		local lh2_CHE "School enrollment, tertiary (% gross)"
		local h3_CHE une_2eap_mf_y
		local lh3_CHE "Youth unemployment (%), ages 15-24"
		local b1_CHE eap_2wap_mf_a_f
		local lb1_CHE "Labour force participation (%), ages 25+, Female"
		local b2_CHE eap_2wap_mf_a_m
		local lb2_CHE "Labour force participation (%), ages 25+, Male"
		local b3_CHE sp_dyn_le00_in
		local lb3_CHE "Life expectancy at birth (years)"
		local l1_CHL unicef_neomort
		local ll1_CHL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CHL uisger02
		local ll2_CHL "School enrollment, preprimary (% gross)"
		local l3_CHL lastnm_mmrt
		local ll3_CHL "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_CHL uiscr1
		local le1_CHL "Primary completion rate (% of relevant age group)"
		local e2_CHL lastnm_sec_ger
		local le2_CHL "School enrollment, secondary (% gross)"
		local e3_CHL se_lpv_prim
		local le3_CHL "Learning Poverty"
		local h1_CHL eip_neet_mf_y
		local lh1_CHL "Youth NEET (%), ages 15-24"
		local h2_CHL lastnm_afr
		local lh2_CHL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CHL lastnm_ter_ger
		local lh3_CHL "School enrollment, tertiary (% gross)"
		local b1_CHL eap_2wap_mf_a_f
		local lb1_CHL "Labour force participation (%), ages 25+, Female"
		local b2_CHL eap_2wap_mf_a_m
		local lb2_CHL "Labour force participation (%), ages 25+, Male"
		local b3_CHL sp_dyn_le00_in
		local lb3_CHL "Life expectancy at birth (years)"
		local l1_CHN unicef_neomort
		local ll1_CHN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CHN uisger02
		local ll2_CHN "School enrollment, preprimary (% gross)"
		local l3_CHN unicef_diarrhoea
		local ll3_CHN "Careseeking for diarrhoea (%)"
		local e1_CHN se_lpv_prim
		local le1_CHN "Learning Poverty"
		local e2_CHN vacHEPBB
		local le2_CHN "Vaccine coverage - Hepatitis B (HEPBB)"
		local e3_CHN uiscr1
		local le3_CHN ""
		local h1_CHN lastnm_afr
		local lh1_CHN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CHN lastnm_ter_ger
		local lh2_CHN "School enrollment, tertiary (% gross)"
		local h3_CHN une_2eap_mf_y
		local lh3_CHN "Youth unemployment (%), ages 15-24"
		local b1_CHN eap_2wap_mf_a_f
		local lb1_CHN "Labour force participation (%), ages 25+, Female"
		local b2_CHN eap_2wap_mf_a_m
		local lb2_CHN "Labour force participation (%), ages 25+, Male"
		local b3_CHN sp_dyn_le00_in
		local lb3_CHN "Life expectancy at birth (years)"
		local l1_CIV unicef_neomort
		local ll1_CIV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CIV unicef_mealfreq
		local ll2_CIV "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_CIV uisger02
		local ll3_CIV "School enrollment, preprimary (% gross)"
		local e1_CIV uiscr1
		local le1_CIV "Primary completion rate (% of relevant age group)"
		local e2_CIV lastnm_sec_ger
		local le2_CIV "School enrollment, secondary (% gross)"
		local e3_CIV se_lpv_prim
		local le3_CIV "Learning Poverty"
		local h1_CIV eip_neet_mf_y
		local lh1_CIV "Youth NEET (%), ages 15-24"
		local h2_CIV lastnm_afr
		local lh2_CIV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CIV lastnm_ter_ger
		local lh3_CIV "School enrollment, tertiary (% gross)"
		local b1_CIV eap_2wap_mf_a_f
		local lb1_CIV "Labour force participation (%), ages 25+, Female"
		local b2_CIV eap_2wap_mf_a_m
		local lb2_CIV "Labour force participation (%), ages 25+, Male"
		local b3_CIV sp_dyn_le00_in
		local lb3_CIV "Life expectancy at birth (years)"
		local l1_CMR unicef_neomort
		local ll1_CMR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CMR unicef_mealfreq
		local ll2_CMR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_CMR uisger02
		local ll3_CMR "School enrollment, preprimary (% gross)"
		local e1_CMR uiscr1
		local le1_CMR "Primary completion rate (% of relevant age group)"
		local e2_CMR lastnm_sec_ger
		local le2_CMR "School enrollment, secondary (% gross)"
		local e3_CMR se_lpv_prim
		local le3_CMR "Learning Poverty"
		local h1_CMR lastnm_afr
		local lh1_CMR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CMR lastnm_ter_ger
		local lh2_CMR "School enrollment, tertiary (% gross)"
		local h3_CMR une_2eap_mf_y
		local lh3_CMR "Youth unemployment (%), ages 15-24"
		local b1_CMR eap_2wap_mf_a_f
		local lb1_CMR "Labour force participation (%), ages 25+, Female"
		local b2_CMR eap_2wap_mf_a_m
		local lb2_CMR "Labour force participation (%), ages 25+, Male"
		local b3_CMR sp_dyn_le00_in
		local lb3_CMR "Life expectancy at birth (years)"
		local l1_COD unicef_neomort
		local ll1_COD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COD unicef_mealfreq
		local ll2_COD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_COD uisger02
		local ll3_COD "School enrollment, preprimary (% gross)"
		local e1_COD uiscr1
		local le1_COD "Primary completion rate (% of relevant age group)"
		local e2_COD lastnm_sec_ger
		local le2_COD "School enrollment, secondary (% gross)"
		local e3_COD se_lpv_prim
		local le3_COD "Learning Poverty"
		local h1_COD lastnm_afr
		local lh1_COD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_COD lastnm_ter_ger
		local lh2_COD "School enrollment, tertiary (% gross)"
		local h3_COD une_2eap_mf_y
		local lh3_COD "Youth unemployment (%), ages 15-24"
		local b1_COD eap_2wap_mf_a_f
		local lb1_COD "Labour force participation (%), ages 25+, Female"
		local b2_COD eap_2wap_mf_a_m
		local lb2_COD "Labour force participation (%), ages 25+, Male"
		local b3_COD sp_dyn_le00_in
		local lb3_COD "Life expectancy at birth (years)"
		local l1_COG unicef_neomort
		local ll1_COG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COG uisger02
		local ll2_COG "School enrollment, preprimary (% gross)"
		local l3_COG lastnm_mmrt
		local ll3_COG "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_COG uiscr1
		local le1_COG "Primary completion rate (% of relevant age group)"
		local e2_COG lastnm_sec_ger
		local le2_COG "School enrollment, secondary (% gross)"
		local e3_COG se_lpv_prim
		local le3_COG "Learning Poverty"
		local h1_COG lastnm_afr
		local lh1_COG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_COG lastnm_ter_ger
		local lh2_COG "School enrollment, tertiary (% gross)"
		local h3_COG une_2eap_mf_y
		local lh3_COG "Youth unemployment (%), ages 15-24"
		local b1_COG eap_2wap_mf_a_f
		local lb1_COG "Labour force participation (%), ages 25+, Female"
		local b2_COG eap_2wap_mf_a_m
		local lb2_COG "Labour force participation (%), ages 25+, Male"
		local b3_COG sp_dyn_le00_in
		local lb3_COG "Life expectancy at birth (years)"
		local l1_COL unicef_neomort
		local ll1_COL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COL unicef_mealfreq
		local ll2_COL "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_COL uisger02
		local ll3_COL "School enrollment, preprimary (% gross)"
		local e1_COL uiscr1
		local le1_COL "Primary completion rate (% of relevant age group)"
		local e2_COL lastnm_sec_ger
		local le2_COL "School enrollment, secondary (% gross)"
		local e3_COL se_lpv_prim
		local le3_COL "Learning Poverty"
		local h1_COL eip_neet_mf_y
		local lh1_COL "Youth NEET (%), ages 15-24"
		local h2_COL lastnm_afr
		local lh2_COL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_COL lastnm_ter_ger
		local lh3_COL "School enrollment, tertiary (% gross)"
		local b1_COL eap_2wap_mf_a_f
		local lb1_COL "Labour force participation (%), ages 25+, Female"
		local b2_COL eap_2wap_mf_a_m
		local lb2_COL "Labour force participation (%), ages 25+, Male"
		local b3_COL sp_dyn_le00_in
		local lb3_COL "Life expectancy at birth (years)"
		local l1_COM unicef_neomort
		local ll1_COM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_COM uisger02
		local ll2_COM "School enrollment, preprimary (% gross)"
		local l3_COM vacBCG
		local ll3_COM "Vaccine coverage - BCG"
		local e1_COM uiscr1
		local le1_COM "Primary completion rate (% of relevant age group)"
		local e2_COM lastnm_sec_ger
		local le2_COM "School enrollment, secondary (% gross)"
		local e3_COM uiscr2
		local le3_COM "Lower secondary completion rate (% of relevant age group)"
		local h1_COM lastnm_afr
		local lh1_COM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_COM une_2eap_mf_y_f
		local lh2_COM "Youth unemployment (%), ages 15-24, Female"
		local h3_COM une_2eap_mf_y_m
		local lh3_COM "Youth unemployment (%), ages 15-24, Male"
		local b1_COM eap_2wap_mf_a_f
		local lb1_COM "Labour force participation (%), ages 25+, Female"
		local b2_COM eap_2wap_mf_a_m
		local lb2_COM "Labour force participation (%), ages 25+, Male"
		local b3_COM sp_dyn_le00_in
		local lb3_COM "Life expectancy at birth (years)"
		local l1_CRI unicef_neomort
		local ll1_CRI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CRI uisger02
		local ll2_CRI "School enrollment, preprimary (% gross)"
		local l3_CRI lastnm_mmrt
		local ll3_CRI "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_CRI uiscr1
		local le1_CRI "Primary completion rate (% of relevant age group)"
		local e2_CRI lastnm_sec_ger
		local le2_CRI "School enrollment, secondary (% gross)"
		local e3_CRI se_lpv_prim
		local le3_CRI "Learning Poverty"
		local h1_CRI eip_neet_mf_y
		local lh1_CRI "Youth NEET (%), ages 15-24"
		local h2_CRI lastnm_afr
		local lh2_CRI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_CRI lastnm_ter_ger
		local lh3_CRI "School enrollment, tertiary (% gross)"
		local b1_CRI eap_2wap_mf_a_f
		local lb1_CRI "Labour force participation (%), ages 25+, Female"
		local b2_CRI eap_2wap_mf_a_m
		local lb2_CRI "Labour force participation (%), ages 25+, Male"
		local b3_CRI sp_dyn_le00_in
		local lb3_CRI "Life expectancy at birth (years)"
		local l1_CYP unicef_neomort
		local ll1_CYP "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CYP uisger02
		local ll2_CYP "School enrollment, preprimary (% gross)"
		local l3_CYP lastnm_birth_reg
		local ll3_CYP "Completeness of birth registration (%)"
		local e1_CYP uiscr1
		local le1_CYP "Primary completion rate (% of relevant age group)"
		local e2_CYP lastnm_sec_ger
		local le2_CYP "School enrollment, secondary (% gross)"
		local e3_CYP se_lpv_prim
		local le3_CYP "Learning Poverty"
		local h1_CYP lastnm_afr
		local lh1_CYP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CYP lastnm_ter_ger
		local lh2_CYP "School enrollment, tertiary (% gross)"
		local h3_CYP une_2eap_mf_y
		local lh3_CYP "Youth unemployment (%), ages 15-24"
		local b1_CYP eap_2wap_mf_a_f
		local lb1_CYP "Labour force participation (%), ages 25+, Female"
		local b2_CYP eap_2wap_mf_a_m
		local lb2_CYP "Labour force participation (%), ages 25+, Male"
		local b3_CYP sp_dyn_le00_in
		local lb3_CYP "Life expectancy at birth (years)"
		local l1_CZE unicef_neomort
		local ll1_CZE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_CZE uisger02
		local ll2_CZE "School enrollment, preprimary (% gross)"
		local l3_CZE lastnm_mmrt
		local ll3_CZE "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_CZE uiscr1
		local le1_CZE "Primary completion rate (% of relevant age group)"
		local e2_CZE lastnm_sec_ger
		local le2_CZE "School enrollment, secondary (% gross)"
		local e3_CZE se_lpv_prim
		local le3_CZE "Learning Poverty"
		local h1_CZE lastnm_afr
		local lh1_CZE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_CZE lastnm_ter_ger
		local lh2_CZE "School enrollment, tertiary (% gross)"
		local h3_CZE une_2eap_mf_y
		local lh3_CZE "Youth unemployment (%), ages 15-24"
		local b1_CZE eap_2wap_mf_a_f
		local lb1_CZE "Labour force participation (%), ages 25+, Female"
		local b2_CZE eap_2wap_mf_a_m
		local lb2_CZE "Labour force participation (%), ages 25+, Male"
		local b3_CZE sp_dyn_le00_in
		local lb3_CZE "Life expectancy at birth (years)"
		local l1_DEU unicef_neomort
		local ll1_DEU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DEU uisger02
		local ll2_DEU "School enrollment, preprimary (% gross)"
		local l3_DEU lastnm_mmrt
		local ll3_DEU "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_DEU uiscr1
		local le1_DEU "Primary completion rate (% of relevant age group)"
		local e2_DEU lastnm_sec_ger
		local le2_DEU "School enrollment, secondary (% gross)"
		local e3_DEU se_lpv_prim
		local le3_DEU "Learning Poverty"
		local h1_DEU lastnm_afr
		local lh1_DEU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_DEU lastnm_ter_ger
		local lh2_DEU "School enrollment, tertiary (% gross)"
		local h3_DEU une_2eap_mf_y
		local lh3_DEU "Youth unemployment (%), ages 15-24"
		local b1_DEU eap_2wap_mf_a_f
		local lb1_DEU "Labour force participation (%), ages 25+, Female"
		local b2_DEU eap_2wap_mf_a_m
		local lb2_DEU "Labour force participation (%), ages 25+, Male"
		local b3_DEU sp_dyn_le00_in
		local lb3_DEU "Life expectancy at birth (years)"
		local l1_DMA unicef_neomort
		local ll1_DMA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DMA uisger02
		local ll2_DMA "School enrollment, preprimary (% gross)"
		local l3_DMA vacBCG
		local ll3_DMA "Vaccine coverage - BCG"
		local e1_DMA uiscr1
		local le1_DMA "Primary completion rate (% of relevant age group)"
		local e2_DMA lastnm_sec_ger
		local le2_DMA "School enrollment, secondary (% gross)"
		local e3_DMA uiscr2
		local le3_DMA "Lower secondary completion rate (% of relevant age group)"
		local h1_DMA eip_neet_mf_y
		local lh1_DMA ""
		local h2_DMA lastnm_afr
		local lh2_DMA ""
		local h3_DMA lastnm_ter_ger
		local lh3_DMA ""
		local b1_DMA eap_2wap_mf_a_f
		local lb1_DMA ""
		local b2_DMA eap_2wap_mf_a_m
		local lb2_DMA ""
		local b3_DMA sp_dyn_le00_in
		local lb3_DMA ""
		local l1_DNK unicef_neomort
		local ll1_DNK "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DNK uisger02
		local ll2_DNK "School enrollment, preprimary (% gross)"
		local l3_DNK lastnm_birth_reg
		local ll3_DNK "Completeness of birth registration (%)"
		local e1_DNK uiscr1
		local le1_DNK "Primary completion rate (% of relevant age group)"
		local e2_DNK lastnm_sec_ger
		local le2_DNK "School enrollment, secondary (% gross)"
		local e3_DNK se_lpv_prim
		local le3_DNK "Learning Poverty"
		local h1_DNK lastnm_afr
		local lh1_DNK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_DNK lastnm_ter_ger
		local lh2_DNK "School enrollment, tertiary (% gross)"
		local h3_DNK une_2eap_mf_y
		local lh3_DNK "Youth unemployment (%), ages 15-24"
		local b1_DNK eap_2wap_mf_a_f
		local lb1_DNK "Labour force participation (%), ages 25+, Female"
		local b2_DNK eap_2wap_mf_a_m
		local lb2_DNK "Labour force participation (%), ages 25+, Male"
		local b3_DNK sp_dyn_le00_in
		local lb3_DNK "Life expectancy at birth (years)"
		local l1_DOM unicef_neomort
		local ll1_DOM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DOM uisger02
		local ll2_DOM "School enrollment, preprimary (% gross)"
		local l3_DOM lastnm_mmrt
		local ll3_DOM "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_DOM uiscr1
		local le1_DOM "Primary completion rate (% of relevant age group)"
		local e2_DOM lastnm_sec_ger
		local le2_DOM "School enrollment, secondary (% gross)"
		local e3_DOM se_lpv_prim
		local le3_DOM "Learning Poverty"
		local h1_DOM eip_neet_mf_y
		local lh1_DOM "Youth NEET (%), ages 15-24"
		local h2_DOM lastnm_afr
		local lh2_DOM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_DOM lastnm_ter_ger
		local lh3_DOM "School enrollment, tertiary (% gross)"
		local b1_DOM eap_2wap_mf_a_f
		local lb1_DOM "Labour force participation (%), ages 25+, Female"
		local b2_DOM eap_2wap_mf_a_m
		local lb2_DOM "Labour force participation (%), ages 25+, Male"
		local b3_DOM sp_dyn_le00_in
		local lb3_DOM "Life expectancy at birth (years)"
		local l1_DZA unicef_neomort
		local ll1_DZA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_DZA unicef_mealfreq
		local ll2_DZA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_DZA unicef_care
		local ll3_DZA "Postnatal contact with a health provider within 2 days of delivery"
		local e1_DZA uiscr1
		local le1_DZA "Primary completion rate (% of relevant age group)"
		local e2_DZA uiscr2
		local le2_DZA "Lower secondary completion rate (% of relevant age group)"
		local e3_DZA vacHEPBB
		local le3_DZA "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_DZA lastnm_afr
		local lh1_DZA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_DZA lastnm_ter_ger
		local lh2_DZA "School enrollment, tertiary (% gross)"
		local h3_DZA une_2eap_mf_y
		local lh3_DZA "Youth unemployment (%), ages 15-24"
		local b1_DZA eap_2wap_mf_a_f
		local lb1_DZA "Labour force participation (%), ages 25+, Female"
		local b2_DZA eap_2wap_mf_a_m
		local lb2_DZA "Labour force participation (%), ages 25+, Male"
		local b3_DZA sp_dyn_le00_in
		local lb3_DZA "Life expectancy at birth (years)"
		local l1_ECU unicef_neomort
		local ll1_ECU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ECU unicef_mealfreq
		local ll2_ECU "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ECU uisger02
		local ll3_ECU "School enrollment, preprimary (% gross)"
		local e1_ECU uiscr1
		local le1_ECU "Primary completion rate (% of relevant age group)"
		local e2_ECU lastnm_sec_ger
		local le2_ECU "School enrollment, secondary (% gross)"
		local e3_ECU se_lpv_prim
		local le3_ECU "Learning Poverty"
		local h1_ECU eip_neet_mf_y
		local lh1_ECU "Youth NEET (%), ages 15-24"
		local h2_ECU lastnm_afr
		local lh2_ECU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ECU lastnm_ter_ger
		local lh3_ECU "School enrollment, tertiary (% gross)"
		local b1_ECU eap_2wap_mf_a_f
		local lb1_ECU "Labour force participation (%), ages 25+, Female"
		local b2_ECU eap_2wap_mf_a_m
		local lb2_ECU "Labour force participation (%), ages 25+, Male"
		local b3_ECU sp_dyn_le00_in
		local lb3_ECU "Life expectancy at birth (years)"
		local l1_EGY unicef_neomort
		local ll1_EGY "Mortality rate, neonatal (per 1,000 live births)"
		local l2_EGY uisger02
		local ll2_EGY "School enrollment, preprimary (% gross)"
		local l3_EGY lastnm_mmrt
		local ll3_EGY "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_EGY uiscr1
		local le1_EGY "Primary completion rate (% of relevant age group)"
		local e2_EGY lastnm_sec_ger
		local le2_EGY "School enrollment, secondary (% gross)"
		local e3_EGY se_lpv_prim
		local le3_EGY "Learning Poverty"
		local h1_EGY eip_neet_mf_y
		local lh1_EGY "Youth NEET (%), ages 15-24"
		local h2_EGY lastnm_afr
		local lh2_EGY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_EGY lastnm_ter_ger
		local lh3_EGY "School enrollment, tertiary (% gross)"
		local b1_EGY eap_2wap_mf_a_f
		local lb1_EGY "Labour force participation (%), ages 25+, Female"
		local b2_EGY eap_2wap_mf_a_m
		local lb2_EGY "Labour force participation (%), ages 25+, Male"
		local b3_EGY sp_dyn_le00_in
		local lb3_EGY "Life expectancy at birth (years)"
		local l1_ESP unicef_neomort
		local ll1_ESP "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ESP uisger02
		local ll2_ESP "School enrollment, preprimary (% gross)"
		local l3_ESP lastnm_mmrt
		local ll3_ESP "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_ESP uiscr1
		local le1_ESP "Primary completion rate (% of relevant age group)"
		local e2_ESP lastnm_sec_ger
		local le2_ESP "School enrollment, secondary (% gross)"
		local e3_ESP se_lpv_prim
		local le3_ESP "Learning Poverty"
		local h1_ESP lastnm_afr
		local lh1_ESP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ESP lastnm_ter_ger
		local lh2_ESP "School enrollment, tertiary (% gross)"
		local h3_ESP une_2eap_mf_y
		local lh3_ESP "Youth unemployment (%), ages 15-24"
		local b1_ESP eap_2wap_mf_a_f
		local lb1_ESP "Labour force participation (%), ages 25+, Female"
		local b2_ESP eap_2wap_mf_a_m
		local lb2_ESP "Labour force participation (%), ages 25+, Male"
		local b3_ESP sp_dyn_le00_in
		local lb3_ESP "Life expectancy at birth (years)"
		local l1_EST unicef_neomort
		local ll1_EST "Mortality rate, neonatal (per 1,000 live births)"
		local l2_EST uisger02
		local ll2_EST "School enrollment, preprimary (% gross)"
		local l3_EST lastnm_mmrt
		local ll3_EST "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_EST uiscr1
		local le1_EST "Primary completion rate (% of relevant age group)"
		local e2_EST lastnm_sec_ger
		local le2_EST "School enrollment, secondary (% gross)"
		local e3_EST uiscr2
		local le3_EST "Lower secondary completion rate (% of relevant age group)"
		local h1_EST lastnm_afr
		local lh1_EST "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_EST lastnm_ter_ger
		local lh2_EST "School enrollment, tertiary (% gross)"
		local h3_EST une_2eap_mf_y
		local lh3_EST "Youth unemployment (%), ages 15-24"
		local b1_EST eap_2wap_mf_a_f
		local lb1_EST "Labour force participation (%), ages 25+, Female"
		local b2_EST eap_2wap_mf_a_m
		local lb2_EST "Labour force participation (%), ages 25+, Male"
		local b3_EST sp_dyn_le00_in
		local lb3_EST "Life expectancy at birth (years)"
		local l1_ETH unicef_neomort
		local ll1_ETH "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ETH unicef_mealfreq
		local ll2_ETH "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ETH uisger02
		local ll3_ETH "School enrollment, preprimary (% gross)"
		local e1_ETH uiscr1
		local le1_ETH "Primary completion rate (% of relevant age group)"
		local e2_ETH lastnm_sec_ger
		local le2_ETH "School enrollment, secondary (% gross)"
		local e3_ETH se_lpv_prim
		local le3_ETH "Learning Poverty"
		local h1_ETH lastnm_afr
		local lh1_ETH "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ETH lastnm_ter_ger
		local lh2_ETH "School enrollment, tertiary (% gross)"
		local h3_ETH une_2eap_mf_y
		local lh3_ETH "Youth unemployment (%), ages 15-24"
		local b1_ETH eap_2wap_mf_a_f
		local lb1_ETH "Labour force participation (%), ages 25+, Female"
		local b2_ETH eap_2wap_mf_a_m
		local lb2_ETH "Labour force participation (%), ages 25+, Male"
		local b3_ETH sp_dyn_le00_in
		local lb3_ETH "Life expectancy at birth (years)"
		local l1_FIN unicef_neomort
		local ll1_FIN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_FIN uisger02
		local ll2_FIN "School enrollment, preprimary (% gross)"
		local l3_FIN lastnm_mmrt
		local ll3_FIN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_FIN uiscr1
		local le1_FIN "Primary completion rate (% of relevant age group)"
		local e2_FIN lastnm_sec_ger
		local le2_FIN "School enrollment, secondary (% gross)"
		local e3_FIN se_lpv_prim
		local le3_FIN "Learning Poverty"
		local h1_FIN lastnm_afr
		local lh1_FIN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_FIN lastnm_ter_ger
		local lh2_FIN "School enrollment, tertiary (% gross)"
		local h3_FIN une_2eap_mf_y
		local lh3_FIN "Youth unemployment (%), ages 15-24"
		local b1_FIN eap_2wap_mf_a_f
		local lb1_FIN "Labour force participation (%), ages 25+, Female"
		local b2_FIN eap_2wap_mf_a_m
		local lb2_FIN "Labour force participation (%), ages 25+, Male"
		local b3_FIN sp_dyn_le00_in
		local lb3_FIN "Life expectancy at birth (years)"
		local l1_FJI unicef_neomort
		local ll1_FJI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_FJI uisger02
		local ll2_FJI "School enrollment, preprimary (% gross)"
		local l3_FJI unicef_care
		local ll3_FJI "Postnatal contact with a health provider within 2 days of delivery"
		local e1_FJI uiscr1
		local le1_FJI "Primary completion rate (% of relevant age group)"
		local e2_FJI lastnm_sec_ger
		local le2_FJI "School enrollment, secondary (% gross)"
		local e3_FJI uiscr2
		local le3_FJI "Lower secondary completion rate (% of relevant age group)"
		local h1_FJI eip_neet_mf_y
		local lh1_FJI "Youth NEET (%), ages 15-24"
		local h2_FJI lastnm_afr
		local lh2_FJI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_FJI lastnm_ter_ger
		local lh3_FJI "School enrollment, tertiary (% gross)"
		local b1_FJI eap_2wap_mf_a_f
		local lb1_FJI "Labour force participation (%), ages 25+, Female"
		local b2_FJI eap_2wap_mf_a_m
		local lb2_FJI "Labour force participation (%), ages 25+, Male"
		local b3_FJI sp_dyn_le00_in
		local lb3_FJI "Life expectancy at birth (years)"
		local l1_FRA unicef_neomort
		local ll1_FRA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_FRA uisger02
		local ll2_FRA "School enrollment, preprimary (% gross)"
		local l3_FRA lastnm_mmrt
		local ll3_FRA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_FRA lastnm_sec_ger
		local le1_FRA "School enrollment, secondary (% gross)"
		local e2_FRA se_lpv_prim
		local le2_FRA "Learning Poverty"
		local e3_FRA uiscr2
		local le3_FRA "Lower secondary completion rate (% of relevant age group)"
		local h1_FRA lastnm_afr
		local lh1_FRA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_FRA lastnm_ter_ger
		local lh2_FRA "School enrollment, tertiary (% gross)"
		local h3_FRA une_2eap_mf_y
		local lh3_FRA "Youth unemployment (%), ages 15-24"
		local b1_FRA eap_2wap_mf_a_f
		local lb1_FRA "Labour force participation (%), ages 25+, Female"
		local b2_FRA eap_2wap_mf_a_m
		local lb2_FRA "Labour force participation (%), ages 25+, Male"
		local b3_FRA sp_dyn_le00_in
		local lb3_FRA "Life expectancy at birth (years)"
		local l1_FSM unicef_neomort
		local ll1_FSM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_FSM uisger02
		local ll2_FSM "School enrollment, preprimary (% gross)"
		local l3_FSM vacBCG
		local ll3_FSM "Vaccine coverage - BCG"
		local e1_FSM uiscr1
		local le1_FSM "Primary completion rate (% of relevant age group)"
		local e2_FSM uiscr2
		local le2_FSM "Lower secondary completion rate (% of relevant age group)"
		local e3_FSM vacHEPBB
		local le3_FSM "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_FSM lastnm_afr
		local lh1_FSM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_FSM eip_neet_mf_y
		local lh2_FSM ""
		local h3_FSM lastnm_ter_ger
		local lh3_FSM ""
		local b1_FSM lastnm_probdeath_ncd
		local lb1_FSM "Cause of death, by non-communicable diseases (% of total)"
		local b2_FSM sp_dyn_le00_in_f
		local lb2_FSM "Life expectancy at birth (years), Female"
		local b3_FSM sp_dyn_le00_in_m
		local lb3_FSM "Life expectancy at birth (years), Male"
		local l1_GAB unicef_neomort
		local ll1_GAB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GAB uisger02
		local ll2_GAB "School enrollment, preprimary (% gross)"
		local l3_GAB vacBCG
		local ll3_GAB "Vaccine coverage - BCG"
		local e1_GAB uiscr1
		local le1_GAB "Primary completion rate (% of relevant age group)"
		local e2_GAB lastnm_sec_ger
		local le2_GAB "School enrollment, secondary (% gross)"
		local e3_GAB se_lpv_prim
		local le3_GAB "Learning Poverty"
		local h1_GAB lastnm_afr
		local lh1_GAB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GAB lastnm_ter_ger
		local lh2_GAB "School enrollment, tertiary (% gross)"
		local h3_GAB une_2eap_mf_y
		local lh3_GAB "Youth unemployment (%), ages 15-24"
		local b1_GAB eap_2wap_mf_a_f
		local lb1_GAB "Labour force participation (%), ages 25+, Female"
		local b2_GAB eap_2wap_mf_a_m
		local lb2_GAB "Labour force participation (%), ages 25+, Male"
		local b3_GAB sp_dyn_le00_in
		local lb3_GAB "Life expectancy at birth (years)"
		local l1_GBR unicef_neomort
		local ll1_GBR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GBR uisger02
		local ll2_GBR "School enrollment, preprimary (% gross)"
		local l3_GBR lastnm_mmrt
		local ll3_GBR "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_GBR uiscr1
		local le1_GBR "Primary completion rate (% of relevant age group)"
		local e2_GBR lastnm_sec_ger
		local le2_GBR "School enrollment, secondary (% gross)"
		local e3_GBR se_lpv_prim
		local le3_GBR "Learning Poverty"
		local h1_GBR lastnm_afr
		local lh1_GBR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GBR lastnm_ter_ger
		local lh2_GBR "School enrollment, tertiary (% gross)"
		local h3_GBR une_2eap_mf_y
		local lh3_GBR "Youth unemployment (%), ages 15-24"
		local b1_GBR eap_2wap_mf_a_f
		local lb1_GBR "Labour force participation (%), ages 25+, Female"
		local b2_GBR eap_2wap_mf_a_m
		local lb2_GBR "Labour force participation (%), ages 25+, Male"
		local b3_GBR sp_dyn_le00_in
		local lb3_GBR "Life expectancy at birth (years)"
		local l1_GEO unicef_neomort
		local ll1_GEO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GEO unicef_mealfreq
		local ll2_GEO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_GEO uisger02
		local ll3_GEO "School enrollment, preprimary (% gross)"
		local e1_GEO uiscr1
		local le1_GEO "Primary completion rate (% of relevant age group)"
		local e2_GEO lastnm_sec_ger
		local le2_GEO "School enrollment, secondary (% gross)"
		local e3_GEO se_lpv_prim
		local le3_GEO "Learning Poverty"
		local h1_GEO eip_neet_mf_y
		local lh1_GEO "Youth NEET (%), ages 15-24"
		local h2_GEO lastnm_afr
		local lh2_GEO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GEO lastnm_ter_ger
		local lh3_GEO "School enrollment, tertiary (% gross)"
		local b1_GEO eap_2wap_mf_a_f
		local lb1_GEO "Labour force participation (%), ages 25+, Female"
		local b2_GEO eap_2wap_mf_a_m
		local lb2_GEO "Labour force participation (%), ages 25+, Male"
		local b3_GEO sp_dyn_le00_in
		local lb3_GEO "Life expectancy at birth (years)"
		local l1_GHA unicef_neomort
		local ll1_GHA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GHA unicef_mealfreq
		local ll2_GHA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_GHA uisger02
		local ll3_GHA "School enrollment, preprimary (% gross)"
		local e1_GHA uiscr1
		local le1_GHA "Primary completion rate (% of relevant age group)"
		local e2_GHA lastnm_sec_ger
		local le2_GHA "School enrollment, secondary (% gross)"
		local e3_GHA uiscr2
		local le3_GHA "Lower secondary completion rate (% of relevant age group)"
		local h1_GHA eip_neet_mf_y
		local lh1_GHA "Youth NEET (%), ages 15-24"
		local h2_GHA lastnm_afr
		local lh2_GHA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GHA lastnm_ter_ger
		local lh3_GHA "School enrollment, tertiary (% gross)"
		local b1_GHA eap_2wap_mf_a_f
		local lb1_GHA "Labour force participation (%), ages 25+, Female"
		local b2_GHA eap_2wap_mf_a_m
		local lb2_GHA "Labour force participation (%), ages 25+, Male"
		local b3_GHA sp_dyn_le00_in
		local lb3_GHA "Life expectancy at birth (years)"
		local l1_GIN unicef_neomort
		local ll1_GIN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GIN unicef_mealfreq
		local ll2_GIN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_GIN uisger02
		local ll3_GIN "School enrollment, preprimary (% gross)"
		local e1_GIN uiscr1
		local le1_GIN "Primary completion rate (% of relevant age group)"
		local e2_GIN lastnm_sec_ger
		local le2_GIN "School enrollment, secondary (% gross)"
		local e3_GIN se_lpv_prim
		local le3_GIN "Learning Poverty"
		local h1_GIN eip_neet_mf_y
		local lh1_GIN "Youth NEET (%), ages 15-24"
		local h2_GIN lastnm_afr
		local lh2_GIN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GIN lastnm_ter_ger
		local lh3_GIN "School enrollment, tertiary (% gross)"
		local b1_GIN eap_2wap_mf_a_f
		local lb1_GIN "Labour force participation (%), ages 25+, Female"
		local b2_GIN eap_2wap_mf_a_m
		local lb2_GIN "Labour force participation (%), ages 25+, Male"
		local b3_GIN sp_dyn_le00_in
		local lb3_GIN "Life expectancy at birth (years)"
		local l1_GMB unicef_neomort
		local ll1_GMB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GMB unicef_mealfreq
		local ll2_GMB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_GMB uisger02
		local ll3_GMB "School enrollment, preprimary (% gross)"
		local e1_GMB uiscr1
		local le1_GMB "Primary completion rate (% of relevant age group)"
		local e2_GMB lastnm_sec_ger
		local le2_GMB "School enrollment, secondary (% gross)"
		local e3_GMB uiscr2
		local le3_GMB "Lower secondary completion rate (% of relevant age group)"
		local h1_GMB eip_neet_mf_y
		local lh1_GMB "Youth NEET (%), ages 15-24"
		local h2_GMB lastnm_afr
		local lh2_GMB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GMB une_2eap_mf_y
		local lh3_GMB "Youth unemployment (%), ages 15-24"
		local b1_GMB eap_2wap_mf_a_f
		local lb1_GMB "Labour force participation (%), ages 25+, Female"
		local b2_GMB eap_2wap_mf_a_m
		local lb2_GMB "Labour force participation (%), ages 25+, Male"
		local b3_GMB sp_dyn_le00_in
		local lb3_GMB "Life expectancy at birth (years)"
		local l1_GRC unicef_neomort
		local ll1_GRC "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GRC uisger02
		local ll2_GRC "School enrollment, preprimary (% gross)"
		local l3_GRC lastnm_mmrt
		local ll3_GRC "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_GRC uiscr1
		local le1_GRC "Primary completion rate (% of relevant age group)"
		local e2_GRC lastnm_sec_ger
		local le2_GRC "School enrollment, secondary (% gross)"
		local e3_GRC uiscr2
		local le3_GRC "Lower secondary completion rate (% of relevant age group)"
		local h1_GRC lastnm_afr
		local lh1_GRC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GRC lastnm_ter_ger
		local lh2_GRC "School enrollment, tertiary (% gross)"
		local h3_GRC une_2eap_mf_y
		local lh3_GRC "Youth unemployment (%), ages 15-24"
		local b1_GRC eap_2wap_mf_a_f
		local lb1_GRC "Labour force participation (%), ages 25+, Female"
		local b2_GRC eap_2wap_mf_a_m
		local lb2_GRC "Labour force participation (%), ages 25+, Male"
		local b3_GRC sp_dyn_le00_in
		local lb3_GRC "Life expectancy at birth (years)"
		local l1_GRD unicef_neomort
		local ll1_GRD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GRD uisger02_f
		local ll2_GRD "School enrollment, preprimary (% gross), Female"
		local l3_GRD uisger02_m
		local ll3_GRD "School enrollment, preprimary (% gross), Male"
		local e1_GRD uiscr1
		local le1_GRD "Primary completion rate (% of relevant age group)"
		local e2_GRD lastnm_sec_ger
		local le2_GRD "School enrollment, secondary (% gross)"
		local e3_GRD uiscr2
		local le3_GRD "Lower secondary completion rate (% of relevant age group)"
		local h1_GRD lastnm_afr
		local lh1_GRD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_GRD lastnm_ter_ger
		local lh2_GRD "School enrollment, tertiary (% gross)"
		local h3_GRD eip_neet_mf_y
		local lh3_GRD ""
		local b1_GRD lastnm_probdeath_ncd
		local lb1_GRD "Cause of death, by non-communicable diseases (% of total)"
		local b2_GRD sp_dyn_le00_in_f
		local lb2_GRD "Life expectancy at birth (years), Female"
		local b3_GRD sp_dyn_le00_in_m
		local lb3_GRD "Life expectancy at birth (years), Male"
		local l1_GTM unicef_neomort
		local ll1_GTM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GTM unicef_mealfreq
		local ll2_GTM "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_GTM uisger02
		local ll3_GTM "School enrollment, preprimary (% gross)"
		local e1_GTM uiscr1
		local le1_GTM "Primary completion rate (% of relevant age group)"
		local e2_GTM lastnm_sec_ger
		local le2_GTM "School enrollment, secondary (% gross)"
		local e3_GTM se_lpv_prim
		local le3_GTM "Learning Poverty"
		local h1_GTM eip_neet_mf_y
		local lh1_GTM "Youth NEET (%), ages 15-24"
		local h2_GTM lastnm_afr
		local lh2_GTM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GTM lastnm_ter_ger
		local lh3_GTM "School enrollment, tertiary (% gross)"
		local b1_GTM eap_2wap_mf_a_f
		local lb1_GTM "Labour force participation (%), ages 25+, Female"
		local b2_GTM eap_2wap_mf_a_m
		local lb2_GTM "Labour force participation (%), ages 25+, Male"
		local b3_GTM sp_dyn_le00_in
		local lb3_GTM "Life expectancy at birth (years)"
		local l1_GUY unicef_neomort
		local ll1_GUY "Mortality rate, neonatal (per 1,000 live births)"
		local l2_GUY unicef_care
		local ll2_GUY "Postnatal contact with a health provider within 2 days of delivery"
		local l3_GUY lastnm_birth_reg
		local ll3_GUY "Completeness of birth registration (%)"
		local e1_GUY vacHEPBB
		local le1_GUY "Vaccine coverage - Hepatitis B (HEPBB)"
		local e2_GUY uiscr1
		local le2_GUY ""
		local e3_GUY se_lpv_prim
		local le3_GUY ""
		local h1_GUY eip_neet_mf_y
		local lh1_GUY "Youth NEET (%), ages 15-24"
		local h2_GUY lastnm_afr
		local lh2_GUY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_GUY une_2eap_mf_y
		local lh3_GUY "Youth unemployment (%), ages 15-24"
		local b1_GUY eap_2wap_mf_a_f
		local lb1_GUY "Labour force participation (%), ages 25+, Female"
		local b2_GUY eap_2wap_mf_a_m
		local lb2_GUY "Labour force participation (%), ages 25+, Male"
		local b3_GUY sp_dyn_le00_in
		local lb3_GUY "Life expectancy at birth (years)"
		local l1_HKG uisger02_f
		local ll1_HKG "School enrollment, preprimary (% gross), Female"
		local l2_HKG uisger02_m
		local ll2_HKG "School enrollment, preprimary (% gross), Male"
		local l3_HKG unicef_neomort
		local ll3_HKG ""
		local e1_HKG uiscr1
		local le1_HKG "Primary completion rate (% of relevant age group)"
		local e2_HKG lastnm_sec_ger
		local le2_HKG "School enrollment, secondary (% gross)"
		local e3_HKG se_lpv_prim
		local le3_HKG "Learning Poverty"
		local h1_HKG eip_neet_mf_y
		local lh1_HKG "Youth NEET (%), ages 15-24"
		local h2_HKG lastnm_afr
		local lh2_HKG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_HKG lastnm_ter_ger
		local lh3_HKG "School enrollment, tertiary (% gross)"
		local b1_HKG eap_2wap_mf_a_f
		local lb1_HKG "Labour force participation (%), ages 25+, Female"
		local b2_HKG eap_2wap_mf_a_m
		local lb2_HKG "Labour force participation (%), ages 25+, Male"
		local b3_HKG sp_dyn_le00_in
		local lb3_HKG "Life expectancy at birth (years)"
		local l1_HND unicef_neomort
		local ll1_HND "Mortality rate, neonatal (per 1,000 live births)"
		local l2_HND uisger02
		local ll2_HND "School enrollment, preprimary (% gross)"
		local l3_HND unicef_care
		local ll3_HND "Postnatal contact with a health provider within 2 days of delivery"
		local e1_HND se_lpv_prim
		local le1_HND "Learning Poverty"
		local e2_HND vacHEPBB
		local le2_HND "Vaccine coverage - Hepatitis B (HEPBB)"
		local e3_HND uiscr1
		local le3_HND ""
		local h1_HND eip_neet_mf_y
		local lh1_HND "Youth NEET (%), ages 15-24"
		local h2_HND lastnm_afr
		local lh2_HND "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_HND lastnm_ter_ger
		local lh3_HND "School enrollment, tertiary (% gross)"
		local b1_HND eap_2wap_mf_a_f
		local lb1_HND "Labour force participation (%), ages 25+, Female"
		local b2_HND eap_2wap_mf_a_m
		local lb2_HND "Labour force participation (%), ages 25+, Male"
		local b3_HND sp_dyn_le00_in
		local lb3_HND "Life expectancy at birth (years)"
		local l1_HRV unicef_neomort
		local ll1_HRV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_HRV uisger02
		local ll2_HRV "School enrollment, preprimary (% gross)"
		local l3_HRV lastnm_mmrt
		local ll3_HRV "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_HRV uiscr1
		local le1_HRV "Primary completion rate (% of relevant age group)"
		local e2_HRV lastnm_sec_ger
		local le2_HRV "School enrollment, secondary (% gross)"
		local e3_HRV se_lpv_prim
		local le3_HRV "Learning Poverty"
		local h1_HRV lastnm_afr
		local lh1_HRV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_HRV lastnm_ter_ger
		local lh2_HRV "School enrollment, tertiary (% gross)"
		local h3_HRV une_2eap_mf_y
		local lh3_HRV "Youth unemployment (%), ages 15-24"
		local b1_HRV eap_2wap_mf_a_f
		local lb1_HRV "Labour force participation (%), ages 25+, Female"
		local b2_HRV eap_2wap_mf_a_m
		local lb2_HRV "Labour force participation (%), ages 25+, Male"
		local b3_HRV sp_dyn_le00_in
		local lb3_HRV "Life expectancy at birth (years)"
		local l1_HTI unicef_neomort
		local ll1_HTI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_HTI unicef_mealfreq
		local ll2_HTI "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_HTI lastnm_mmrt
		local ll3_HTI "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_HTI uiscr1
		local le1_HTI ""
		local e2_HTI lastnm_sec_ger
		local le2_HTI ""
		local e3_HTI se_lpv_prim
		local le3_HTI ""
		local h1_HTI lastnm_afr
		local lh1_HTI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_HTI une_2eap_mf_y_f
		local lh2_HTI "Youth unemployment (%), ages 15-24, Female"
		local h3_HTI une_2eap_mf_y_m
		local lh3_HTI "Youth unemployment (%), ages 15-24, Male"
		local b1_HTI eap_2wap_mf_a_f
		local lb1_HTI "Labour force participation (%), ages 25+, Female"
		local b2_HTI eap_2wap_mf_a_m
		local lb2_HTI "Labour force participation (%), ages 25+, Male"
		local b3_HTI sp_dyn_le00_in
		local lb3_HTI "Life expectancy at birth (years)"
		local l1_HUN unicef_neomort
		local ll1_HUN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_HUN uisger02
		local ll2_HUN "School enrollment, preprimary (% gross)"
		local l3_HUN lastnm_mmrt
		local ll3_HUN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_HUN uiscr1
		local le1_HUN "Primary completion rate (% of relevant age group)"
		local e2_HUN lastnm_sec_ger
		local le2_HUN "School enrollment, secondary (% gross)"
		local e3_HUN se_lpv_prim
		local le3_HUN "Learning Poverty"
		local h1_HUN lastnm_afr
		local lh1_HUN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_HUN lastnm_ter_ger
		local lh2_HUN "School enrollment, tertiary (% gross)"
		local h3_HUN une_2eap_mf_y
		local lh3_HUN "Youth unemployment (%), ages 15-24"
		local b1_HUN eap_2wap_mf_a_f
		local lb1_HUN "Labour force participation (%), ages 25+, Female"
		local b2_HUN eap_2wap_mf_a_m
		local lb2_HUN "Labour force participation (%), ages 25+, Male"
		local b3_HUN sp_dyn_le00_in
		local lb3_HUN "Life expectancy at birth (years)"
		local l1_IDN unicef_neomort
		local ll1_IDN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IDN unicef_mealfreq
		local ll2_IDN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_IDN uisger02
		local ll3_IDN "School enrollment, preprimary (% gross)"
		local e1_IDN uiscr1
		local le1_IDN "Primary completion rate (% of relevant age group)"
		local e2_IDN lastnm_sec_ger
		local le2_IDN "School enrollment, secondary (% gross)"
		local e3_IDN se_lpv_prim
		local le3_IDN "Learning Poverty"
		local h1_IDN eip_neet_mf_y
		local lh1_IDN "Youth NEET (%), ages 15-24"
		local h2_IDN lastnm_afr
		local lh2_IDN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_IDN lastnm_ter_ger
		local lh3_IDN "School enrollment, tertiary (% gross)"
		local b1_IDN eap_2wap_mf_a_f
		local lb1_IDN "Labour force participation (%), ages 25+, Female"
		local b2_IDN eap_2wap_mf_a_m
		local lb2_IDN "Labour force participation (%), ages 25+, Male"
		local b3_IDN sp_dyn_le00_in
		local lb3_IDN "Life expectancy at birth (years)"
		local l1_IND unicef_neomort
		local ll1_IND "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IND unicef_mealfreq
		local ll2_IND "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_IND uisger02
		local ll3_IND "School enrollment, preprimary (% gross)"
		local e1_IND uiscr1
		local le1_IND "Primary completion rate (% of relevant age group)"
		local e2_IND lastnm_sec_ger
		local le2_IND "School enrollment, secondary (% gross)"
		local e3_IND se_lpv_prim
		local le3_IND "Learning Poverty"
		local h1_IND lastnm_afr
		local lh1_IND "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_IND lastnm_ter_ger
		local lh2_IND "School enrollment, tertiary (% gross)"
		local h3_IND une_2eap_mf_y
		local lh3_IND "Youth unemployment (%), ages 15-24"
		local b1_IND eap_2wap_mf_a_f
		local lb1_IND "Labour force participation (%), ages 25+, Female"
		local b2_IND eap_2wap_mf_a_m
		local lb2_IND "Labour force participation (%), ages 25+, Male"
		local b3_IND sp_dyn_le00_in
		local lb3_IND "Life expectancy at birth (years)"
		local l1_IRL unicef_neomort
		local ll1_IRL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IRL uisger02
		local ll2_IRL "School enrollment, preprimary (% gross)"
		local l3_IRL lastnm_mmrt
		local ll3_IRL "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_IRL uiscr1
		local le1_IRL "Primary completion rate (% of relevant age group)"
		local e2_IRL lastnm_sec_ger
		local le2_IRL "School enrollment, secondary (% gross)"
		local e3_IRL se_lpv_prim
		local le3_IRL "Learning Poverty"
		local h1_IRL lastnm_afr
		local lh1_IRL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_IRL lastnm_ter_ger
		local lh2_IRL "School enrollment, tertiary (% gross)"
		local h3_IRL une_2eap_mf_y
		local lh3_IRL "Youth unemployment (%), ages 15-24"
		local b1_IRL eap_2wap_mf_a_f
		local lb1_IRL "Labour force participation (%), ages 25+, Female"
		local b2_IRL eap_2wap_mf_a_m
		local lb2_IRL "Labour force participation (%), ages 25+, Male"
		local b3_IRL sp_dyn_le00_in
		local lb3_IRL "Life expectancy at birth (years)"
		local l1_IRN unicef_neomort
		local ll1_IRN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IRN uisger02
		local ll2_IRN "School enrollment, preprimary (% gross)"
		local l3_IRN lastnm_mmrt
		local ll3_IRN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_IRN uiscr1
		local le1_IRN "Primary completion rate (% of relevant age group)"
		local e2_IRN lastnm_sec_ger
		local le2_IRN "School enrollment, secondary (% gross)"
		local e3_IRN se_lpv_prim
		local le3_IRN "Learning Poverty"
		local h1_IRN eip_neet_mf_y
		local lh1_IRN "Youth NEET (%), ages 15-24"
		local h2_IRN lastnm_afr
		local lh2_IRN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_IRN lastnm_ter_ger
		local lh3_IRN "School enrollment, tertiary (% gross)"
		local b1_IRN eap_2wap_mf_a_f
		local lb1_IRN "Labour force participation (%), ages 25+, Female"
		local b2_IRN eap_2wap_mf_a_m
		local lb2_IRN "Labour force participation (%), ages 25+, Male"
		local b3_IRN sp_dyn_le00_in
		local lb3_IRN "Life expectancy at birth (years)"
		local l1_IRQ unicef_neomort
		local ll1_IRQ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_IRQ unicef_mealfreq
		local ll2_IRQ "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_IRQ unicef_care
		local ll3_IRQ "Postnatal contact with a health provider within 2 days of delivery"
		local e1_IRQ vacHEPBB
		local le1_IRQ "Vaccine coverage - Hepatitis B (HEPBB)"
		local e2_IRQ uiscr1
		local le2_IRQ ""
		local e3_IRQ se_lpv_prim
		local le3_IRQ ""
		local h1_IRQ lastnm_afr
		local lh1_IRQ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_IRQ une_2eap_mf_y_f
		local lh2_IRQ "Youth unemployment (%), ages 15-24, Female"
		local h3_IRQ une_2eap_mf_y_m
		local lh3_IRQ "Youth unemployment (%), ages 15-24, Male"
		local b1_IRQ eap_2wap_mf_a_f
		local lb1_IRQ "Labour force participation (%), ages 25+, Female"
		local b2_IRQ eap_2wap_mf_a_m
		local lb2_IRQ "Labour force participation (%), ages 25+, Male"
		local b3_IRQ sp_dyn_le00_in
		local lb3_IRQ "Life expectancy at birth (years)"
		local l1_ISL unicef_neomort
		local ll1_ISL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ISL uisger02
		local ll2_ISL "School enrollment, preprimary (% gross)"
		local l3_ISL lastnm_birth_reg
		local ll3_ISL "Completeness of birth registration (%)"
		local e1_ISL uiscr1
		local le1_ISL "Primary completion rate (% of relevant age group)"
		local e2_ISL lastnm_sec_ger
		local le2_ISL "School enrollment, secondary (% gross)"
		local e3_ISL uiscr2
		local le3_ISL "Lower secondary completion rate (% of relevant age group)"
		local h1_ISL lastnm_afr
		local lh1_ISL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ISL lastnm_ter_ger
		local lh2_ISL "School enrollment, tertiary (% gross)"
		local h3_ISL une_2eap_mf_y
		local lh3_ISL "Youth unemployment (%), ages 15-24"
		local b1_ISL eap_2wap_mf_a_f
		local lb1_ISL "Labour force participation (%), ages 25+, Female"
		local b2_ISL eap_2wap_mf_a_m
		local lb2_ISL "Labour force participation (%), ages 25+, Male"
		local b3_ISL sp_dyn_le00_in
		local lb3_ISL "Life expectancy at birth (years)"
		local l1_ISR unicef_neomort
		local ll1_ISR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ISR uisger02
		local ll2_ISR "School enrollment, preprimary (% gross)"
		local l3_ISR lastnm_mmrt
		local ll3_ISR "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_ISR uiscr1
		local le1_ISR "Primary completion rate (% of relevant age group)"
		local e2_ISR lastnm_sec_ger
		local le2_ISR "School enrollment, secondary (% gross)"
		local e3_ISR se_lpv_prim
		local le3_ISR "Learning Poverty"
		local h1_ISR lastnm_afr
		local lh1_ISR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ISR lastnm_ter_ger
		local lh2_ISR "School enrollment, tertiary (% gross)"
		local h3_ISR une_2eap_mf_y
		local lh3_ISR "Youth unemployment (%), ages 15-24"
		local b1_ISR eap_2wap_mf_a_f
		local lb1_ISR "Labour force participation (%), ages 25+, Female"
		local b2_ISR eap_2wap_mf_a_m
		local lb2_ISR "Labour force participation (%), ages 25+, Male"
		local b3_ISR sp_dyn_le00_in
		local lb3_ISR "Life expectancy at birth (years)"
		local l1_ITA unicef_neomort
		local ll1_ITA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ITA uisger02
		local ll2_ITA "School enrollment, preprimary (% gross)"
		local l3_ITA lastnm_mmrt
		local ll3_ITA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_ITA uiscr1
		local le1_ITA "Primary completion rate (% of relevant age group)"
		local e2_ITA lastnm_sec_ger
		local le2_ITA "School enrollment, secondary (% gross)"
		local e3_ITA se_lpv_prim
		local le3_ITA "Learning Poverty"
		local h1_ITA lastnm_afr
		local lh1_ITA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ITA lastnm_ter_ger
		local lh2_ITA "School enrollment, tertiary (% gross)"
		local h3_ITA une_2eap_mf_y
		local lh3_ITA "Youth unemployment (%), ages 15-24"
		local b1_ITA eap_2wap_mf_a_f
		local lb1_ITA "Labour force participation (%), ages 25+, Female"
		local b2_ITA eap_2wap_mf_a_m
		local lb2_ITA "Labour force participation (%), ages 25+, Male"
		local b3_ITA sp_dyn_le00_in
		local lb3_ITA "Life expectancy at birth (years)"
		local l1_JAM unicef_neomort
		local ll1_JAM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_JAM lastnm_birth_reg
		local ll2_JAM "Completeness of birth registration (%)"
		local l3_JAM vacBCG
		local ll3_JAM "Vaccine coverage - BCG"
		local e1_JAM uiscr2
		local le1_JAM "Lower secondary completion rate (% of relevant age group)"
		local e2_JAM uiscr1_f
		local le2_JAM "Primary completion rate (% of relevant age group), Female"
		local e3_JAM uiscr1_m
		local le3_JAM "Primary completion rate (% of relevant age group), Male"
		local h1_JAM eip_neet_mf_y
		local lh1_JAM "Youth NEET (%), ages 15-24"
		local h2_JAM lastnm_afr
		local lh2_JAM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_JAM lastnm_ter_ger
		local lh3_JAM "School enrollment, tertiary (% gross)"
		local b1_JAM eap_2wap_mf_a_f
		local lb1_JAM "Labour force participation (%), ages 25+, Female"
		local b2_JAM eap_2wap_mf_a_m
		local lb2_JAM "Labour force participation (%), ages 25+, Male"
		local b3_JAM sp_dyn_le00_in
		local lb3_JAM "Life expectancy at birth (years)"
		local l1_JOR unicef_neomort
		local ll1_JOR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_JOR unicef_mealfreq
		local ll2_JOR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_JOR uisger02
		local ll3_JOR "School enrollment, preprimary (% gross)"
		local e1_JOR uiscr1
		local le1_JOR "Primary completion rate (% of relevant age group)"
		local e2_JOR lastnm_sec_ger
		local le2_JOR "School enrollment, secondary (% gross)"
		local e3_JOR se_lpv_prim
		local le3_JOR "Learning Poverty"
		local h1_JOR eip_neet_mf_y
		local lh1_JOR "Youth NEET (%), ages 15-24"
		local h2_JOR lastnm_afr
		local lh2_JOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_JOR lastnm_ter_ger
		local lh3_JOR "School enrollment, tertiary (% gross)"
		local b1_JOR eap_2wap_mf_a_f
		local lb1_JOR "Labour force participation (%), ages 25+, Female"
		local b2_JOR eap_2wap_mf_a_m
		local lb2_JOR "Labour force participation (%), ages 25+, Male"
		local b3_JOR sp_dyn_le00_in
		local lb3_JOR "Life expectancy at birth (years)"
		local l1_JPN unicef_neomort
		local ll1_JPN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_JPN uisger02
		local ll2_JPN "School enrollment, preprimary (% gross)"
		local l3_JPN lastnm_mmrt
		local ll3_JPN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_JPN lastnm_sec_ger
		local le1_JPN "School enrollment, secondary (% gross)"
		local e2_JPN se_lpv_prim_f
		local le2_JPN "Learning Poverty, Female"
		local e3_JPN se_lpv_prim_m
		local le3_JPN "Learning Poverty, Male"
		local h1_JPN lastnm_afr
		local lh1_JPN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_JPN lastnm_ter_ger
		local lh2_JPN "School enrollment, tertiary (% gross)"
		local h3_JPN une_2eap_mf_y
		local lh3_JPN "Youth unemployment (%), ages 15-24"
		local b1_JPN eap_2wap_mf_a_f
		local lb1_JPN "Labour force participation (%), ages 25+, Female"
		local b2_JPN eap_2wap_mf_a_m
		local lb2_JPN "Labour force participation (%), ages 25+, Male"
		local b3_JPN sp_dyn_le00_in
		local lb3_JPN "Life expectancy at birth (years)"
		local l1_KAZ unicef_neomort
		local ll1_KAZ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KAZ unicef_mealfreq
		local ll2_KAZ "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_KAZ uisger02
		local ll3_KAZ "School enrollment, preprimary (% gross)"
		local e1_KAZ uiscr1
		local le1_KAZ "Primary completion rate (% of relevant age group)"
		local e2_KAZ lastnm_sec_ger
		local le2_KAZ "School enrollment, secondary (% gross)"
		local e3_KAZ se_lpv_prim
		local le3_KAZ "Learning Poverty"
		local h1_KAZ lastnm_afr
		local lh1_KAZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_KAZ lastnm_ter_ger
		local lh2_KAZ "School enrollment, tertiary (% gross)"
		local h3_KAZ une_2eap_mf_y
		local lh3_KAZ "Youth unemployment (%), ages 15-24"
		local b1_KAZ eap_2wap_mf_a_f
		local lb1_KAZ "Labour force participation (%), ages 25+, Female"
		local b2_KAZ eap_2wap_mf_a_m
		local lb2_KAZ "Labour force participation (%), ages 25+, Male"
		local b3_KAZ sp_dyn_le00_in
		local lb3_KAZ "Life expectancy at birth (years)"
		local l1_KEN unicef_neomort
		local ll1_KEN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KEN uisger02
		local ll2_KEN "School enrollment, preprimary (% gross)"
		local l3_KEN vacBCG
		local ll3_KEN "Vaccine coverage - BCG"
		local e1_KEN uiscr2
		local le1_KEN "Lower secondary completion rate (% of relevant age group)"
		local e2_KEN uiscr1_f
		local le2_KEN "Primary completion rate (% of relevant age group), Female"
		local e3_KEN uiscr1_m
		local le3_KEN "Primary completion rate (% of relevant age group), Male"
		local h1_KEN eip_neet_mf_y
		local lh1_KEN "Youth NEET (%), ages 15-24"
		local h2_KEN lastnm_afr
		local lh2_KEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KEN lastnm_ter_ger
		local lh3_KEN "School enrollment, tertiary (% gross)"
		local b1_KEN eap_2wap_mf_a_f
		local lb1_KEN "Labour force participation (%), ages 25+, Female"
		local b2_KEN eap_2wap_mf_a_m
		local lb2_KEN "Labour force participation (%), ages 25+, Male"
		local b3_KEN sp_dyn_le00_in
		local lb3_KEN "Life expectancy at birth (years)"
		local l1_KGZ unicef_neomort
		local ll1_KGZ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KGZ unicef_mealfreq
		local ll2_KGZ "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_KGZ uisger02
		local ll3_KGZ "School enrollment, preprimary (% gross)"
		local e1_KGZ uiscr1
		local le1_KGZ "Primary completion rate (% of relevant age group)"
		local e2_KGZ lastnm_sec_ger
		local le2_KGZ "School enrollment, secondary (% gross)"
		local e3_KGZ uiscr2
		local le3_KGZ "Lower secondary completion rate (% of relevant age group)"
		local h1_KGZ eip_neet_mf_y
		local lh1_KGZ "Youth NEET (%), ages 15-24"
		local h2_KGZ lastnm_afr
		local lh2_KGZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KGZ lastnm_ter_ger
		local lh3_KGZ "School enrollment, tertiary (% gross)"
		local b1_KGZ eap_2wap_mf_a_f
		local lb1_KGZ "Labour force participation (%), ages 25+, Female"
		local b2_KGZ eap_2wap_mf_a_m
		local lb2_KGZ "Labour force participation (%), ages 25+, Male"
		local b3_KGZ sp_dyn_le00_in
		local lb3_KGZ "Life expectancy at birth (years)"
		local l1_KHM unicef_neomort
		local ll1_KHM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KHM uisger02
		local ll2_KHM "School enrollment, preprimary (% gross)"
		local l3_KHM vacBCG
		local ll3_KHM "Vaccine coverage - BCG"
		local e1_KHM uiscr1
		local le1_KHM "Primary completion rate (% of relevant age group)"
		local e2_KHM lastnm_sec_ger
		local le2_KHM "School enrollment, secondary (% gross)"
		local e3_KHM se_lpv_prim
		local le3_KHM "Learning Poverty"
		local h1_KHM eip_neet_mf_y
		local lh1_KHM "Youth NEET (%), ages 15-24"
		local h2_KHM lastnm_afr
		local lh2_KHM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_KHM lastnm_ter_ger
		local lh3_KHM "School enrollment, tertiary (% gross)"
		local b1_KHM eap_2wap_mf_a_f
		local lb1_KHM "Labour force participation (%), ages 25+, Female"
		local b2_KHM eap_2wap_mf_a_m
		local lb2_KHM "Labour force participation (%), ages 25+, Male"
		local b3_KHM sp_dyn_le00_in
		local lb3_KHM "Life expectancy at birth (years)"
		local l1_KIR unicef_neomort
		local ll1_KIR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KIR unicef_mealfreq
		local ll2_KIR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_KIR uisger02
		local ll3_KIR "School enrollment, preprimary (% gross)"
		local e1_KIR uiscr1
		local le1_KIR "Primary completion rate (% of relevant age group)"
		local e2_KIR uiscr2
		local le2_KIR "Lower secondary completion rate (% of relevant age group)"
		local e3_KIR vacHEPBB
		local le3_KIR "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_KIR lastnm_afr
		local lh1_KIR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_KIR eip_neet_mf_y_f
		local lh2_KIR "Youth NEET (%), ages 15-24, Female"
		local h3_KIR eip_neet_mf_y_m
		local lh3_KIR "Youth NEET (%), ages 15-24, Male"
		local b1_KIR lastnm_probdeath_ncd
		local lb1_KIR "Cause of death, by non-communicable diseases (% of total)"
		local b2_KIR sp_dyn_le00_in_f
		local lb2_KIR "Life expectancy at birth (years), Female"
		local b3_KIR sp_dyn_le00_in_m
		local lb3_KIR "Life expectancy at birth (years), Male"
		local l1_KNA unicef_neomort
		local ll1_KNA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KNA uisger02
		local ll2_KNA "School enrollment, preprimary (% gross)"
		local l3_KNA vacBCG
		local ll3_KNA "Vaccine coverage - BCG"
		local e1_KNA uiscr1
		local le1_KNA "Primary completion rate (% of relevant age group)"
		local e2_KNA lastnm_sec_ger
		local le2_KNA "School enrollment, secondary (% gross)"
		local e3_KNA uiscr2
		local le3_KNA "Lower secondary completion rate (% of relevant age group)"
		local h1_KNA lastnm_ter_ger
		local lh1_KNA "School enrollment, tertiary (% gross)"
		local h2_KNA eip_neet_mf_y
		local lh2_KNA ""
		local h3_KNA lastnm_afr
		local lh3_KNA ""
		local b1_KNA eap_2wap_mf_a_f
		local lb1_KNA ""
		local b2_KNA eap_2wap_mf_a_m
		local lb2_KNA ""
		local b3_KNA sp_dyn_le00_in
		local lb3_KNA ""
		local l1_KOR unicef_neomort
		local ll1_KOR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KOR uisger02
		local ll2_KOR "School enrollment, preprimary (% gross)"
		local l3_KOR lastnm_mmrt
		local ll3_KOR "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_KOR uiscr1
		local le1_KOR "Primary completion rate (% of relevant age group)"
		local e2_KOR lastnm_sec_ger
		local le2_KOR "School enrollment, secondary (% gross)"
		local e3_KOR se_lpv_prim
		local le3_KOR "Learning Poverty"
		local h1_KOR lastnm_afr
		local lh1_KOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_KOR lastnm_ter_ger
		local lh2_KOR "School enrollment, tertiary (% gross)"
		local h3_KOR une_2eap_mf_y
		local lh3_KOR "Youth unemployment (%), ages 15-24"
		local b1_KOR eap_2wap_mf_a_f
		local lb1_KOR "Labour force participation (%), ages 25+, Female"
		local b2_KOR eap_2wap_mf_a_m
		local lb2_KOR "Labour force participation (%), ages 25+, Male"
		local b3_KOR sp_dyn_le00_in
		local lb3_KOR "Life expectancy at birth (years)"
		local l1_KWT unicef_neomort
		local ll1_KWT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_KWT uisger02
		local ll2_KWT "School enrollment, preprimary (% gross)"
		local l3_KWT vacBCG
		local ll3_KWT "Vaccine coverage - BCG"
		local e1_KWT uiscr1
		local le1_KWT "Primary completion rate (% of relevant age group)"
		local e2_KWT lastnm_sec_ger
		local le2_KWT "School enrollment, secondary (% gross)"
		local e3_KWT se_lpv_prim
		local le3_KWT "Learning Poverty"
		local h1_KWT lastnm_afr
		local lh1_KWT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_KWT lastnm_ter_ger
		local lh2_KWT "School enrollment, tertiary (% gross)"
		local h3_KWT une_2eap_mf_y
		local lh3_KWT "Youth unemployment (%), ages 15-24"
		local b1_KWT eap_2wap_mf_a_f
		local lb1_KWT "Labour force participation (%), ages 25+, Female"
		local b2_KWT eap_2wap_mf_a_m
		local lb2_KWT "Labour force participation (%), ages 25+, Male"
		local b3_KWT sp_dyn_le00_in
		local lb3_KWT "Life expectancy at birth (years)"
		local l1_LAO unicef_neomort
		local ll1_LAO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LAO unicef_mealfreq
		local ll2_LAO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_LAO uisger02
		local ll3_LAO "School enrollment, preprimary (% gross)"
		local e1_LAO uiscr1
		local le1_LAO "Primary completion rate (% of relevant age group)"
		local e2_LAO lastnm_sec_ger
		local le2_LAO "School enrollment, secondary (% gross)"
		local e3_LAO se_lpv_prim
		local le3_LAO "Learning Poverty"
		local h1_LAO eip_neet_mf_y
		local lh1_LAO "Youth NEET (%), ages 15-24"
		local h2_LAO lastnm_afr
		local lh2_LAO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LAO lastnm_ter_ger
		local lh3_LAO "School enrollment, tertiary (% gross)"
		local b1_LAO eap_2wap_mf_a_f
		local lb1_LAO "Labour force participation (%), ages 25+, Female"
		local b2_LAO eap_2wap_mf_a_m
		local lb2_LAO "Labour force participation (%), ages 25+, Male"
		local b3_LAO sp_dyn_le00_in
		local lb3_LAO "Life expectancy at birth (years)"
		local l1_LBN unicef_neomort
		local ll1_LBN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LBN lastnm_mmrt
		local ll2_LBN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local l3_LBN lastnm_birth_reg
		local ll3_LBN "Completeness of birth registration (%)"
		local e1_LBN vacHEPBB
		local le1_LBN "Vaccine coverage - Hepatitis B (HEPBB)"
		local e2_LBN uiscr1
		local le2_LBN ""
		local e3_LBN se_lpv_prim
		local le3_LBN ""
		local h1_LBN eip_neet_mf_y
		local lh1_LBN "Youth NEET (%), ages 15-24"
		local h2_LBN lastnm_afr
		local lh2_LBN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LBN une_2eap_mf_y
		local lh3_LBN "Youth unemployment (%), ages 15-24"
		local b1_LBN eap_2wap_mf_a_f
		local lb1_LBN "Labour force participation (%), ages 25+, Female"
		local b2_LBN eap_2wap_mf_a_m
		local lb2_LBN "Labour force participation (%), ages 25+, Male"
		local b3_LBN sp_dyn_le00_in
		local lb3_LBN "Life expectancy at birth (years)"
		local l1_LBR unicef_neomort
		local ll1_LBR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LBR unicef_mealfreq
		local ll2_LBR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_LBR uisger02
		local ll3_LBR "School enrollment, preprimary (% gross)"
		local e1_LBR uiscr1
		local le1_LBR "Primary completion rate (% of relevant age group)"
		local e2_LBR lastnm_sec_ger
		local le2_LBR "School enrollment, secondary (% gross)"
		local e3_LBR uiscr2
		local le3_LBR "Lower secondary completion rate (% of relevant age group)"
		local h1_LBR eip_neet_mf_y
		local lh1_LBR "Youth NEET (%), ages 15-24"
		local h2_LBR lastnm_afr
		local lh2_LBR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LBR une_2eap_mf_y
		local lh3_LBR "Youth unemployment (%), ages 15-24"
		local b1_LBR eap_2wap_mf_a_f
		local lb1_LBR "Labour force participation (%), ages 25+, Female"
		local b2_LBR eap_2wap_mf_a_m
		local lb2_LBR "Labour force participation (%), ages 25+, Male"
		local b3_LBR sp_dyn_le00_in
		local lb3_LBR "Life expectancy at birth (years)"
		local l1_LCA unicef_neomort
		local ll1_LCA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LCA uisger02
		local ll2_LCA "School enrollment, preprimary (% gross)"
		local l3_LCA vacBCG
		local ll3_LCA "Vaccine coverage - BCG"
		local e1_LCA uiscr1
		local le1_LCA "Primary completion rate (% of relevant age group)"
		local e2_LCA lastnm_sec_ger
		local le2_LCA "School enrollment, secondary (% gross)"
		local e3_LCA uiscr2
		local le3_LCA "Lower secondary completion rate (% of relevant age group)"
		local h1_LCA eip_neet_mf_y
		local lh1_LCA "Youth NEET (%), ages 15-24"
		local h2_LCA lastnm_afr
		local lh2_LCA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LCA lastnm_ter_ger
		local lh3_LCA "School enrollment, tertiary (% gross)"
		local b1_LCA eap_2wap_mf_a_f
		local lb1_LCA "Labour force participation (%), ages 25+, Female"
		local b2_LCA eap_2wap_mf_a_m
		local lb2_LCA "Labour force participation (%), ages 25+, Male"
		local b3_LCA sp_dyn_le00_in
		local lb3_LCA "Life expectancy at birth (years)"
		local l1_LKA unicef_neomort
		local ll1_LKA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LKA uisger02
		local ll2_LKA "School enrollment, preprimary (% gross)"
		local l3_LKA lastnm_mmrt
		local ll3_LKA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_LKA uiscr1
		local le1_LKA "Primary completion rate (% of relevant age group)"
		local e2_LKA lastnm_sec_ger
		local le2_LKA "School enrollment, secondary (% gross)"
		local e3_LKA se_lpv_prim
		local le3_LKA "Learning Poverty"
		local h1_LKA eip_neet_mf_y
		local lh1_LKA "Youth NEET (%), ages 15-24"
		local h2_LKA lastnm_afr
		local lh2_LKA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LKA lastnm_ter_ger
		local lh3_LKA "School enrollment, tertiary (% gross)"
		local b1_LKA eap_2wap_mf_a_f
		local lb1_LKA "Labour force participation (%), ages 25+, Female"
		local b2_LKA eap_2wap_mf_a_m
		local lb2_LKA "Labour force participation (%), ages 25+, Male"
		local b3_LKA sp_dyn_le00_in
		local lb3_LKA "Life expectancy at birth (years)"
		local l1_LSO unicef_neomort
		local ll1_LSO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LSO unicef_mealfreq
		local ll2_LSO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_LSO uisger02
		local ll3_LSO "School enrollment, preprimary (% gross)"
		local e1_LSO uiscr1
		local le1_LSO "Primary completion rate (% of relevant age group)"
		local e2_LSO lastnm_sec_ger
		local le2_LSO "School enrollment, secondary (% gross)"
		local e3_LSO uiscr2
		local le3_LSO "Lower secondary completion rate (% of relevant age group)"
		local h1_LSO eip_neet_mf_y
		local lh1_LSO "Youth NEET (%), ages 15-24"
		local h2_LSO lastnm_afr
		local lh2_LSO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_LSO lastnm_ter_ger
		local lh3_LSO "School enrollment, tertiary (% gross)"
		local b1_LSO eap_2wap_mf_a_f
		local lb1_LSO "Labour force participation (%), ages 25+, Female"
		local b2_LSO eap_2wap_mf_a_m
		local lb2_LSO "Labour force participation (%), ages 25+, Male"
		local b3_LSO sp_dyn_le00_in
		local lb3_LSO "Life expectancy at birth (years)"
		local l1_LTU unicef_neomort
		local ll1_LTU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LTU uisger02
		local ll2_LTU "School enrollment, preprimary (% gross)"
		local l3_LTU lastnm_mmrt
		local ll3_LTU "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_LTU uiscr1
		local le1_LTU "Primary completion rate (% of relevant age group)"
		local e2_LTU lastnm_sec_ger
		local le2_LTU "School enrollment, secondary (% gross)"
		local e3_LTU se_lpv_prim
		local le3_LTU "Learning Poverty"
		local h1_LTU lastnm_afr
		local lh1_LTU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LTU lastnm_ter_ger
		local lh2_LTU "School enrollment, tertiary (% gross)"
		local h3_LTU une_2eap_mf_y
		local lh3_LTU "Youth unemployment (%), ages 15-24"
		local b1_LTU eap_2wap_mf_a_f
		local lb1_LTU "Labour force participation (%), ages 25+, Female"
		local b2_LTU eap_2wap_mf_a_m
		local lb2_LTU "Labour force participation (%), ages 25+, Male"
		local b3_LTU sp_dyn_le00_in
		local lb3_LTU "Life expectancy at birth (years)"
		local l1_LUX unicef_neomort
		local ll1_LUX "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LUX uisger02
		local ll2_LUX "School enrollment, preprimary (% gross)"
		local l3_LUX lastnm_birth_reg
		local ll3_LUX "Completeness of birth registration (%)"
		local e1_LUX uiscr1
		local le1_LUX "Primary completion rate (% of relevant age group)"
		local e2_LUX lastnm_sec_ger
		local le2_LUX "School enrollment, secondary (% gross)"
		local e3_LUX uiscr2
		local le3_LUX "Lower secondary completion rate (% of relevant age group)"
		local h1_LUX lastnm_afr
		local lh1_LUX "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LUX lastnm_ter_ger
		local lh2_LUX "School enrollment, tertiary (% gross)"
		local h3_LUX une_2eap_mf_y
		local lh3_LUX "Youth unemployment (%), ages 15-24"
		local b1_LUX eap_2wap_mf_a_f
		local lb1_LUX "Labour force participation (%), ages 25+, Female"
		local b2_LUX eap_2wap_mf_a_m
		local lb2_LUX "Labour force participation (%), ages 25+, Male"
		local b3_LUX sp_dyn_le00_in
		local lb3_LUX "Life expectancy at birth (years)"
		local l1_LVA unicef_neomort
		local ll1_LVA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_LVA uisger02
		local ll2_LVA "School enrollment, preprimary (% gross)"
		local l3_LVA lastnm_mmrt
		local ll3_LVA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_LVA uiscr1
		local le1_LVA "Primary completion rate (% of relevant age group)"
		local e2_LVA lastnm_sec_ger
		local le2_LVA "School enrollment, secondary (% gross)"
		local e3_LVA se_lpv_prim
		local le3_LVA "Learning Poverty"
		local h1_LVA lastnm_afr
		local lh1_LVA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_LVA lastnm_ter_ger
		local lh2_LVA "School enrollment, tertiary (% gross)"
		local h3_LVA une_2eap_mf_y
		local lh3_LVA "Youth unemployment (%), ages 15-24"
		local b1_LVA eap_2wap_mf_a_f
		local lb1_LVA "Labour force participation (%), ages 25+, Female"
		local b2_LVA eap_2wap_mf_a_m
		local lb2_LVA "Labour force participation (%), ages 25+, Male"
		local b3_LVA sp_dyn_le00_in
		local lb3_LVA "Life expectancy at birth (years)"
		local l1_MAC uisger02_f
		local ll1_MAC "School enrollment, preprimary (% gross), Female"
		local l2_MAC uisger02_m
		local ll2_MAC "School enrollment, preprimary (% gross), Male"
		local l3_MAC unicef_neomort
		local ll3_MAC ""
		local e1_MAC uiscr1
		local le1_MAC "Primary completion rate (% of relevant age group)"
		local e2_MAC lastnm_sec_ger
		local le2_MAC "School enrollment, secondary (% gross)"
		local e3_MAC se_lpv_prim
		local le3_MAC "Learning Poverty"
		local h1_MAC lastnm_afr
		local lh1_MAC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MAC lastnm_ter_ger
		local lh2_MAC "School enrollment, tertiary (% gross)"
		local h3_MAC une_2eap_mf_y
		local lh3_MAC "Youth unemployment (%), ages 15-24"
		local b1_MAC eap_2wap_mf_a_f
		local lb1_MAC "Labour force participation (%), ages 25+, Female"
		local b2_MAC eap_2wap_mf_a_m
		local lb2_MAC "Labour force participation (%), ages 25+, Male"
		local b3_MAC sp_dyn_le00_in
		local lb3_MAC "Life expectancy at birth (years)"
		local l1_MAR unicef_neomort
		local ll1_MAR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MAR uisger02
		local ll2_MAR "School enrollment, preprimary (% gross)"
		local l3_MAR lastnm_birth_reg
		local ll3_MAR "Completeness of birth registration (%)"
		local e1_MAR uiscr1
		local le1_MAR "Primary completion rate (% of relevant age group)"
		local e2_MAR lastnm_sec_ger
		local le2_MAR "School enrollment, secondary (% gross)"
		local e3_MAR se_lpv_prim
		local le3_MAR "Learning Poverty"
		local h1_MAR lastnm_afr
		local lh1_MAR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MAR lastnm_ter_ger
		local lh2_MAR "School enrollment, tertiary (% gross)"
		local h3_MAR une_2eap_mf_y
		local lh3_MAR "Youth unemployment (%), ages 15-24"
		local b1_MAR eap_2wap_mf_a_f
		local lb1_MAR "Labour force participation (%), ages 25+, Female"
		local b2_MAR eap_2wap_mf_a_m
		local lb2_MAR "Labour force participation (%), ages 25+, Male"
		local b3_MAR sp_dyn_le00_in
		local lb3_MAR "Life expectancy at birth (years)"
		local l1_MDA unicef_neomort
		local ll1_MDA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MDA uisger02
		local ll2_MDA "School enrollment, preprimary (% gross)"
		local l3_MDA lastnm_mmrt
		local ll3_MDA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_MDA uiscr1
		local le1_MDA "Primary completion rate (% of relevant age group)"
		local e2_MDA lastnm_sec_ger
		local le2_MDA "School enrollment, secondary (% gross)"
		local e3_MDA uiscr2
		local le3_MDA "Lower secondary completion rate (% of relevant age group)"
		local h1_MDA lastnm_afr
		local lh1_MDA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MDA lastnm_ter_ger
		local lh2_MDA "School enrollment, tertiary (% gross)"
		local h3_MDA une_2eap_mf_y
		local lh3_MDA "Youth unemployment (%), ages 15-24"
		local b1_MDA eap_2wap_mf_a_f
		local lb1_MDA "Labour force participation (%), ages 25+, Female"
		local b2_MDA eap_2wap_mf_a_m
		local lb2_MDA "Labour force participation (%), ages 25+, Male"
		local b3_MDA sp_dyn_le00_in
		local lb3_MDA "Life expectancy at birth (years)"
		local l1_MDG unicef_neomort
		local ll1_MDG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MDG unicef_mealfreq
		local ll2_MDG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MDG uisger02
		local ll3_MDG "School enrollment, preprimary (% gross)"
		local e1_MDG uiscr1
		local le1_MDG "Primary completion rate (% of relevant age group)"
		local e2_MDG lastnm_sec_ger
		local le2_MDG "School enrollment, secondary (% gross)"
		local e3_MDG se_lpv_prim
		local le3_MDG "Learning Poverty"
		local h1_MDG lastnm_afr
		local lh1_MDG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MDG lastnm_ter_ger
		local lh2_MDG "School enrollment, tertiary (% gross)"
		local h3_MDG une_2eap_mf_y
		local lh3_MDG "Youth unemployment (%), ages 15-24"
		local b1_MDG eap_2wap_mf_a_f
		local lb1_MDG "Labour force participation (%), ages 25+, Female"
		local b2_MDG eap_2wap_mf_a_m
		local lb2_MDG "Labour force participation (%), ages 25+, Male"
		local b3_MDG sp_dyn_le00_in
		local lb3_MDG "Life expectancy at birth (years)"
		local l1_MEX unicef_neomort
		local ll1_MEX "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MEX unicef_mealfreq
		local ll2_MEX "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MEX uisger02
		local ll3_MEX "School enrollment, preprimary (% gross)"
		local e1_MEX uiscr1
		local le1_MEX "Primary completion rate (% of relevant age group)"
		local e2_MEX lastnm_sec_ger
		local le2_MEX "School enrollment, secondary (% gross)"
		local e3_MEX se_lpv_prim
		local le3_MEX "Learning Poverty"
		local h1_MEX eip_neet_mf_y
		local lh1_MEX "Youth NEET (%), ages 15-24"
		local h2_MEX lastnm_afr
		local lh2_MEX "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MEX lastnm_ter_ger
		local lh3_MEX "School enrollment, tertiary (% gross)"
		local b1_MEX eap_2wap_mf_a_f
		local lb1_MEX "Labour force participation (%), ages 25+, Female"
		local b2_MEX eap_2wap_mf_a_m
		local lb2_MEX "Labour force participation (%), ages 25+, Male"
		local b3_MEX sp_dyn_le00_in
		local lb3_MEX "Life expectancy at birth (years)"
		local l1_MHL unicef_neomort
		local ll1_MHL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MHL unicef_mealfreq
		local ll2_MHL "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MHL uisger02
		local ll3_MHL "School enrollment, preprimary (% gross)"
		local e1_MHL uiscr1
		local le1_MHL "Primary completion rate (% of relevant age group)"
		local e2_MHL lastnm_sec_ger
		local le2_MHL "School enrollment, secondary (% gross)"
		local e3_MHL uiscr2
		local le3_MHL "Lower secondary completion rate (% of relevant age group)"
		local h1_MHL lastnm_ter_ger
		local lh1_MHL "School enrollment, tertiary (% gross)"
		local h2_MHL eip_neet_mf_y_f
		local lh2_MHL "Youth NEET (%), ages 15-24, Female"
		local h3_MHL eip_neet_mf_y_m
		local lh3_MHL "Youth NEET (%), ages 15-24, Male"
		local b1_MHL eap_2wap_mf_a_f
		local lb1_MHL ""
		local b2_MHL eap_2wap_mf_a_m
		local lb2_MHL ""
		local b3_MHL sp_dyn_le00_in
		local lb3_MHL ""
		local l1_MKD unicef_neomort
		local ll1_MKD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MKD unicef_mealfreq
		local ll2_MKD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MKD uisger02
		local ll3_MKD "School enrollment, preprimary (% gross)"
		local e1_MKD uiscr1
		local le1_MKD "Primary completion rate (% of relevant age group)"
		local e2_MKD lastnm_sec_ger
		local le2_MKD "School enrollment, secondary (% gross)"
		local e3_MKD se_lpv_prim
		local le3_MKD "Learning Poverty"
		local h1_MKD eip_neet_mf_y
		local lh1_MKD "Youth NEET (%), ages 15-24"
		local h2_MKD lastnm_afr
		local lh2_MKD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MKD lastnm_ter_ger
		local lh3_MKD "School enrollment, tertiary (% gross)"
		local b1_MKD eap_2wap_mf_a_f
		local lb1_MKD "Labour force participation (%), ages 25+, Female"
		local b2_MKD eap_2wap_mf_a_m
		local lb2_MKD "Labour force participation (%), ages 25+, Male"
		local b3_MKD sp_dyn_le00_in
		local lb3_MKD "Life expectancy at birth (years)"
		local l1_MLI unicef_neomort
		local ll1_MLI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MLI unicef_mealfreq
		local ll2_MLI "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MLI uisger02
		local ll3_MLI "School enrollment, preprimary (% gross)"
		local e1_MLI uiscr1
		local le1_MLI "Primary completion rate (% of relevant age group)"
		local e2_MLI lastnm_sec_ger
		local le2_MLI "School enrollment, secondary (% gross)"
		local e3_MLI uiscr2
		local le3_MLI "Lower secondary completion rate (% of relevant age group)"
		local h1_MLI eip_neet_mf_y
		local lh1_MLI "Youth NEET (%), ages 15-24"
		local h2_MLI lastnm_afr
		local lh2_MLI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MLI lastnm_ter_ger
		local lh3_MLI "School enrollment, tertiary (% gross)"
		local b1_MLI eap_2wap_mf_a_f
		local lb1_MLI "Labour force participation (%), ages 25+, Female"
		local b2_MLI eap_2wap_mf_a_m
		local lb2_MLI "Labour force participation (%), ages 25+, Male"
		local b3_MLI sp_dyn_le00_in
		local lb3_MLI "Life expectancy at birth (years)"
		local l1_MLT unicef_neomort
		local ll1_MLT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MLT uisger02
		local ll2_MLT "School enrollment, preprimary (% gross)"
		local l3_MLT lastnm_birth_reg
		local ll3_MLT "Completeness of birth registration (%)"
		local e1_MLT uiscr1
		local le1_MLT "Primary completion rate (% of relevant age group)"
		local e2_MLT lastnm_sec_ger
		local le2_MLT "School enrollment, secondary (% gross)"
		local e3_MLT se_lpv_prim
		local le3_MLT "Learning Poverty"
		local h1_MLT lastnm_afr
		local lh1_MLT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MLT lastnm_ter_ger
		local lh2_MLT "School enrollment, tertiary (% gross)"
		local h3_MLT une_2eap_mf_y
		local lh3_MLT "Youth unemployment (%), ages 15-24"
		local b1_MLT eap_2wap_mf_a_f
		local lb1_MLT "Labour force participation (%), ages 25+, Female"
		local b2_MLT eap_2wap_mf_a_m
		local lb2_MLT "Labour force participation (%), ages 25+, Male"
		local b3_MLT sp_dyn_le00_in
		local lb3_MLT "Life expectancy at birth (years)"
		local l1_MMR unicef_neomort
		local ll1_MMR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MMR unicef_mealfreq
		local ll2_MMR "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MMR uisger02
		local ll3_MMR "School enrollment, preprimary (% gross)"
		local e1_MMR uiscr1
		local le1_MMR "Primary completion rate (% of relevant age group)"
		local e2_MMR lastnm_sec_ger
		local le2_MMR "School enrollment, secondary (% gross)"
		local e3_MMR se_lpv_prim
		local le3_MMR "Learning Poverty"
		local h1_MMR eip_neet_mf_y
		local lh1_MMR "Youth NEET (%), ages 15-24"
		local h2_MMR lastnm_afr
		local lh2_MMR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MMR lastnm_ter_ger
		local lh3_MMR "School enrollment, tertiary (% gross)"
		local b1_MMR eap_2wap_mf_a_f
		local lb1_MMR "Labour force participation (%), ages 25+, Female"
		local b2_MMR eap_2wap_mf_a_m
		local lb2_MMR "Labour force participation (%), ages 25+, Male"
		local b3_MMR sp_dyn_le00_in
		local lb3_MMR "Life expectancy at birth (years)"
		local l1_MNE unicef_neomort
		local ll1_MNE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MNE unicef_mealfreq
		local ll2_MNE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MNE uisger02
		local ll3_MNE "School enrollment, preprimary (% gross)"
		local e1_MNE uiscr1
		local le1_MNE "Primary completion rate (% of relevant age group)"
		local e2_MNE lastnm_sec_ger
		local le2_MNE "School enrollment, secondary (% gross)"
		local e3_MNE se_lpv_prim
		local le3_MNE "Learning Poverty"
		local h1_MNE eip_neet_mf_y
		local lh1_MNE "Youth NEET (%), ages 15-24"
		local h2_MNE lastnm_afr
		local lh2_MNE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MNE lastnm_ter_ger
		local lh3_MNE "School enrollment, tertiary (% gross)"
		local b1_MNE eap_2wap_mf_a_f
		local lb1_MNE "Labour force participation (%), ages 25+, Female"
		local b2_MNE eap_2wap_mf_a_m
		local lb2_MNE "Labour force participation (%), ages 25+, Male"
		local b3_MNE sp_dyn_le00_in
		local lb3_MNE "Life expectancy at birth (years)"
		local l1_MNG unicef_neomort
		local ll1_MNG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MNG unicef_mealfreq
		local ll2_MNG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MNG uisger02
		local ll3_MNG "School enrollment, preprimary (% gross)"
		local e1_MNG uiscr1
		local le1_MNG "Primary completion rate (% of relevant age group)"
		local e2_MNG lastnm_sec_ger
		local le2_MNG "School enrollment, secondary (% gross)"
		local e3_MNG uiscr2
		local le3_MNG "Lower secondary completion rate (% of relevant age group)"
		local h1_MNG eip_neet_mf_y
		local lh1_MNG "Youth NEET (%), ages 15-24"
		local h2_MNG lastnm_afr
		local lh2_MNG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MNG lastnm_ter_ger
		local lh3_MNG "School enrollment, tertiary (% gross)"
		local b1_MNG eap_2wap_mf_a_f
		local lb1_MNG "Labour force participation (%), ages 25+, Female"
		local b2_MNG eap_2wap_mf_a_m
		local lb2_MNG "Labour force participation (%), ages 25+, Male"
		local b3_MNG sp_dyn_le00_in
		local lb3_MNG "Life expectancy at birth (years)"
		local l1_MOZ unicef_neomort
		local ll1_MOZ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MOZ unicef_care
		local ll2_MOZ "Postnatal contact with a health provider within 2 days of delivery"
		local l3_MOZ lastnm_birth_reg
		local ll3_MOZ "Completeness of birth registration (%)"
		local e1_MOZ uiscr1
		local le1_MOZ "Primary completion rate (% of relevant age group)"
		local e2_MOZ lastnm_sec_ger
		local le2_MOZ "School enrollment, secondary (% gross)"
		local e3_MOZ uiscr2
		local le3_MOZ "Lower secondary completion rate (% of relevant age group)"
		local h1_MOZ lastnm_afr
		local lh1_MOZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MOZ lastnm_ter_ger
		local lh2_MOZ "School enrollment, tertiary (% gross)"
		local h3_MOZ une_2eap_mf_y
		local lh3_MOZ "Youth unemployment (%), ages 15-24"
		local b1_MOZ eap_2wap_mf_a_f
		local lb1_MOZ "Labour force participation (%), ages 25+, Female"
		local b2_MOZ eap_2wap_mf_a_m
		local lb2_MOZ "Labour force participation (%), ages 25+, Male"
		local b3_MOZ sp_dyn_le00_in
		local lb3_MOZ "Life expectancy at birth (years)"
		local l1_MRT unicef_neomort
		local ll1_MRT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MRT unicef_mealfreq
		local ll2_MRT "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MRT uisger02
		local ll3_MRT "School enrollment, preprimary (% gross)"
		local e1_MRT uiscr1
		local le1_MRT "Primary completion rate (% of relevant age group)"
		local e2_MRT lastnm_sec_ger
		local le2_MRT "School enrollment, secondary (% gross)"
		local e3_MRT uiscr2
		local le3_MRT "Lower secondary completion rate (% of relevant age group)"
		local h1_MRT eip_neet_mf_y
		local lh1_MRT "Youth NEET (%), ages 15-24"
		local h2_MRT lastnm_afr
		local lh2_MRT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MRT lastnm_ter_ger
		local lh3_MRT "School enrollment, tertiary (% gross)"
		local b1_MRT eap_2wap_mf_a_f
		local lb1_MRT "Labour force participation (%), ages 25+, Female"
		local b2_MRT eap_2wap_mf_a_m
		local lb2_MRT "Labour force participation (%), ages 25+, Male"
		local b3_MRT sp_dyn_le00_in
		local lb3_MRT "Life expectancy at birth (years)"
		local l1_MUS unicef_neomort
		local ll1_MUS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MUS uisger02
		local ll2_MUS "School enrollment, preprimary (% gross)"
		local l3_MUS lastnm_mmrt
		local ll3_MUS "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_MUS uiscr1
		local le1_MUS "Primary completion rate (% of relevant age group)"
		local e2_MUS lastnm_sec_ger
		local le2_MUS "School enrollment, secondary (% gross)"
		local e3_MUS uiscr2
		local le3_MUS "Lower secondary completion rate (% of relevant age group)"
		local h1_MUS eip_neet_mf_y
		local lh1_MUS "Youth NEET (%), ages 15-24"
		local h2_MUS lastnm_afr
		local lh2_MUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MUS lastnm_ter_ger
		local lh3_MUS "School enrollment, tertiary (% gross)"
		local b1_MUS eap_2wap_mf_a_f
		local lb1_MUS "Labour force participation (%), ages 25+, Female"
		local b2_MUS eap_2wap_mf_a_m
		local lb2_MUS "Labour force participation (%), ages 25+, Male"
		local b3_MUS sp_dyn_le00_in
		local lb3_MUS "Life expectancy at birth (years)"
		local l1_MWI unicef_neomort
		local ll1_MWI "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MWI unicef_mealfreq
		local ll2_MWI "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_MWI uisger02
		local ll3_MWI "School enrollment, preprimary (% gross)"
		local e1_MWI uiscr1
		local le1_MWI "Primary completion rate (% of relevant age group)"
		local e2_MWI lastnm_sec_ger
		local le2_MWI "School enrollment, secondary (% gross)"
		local e3_MWI uiscr2
		local le3_MWI "Lower secondary completion rate (% of relevant age group)"
		local h1_MWI eip_neet_mf_y
		local lh1_MWI "Youth NEET (%), ages 15-24"
		local h2_MWI lastnm_afr
		local lh2_MWI "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_MWI lastnm_ter_ger
		local lh3_MWI "School enrollment, tertiary (% gross)"
		local b1_MWI eap_2wap_mf_a_f
		local lb1_MWI "Labour force participation (%), ages 25+, Female"
		local b2_MWI eap_2wap_mf_a_m
		local lb2_MWI "Labour force participation (%), ages 25+, Male"
		local b3_MWI sp_dyn_le00_in
		local lb3_MWI "Life expectancy at birth (years)"
		local l1_MYS unicef_neomort
		local ll1_MYS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_MYS uisger02
		local ll2_MYS "School enrollment, preprimary (% gross)"
		local l3_MYS unicef_breastf
		local ll3_MYS "Exclusive breastfeeding (%)"
		local e1_MYS uiscr1
		local le1_MYS "Primary completion rate (% of relevant age group)"
		local e2_MYS lastnm_sec_ger
		local le2_MYS "School enrollment, secondary (% gross)"
		local e3_MYS se_lpv_prim
		local le3_MYS "Learning Poverty"
		local h1_MYS lastnm_afr
		local lh1_MYS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_MYS lastnm_ter_ger
		local lh2_MYS "School enrollment, tertiary (% gross)"
		local h3_MYS une_2eap_mf_y
		local lh3_MYS "Youth unemployment (%), ages 15-24"
		local b1_MYS eap_2wap_mf_a_f
		local lb1_MYS "Labour force participation (%), ages 25+, Female"
		local b2_MYS eap_2wap_mf_a_m
		local lb2_MYS "Labour force participation (%), ages 25+, Male"
		local b3_MYS sp_dyn_le00_in
		local lb3_MYS "Life expectancy at birth (years)"
		local l1_NAM unicef_neomort
		local ll1_NAM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NAM uisger02
		local ll2_NAM "School enrollment, preprimary (% gross)"
		local l3_NAM lastnm_birth_reg
		local ll3_NAM "Completeness of birth registration (%)"
		local e1_NAM uiscr1
		local le1_NAM "Primary completion rate (% of relevant age group)"
		local e2_NAM uiscr2
		local le2_NAM "Lower secondary completion rate (% of relevant age group)"
		local e3_NAM vacHEPBB
		local le3_NAM "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_NAM eip_neet_mf_y
		local lh1_NAM "Youth NEET (%), ages 15-24"
		local h2_NAM lastnm_afr
		local lh2_NAM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NAM lastnm_ter_ger
		local lh3_NAM "School enrollment, tertiary (% gross)"
		local b1_NAM eap_2wap_mf_a_f
		local lb1_NAM "Labour force participation (%), ages 25+, Female"
		local b2_NAM eap_2wap_mf_a_m
		local lb2_NAM "Labour force participation (%), ages 25+, Male"
		local b3_NAM sp_dyn_le00_in
		local lb3_NAM "Life expectancy at birth (years)"
		local l1_NER unicef_neomort
		local ll1_NER "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NER unicef_mealfreq
		local ll2_NER "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_NER uisger02
		local ll3_NER "School enrollment, preprimary (% gross)"
		local e1_NER uiscr1
		local le1_NER "Primary completion rate (% of relevant age group)"
		local e2_NER lastnm_sec_ger
		local le2_NER "School enrollment, secondary (% gross)"
		local e3_NER se_lpv_prim
		local le3_NER "Learning Poverty"
		local h1_NER eip_neet_mf_y
		local lh1_NER "Youth NEET (%), ages 15-24"
		local h2_NER lastnm_afr
		local lh2_NER "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NER lastnm_ter_ger
		local lh3_NER "School enrollment, tertiary (% gross)"
		local b1_NER eap_2wap_mf_a_f
		local lb1_NER "Labour force participation (%), ages 25+, Female"
		local b2_NER eap_2wap_mf_a_m
		local lb2_NER "Labour force participation (%), ages 25+, Male"
		local b3_NER sp_dyn_le00_in
		local lb3_NER "Life expectancy at birth (years)"
		local l1_NGA unicef_neomort
		local ll1_NGA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NGA unicef_mealfreq
		local ll2_NGA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_NGA uisger02
		local ll3_NGA "School enrollment, preprimary (% gross)"
		local e1_NGA lastnm_sec_ger
		local le1_NGA "School enrollment, secondary (% gross)"
		local e2_NGA vacHEPBB
		local le2_NGA "Vaccine coverage - Hepatitis B (HEPBB)"
		local e3_NGA uiscr1
		local le3_NGA ""
		local h1_NGA eip_neet_mf_y
		local lh1_NGA "Youth NEET (%), ages 15-24"
		local h2_NGA lastnm_afr
		local lh2_NGA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NGA lastnm_ter_ger
		local lh3_NGA "School enrollment, tertiary (% gross)"
		local b1_NGA eap_2wap_mf_a_f
		local lb1_NGA "Labour force participation (%), ages 25+, Female"
		local b2_NGA eap_2wap_mf_a_m
		local lb2_NGA "Labour force participation (%), ages 25+, Male"
		local b3_NGA sp_dyn_le00_in
		local lb3_NGA "Life expectancy at birth (years)"
		local l1_NIC unicef_neomort
		local ll1_NIC "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NIC uisger02
		local ll2_NIC "School enrollment, preprimary (% gross)"
		local l3_NIC lastnm_mmrt
		local ll3_NIC "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_NIC se_lpv_prim
		local le1_NIC "Learning Poverty"
		local e2_NIC uiscr1
		local le2_NIC ""
		local e3_NIC lastnm_sec_ger
		local le3_NIC ""
		local h1_NIC lastnm_afr
		local lh1_NIC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_NIC lastnm_ter_ger
		local lh2_NIC "School enrollment, tertiary (% gross)"
		local h3_NIC une_2eap_mf_y
		local lh3_NIC "Youth unemployment (%), ages 15-24"
		local b1_NIC eap_2wap_mf_a_f
		local lb1_NIC "Labour force participation (%), ages 25+, Female"
		local b2_NIC eap_2wap_mf_a_m
		local lb2_NIC "Labour force participation (%), ages 25+, Male"
		local b3_NIC sp_dyn_le00_in
		local lb3_NIC "Life expectancy at birth (years)"
		local l1_NLD unicef_neomort
		local ll1_NLD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NLD uisger02
		local ll2_NLD "School enrollment, preprimary (% gross)"
		local l3_NLD lastnm_mmrt
		local ll3_NLD "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_NLD lastnm_sec_ger
		local le1_NLD "School enrollment, secondary (% gross)"
		local e2_NLD se_lpv_prim_f
		local le2_NLD "Learning Poverty, Female"
		local e3_NLD se_lpv_prim_m
		local le3_NLD "Learning Poverty, Male"
		local h1_NLD lastnm_afr
		local lh1_NLD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_NLD lastnm_ter_ger
		local lh2_NLD "School enrollment, tertiary (% gross)"
		local h3_NLD une_2eap_mf_y
		local lh3_NLD "Youth unemployment (%), ages 15-24"
		local b1_NLD eap_2wap_mf_a_f
		local lb1_NLD "Labour force participation (%), ages 25+, Female"
		local b2_NLD eap_2wap_mf_a_m
		local lb2_NLD "Labour force participation (%), ages 25+, Male"
		local b3_NLD sp_dyn_le00_in
		local lb3_NLD "Life expectancy at birth (years)"
		local l1_NOR unicef_neomort
		local ll1_NOR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NOR uisger02
		local ll2_NOR "School enrollment, preprimary (% gross)"
		local l3_NOR lastnm_birth_reg
		local ll3_NOR "Completeness of birth registration (%)"
		local e1_NOR uiscr1
		local le1_NOR "Primary completion rate (% of relevant age group)"
		local e2_NOR lastnm_sec_ger
		local le2_NOR "School enrollment, secondary (% gross)"
		local e3_NOR se_lpv_prim
		local le3_NOR "Learning Poverty"
		local h1_NOR lastnm_afr
		local lh1_NOR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_NOR lastnm_ter_ger
		local lh2_NOR "School enrollment, tertiary (% gross)"
		local h3_NOR une_2eap_mf_y
		local lh3_NOR "Youth unemployment (%), ages 15-24"
		local b1_NOR eap_2wap_mf_a_f
		local lb1_NOR "Labour force participation (%), ages 25+, Female"
		local b2_NOR eap_2wap_mf_a_m
		local lb2_NOR "Labour force participation (%), ages 25+, Male"
		local b3_NOR sp_dyn_le00_in
		local lb3_NOR "Life expectancy at birth (years)"
		local l1_NPL unicef_neomort
		local ll1_NPL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NPL unicef_mealfreq
		local ll2_NPL "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_NPL uisger02
		local ll3_NPL "School enrollment, preprimary (% gross)"
		local e1_NPL uiscr1
		local le1_NPL "Primary completion rate (% of relevant age group)"
		local e2_NPL lastnm_sec_ger
		local le2_NPL "School enrollment, secondary (% gross)"
		local e3_NPL uiscr2
		local le3_NPL "Lower secondary completion rate (% of relevant age group)"
		local h1_NPL eip_neet_mf_y
		local lh1_NPL "Youth NEET (%), ages 15-24"
		local h2_NPL lastnm_afr
		local lh2_NPL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_NPL lastnm_ter_ger
		local lh3_NPL "School enrollment, tertiary (% gross)"
		local b1_NPL eap_2wap_mf_a_f
		local lb1_NPL "Labour force participation (%), ages 25+, Female"
		local b2_NPL eap_2wap_mf_a_m
		local lb2_NPL "Labour force participation (%), ages 25+, Male"
		local b3_NPL sp_dyn_le00_in
		local lb3_NPL "Life expectancy at birth (years)"
		local l1_NRU unicef_neomort
		local ll1_NRU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NRU uisger02
		local ll2_NRU "School enrollment, preprimary (% gross)"
		local l3_NRU vacBCG
		local ll3_NRU "Vaccine coverage - BCG"
		local e1_NRU uiscr1
		local le1_NRU "Primary completion rate (% of relevant age group)"
		local e2_NRU lastnm_sec_ger
		local le2_NRU "School enrollment, secondary (% gross)"
		local e3_NRU uiscr2
		local le3_NRU "Lower secondary completion rate (% of relevant age group)"
		local h1_NRU eip_neet_mf_y
		local lh1_NRU ""
		local h2_NRU lastnm_afr
		local lh2_NRU ""
		local h3_NRU lastnm_ter_ger
		local lh3_NRU ""
		local b1_NRU eap_2wap_mf_a_f
		local lb1_NRU ""
		local b2_NRU eap_2wap_mf_a_m
		local lb2_NRU ""
		local b3_NRU sp_dyn_le00_in
		local lb3_NRU ""
		local l1_NZL unicef_neomort
		local ll1_NZL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_NZL uisger02
		local ll2_NZL "School enrollment, preprimary (% gross)"
		local l3_NZL lastnm_mmrt
		local ll3_NZL "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_NZL lastnm_sec_ger
		local le1_NZL "School enrollment, secondary (% gross)"
		local e2_NZL se_lpv_prim_f
		local le2_NZL "Learning Poverty, Female"
		local e3_NZL se_lpv_prim_m
		local le3_NZL "Learning Poverty, Male"
		local h1_NZL lastnm_afr
		local lh1_NZL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_NZL lastnm_ter_ger
		local lh2_NZL "School enrollment, tertiary (% gross)"
		local h3_NZL une_2eap_mf_y
		local lh3_NZL "Youth unemployment (%), ages 15-24"
		local b1_NZL eap_2wap_mf_a_f
		local lb1_NZL "Labour force participation (%), ages 25+, Female"
		local b2_NZL eap_2wap_mf_a_m
		local lb2_NZL "Labour force participation (%), ages 25+, Male"
		local b3_NZL sp_dyn_le00_in
		local lb3_NZL "Life expectancy at birth (years)"
		local l1_OMN unicef_neomort
		local ll1_OMN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_OMN uisger02
		local ll2_OMN "School enrollment, preprimary (% gross)"
		local l3_OMN lastnm_mmrt
		local ll3_OMN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_OMN uiscr1
		local le1_OMN "Primary completion rate (% of relevant age group)"
		local e2_OMN lastnm_sec_ger
		local le2_OMN "School enrollment, secondary (% gross)"
		local e3_OMN se_lpv_prim
		local le3_OMN "Learning Poverty"
		local h1_OMN lastnm_afr
		local lh1_OMN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_OMN lastnm_ter_ger
		local lh2_OMN "School enrollment, tertiary (% gross)"
		local h3_OMN une_2eap_mf_y
		local lh3_OMN "Youth unemployment (%), ages 15-24"
		local b1_OMN eap_2wap_mf_a_f
		local lb1_OMN "Labour force participation (%), ages 25+, Female"
		local b2_OMN eap_2wap_mf_a_m
		local lb2_OMN "Labour force participation (%), ages 25+, Male"
		local b3_OMN sp_dyn_le00_in
		local lb3_OMN "Life expectancy at birth (years)"
		local l1_PAK unicef_neomort
		local ll1_PAK "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PAK unicef_mealfreq
		local ll2_PAK "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_PAK uisger02
		local ll3_PAK "School enrollment, preprimary (% gross)"
		local e1_PAK uiscr1
		local le1_PAK "Primary completion rate (% of relevant age group)"
		local e2_PAK lastnm_sec_ger
		local le2_PAK "School enrollment, secondary (% gross)"
		local e3_PAK uiscr2
		local le3_PAK "Lower secondary completion rate (% of relevant age group)"
		local h1_PAK eip_neet_mf_y
		local lh1_PAK "Youth NEET (%), ages 15-24"
		local h2_PAK lastnm_afr
		local lh2_PAK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PAK lastnm_ter_ger
		local lh3_PAK "School enrollment, tertiary (% gross)"
		local b1_PAK eap_2wap_mf_a_f
		local lb1_PAK "Labour force participation (%), ages 25+, Female"
		local b2_PAK eap_2wap_mf_a_m
		local lb2_PAK "Labour force participation (%), ages 25+, Male"
		local b3_PAK sp_dyn_le00_in
		local lb3_PAK "Life expectancy at birth (years)"
		local l1_PAN unicef_neomort
		local ll1_PAN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PAN uisger02
		local ll2_PAN "School enrollment, preprimary (% gross)"
		local l3_PAN lastnm_mmrt
		local ll3_PAN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_PAN uiscr1
		local le1_PAN "Primary completion rate (% of relevant age group)"
		local e2_PAN lastnm_sec_ger
		local le2_PAN "School enrollment, secondary (% gross)"
		local e3_PAN se_lpv_prim
		local le3_PAN "Learning Poverty"
		local h1_PAN eip_neet_mf_y
		local lh1_PAN "Youth NEET (%), ages 15-24"
		local h2_PAN lastnm_afr
		local lh2_PAN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PAN lastnm_ter_ger
		local lh3_PAN "School enrollment, tertiary (% gross)"
		local b1_PAN eap_2wap_mf_a_f
		local lb1_PAN "Labour force participation (%), ages 25+, Female"
		local b2_PAN eap_2wap_mf_a_m
		local lb2_PAN "Labour force participation (%), ages 25+, Male"
		local b3_PAN sp_dyn_le00_in
		local lb3_PAN "Life expectancy at birth (years)"
		local l1_PER unicef_neomort
		local ll1_PER "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PER uisger02
		local ll2_PER "School enrollment, preprimary (% gross)"
		local l3_PER lastnm_birth_reg
		local ll3_PER "Completeness of birth registration (%)"
		local e1_PER uiscr1
		local le1_PER "Primary completion rate (% of relevant age group)"
		local e2_PER lastnm_sec_ger
		local le2_PER "School enrollment, secondary (% gross)"
		local e3_PER se_lpv_prim
		local le3_PER "Learning Poverty"
		local h1_PER eip_neet_mf_y
		local lh1_PER "Youth NEET (%), ages 15-24"
		local h2_PER lastnm_afr
		local lh2_PER "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PER lastnm_ter_ger
		local lh3_PER "School enrollment, tertiary (% gross)"
		local b1_PER eap_2wap_mf_a_f
		local lb1_PER "Labour force participation (%), ages 25+, Female"
		local b2_PER eap_2wap_mf_a_m
		local lb2_PER "Labour force participation (%), ages 25+, Male"
		local b3_PER sp_dyn_le00_in
		local lb3_PER "Life expectancy at birth (years)"
		local l1_PHL unicef_neomort
		local ll1_PHL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PHL uisger02
		local ll2_PHL "School enrollment, preprimary (% gross)"
		local l3_PHL unicef_care
		local ll3_PHL "Postnatal contact with a health provider within 2 days of delivery"
		local e1_PHL uiscr1
		local le1_PHL "Primary completion rate (% of relevant age group)"
		local e2_PHL lastnm_sec_ger
		local le2_PHL "School enrollment, secondary (% gross)"
		local e3_PHL se_lpv_prim
		local le3_PHL "Learning Poverty"
		local h1_PHL eip_neet_mf_y
		local lh1_PHL "Youth NEET (%), ages 15-24"
		local h2_PHL lastnm_afr
		local lh2_PHL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PHL lastnm_ter_ger
		local lh3_PHL "School enrollment, tertiary (% gross)"
		local b1_PHL eap_2wap_mf_a_f
		local lb1_PHL "Labour force participation (%), ages 25+, Female"
		local b2_PHL eap_2wap_mf_a_m
		local lb2_PHL "Labour force participation (%), ages 25+, Male"
		local b3_PHL sp_dyn_le00_in
		local lb3_PHL "Life expectancy at birth (years)"
		local l1_PLW unicef_neomort
		local ll1_PLW "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PLW uisger02_f
		local ll2_PLW "School enrollment, preprimary (% gross), Female"
		local l3_PLW uisger02_m
		local ll3_PLW "School enrollment, preprimary (% gross), Male"
		local e1_PLW uiscr1
		local le1_PLW "Primary completion rate (% of relevant age group)"
		local e2_PLW lastnm_sec_ger
		local le2_PLW "School enrollment, secondary (% gross)"
		local e3_PLW uiscr2
		local le3_PLW "Lower secondary completion rate (% of relevant age group)"
		local h1_PLW eip_neet_mf_y
		local lh1_PLW ""
		local h2_PLW lastnm_afr
		local lh2_PLW ""
		local h3_PLW lastnm_ter_ger
		local lh3_PLW ""
		local b1_PLW eap_2wap_mf_a_f
		local lb1_PLW ""
		local b2_PLW eap_2wap_mf_a_m
		local lb2_PLW ""
		local b3_PLW sp_dyn_le00_in
		local lb3_PLW ""
		local l1_PNG unicef_neomort
		local ll1_PNG "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PNG unicef_mealfreq
		local ll2_PNG "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_PNG uisger02
		local ll3_PNG "School enrollment, preprimary (% gross)"
		local e1_PNG uiscr1
		local le1_PNG "Primary completion rate (% of relevant age group)"
		local e2_PNG lastnm_sec_ger
		local le2_PNG "School enrollment, secondary (% gross)"
		local e3_PNG uiscr2
		local le3_PNG "Lower secondary completion rate (% of relevant age group)"
		local h1_PNG lastnm_afr
		local lh1_PNG "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_PNG une_2eap_mf_y_f
		local lh2_PNG "Youth unemployment (%), ages 15-24, Female"
		local h3_PNG une_2eap_mf_y_m
		local lh3_PNG "Youth unemployment (%), ages 15-24, Male"
		local b1_PNG eap_2wap_mf_a_f
		local lb1_PNG "Labour force participation (%), ages 25+, Female"
		local b2_PNG eap_2wap_mf_a_m
		local lb2_PNG "Labour force participation (%), ages 25+, Male"
		local b3_PNG sp_dyn_le00_in
		local lb3_PNG "Life expectancy at birth (years)"
		local l1_POL unicef_neomort
		local ll1_POL "Mortality rate, neonatal (per 1,000 live births)"
		local l2_POL uisger02
		local ll2_POL "School enrollment, preprimary (% gross)"
		local l3_POL lastnm_mmrt
		local ll3_POL "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_POL uiscr1
		local le1_POL "Primary completion rate (% of relevant age group)"
		local e2_POL lastnm_sec_ger
		local le2_POL "School enrollment, secondary (% gross)"
		local e3_POL se_lpv_prim
		local le3_POL "Learning Poverty"
		local h1_POL lastnm_afr
		local lh1_POL "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_POL lastnm_ter_ger
		local lh2_POL "School enrollment, tertiary (% gross)"
		local h3_POL une_2eap_mf_y
		local lh3_POL "Youth unemployment (%), ages 15-24"
		local b1_POL eap_2wap_mf_a_f
		local lb1_POL "Labour force participation (%), ages 25+, Female"
		local b2_POL eap_2wap_mf_a_m
		local lb2_POL "Labour force participation (%), ages 25+, Male"
		local b3_POL sp_dyn_le00_in
		local lb3_POL "Life expectancy at birth (years)"
		local l1_PRT unicef_neomort
		local ll1_PRT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PRT uisger02
		local ll2_PRT "School enrollment, preprimary (% gross)"
		local l3_PRT lastnm_mmrt
		local ll3_PRT "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_PRT uiscr1
		local le1_PRT "Primary completion rate (% of relevant age group)"
		local e2_PRT lastnm_sec_ger
		local le2_PRT "School enrollment, secondary (% gross)"
		local e3_PRT se_lpv_prim
		local le3_PRT "Learning Poverty"
		local h1_PRT eip_neet_mf_y
		local lh1_PRT "Youth NEET (%), ages 15-24"
		local h2_PRT lastnm_afr
		local lh2_PRT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PRT lastnm_ter_ger
		local lh3_PRT "School enrollment, tertiary (% gross)"
		local b1_PRT eap_2wap_mf_a_f
		local lb1_PRT "Labour force participation (%), ages 25+, Female"
		local b2_PRT eap_2wap_mf_a_m
		local lb2_PRT "Labour force participation (%), ages 25+, Male"
		local b3_PRT sp_dyn_le00_in
		local lb3_PRT "Life expectancy at birth (years)"
		local l1_PRY unicef_neomort
		local ll1_PRY "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PRY unicef_mealfreq
		local ll2_PRY "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_PRY uisger02
		local ll3_PRY "School enrollment, preprimary (% gross)"
		local e1_PRY uiscr1
		local le1_PRY "Primary completion rate (% of relevant age group)"
		local e2_PRY se_lpv_prim
		local le2_PRY "Learning Poverty"
		local e3_PRY uiscr2
		local le3_PRY "Lower secondary completion rate (% of relevant age group)"
		local h1_PRY eip_neet_mf_y
		local lh1_PRY "Youth NEET (%), ages 15-24"
		local h2_PRY lastnm_afr
		local lh2_PRY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PRY une_2eap_mf_y
		local lh3_PRY "Youth unemployment (%), ages 15-24"
		local b1_PRY eap_2wap_mf_a_f
		local lb1_PRY "Labour force participation (%), ages 25+, Female"
		local b2_PRY eap_2wap_mf_a_m
		local lb2_PRY "Labour force participation (%), ages 25+, Male"
		local b3_PRY sp_dyn_le00_in
		local lb3_PRY "Life expectancy at birth (years)"
		local l1_PSE unicef_neomort
		local ll1_PSE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_PSE unicef_mealfreq
		local ll2_PSE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_PSE uisger02
		local ll3_PSE "School enrollment, preprimary (% gross)"
		local e1_PSE uiscr1
		local le1_PSE "Primary completion rate (% of relevant age group)"
		local e2_PSE lastnm_sec_ger
		local le2_PSE "School enrollment, secondary (% gross)"
		local e3_PSE uiscr2
		local le3_PSE "Lower secondary completion rate (% of relevant age group)"
		local h1_PSE eip_neet_mf_y
		local lh1_PSE "Youth NEET (%), ages 15-24"
		local h2_PSE lastnm_afr
		local lh2_PSE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_PSE lastnm_ter_ger
		local lh3_PSE "School enrollment, tertiary (% gross)"
		local b1_PSE eap_2wap_mf_a_f
		local lb1_PSE "Labour force participation (%), ages 25+, Female"
		local b2_PSE eap_2wap_mf_a_m
		local lb2_PSE "Labour force participation (%), ages 25+, Male"
		local b3_PSE sp_dyn_le00_in
		local lb3_PSE "Life expectancy at birth (years)"
		local l1_QAT unicef_neomort
		local ll1_QAT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_QAT uisger02
		local ll2_QAT "School enrollment, preprimary (% gross)"
		local l3_QAT lastnm_birth_reg
		local ll3_QAT "Completeness of birth registration (%)"
		local e1_QAT uiscr1
		local le1_QAT "Primary completion rate (% of relevant age group)"
		local e2_QAT se_lpv_prim
		local le2_QAT "Learning Poverty"
		local e3_QAT uiscr2
		local le3_QAT "Lower secondary completion rate (% of relevant age group)"
		local h1_QAT lastnm_afr
		local lh1_QAT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_QAT lastnm_ter_ger
		local lh2_QAT "School enrollment, tertiary (% gross)"
		local h3_QAT une_2eap_mf_y
		local lh3_QAT "Youth unemployment (%), ages 15-24"
		local b1_QAT eap_2wap_mf_a_f
		local lb1_QAT "Labour force participation (%), ages 25+, Female"
		local b2_QAT eap_2wap_mf_a_m
		local lb2_QAT "Labour force participation (%), ages 25+, Male"
		local b3_QAT sp_dyn_le00_in
		local lb3_QAT "Life expectancy at birth (years)"
		local l1_ROU unicef_neomort
		local ll1_ROU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ROU uisger02
		local ll2_ROU "School enrollment, preprimary (% gross)"
		local l3_ROU lastnm_mmrt
		local ll3_ROU "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_ROU uiscr1
		local le1_ROU "Primary completion rate (% of relevant age group)"
		local e2_ROU lastnm_sec_ger
		local le2_ROU "School enrollment, secondary (% gross)"
		local e3_ROU uiscr2
		local le3_ROU "Lower secondary completion rate (% of relevant age group)"
		local h1_ROU lastnm_afr
		local lh1_ROU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_ROU lastnm_ter_ger
		local lh2_ROU "School enrollment, tertiary (% gross)"
		local h3_ROU une_2eap_mf_y
		local lh3_ROU "Youth unemployment (%), ages 15-24"
		local b1_ROU eap_2wap_mf_a_f
		local lb1_ROU "Labour force participation (%), ages 25+, Female"
		local b2_ROU eap_2wap_mf_a_m
		local lb2_ROU "Labour force participation (%), ages 25+, Male"
		local b3_ROU sp_dyn_le00_in
		local lb3_ROU "Life expectancy at birth (years)"
		local l1_RUS unicef_neomort
		local ll1_RUS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_RUS uisger02
		local ll2_RUS "School enrollment, preprimary (% gross)"
		local l3_RUS lastnm_mmrt
		local ll3_RUS "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_RUS uiscr1
		local le1_RUS "Primary completion rate (% of relevant age group)"
		local e2_RUS lastnm_sec_ger
		local le2_RUS "School enrollment, secondary (% gross)"
		local e3_RUS se_lpv_prim
		local le3_RUS "Learning Poverty"
		local h1_RUS lastnm_afr
		local lh1_RUS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_RUS lastnm_ter_ger
		local lh2_RUS "School enrollment, tertiary (% gross)"
		local h3_RUS une_2eap_mf_y
		local lh3_RUS "Youth unemployment (%), ages 15-24"
		local b1_RUS eap_2wap_mf_a_f
		local lb1_RUS "Labour force participation (%), ages 25+, Female"
		local b2_RUS eap_2wap_mf_a_m
		local lb2_RUS "Labour force participation (%), ages 25+, Male"
		local b3_RUS sp_dyn_le00_in
		local lb3_RUS "Life expectancy at birth (years)"
		local l1_RWA unicef_neomort
		local ll1_RWA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_RWA unicef_mealfreq
		local ll2_RWA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_RWA uisger02
		local ll3_RWA "School enrollment, preprimary (% gross)"
		local e1_RWA uiscr1
		local le1_RWA "Primary completion rate (% of relevant age group)"
		local e2_RWA lastnm_sec_ger
		local le2_RWA "School enrollment, secondary (% gross)"
		local e3_RWA uiscr2
		local le3_RWA "Lower secondary completion rate (% of relevant age group)"
		local h1_RWA eip_neet_mf_y
		local lh1_RWA "Youth NEET (%), ages 15-24"
		local h2_RWA lastnm_afr
		local lh2_RWA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_RWA lastnm_ter_ger
		local lh3_RWA "School enrollment, tertiary (% gross)"
		local b1_RWA eap_2wap_mf_a_f
		local lb1_RWA "Labour force participation (%), ages 25+, Female"
		local b2_RWA eap_2wap_mf_a_m
		local lb2_RWA "Labour force participation (%), ages 25+, Male"
		local b3_RWA sp_dyn_le00_in
		local lb3_RWA "Life expectancy at birth (years)"
		local l1_SAU unicef_neomort
		local ll1_SAU "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SAU uisger02
		local ll2_SAU "School enrollment, preprimary (% gross)"
		local l3_SAU lastnm_birth_reg
		local ll3_SAU "Completeness of birth registration (%)"
		local e1_SAU uiscr1
		local le1_SAU "Primary completion rate (% of relevant age group)"
		local e2_SAU lastnm_sec_ger
		local le2_SAU "School enrollment, secondary (% gross)"
		local e3_SAU se_lpv_prim
		local le3_SAU "Learning Poverty"
		local h1_SAU lastnm_afr
		local lh1_SAU "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SAU lastnm_ter_ger
		local lh2_SAU "School enrollment, tertiary (% gross)"
		local h3_SAU une_2eap_mf_y
		local lh3_SAU "Youth unemployment (%), ages 15-24"
		local b1_SAU eap_2wap_mf_a_f
		local lb1_SAU "Labour force participation (%), ages 25+, Female"
		local b2_SAU eap_2wap_mf_a_m
		local lb2_SAU "Labour force participation (%), ages 25+, Male"
		local b3_SAU sp_dyn_le00_in
		local lb3_SAU "Life expectancy at birth (years)"
		local l1_SDN unicef_neomort
		local ll1_SDN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SDN uisger02
		local ll2_SDN "School enrollment, preprimary (% gross)"
		local l3_SDN vacBCG
		local ll3_SDN "Vaccine coverage - BCG"
		local e1_SDN uiscr1
		local le1_SDN "Primary completion rate (% of relevant age group)"
		local e2_SDN lastnm_sec_ger
		local le2_SDN "School enrollment, secondary (% gross)"
		local e3_SDN uiscr2
		local le3_SDN "Lower secondary completion rate (% of relevant age group)"
		local h1_SDN lastnm_afr
		local lh1_SDN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SDN lastnm_ter_ger
		local lh2_SDN "School enrollment, tertiary (% gross)"
		local h3_SDN une_2eap_mf_y
		local lh3_SDN "Youth unemployment (%), ages 15-24"
		local b1_SDN eap_2wap_mf_a_f
		local lb1_SDN "Labour force participation (%), ages 25+, Female"
		local b2_SDN eap_2wap_mf_a_m
		local lb2_SDN "Labour force participation (%), ages 25+, Male"
		local b3_SDN sp_dyn_le00_in
		local lb3_SDN "Life expectancy at birth (years)"
		local l1_SEN unicef_neomort
		local ll1_SEN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SEN unicef_mealfreq
		local ll2_SEN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_SEN uisger02
		local ll3_SEN "School enrollment, preprimary (% gross)"
		local e1_SEN uiscr1
		local le1_SEN "Primary completion rate (% of relevant age group)"
		local e2_SEN lastnm_sec_ger
		local le2_SEN "School enrollment, secondary (% gross)"
		local e3_SEN se_lpv_prim
		local le3_SEN "Learning Poverty"
		local h1_SEN eip_neet_mf_y
		local lh1_SEN "Youth NEET (%), ages 15-24"
		local h2_SEN lastnm_afr
		local lh2_SEN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SEN lastnm_ter_ger
		local lh3_SEN "School enrollment, tertiary (% gross)"
		local b1_SEN eap_2wap_mf_a_f
		local lb1_SEN "Labour force participation (%), ages 25+, Female"
		local b2_SEN eap_2wap_mf_a_m
		local lb2_SEN "Labour force participation (%), ages 25+, Male"
		local b3_SEN sp_dyn_le00_in
		local lb3_SEN "Life expectancy at birth (years)"
		local l1_SGP unicef_neomort
		local ll1_SGP "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SGP uisger02
		local ll2_SGP "School enrollment, preprimary (% gross)"
		local l3_SGP lastnm_mmrt
		local ll3_SGP "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_SGP uiscr1
		local le1_SGP "Primary completion rate (% of relevant age group)"
		local e2_SGP lastnm_sec_ger
		local le2_SGP "School enrollment, secondary (% gross)"
		local e3_SGP se_lpv_prim
		local le3_SGP "Learning Poverty"
		local h1_SGP lastnm_afr
		local lh1_SGP "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SGP lastnm_ter_ger
		local lh2_SGP "School enrollment, tertiary (% gross)"
		local h3_SGP une_2eap_mf_y
		local lh3_SGP "Youth unemployment (%), ages 15-24"
		local b1_SGP eap_2wap_mf_a_f
		local lb1_SGP "Labour force participation (%), ages 25+, Female"
		local b2_SGP eap_2wap_mf_a_m
		local lb2_SGP "Labour force participation (%), ages 25+, Male"
		local b3_SGP sp_dyn_le00_in
		local lb3_SGP "Life expectancy at birth (years)"
		local l1_SLB unicef_neomort
		local ll1_SLB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SLB uisger02
		local ll2_SLB "School enrollment, preprimary (% gross)"
		local l3_SLB unicef_care
		local ll3_SLB "Postnatal contact with a health provider within 2 days of delivery"
		local e1_SLB uiscr1
		local le1_SLB "Primary completion rate (% of relevant age group)"
		local e2_SLB uiscr2
		local le2_SLB "Lower secondary completion rate (% of relevant age group)"
		local e3_SLB vacHEPBB
		local le3_SLB "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_SLB lastnm_afr
		local lh1_SLB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SLB une_2eap_mf_y_f
		local lh2_SLB "Youth unemployment (%), ages 15-24, Female"
		local h3_SLB une_2eap_mf_y_m
		local lh3_SLB "Youth unemployment (%), ages 15-24, Male"
		local b1_SLB eap_2wap_mf_a_f
		local lb1_SLB "Labour force participation (%), ages 25+, Female"
		local b2_SLB eap_2wap_mf_a_m
		local lb2_SLB "Labour force participation (%), ages 25+, Male"
		local b3_SLB sp_dyn_le00_in
		local lb3_SLB "Life expectancy at birth (years)"
		local l1_SLE unicef_neomort
		local ll1_SLE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SLE unicef_mealfreq
		local ll2_SLE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_SLE uisger02
		local ll3_SLE "School enrollment, preprimary (% gross)"
		local e1_SLE uiscr1
		local le1_SLE "Primary completion rate (% of relevant age group)"
		local e2_SLE lastnm_sec_ger
		local le2_SLE "School enrollment, secondary (% gross)"
		local e3_SLE uiscr2
		local le3_SLE "Lower secondary completion rate (% of relevant age group)"
		local h1_SLE eip_neet_mf_y
		local lh1_SLE "Youth NEET (%), ages 15-24"
		local h2_SLE lastnm_afr
		local lh2_SLE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SLE une_2eap_mf_y
		local lh3_SLE "Youth unemployment (%), ages 15-24"
		local b1_SLE eap_2wap_mf_a_f
		local lb1_SLE "Labour force participation (%), ages 25+, Female"
		local b2_SLE eap_2wap_mf_a_m
		local lb2_SLE "Labour force participation (%), ages 25+, Male"
		local b3_SLE sp_dyn_le00_in
		local lb3_SLE "Life expectancy at birth (years)"
		local l1_SLV unicef_neomort
		local ll1_SLV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SLV lastnm_birth_reg
		local ll2_SLV "Completeness of birth registration (%)"
		local l3_SLV vacBCG
		local ll3_SLV "Vaccine coverage - BCG"
		local e1_SLV uiscr2
		local le1_SLV "Lower secondary completion rate (% of relevant age group)"
		local e2_SLV vacHEPBB
		local le2_SLV "Vaccine coverage - Hepatitis B (HEPBB)"
		local e3_SLV uiscr1
		local le3_SLV ""
		local h1_SLV eip_neet_mf_y
		local lh1_SLV "Youth NEET (%), ages 15-24"
		local h2_SLV lastnm_afr
		local lh2_SLV "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SLV lastnm_ter_ger
		local lh3_SLV "School enrollment, tertiary (% gross)"
		local b1_SLV eap_2wap_mf_a_f
		local lb1_SLV "Labour force participation (%), ages 25+, Female"
		local b2_SLV eap_2wap_mf_a_m
		local lb2_SLV "Labour force participation (%), ages 25+, Male"
		local b3_SLV sp_dyn_le00_in
		local lb3_SLV "Life expectancy at birth (years)"
		local l1_SRB unicef_neomort
		local ll1_SRB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SRB unicef_mealfreq
		local ll2_SRB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_SRB uisger02
		local ll3_SRB "School enrollment, preprimary (% gross)"
		local e1_SRB uiscr1
		local le1_SRB "Primary completion rate (% of relevant age group)"
		local e2_SRB lastnm_sec_ger
		local le2_SRB "School enrollment, secondary (% gross)"
		local e3_SRB se_lpv_prim
		local le3_SRB "Learning Poverty"
		local h1_SRB eip_neet_mf_y
		local lh1_SRB "Youth NEET (%), ages 15-24"
		local h2_SRB lastnm_afr
		local lh2_SRB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SRB lastnm_ter_ger
		local lh3_SRB "School enrollment, tertiary (% gross)"
		local b1_SRB eap_2wap_mf_a_f
		local lb1_SRB "Labour force participation (%), ages 25+, Female"
		local b2_SRB eap_2wap_mf_a_m
		local lb2_SRB "Labour force participation (%), ages 25+, Male"
		local b3_SRB sp_dyn_le00_in
		local lb3_SRB "Life expectancy at birth (years)"
		local l1_SSD unicef_neomort
		local ll1_SSD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SSD uisger02
		local ll2_SSD "School enrollment, preprimary (% gross)"
		local l3_SSD vacBCG
		local ll3_SSD "Vaccine coverage - BCG"
		local e1_SSD uiscr1
		local le1_SSD "Primary completion rate (% of relevant age group)"
		local e2_SSD lastnm_sec_ger
		local le2_SSD "School enrollment, secondary (% gross)"
		local e3_SSD uiscr2
		local le3_SSD "Lower secondary completion rate (% of relevant age group)"
		local h1_SSD lastnm_afr
		local lh1_SSD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SSD lastnm_ter_ger
		local lh2_SSD "School enrollment, tertiary (% gross)"
		local h3_SSD une_2eap_mf_y
		local lh3_SSD "Youth unemployment (%), ages 15-24"
		local b1_SSD eap_2wap_mf_a_f
		local lb1_SSD "Labour force participation (%), ages 25+, Female"
		local b2_SSD eap_2wap_mf_a_m
		local lb2_SSD "Labour force participation (%), ages 25+, Male"
		local b3_SSD sp_dyn_le00_in
		local lb3_SSD "Life expectancy at birth (years)"
		local l1_SVK unicef_neomort
		local ll1_SVK "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SVK uisger02
		local ll2_SVK "School enrollment, preprimary (% gross)"
		local l3_SVK lastnm_mmrt
		local ll3_SVK "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_SVK uiscr1
		local le1_SVK "Primary completion rate (% of relevant age group)"
		local e2_SVK lastnm_sec_ger
		local le2_SVK "School enrollment, secondary (% gross)"
		local e3_SVK se_lpv_prim
		local le3_SVK "Learning Poverty"
		local h1_SVK lastnm_afr
		local lh1_SVK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SVK lastnm_ter_ger
		local lh2_SVK "School enrollment, tertiary (% gross)"
		local h3_SVK une_2eap_mf_y
		local lh3_SVK "Youth unemployment (%), ages 15-24"
		local b1_SVK eap_2wap_mf_a_f
		local lb1_SVK "Labour force participation (%), ages 25+, Female"
		local b2_SVK eap_2wap_mf_a_m
		local lb2_SVK "Labour force participation (%), ages 25+, Male"
		local b3_SVK sp_dyn_le00_in
		local lb3_SVK "Life expectancy at birth (years)"
		local l1_SVN unicef_neomort
		local ll1_SVN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SVN uisger02
		local ll2_SVN "School enrollment, preprimary (% gross)"
		local l3_SVN lastnm_mmrt
		local ll3_SVN "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_SVN uiscr1
		local le1_SVN "Primary completion rate (% of relevant age group)"
		local e2_SVN lastnm_sec_ger
		local le2_SVN "School enrollment, secondary (% gross)"
		local e3_SVN se_lpv_prim
		local le3_SVN "Learning Poverty"
		local h1_SVN lastnm_afr
		local lh1_SVN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SVN lastnm_ter_ger
		local lh2_SVN "School enrollment, tertiary (% gross)"
		local h3_SVN une_2eap_mf_y
		local lh3_SVN "Youth unemployment (%), ages 15-24"
		local b1_SVN eap_2wap_mf_a_f
		local lb1_SVN "Labour force participation (%), ages 25+, Female"
		local b2_SVN eap_2wap_mf_a_m
		local lb2_SVN "Labour force participation (%), ages 25+, Male"
		local b3_SVN sp_dyn_le00_in
		local lb3_SVN "Life expectancy at birth (years)"
		local l1_SWE unicef_neomort
		local ll1_SWE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SWE uisger02
		local ll2_SWE "School enrollment, preprimary (% gross)"
		local l3_SWE lastnm_mmrt
		local ll3_SWE "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_SWE uiscr1
		local le1_SWE "Primary completion rate (% of relevant age group)"
		local e2_SWE lastnm_sec_ger
		local le2_SWE "School enrollment, secondary (% gross)"
		local e3_SWE se_lpv_prim
		local le3_SWE "Learning Poverty"
		local h1_SWE lastnm_afr
		local lh1_SWE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_SWE lastnm_ter_ger
		local lh2_SWE "School enrollment, tertiary (% gross)"
		local h3_SWE une_2eap_mf_y
		local lh3_SWE "Youth unemployment (%), ages 15-24"
		local b1_SWE eap_2wap_mf_a_f
		local lb1_SWE "Labour force participation (%), ages 25+, Female"
		local b2_SWE eap_2wap_mf_a_m
		local lb2_SWE "Labour force participation (%), ages 25+, Male"
		local b3_SWE sp_dyn_le00_in
		local lb3_SWE "Life expectancy at birth (years)"
		local l1_SWZ unicef_neomort
		local ll1_SWZ "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SWZ vacBCG
		local ll2_SWZ "Vaccine coverage - BCG"
		local l3_SWZ uisger02
		local ll3_SWZ ""
		local e1_SWZ uiscr1
		local le1_SWZ "Primary completion rate (% of relevant age group)"
		local e2_SWZ lastnm_sec_ger
		local le2_SWZ "School enrollment, secondary (% gross)"
		local e3_SWZ uiscr2
		local le3_SWZ "Lower secondary completion rate (% of relevant age group)"
		local h1_SWZ eip_neet_mf_y
		local lh1_SWZ "Youth NEET (%), ages 15-24"
		local h2_SWZ lastnm_afr
		local lh2_SWZ "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SWZ une_2eap_mf_y
		local lh3_SWZ "Youth unemployment (%), ages 15-24"
		local b1_SWZ eap_2wap_mf_a_f
		local lb1_SWZ "Labour force participation (%), ages 25+, Female"
		local b2_SWZ eap_2wap_mf_a_m
		local lb2_SWZ "Labour force participation (%), ages 25+, Male"
		local b3_SWZ sp_dyn_le00_in
		local lb3_SWZ "Life expectancy at birth (years)"
		local l1_SYC unicef_neomort
		local ll1_SYC "Mortality rate, neonatal (per 1,000 live births)"
		local l2_SYC uisger02
		local ll2_SYC "School enrollment, preprimary (% gross)"
		local l3_SYC vacBCG
		local ll3_SYC "Vaccine coverage - BCG"
		local e1_SYC uiscr1
		local le1_SYC "Primary completion rate (% of relevant age group)"
		local e2_SYC lastnm_sec_ger
		local le2_SYC "School enrollment, secondary (% gross)"
		local e3_SYC uiscr2
		local le3_SYC "Lower secondary completion rate (% of relevant age group)"
		local h1_SYC eip_neet_mf_y
		local lh1_SYC "Youth NEET (%), ages 15-24"
		local h2_SYC lastnm_afr
		local lh2_SYC "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_SYC lastnm_ter_ger
		local lh3_SYC "School enrollment, tertiary (% gross)"
		local b1_SYC lastnm_probdeath_ncd
		local lb1_SYC "Cause of death, by non-communicable diseases (% of total)"
		local b2_SYC sp_dyn_le00_in_f
		local lb2_SYC "Life expectancy at birth (years), Female"
		local b3_SYC sp_dyn_le00_in_m
		local lb3_SYC "Life expectancy at birth (years), Male"
		local l1_TCD unicef_neomort
		local ll1_TCD "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TCD unicef_mealfreq
		local ll2_TCD "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TCD uisger02
		local ll3_TCD "School enrollment, preprimary (% gross)"
		local e1_TCD uiscr1
		local le1_TCD "Primary completion rate (% of relevant age group)"
		local e2_TCD lastnm_sec_ger
		local le2_TCD "School enrollment, secondary (% gross)"
		local e3_TCD se_lpv_prim
		local le3_TCD "Learning Poverty"
		local h1_TCD eip_neet_mf_y
		local lh1_TCD "Youth NEET (%), ages 15-24"
		local h2_TCD lastnm_afr
		local lh2_TCD "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TCD lastnm_ter_ger
		local lh3_TCD "School enrollment, tertiary (% gross)"
		local b1_TCD eap_2wap_mf_a_f
		local lb1_TCD "Labour force participation (%), ages 25+, Female"
		local b2_TCD eap_2wap_mf_a_m
		local lb2_TCD "Labour force participation (%), ages 25+, Male"
		local b3_TCD sp_dyn_le00_in
		local lb3_TCD "Life expectancy at birth (years)"
		local l1_TGO unicef_neomort
		local ll1_TGO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TGO unicef_mealfreq
		local ll2_TGO "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TGO uisger02
		local ll3_TGO "School enrollment, preprimary (% gross)"
		local e1_TGO uiscr1
		local le1_TGO "Primary completion rate (% of relevant age group)"
		local e2_TGO lastnm_sec_ger
		local le2_TGO "School enrollment, secondary (% gross)"
		local e3_TGO se_lpv_prim
		local le3_TGO "Learning Poverty"
		local h1_TGO eip_neet_mf_y
		local lh1_TGO "Youth NEET (%), ages 15-24"
		local h2_TGO lastnm_afr
		local lh2_TGO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TGO lastnm_ter_ger
		local lh3_TGO "School enrollment, tertiary (% gross)"
		local b1_TGO eap_2wap_mf_a_f
		local lb1_TGO "Labour force participation (%), ages 25+, Female"
		local b2_TGO eap_2wap_mf_a_m
		local lb2_TGO "Labour force participation (%), ages 25+, Male"
		local b3_TGO sp_dyn_le00_in
		local lb3_TGO "Life expectancy at birth (years)"
		local l1_THA unicef_neomort
		local ll1_THA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_THA unicef_mealfreq
		local ll2_THA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_THA uisger02
		local ll3_THA "School enrollment, preprimary (% gross)"
		local e1_THA uiscr1
		local le1_THA "Primary completion rate (% of relevant age group)"
		local e2_THA lastnm_sec_ger
		local le2_THA "School enrollment, secondary (% gross)"
		local e3_THA uiscr2
		local le3_THA "Lower secondary completion rate (% of relevant age group)"
		local h1_THA eip_neet_mf_y
		local lh1_THA "Youth NEET (%), ages 15-24"
		local h2_THA lastnm_afr
		local lh2_THA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_THA lastnm_ter_ger
		local lh3_THA "School enrollment, tertiary (% gross)"
		local b1_THA eap_2wap_mf_a_f
		local lb1_THA "Labour force participation (%), ages 25+, Female"
		local b2_THA eap_2wap_mf_a_m
		local lb2_THA "Labour force participation (%), ages 25+, Male"
		local b3_THA sp_dyn_le00_in
		local lb3_THA "Life expectancy at birth (years)"
		local l1_TJK unicef_neomort
		local ll1_TJK "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TJK unicef_mealfreq
		local ll2_TJK "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TJK uisger02
		local ll3_TJK "School enrollment, preprimary (% gross)"
		local e1_TJK uiscr1
		local le1_TJK "Primary completion rate (% of relevant age group)"
		local e2_TJK uiscr2
		local le2_TJK "Lower secondary completion rate (% of relevant age group)"
		local e3_TJK vacHEPBB
		local le3_TJK "Vaccine coverage - Hepatitis B (HEPBB)"
		local h1_TJK lastnm_afr
		local lh1_TJK "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TJK lastnm_ter_ger
		local lh2_TJK "School enrollment, tertiary (% gross)"
		local h3_TJK une_2eap_mf_y
		local lh3_TJK "Youth unemployment (%), ages 15-24"
		local b1_TJK eap_2wap_mf_a_f
		local lb1_TJK "Labour force participation (%), ages 25+, Female"
		local b2_TJK eap_2wap_mf_a_m
		local lb2_TJK "Labour force participation (%), ages 25+, Male"
		local b3_TJK sp_dyn_le00_in
		local lb3_TJK "Life expectancy at birth (years)"
		local l1_TLS unicef_neomort
		local ll1_TLS "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TLS unicef_mealfreq
		local ll2_TLS "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TLS uisger02
		local ll3_TLS "School enrollment, preprimary (% gross)"
		local e1_TLS uiscr1
		local le1_TLS "Primary completion rate (% of relevant age group)"
		local e2_TLS lastnm_sec_ger
		local le2_TLS "School enrollment, secondary (% gross)"
		local e3_TLS uiscr2
		local le3_TLS "Lower secondary completion rate (% of relevant age group)"
		local h1_TLS eip_neet_mf_y
		local lh1_TLS "Youth NEET (%), ages 15-24"
		local h2_TLS lastnm_afr
		local lh2_TLS "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TLS une_2eap_mf_y
		local lh3_TLS "Youth unemployment (%), ages 15-24"
		local b1_TLS eap_2wap_mf_a_f
		local lb1_TLS "Labour force participation (%), ages 25+, Female"
		local b2_TLS eap_2wap_mf_a_m
		local lb2_TLS "Labour force participation (%), ages 25+, Male"
		local b3_TLS sp_dyn_le00_in
		local lb3_TLS "Life expectancy at birth (years)"
		local l1_TON unicef_neomort
		local ll1_TON "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TON unicef_mealfreq
		local ll2_TON "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TON uisger02
		local ll3_TON "School enrollment, preprimary (% gross)"
		local e1_TON uiscr1
		local le1_TON "Primary completion rate (% of relevant age group)"
		local e2_TON lastnm_sec_ger
		local le2_TON "School enrollment, secondary (% gross)"
		local e3_TON uiscr2
		local le3_TON "Lower secondary completion rate (% of relevant age group)"
		local h1_TON eip_neet_mf_y
		local lh1_TON "Youth NEET (%), ages 15-24"
		local h2_TON lastnm_afr
		local lh2_TON "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TON lastnm_ter_ger
		local lh3_TON "School enrollment, tertiary (% gross)"
		local b1_TON eap_2wap_mf_a_f
		local lb1_TON "Labour force participation (%), ages 25+, Female"
		local b2_TON eap_2wap_mf_a_m
		local lb2_TON "Labour force participation (%), ages 25+, Male"
		local b3_TON sp_dyn_le00_in
		local lb3_TON "Life expectancy at birth (years)"
		local l1_TTO unicef_neomort
		local ll1_TTO "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TTO uisger02_f
		local ll2_TTO "School enrollment, preprimary (% gross), Female"
		local l3_TTO uisger02_m
		local ll3_TTO "School enrollment, preprimary (% gross), Male"
		local e1_TTO se_lpv_prim_f
		local le1_TTO "Learning Poverty, Female"
		local e2_TTO se_lpv_prim_m
		local le2_TTO "Learning Poverty, Male"
		local e3_TTO uiscr1
		local le3_TTO ""
		local h1_TTO lastnm_afr
		local lh1_TTO "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TTO une_2eap_mf_y_f
		local lh2_TTO "Youth unemployment (%), ages 15-24, Female"
		local h3_TTO une_2eap_mf_y_m
		local lh3_TTO "Youth unemployment (%), ages 15-24, Male"
		local b1_TTO eap_2wap_mf_a_f
		local lb1_TTO "Labour force participation (%), ages 25+, Female"
		local b2_TTO eap_2wap_mf_a_m
		local lb2_TTO "Labour force participation (%), ages 25+, Male"
		local b3_TTO sp_dyn_le00_in
		local lb3_TTO "Life expectancy at birth (years)"
		local l1_TUN unicef_neomort
		local ll1_TUN "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUN unicef_mealfreq
		local ll2_TUN "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TUN uisger02
		local ll3_TUN "School enrollment, preprimary (% gross)"
		local e1_TUN uiscr1
		local le1_TUN "Primary completion rate (% of relevant age group)"
		local e2_TUN lastnm_sec_ger
		local le2_TUN "School enrollment, secondary (% gross)"
		local e3_TUN uiscr2
		local le3_TUN "Lower secondary completion rate (% of relevant age group)"
		local h1_TUN lastnm_afr
		local lh1_TUN "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TUN lastnm_ter_ger
		local lh2_TUN "School enrollment, tertiary (% gross)"
		local h3_TUN une_2eap_mf_y
		local lh3_TUN "Youth unemployment (%), ages 15-24"
		local b1_TUN eap_2wap_mf_a_f
		local lb1_TUN "Labour force participation (%), ages 25+, Female"
		local b2_TUN eap_2wap_mf_a_m
		local lb2_TUN "Labour force participation (%), ages 25+, Male"
		local b3_TUN sp_dyn_le00_in
		local lb3_TUN "Life expectancy at birth (years)"
		local l1_TUR unicef_neomort
		local ll1_TUR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUR uisger02
		local ll2_TUR "School enrollment, preprimary (% gross)"
		local l3_TUR lastnm_mmrt
		local ll3_TUR "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_TUR uiscr1
		local le1_TUR "Primary completion rate (% of relevant age group)"
		local e2_TUR lastnm_sec_ger
		local le2_TUR "School enrollment, secondary (% gross)"
		local e3_TUR se_lpv_prim
		local le3_TUR "Learning Poverty"
		local h1_TUR eip_neet_mf_y
		local lh1_TUR "Youth NEET (%), ages 15-24"
		local h2_TUR lastnm_afr
		local lh2_TUR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_TUR lastnm_ter_ger
		local lh3_TUR "School enrollment, tertiary (% gross)"
		local b1_TUR eap_2wap_mf_a_f
		local lb1_TUR "Labour force participation (%), ages 25+, Female"
		local b2_TUR eap_2wap_mf_a_m
		local lb2_TUR "Labour force participation (%), ages 25+, Male"
		local b3_TUR sp_dyn_le00_in
		local lb3_TUR "Life expectancy at birth (years)"
		local l1_TUV unicef_neomort
		local ll1_TUV "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TUV uisger02
		local ll2_TUV "School enrollment, preprimary (% gross)"
		local l3_TUV unicef_care
		local ll3_TUV "Postnatal contact with a health provider within 2 days of delivery"
		local e1_TUV uiscr1
		local le1_TUV "Primary completion rate (% of relevant age group)"
		local e2_TUV lastnm_sec_ger
		local le2_TUV "School enrollment, secondary (% gross)"
		local e3_TUV uiscr2
		local le3_TUV "Lower secondary completion rate (% of relevant age group)"
		local h1_TUV eip_neet_mf_y_f
		local lh1_TUV "Youth NEET (%), ages 15-24, Female"
		local h2_TUV eip_neet_mf_y_m
		local lh2_TUV "Youth NEET (%), ages 15-24, Male"
		local h3_TUV lastnm_afr
		local lh3_TUV ""
		local b1_TUV sp_dyn_le00_in_f
		local lb1_TUV "Life expectancy at birth (years), Female"
		local b2_TUV sp_dyn_le00_in_m
		local lb2_TUV "Life expectancy at birth (years), Male"
		local b3_TUV eap_2wap_mf_a_f
		local lb3_TUV ""
		local l1_TZA unicef_neomort
		local ll1_TZA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_TZA unicef_mealfreq
		local ll2_TZA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_TZA uisger02
		local ll3_TZA "School enrollment, preprimary (% gross)"
		local e1_TZA uiscr1
		local le1_TZA "Primary completion rate (% of relevant age group)"
		local e2_TZA lastnm_sec_ger
		local le2_TZA "School enrollment, secondary (% gross)"
		local e3_TZA uiscr2
		local le3_TZA "Lower secondary completion rate (% of relevant age group)"
		local h1_TZA lastnm_afr
		local lh1_TZA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_TZA lastnm_ter_ger
		local lh2_TZA "School enrollment, tertiary (% gross)"
		local h3_TZA une_2eap_mf_y
		local lh3_TZA "Youth unemployment (%), ages 15-24"
		local b1_TZA eap_2wap_mf_a_f
		local lb1_TZA "Labour force participation (%), ages 25+, Female"
		local b2_TZA eap_2wap_mf_a_m
		local lb2_TZA "Labour force participation (%), ages 25+, Male"
		local b3_TZA sp_dyn_le00_in
		local lb3_TZA "Life expectancy at birth (years)"
		local l1_UGA unicef_neomort
		local ll1_UGA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_UGA unicef_mealfreq
		local ll2_UGA "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_UGA uisger02
		local ll3_UGA "School enrollment, preprimary (% gross)"
		local e1_UGA uiscr1
		local le1_UGA "Primary completion rate (% of relevant age group)"
		local e2_UGA lastnm_sec_ger
		local le2_UGA "School enrollment, secondary (% gross)"
		local e3_UGA uiscr2
		local le3_UGA "Lower secondary completion rate (% of relevant age group)"
		local h1_UGA eip_neet_mf_y
		local lh1_UGA "Youth NEET (%), ages 15-24"
		local h2_UGA lastnm_afr
		local lh2_UGA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_UGA lastnm_ter_ger
		local lh3_UGA "School enrollment, tertiary (% gross)"
		local b1_UGA eap_2wap_mf_a_f
		local lb1_UGA "Labour force participation (%), ages 25+, Female"
		local b2_UGA eap_2wap_mf_a_m
		local lb2_UGA "Labour force participation (%), ages 25+, Male"
		local b3_UGA sp_dyn_le00_in
		local lb3_UGA "Life expectancy at birth (years)"
		local l1_UKR unicef_neomort
		local ll1_UKR "Mortality rate, neonatal (per 1,000 live births)"
		local l2_UKR uisger02
		local ll2_UKR "School enrollment, preprimary (% gross)"
		local l3_UKR lastnm_mmrt
		local ll3_UKR "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_UKR vacHEPBB
		local le1_UKR "Vaccine coverage - Hepatitis B (HEPBB)"
		local e2_UKR uiscr1
		local le2_UKR ""
		local e3_UKR se_lpv_prim
		local le3_UKR ""
		local h1_UKR lastnm_afr
		local lh1_UKR "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_UKR une_2eap_mf_y_f
		local lh2_UKR "Youth unemployment (%), ages 15-24, Female"
		local h3_UKR une_2eap_mf_y_m
		local lh3_UKR "Youth unemployment (%), ages 15-24, Male"
		local b1_UKR eap_2wap_mf_a_f
		local lb1_UKR "Labour force participation (%), ages 25+, Female"
		local b2_UKR eap_2wap_mf_a_m
		local lb2_UKR "Labour force participation (%), ages 25+, Male"
		local b3_UKR sp_dyn_le00_in
		local lb3_UKR "Life expectancy at birth (years)"
		local l1_URY unicef_neomort
		local ll1_URY "Mortality rate, neonatal (per 1,000 live births)"
		local l2_URY uisger02
		local ll2_URY "School enrollment, preprimary (% gross)"
		local l3_URY lastnm_mmrt
		local ll3_URY "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_URY uiscr1
		local le1_URY "Primary completion rate (% of relevant age group)"
		local e2_URY lastnm_sec_ger
		local le2_URY "School enrollment, secondary (% gross)"
		local e3_URY se_lpv_prim
		local le3_URY "Learning Poverty"
		local h1_URY eip_neet_mf_y
		local lh1_URY "Youth NEET (%), ages 15-24"
		local h2_URY lastnm_afr
		local lh2_URY "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_URY lastnm_ter_ger
		local lh3_URY "School enrollment, tertiary (% gross)"
		local b1_URY eap_2wap_mf_a_f
		local lb1_URY "Labour force participation (%), ages 25+, Female"
		local b2_URY eap_2wap_mf_a_m
		local lb2_URY "Labour force participation (%), ages 25+, Male"
		local b3_URY sp_dyn_le00_in
		local lb3_URY "Life expectancy at birth (years)"
		local l1_USA unicef_neomort
		local ll1_USA "Mortality rate, neonatal (per 1,000 live births)"
		local l2_USA uisger02
		local ll2_USA "School enrollment, preprimary (% gross)"
		local l3_USA lastnm_mmrt
		local ll3_USA "Maternal mortality ratio (national estimate, per 100,000 live births)"
		local e1_USA uiscr1
		local le1_USA "Primary completion rate (% of relevant age group)"
		local e2_USA lastnm_sec_ger
		local le2_USA "School enrollment, secondary (% gross)"
		local e3_USA se_lpv_prim
		local le3_USA "Learning Poverty"
		local h1_USA eip_neet_mf_y
		local lh1_USA "Youth NEET (%), ages 15-24"
		local h2_USA lastnm_afr
		local lh2_USA "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_USA lastnm_ter_ger
		local lh3_USA "School enrollment, tertiary (% gross)"
		local b1_USA eap_2wap_mf_a_f
		local lb1_USA "Labour force participation (%), ages 25+, Female"
		local b2_USA eap_2wap_mf_a_m
		local lb2_USA "Labour force participation (%), ages 25+, Male"
		local b3_USA sp_dyn_le00_in
		local lb3_USA "Life expectancy at birth (years)"
		local l1_UZB unicef_neomort
		local ll1_UZB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_UZB unicef_mealfreq
		local ll2_UZB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_UZB uisger02
		local ll3_UZB "School enrollment, preprimary (% gross)"
		local e1_UZB uiscr1
		local le1_UZB "Primary completion rate (% of relevant age group)"
		local e2_UZB lastnm_sec_ger
		local le2_UZB "School enrollment, secondary (% gross)"
		local e3_UZB uiscr2
		local le3_UZB "Lower secondary completion rate (% of relevant age group)"
		local h1_UZB lastnm_afr
		local lh1_UZB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_UZB lastnm_ter_ger
		local lh2_UZB "School enrollment, tertiary (% gross)"
		local h3_UZB une_2eap_mf_y
		local lh3_UZB "Youth unemployment (%), ages 15-24"
		local b1_UZB eap_2wap_mf_a_f
		local lb1_UZB "Labour force participation (%), ages 25+, Female"
		local b2_UZB eap_2wap_mf_a_m
		local lb2_UZB "Labour force participation (%), ages 25+, Male"
		local b3_UZB sp_dyn_le00_in
		local lb3_UZB "Life expectancy at birth (years)"
		local l1_VCT unicef_neomort
		local ll1_VCT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_VCT uisger02
		local ll2_VCT "School enrollment, preprimary (% gross)"
		local l3_VCT vacBCG
		local ll3_VCT "Vaccine coverage - BCG"
		local e1_VCT uiscr1
		local le1_VCT "Primary completion rate (% of relevant age group)"
		local e2_VCT lastnm_sec_ger
		local le2_VCT "School enrollment, secondary (% gross)"
		local e3_VCT uiscr2
		local le3_VCT "Lower secondary completion rate (% of relevant age group)"
		local h1_VCT lastnm_afr
		local lh1_VCT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_VCT lastnm_ter_ger
		local lh2_VCT "School enrollment, tertiary (% gross)"
		local h3_VCT une_2eap_mf_y
		local lh3_VCT "Youth unemployment (%), ages 15-24"
		local b1_VCT eap_2wap_mf_a_f
		local lb1_VCT "Labour force participation (%), ages 25+, Female"
		local b2_VCT eap_2wap_mf_a_m
		local lb2_VCT "Labour force participation (%), ages 25+, Male"
		local b3_VCT sp_dyn_le00_in
		local lb3_VCT "Life expectancy at birth (years)"
		local l1_VNM unicef_neomort
		local ll1_VNM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_VNM uisger02
		local ll2_VNM "School enrollment, preprimary (% gross)"
		local l3_VNM unicef_care
		local ll3_VNM "Postnatal contact with a health provider within 2 days of delivery"
		local e1_VNM uiscr1
		local le1_VNM "Primary completion rate (% of relevant age group)"
		local e2_VNM se_lpv_prim
		local le2_VNM "Learning Poverty"
		local e3_VNM uiscr2
		local le3_VNM "Lower secondary completion rate (% of relevant age group)"
		local h1_VNM eip_neet_mf_y
		local lh1_VNM "Youth NEET (%), ages 15-24"
		local h2_VNM lastnm_afr
		local lh2_VNM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_VNM lastnm_ter_ger
		local lh3_VNM "School enrollment, tertiary (% gross)"
		local b1_VNM eap_2wap_mf_a_f
		local lb1_VNM "Labour force participation (%), ages 25+, Female"
		local b2_VNM eap_2wap_mf_a_m
		local lb2_VNM "Labour force participation (%), ages 25+, Male"
		local b3_VNM sp_dyn_le00_in
		local lb3_VNM "Life expectancy at birth (years)"
		local l1_VUT unicef_neomort
		local ll1_VUT "Mortality rate, neonatal (per 1,000 live births)"
		local l2_VUT uisger02
		local ll2_VUT "School enrollment, preprimary (% gross)"
		local l3_VUT vacBCG
		local ll3_VUT "Vaccine coverage - BCG"
		local e1_VUT uiscr1
		local le1_VUT "Primary completion rate (% of relevant age group)"
		local e2_VUT lastnm_sec_ger
		local le2_VUT "School enrollment, secondary (% gross)"
		local e3_VUT uiscr2
		local le3_VUT "Lower secondary completion rate (% of relevant age group)"
		local h1_VUT eip_neet_mf_y
		local lh1_VUT "Youth NEET (%), ages 15-24"
		local h2_VUT lastnm_afr
		local lh2_VUT "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_VUT une_2eap_mf_y
		local lh3_VUT "Youth unemployment (%), ages 15-24"
		local b1_VUT eap_2wap_mf_a_f
		local lb1_VUT "Labour force participation (%), ages 25+, Female"
		local b2_VUT eap_2wap_mf_a_m
		local lb2_VUT "Labour force participation (%), ages 25+, Male"
		local b3_VUT sp_dyn_le00_in
		local lb3_VUT "Life expectancy at birth (years)"
		local l1_WSM unicef_neomort
		local ll1_WSM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_WSM uisger02
		local ll2_WSM "School enrollment, preprimary (% gross)"
		local l3_WSM unicef_care
		local ll3_WSM "Postnatal contact with a health provider within 2 days of delivery"
		local e1_WSM uiscr1
		local le1_WSM "Primary completion rate (% of relevant age group)"
		local e2_WSM lastnm_sec_ger
		local le2_WSM "School enrollment, secondary (% gross)"
		local e3_WSM uiscr2
		local le3_WSM "Lower secondary completion rate (% of relevant age group)"
		local h1_WSM eip_neet_mf_y
		local lh1_WSM "Youth NEET (%), ages 15-24"
		local h2_WSM lastnm_afr
		local lh2_WSM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_WSM lastnm_ter_ger
		local lh3_WSM "School enrollment, tertiary (% gross)"
		local b1_WSM eap_2wap_mf_a_f
		local lb1_WSM "Labour force participation (%), ages 25+, Female"
		local b2_WSM eap_2wap_mf_a_m
		local lb2_WSM "Labour force participation (%), ages 25+, Male"
		local b3_WSM sp_dyn_le00_in
		local lb3_WSM "Life expectancy at birth (years)"
		local l1_XKX unicef_neomort
		local ll1_XKX ""
		local l2_XKX unicef_mealfreq
		local ll2_XKX ""
		local l3_XKX uisger02
		local ll3_XKX ""
		local e1_XKX uiscr1
		local le1_XKX ""
		local e2_XKX lastnm_sec_ger
		local le2_XKX ""
		local e3_XKX se_lpv_prim
		local le3_XKX ""
		local h1_XKX eip_neet_mf_y
		local lh1_XKX ""
		local h2_XKX lastnm_afr
		local lh2_XKX ""
		local h3_XKX lastnm_ter_ger
		local lh3_XKX ""
		local b1_XKX sp_dyn_le00_in_f
		local lb1_XKX "Life expectancy at birth (years), Female"
		local b2_XKX sp_dyn_le00_in_m
		local lb2_XKX "Life expectancy at birth (years), Male"
		local b3_XKX eap_2wap_mf_a_f
		local lb3_XKX ""
		local l1_YEM unicef_neomort
		local ll1_YEM "Mortality rate, neonatal (per 1,000 live births)"
		local l2_YEM uisger02
		local ll2_YEM "School enrollment, preprimary (% gross)"
		local l3_YEM vacBCG
		local ll3_YEM "Vaccine coverage - BCG"
		local e1_YEM uiscr1
		local le1_YEM "Primary completion rate (% of relevant age group)"
		local e2_YEM lastnm_sec_ger
		local le2_YEM "School enrollment, secondary (% gross)"
		local e3_YEM uiscr2
		local le3_YEM "Lower secondary completion rate (% of relevant age group)"
		local h1_YEM lastnm_afr
		local lh1_YEM "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h2_YEM une_2eap_mf_y_f
		local lh2_YEM "Youth unemployment (%), ages 15-24, Female"
		local h3_YEM une_2eap_mf_y_m
		local lh3_YEM "Youth unemployment (%), ages 15-24, Male"
		local b1_YEM eap_2wap_mf_a_f
		local lb1_YEM "Labour force participation (%), ages 25+, Female"
		local b2_YEM eap_2wap_mf_a_m
		local lb2_YEM "Labour force participation (%), ages 25+, Male"
		local b3_YEM sp_dyn_le00_in
		local lb3_YEM "Life expectancy at birth (years)"
		local l1_ZAF unicef_neomort
		local ll1_ZAF "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ZAF unicef_mealfreq
		local ll2_ZAF "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ZAF uisger02
		local ll3_ZAF "School enrollment, preprimary (% gross)"
		local e1_ZAF uiscr1
		local le1_ZAF "Primary completion rate (% of relevant age group)"
		local e2_ZAF lastnm_sec_ger
		local le2_ZAF "School enrollment, secondary (% gross)"
		local e3_ZAF se_lpv_prim
		local le3_ZAF "Learning Poverty"
		local h1_ZAF eip_neet_mf_y
		local lh1_ZAF "Youth NEET (%), ages 15-24"
		local h2_ZAF lastnm_afr
		local lh2_ZAF "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ZAF lastnm_ter_ger
		local lh3_ZAF "School enrollment, tertiary (% gross)"
		local b1_ZAF eap_2wap_mf_a_f
		local lb1_ZAF "Labour force participation (%), ages 25+, Female"
		local b2_ZAF eap_2wap_mf_a_m
		local lb2_ZAF "Labour force participation (%), ages 25+, Male"
		local b3_ZAF sp_dyn_le00_in
		local lb3_ZAF "Life expectancy at birth (years)"
		local l1_ZMB unicef_neomort
		local ll1_ZMB "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ZMB unicef_mealfreq
		local ll2_ZMB "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ZMB uisger02
		local ll3_ZMB "School enrollment, preprimary (% gross)"
		local e1_ZMB uiscr1
		local le1_ZMB ""
		local e2_ZMB lastnm_sec_ger
		local le2_ZMB ""
		local e3_ZMB se_lpv_prim
		local le3_ZMB ""
		local h1_ZMB eip_neet_mf_y
		local lh1_ZMB "Youth NEET (%), ages 15-24"
		local h2_ZMB lastnm_afr
		local lh2_ZMB "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ZMB une_2eap_mf_y
		local lh3_ZMB "Youth unemployment (%), ages 15-24"
		local b1_ZMB eap_2wap_mf_a_f
		local lb1_ZMB "Labour force participation (%), ages 25+, Female"
		local b2_ZMB eap_2wap_mf_a_m
		local lb2_ZMB "Labour force participation (%), ages 25+, Male"
		local b3_ZMB sp_dyn_le00_in
		local lb3_ZMB "Life expectancy at birth (years)"
		local l1_ZWE unicef_neomort
		local ll1_ZWE "Mortality rate, neonatal (per 1,000 live births)"
		local l2_ZWE unicef_mealfreq
		local ll2_ZWE "Minimum meal frequency (children aged 6 to 23 months) (%)"
		local l3_ZWE uisger02
		local ll3_ZWE "School enrollment, preprimary (% gross)"
		local e1_ZWE uiscr2
		local le1_ZWE "Lower secondary completion rate (% of relevant age group)"
		local e2_ZWE uiscr1_f
		local le2_ZWE "Primary completion rate (% of relevant age group), Female"
		local e3_ZWE uiscr1_m
		local le3_ZWE "Primary completion rate (% of relevant age group), Male"
		local h1_ZWE eip_neet_mf_y
		local lh1_ZWE "Youth NEET (%), ages 15-24"
		local h2_ZWE lastnm_afr
		local lh2_ZWE "Adolescent fertility rate (births per 1,000 women ages 15-19)"
		local h3_ZWE lastnm_ter_ger
		local lh3_ZWE "School enrollment, tertiary (% gross)"
		local b1_ZWE eap_2wap_mf_a_f
		local lb1_ZWE "Labour force participation (%), ages 25+, Female"
		local b2_ZWE eap_2wap_mf_a_m
		local lb2_ZWE "Labour force participation (%), ages 25+, Male"
		local b3_ZWE sp_dyn_le00_in
		local lb3_ZWE "Life expectancy at birth (years)"

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
	
		foreach i of local obs {
		*if (wbcode[`i'] != "AFG") continue 
		
		local ctry=wbcode in `i'
		local region=wbregion in `i'
		local income=wbincomegroup in `i'
		local income2=incomegroup in `i'
		local country=wbcountryname in `i'	
		
		*------------------------------First page------------------------------*
		
		/* Cuando hay data */
		
		foreach x in c {
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
		(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(13pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(10pt) mlc(black) mfcolor(reddish)) ///
		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(18pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(10pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(10pt)) xsize(4.4) ysize(1) graphregion(margin(small))
		graph save graph_`ctry'_`x'`m', replace
	
		}	
		}
		
		/* Cuando no hay data */
		
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
		graph save graph_`ctry'_`x'`m', replace
		drop obs_``x'`m''_`i'
		}
		else {
		
		}
		}
		}
		
		/* La leyenda */
		
		gen m = 0.1
		gen f_`ctry' = 1
		gen g_`ctry' = 1.1 
		gen h_`ctry' = 1.2
		gen i_`ctry' = 1.3
		gen j_`ctry' = 1.4
		
		twoway /// 
		(scatter f_`ctry' m, msymbol(Oh) mlabcolor(black) mlabsize(11pt) msymbol(Oh) msize(vlarge) mcolor(dimgray*1.5) mlabposition(3) mlabgap(8pt)) ///
		(scatter g_`ctry' m, msymbol(D) mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(D) msize(vlarge) mcolor(sky) mlabposition(3) mlabgap(8pt)) ///
		(scatter h_`ctry' m, msymbol(s)  mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(S) msize(vlarge) mcolor(orangebrown) mlabposition(3) mlabgap(8pt)) ///
		(scatter i_`ctry' m, msymbol(Oh) mlabcolor(black) mlabsize(11pt) mlc(black) msymbol(solid) msize(vlarge) mcolor(reddish) mlabposition(3) mlabgap(6pt)) ///
		(scatter j_`ctry' m, msymbol(Oh) msize(vtiny) mcolor(white) mlabcolor(black) mlabsize(11pt) mlabgap(12pt)), ///
		graphregion(color(white)) xscale(off) yscale(off) xlabel(0(0)4) legend(off) ylabel(,nogrid) ysize(1.8) text(1.21 1.55 "Notes for all figures in this brief:" "represents `country'." "represents the average for `income2'." "represents the average for `region'." "represent other countries in the World.", size(12pt) linegap(2.25) justification(left)) /*Suggested by Nora*/		
		graph save notes_`ctry', replace	
		
		drop m 

		graph combine graph_`ctry'_c1.gph  graph_`ctry'_c2.gph  graph_`ctry'_c3.gph  graph_`ctry'_c4.gph graph_`ctry'_c5.gph graph_`ctry'_c6.gph graph_`ctry'_c7.gph notes_`ctry'.gph, rows(8) cols(1) xsize(4.4) ysize(8.8) graphregion(margin(vsmall) fcolor(black)) /*Suggested by Nora*/
		graph export "$charts\p1_`ctry'_all.pdf", replace	
		graph export "$charts\p1_`ctry'_all.png", replace
		
		erase graph_`ctry'_c1.gph
		erase graph_`ctry'_c2.gph
		erase graph_`ctry'_c3.gph
		erase graph_`ctry'_c4.gph
		erase graph_`ctry'_c5.gph
		erase graph_`ctry'_c6.gph
		erase graph_`ctry'_c7.gph
		erase notes_`ctry'.gph
		
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

		twoway ///
		(scatter onesvec ``x'`m'_`ctry'' if ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msymbol(Oh) msize(12pt) mcolor(dimgray*1.5)) ///
		(scatter onesvec ``x'`m'_`ctry''_reg if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(D) mlc(black) mfcolor(sky)) /// 
		(scatter onesvec ``x'`m'_`ctry''_inc if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(S) mlc(black) mfcolor(orangebrown)) /// 
		(scatter onesvec ``x'`m'_`ctry'' if wbcode=="`ctry'" & ``x'`m'_`ctry'' > 0 & ``x'`m'_`ctry'' <=`=scalar(r(p100))', msize(25pt) msymbol(solid) mlabel(``x'`m'_`ctry'') mlabcolor(reddish) mlabposition(12) mlabformat(%8.0f) mlabsize(17pt) mlc(black) mfcolor(reddish)) ///
		, legend(off) title("`l`x'`m'_`ctry''", margin(b=5) size(30pt) pos(11)) xtitle("") ytitle("") yscale(range(0.5 1.2) lcolor(white)) ylabel(none) xlabel(,labsize(17pt) format(%8.3g)) xscale(lwidth(0.6pt)) graphregion(color(white)) xscale(range(`=scalar(min``x'`m'_`ctry'')' `=scalar(max``x'`m'_`ctry'')')) xlabel(`=scalar(min``x'`m'_`ctry'')' (`=scalar(inter``x'`m'_`ctry'')') `=scalar(max``x'`m'_`ctry'')',labsize(17pt)) xsize(6) ysize(1) graphregion(margin(medsmall))
		graph save graph_`ctry'_`x'`m', replace		
		}
		}
		
/*		
		graph combine graph_`ctry'_l1.gph graph_`ctry'_l2.gph graph_`ctry'_l3.gph graph_`ctry'_e1.gph graph_`ctry'_e2.gph graph_`ctry'_e3.gph graph_`ctry'_h1.gph graph_`ctry'_h2.gph graph_`ctry'_h3.gph graph_`ctry'_b1.gph graph_`ctry'_b2.gph graph_`ctry'_b3.gph, rows(12) cols(1) xsize(6) ysize(12) graphregion(margin(vsmall) fcolor(black))
		graph export "$charts\p2_`ctry'.pdf", replace
*/		
		graph combine graph_`ctry'_l1.gph graph_`ctry'_l2.gph graph_`ctry'_l3.gph, rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Early Childhood", suffix color(black) size(vlarge) linegap(3) pos(11) span)
		graph save stage_1, replace
		graph combine graph_`ctry'_e1.gph graph_`ctry'_e2.gph graph_`ctry'_e3.gph, rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("School Age", suffix color(black) size(vlarge) linegap(3) pos(11) span) 
		graph save stage_2, replace
		graph combine graph_`ctry'_h1.gph graph_`ctry'_h2.gph graph_`ctry'_h3.gph, rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Youth", suffix color(black) size(vlarge) linegap(3) pos(11) span)
		graph save stage_3, replace
		graph combine graph_`ctry'_b1.gph graph_`ctry'_b2.gph graph_`ctry'_b3.gph, rows(3) cols(1) xsize(6) ysize(3.5) graphregion(margin(zero) color(white)) title("Adults & Elderly", suffix color(black) size(vlarge) linegap(3) pos(11) span)
		graph save stage_4, replace	
		
		graph combine stage_1.gph stage_2.gph stage_3.gph stage_4.gph, rows(4) cols(1) xsize(6) ysize(14) graphregion(margin(vsmall) fcolor(black))
		graph export "$charts\p2_`ctry'_stages.pdf", replace
		graph export "$charts\p2_`ctry'_stages.png", replace
		
		erase graph_`ctry'_l1.gph
		erase graph_`ctry'_l2.gph
		erase graph_`ctry'_l3.gph		
		erase graph_`ctry'_e1.gph
		erase graph_`ctry'_e2.gph
		erase graph_`ctry'_e3.gph		
		erase graph_`ctry'_h1.gph
		erase graph_`ctry'_h2.gph
		erase graph_`ctry'_h3.gph		
		erase graph_`ctry'_b1.gph
		erase graph_`ctry'_b2.gph
		erase graph_`ctry'_b3.gph

		erase stage_1.gph 
		erase stage_2.gph 
		erase stage_3.gph
		erase stage_4.gph
			
	
		}	