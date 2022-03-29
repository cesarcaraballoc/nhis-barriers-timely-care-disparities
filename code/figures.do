/* 				

Trends in Racial and Ethnic Disparities in BArriers to Timely Medical Care, 1999-2018

César Caraballo, Jeph Herrin, Harlan M. Krumholz, et al.
						
Main analysis figures

	1. Any nonfinancial barrier
		1.1 Overall
		1.2 By income
			1.2.1 middle/high income and low income
			1.2.2 low-income only
			1.2.3 middle/high income only
		1.3 By sex/gender
			1.3.1 Women and men
			1.3.2 Females only
			1.3.1 Males only
		1.4 By unmet medical needs due to cost status
			1.4.1 With and without unmet medical needs due to cost
			1.4.2 With unmet medical needs due to cost only
			1.4.1 Without unmet medical needs due to cost only
		1.5 By insurance status
			1.5.1 Uninsured and insured
			1.5.2 Uninsured only
			1.5.3 Insured only
	2. Specific reasons
		2.1 Couldn't get through on the telephone
				2.1.1 Overall
				2.1.2 By income
					2.1.2.1 Low and mid/high income
					2.1.2.2 Low income only
					2.1.2.3 Mid/high income only
				2.1.3 By sex/gender
					2.1.3.1 Women and men
					2.1.3.2 Females only
					2.1.3.3 Males only
		2.2 Couldn't get an appointment soon enough
				2.2.1 Overall
				2.2.2 By income
					2.2.2.1 Low and mid/high income only
					2.2.2.2 Low income only
					2.2.2.3 Mid/high income only
				2.2.3 By sex/gender
					2.2.3.1 Women and men
					2.2.3.2 Females only
					2.2.3.3 Males only
		2.3 Once they get there, they have to wait too long to see the doctor
				2.3.1 Overall
				2.3.2 By income
				2.3.3 By sex/gender
		2.4 The clinic/doctor's office wasn't open when they could get there
				2.4.1 Overall
				2.4.2 By income
				2.4.3 By sex/gender
		2.5 Didn't have transportation
				2.5.1 Overall
				2.5.2 By income
				2.5.3 By sex/gender
		3. Ordered number of barriers 
		4. Mean number of barriers
		5. Number of barriers by race and ethnicity (histogram)
		
Note: 	This do file requires the files created from the .do files preprocess.do 
		and main_analysis.do
*/

**# 1. Any nonfinancial barrier

**# 	1.1 Overall

u ratefile_delay_any.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("") 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delayany, replace ;
graph export figure_delayany.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**# 	1.2 By income level

**#			1.2.1 Low and mid/high income

u ratefile_delay_any_lowinc,clear

append using ratefile_delay_any_midhighinc

#delimit ;
 mylabels 0(5)30, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

	// (rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen))
	// (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry))
	// (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand))
	// (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender))
	
	// (rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%50))
	// (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%50))
	// (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%50))
	// (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%50))
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("") 
	legend(
		label(1 "Asian LI") 
		label(2 "Asian MHI") 
		label(3 "Black LI") 
		label(4 "Black MHI")
		label(5 "Latino LI") 
		label(6 "Latino MHI") 
		label(7 "White LI") 
		label(8 "White MHI") 
		order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_income,replace ; 
graph export figure_delay_any_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.2.2 Low-income only

#delimit ;
 mylabels 0(5)30, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Low-income only") 
	legend(

		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_income_lowincome_only,replace ; 
graph export figure_delay_any_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.2.3 Mid/high income only

#delimit ;
 mylabels 0(5)30, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Mid/High-income only") 
	legend(

		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_income_midhighincome_only,replace ; 
graph export figure_delay_any_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**# 	1.3 By sex/gender

**# 		1.3.1 Women and men

u ratefile_delay_any_female,clear

append using ratefile_delay_any_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_sex,replace ; 
graph export figure_delay_any_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.3.2 Females only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Females only") 
	legend(

		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_sex_women_only,replace ; 
graph export figure_delay_any_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.3.2 Males only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_sex_men_only,replace ; 
graph export figure_delay_any_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**#		1.4 By unmet medical needs due to cost status

**#			1.4.1 With and without unmet medical needs due to cost

u ratefile_delay_any_unmet_needs,clear

append using ratefile_delay_any_no_unmet_needs

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if unmet_needs_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if unmet_needs_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if unmet_needs_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if unmet_needs_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if unmet_needs_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if unmet_needs_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if unmet_needs_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if unmet_needs_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("") 
	legend(
		label(1 "Asian w/ unmet medical needs due to cost") 
		label(2 "Asian w/o unmet medical needs due to cost") 
		label(3 "Black w/ unmet medical needs due to cost") 
		label(4 "Black w/o unmet medical needs due to cost")
		label(5 "Latino w/ unmet medical needs due to cost") 
		label(6 "Latino w/o unmet medical needs due to cost") 
		label(7 "White w/ unmet medical needs due to cost") 
		label(8 "White w/o unmet medical needs due to cost") 
		order(1 "Asian w/ unmet medical needs due to cost" 2 "Asian w/o unmet medical needs due to cost" 3 "Black w/ unmet medical needs due to cost" 4 "Black w/o unmet medical needs due to cost" 5 "Latino w/ unmet medical needs due to cost" 6 "Latino w/o unmet medical needs due to cost" 7 "White w/ unmet medical needs due to cost" 8 "White w/o unmet medical needs due to cost")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_unmet_needs,replace ; 
graph export figure_delay_any_by_unmet_needs.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.4.2 With unmet medical needs due to cost only

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if unmet_needs_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if unmet_needs_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if unmet_needs_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if unmet_needs_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if unmet_needs_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if unmet_needs_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if unmet_needs_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if unmet_needs_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("With affordability barriers") 
	legend(

		order(1 "Asian" 2 "Black" 3 "Latino" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_unmet_needs_unmet_needs_only,replace ; 
graph export figure_delay_any_by_unmet_needs_unmet_needs_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.4.1 Without unmet medical needs due to cost only

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if unmet_needs_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if unmet_needs_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if unmet_needs_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if unmet_needs_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if unmet_needs_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if unmet_needs_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if unmet_needs_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if unmet_needs_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Without affordability barriers") 
	legend(
		order(1 "Asian" 2 "Black" 3 "Latino" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_unmet_needs_no_unmet_needs_only,replace ; 
graph export figure_delay_any_by_unmet_needs_no_unmet_needs_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**# 1.5 By insurance status

**# 1.5.1 Uninsured and insured 

u ratefile_delay_any_uninsured,clear

append using ratefile_delay_any_insured

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if uninsured_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if uninsured_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if uninsured_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if uninsured_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if uninsured_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if uninsured_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if uninsured_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if uninsured_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("") 
	legend(
		label(1 "Asian uninsured") 
		label(2 "Asian insured") 
		label(3 "Black uninsured") 
		label(4 "Black insured")
		label(5 "Latino uninsured") 
		label(6 "Latino insured") 
		label(7 "White uninsured") 
		label(8 "White insured") 
		order(1 "Asian uninsured" 2 "Asian insured" 3 "Black uninsured" 4 "Black insured" 5 "Latino uninsured" 6 "Latino insured" 7 "White uninsured" 8 "White insured")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_insurance,replace ; 
graph export figure_delay_any_by_insurance.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.5.2 Uninsured only

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if uninsured_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if uninsured_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if uninsured_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if uninsured_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if uninsured_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if uninsured_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if uninsured_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if uninsured_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Uninsured only") 
	legend(

		order(1 "Asian" 2 "Black" 3 "Latino" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_uninsured_only,replace ; 
graph export figure_delay_any_by_uninsured_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#			1.5.3 Insured only

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if uninsured_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if uninsured_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if uninsured_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if uninsured_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if uninsured_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if uninsured_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if uninsured_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if uninsured_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Delayed care due to any barrier not directly related to cost", size(small))
	subtitle("Insured only") 
	legend(
		order(1 "Asian" 2 "Black" 3 "Latino" 4 "White " )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delay_any_by_insured_only,replace ; 
graph export figure_delay_any_by_insured_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**#	2. Specific reasons

**#		2.1 Couldn't get through on the telephone

**#				2.1.1 Overall

u ratefile_delayphone.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("", size(medium) position(10)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delayphone, replace ;
graph export figure_delayphone.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.1.2 By income

**#					2.1.2.1 Low and mid/high income


u ratefile_delayphone_lowinc,clear

append using ratefile_delayphone_midhighinc

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

	// (rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen))
	// (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry))
	// (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand))
	// (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender))
	
	// (rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%50))
	// (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%50))
	// (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%50))
	// (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%50))
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("") 
	legend(order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_income,replace ; 
graph export figure_delayphone_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.1.2.2 Low income only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("Low-income only") 
	legend(order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_income_lowincome_only,replace ; 
graph export figure_delayphone_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.1.2.3 Mid/high income

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("Mid/High-income only") 
	legend(		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_income_midhighincome_only,replace ; 
graph export figure_delayphone_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.1.3 By sex/gender

**#				2.1.3.1 Women and men

u ratefile_delayphone_female,clear

append using ratefile_delayphone_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

	// (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen))
	// (rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry))
	// (rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand))
	// (rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender))
	
	// (rcap lb_asian ub_asian year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%50))
	// (rcap lb_black ub_black year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%50))
	// (rcap lb_hispanic ub_hispanic year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(sand%50))
	// (rcap lb_white ub_white year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(lavender%50))
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_sex,replace ; 
graph export figure_delayphone_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.1.3.2 Females only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("Females only") 
	legend(

		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_sex_women_only,replace ; 
graph export figure_delayphone_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.1.3.3 Males only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get through by phone", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayphone_by_sex_men_only,replace ; 
graph export figure_delayphone_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**#		2.2 Couldn't get an appointment soon enough

**#				2.2.1 Overall

u ratefile_delayappt.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("", size(medium) position(10)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delayappt, replace ;
graph export figure_delayappt.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.2.2 By income

**#					2.2.2.1 Low and mid/high income

u ratefile_delayappt_lowinc,clear

append using ratefile_delayappt_midhighinc

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

	// (rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen))
	// (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry))
	// (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand))
	// (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender))
	
	// (rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%50))
	// (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%50))
	// (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%50))
	// (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%50))
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("") 
	legend(order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_income,replace ; 
graph export figure_delayappt_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**#					2.2.2.2 Low income only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("Low-income only") 
	legend(order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_income_lowincome_only,replace ; 
graph export figure_delayappt_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.2.2.3 Mid/high income only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("Mid/High-income only") 
	legend(		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_income_midhighincome_only,replace ; 
graph export figure_delayappt_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**#				2.2.3 By sex/gender

**#					2.2.3.1 Women and men

u ratefile_delayappt_female,clear

append using ratefile_delayappt_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

	// (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen))
	// (rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry))
	// (rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand))
	// (rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender))
	
	// (rcap lb_asian ub_asian year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%50))
	// (rcap lb_black ub_black year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%50))
	// (rcap lb_hispanic ub_hispanic year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(sand%50))
	// (rcap lb_white ub_white year if female_flag==2, lwidth(thin) lpattern(solid) lcolor(lavender%50))
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_sex,replace ; 
graph export figure_delayappt_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.2.3.2 Females only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("Females only") 
	legend(

		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_sex_women_only,replace ; 
graph export figure_delayappt_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.2.3.3 Males only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Couldn't get appointment soon", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayappt_by_sex_men_only,replace ; 
graph export figure_delayappt_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**#		2.3 Once they get there, they have to wait too long to see the doctor

**#				2.3.1 Overall

u ratefile_delaywait.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("", size(medium) position(10)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delaywait, replace ;
graph export figure_delaywait.jpg, as(jpg) name("Graph") quality(100) replace ;

**#				2.3.2 By income

**#					2.3.2.1 Low and mid/high income

u ratefile_delaywait_lowinc,clear ;

append using ratefile_delaywait_midhighinc ;


 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("") 
	legend(order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_income,replace ; 
graph export figure_delaywait_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.3.2.2 Low income only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Low-income only") 
	legend(order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_income_lowincome_only,replace ; 
graph export figure_delaywait_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**#					2.3.2.3 Mid/high income only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Mid/High-income only") 
	legend(		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_income_midhighincome_only,replace ; 
graph export figure_delaywait_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.3.3 By sex/gender

**#					2.3.3.1 Women and men


u ratefile_delaywait_female,clear

append using ratefile_delaywait_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)


		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_sex,replace ; 
graph export figure_delaywait_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.3.3.2 Females only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Females only") 
	legend(

		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_sex_women_only,replace ; 
graph export figure_delaywait_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.3.3.3 Males only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaywait_by_sex_men_only,replace ; 
graph export figure_delaywait_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************


**#		2.4 The clinic/doctor's office wasn't open when they could get there

**#				2.4.1 Overall

u ratefile_delayhrs.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Doctor's office not open", size(small))
	subtitle("", size(medium) position(10)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delayhrs, replace ;
graph export figure_delayhrs.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.4.2 By income

**#					2.4.2.1 Low and mid/high income

u ratefile_delayhrs_lowinc,clear

append using ratefile_delayhrs_midhighinc

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Doctor's office not open", size(small))
	subtitle("") 
	legend(order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_income,replace ; 
graph export figure_delayhrs_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.4.2.2 Low income only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Doctor's office not open", size(small))
	subtitle("Low-income only") 
	legend(order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_income_lowincome_only,replace ; 
graph export figure_delayhrs_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.4.2.3 Mid/high income only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Doctor's office not open", size(small))
	subtitle("Mid/High-income only") 
	legend(		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_income_midhighincome_only,replace ; 
graph export figure_delayhrs_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


**#				2.4.3 By sex/gender

**#					2.4.3.1 Women and men


u ratefile_delayhrs_female,clear

append using ratefile_delayhrs_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_sex,replace ; 
graph export figure_delayhrs_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.4.3.2 Females only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Females only") 
	legend(

		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_sex_women_only,replace ; 
graph export figure_delayhrs_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.4.3.3 Males only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Wait too long in doctor's office", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delayhrs_by_sex_men_only,replace ; 
graph export figure_delayhrs_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************


**#		2.5 Didn't have transportation

**#				2.5.1 Overall

u ratefile_delaytrans.dta, clear
 
#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("", size(medium) position(10)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_delaytrans, replace ;
graph export figure_delaytrans.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#				2.5.2 By income

**#					2.5.2.1 Low and mid/high income

u ratefile_delaytrans_lowinc,clear

append using ratefile_delaytrans_midhighinc

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if incflag==2, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if incflag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if incflag==2, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if incflag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if incflag==2, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if incflag==2, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("") 
	legend(order(1 "Asian LI" 2 "Asian MHI" 3 "Black LI" 4 "Black MHI" 5 "Latino LI" 6 "Latino MHI" 7 "White LI" 8 "White MHI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_income,replace ; 
graph export figure_delaytrans_by_income.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("Low-income only") 
	legend(order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_income_lowincome_only,replace ; 
graph export figure_delaytrans_by_income_lowincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.5.2.3 Mid/high income only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if incflag==2, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 

	(connected rate_black year if incflag==2, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

	(connected rate_hispanic year if incflag==2, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if incflag==2, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_asian ub_asian year if incflag==2, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	 (rcap lb_black ub_black year if incflag==2, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	 (rcap lb_hispanic ub_hispanic year if incflag==2, lwidth(thin) lpattern(solid) lcolor(sand%40))
	 (rcap lb_white ub_white year if incflag==2, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("Mid/High-income only") 
	legend(		order(1 "Asian LI" 2 "Balck LI" 3 "Latino LI" 4 "White LI")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_income_midhighincome_only,replace ; 
graph export figure_delaytrans_by_income_midhighincome_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr
	
**#				2.5.3 By sex/gender

**#					2.5.3.1 Women and men


u ratefile_delaytrans_female,clear

append using ratefile_delaytrans_male

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(shortdash) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_asian year if female_flag==0, 
		lpattern(longdash_dot) lcolor(midgreen%50) msymbol(c) mcolor(midgreen%50) mlabel()
		graphregion(color(none))
		) 
		
	(connected rate_black year if female_flag==1, 
		lpattern(shortdash) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(longdash_dot) lcolor(cranberry%50) msymbol(s) mcolor(cranberry%50)
		graphregion(color(none))
		) 
		
	(connected rate_hispanic year if female_flag==1, 
		lpattern(shortdash) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(longdash_dot) lcolor(sand%50) msymbol(t) mcolor(sand%50)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(shortdash) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
	(connected rate_white year if female_flag==0, 
		lpattern(longdash_dot) lcolor(lavender%50) msymbol(d) mcolor(lavender%50)
		graphregion(color(none))
		)

		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("") 
	legend(
		label(1 "Asian females") 
		label(2 "Asian males") 
		label(3 "Black females") 
		label(4 "Black males")
		label(5 "Latino females") 
		label(6 "Latino males") 
		label(7 "White females") 
		label(8 "White males") 
		order(1 "Asian females" 2 "Asian males" 3 "Black females" 4 "Black males" 5 "Latino females" 6 "Latino males" 7 "White females" 8 "White males")
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_sex,replace ; 
graph export figure_delaytrans_by_sex.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.5.3.2 Females only


#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==1, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==1, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==1, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==1, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==1, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("Females only") 
	legend(
		order(1 "Asian females" 2 "Black females" 3 "Latina women" 4 "White females" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_sex_women_only,replace ; 
graph export figure_delaytrans_by_sex_women_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

**#					2.5.3.3 Males only

#delimit ;
 mylabels 0(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_asian year if female_flag==0, 
		lpattern(solid) lcolor(midgreen) msymbol(c) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_black year if female_flag==0, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 
	(connected rate_hispanic year if female_flag==0, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
		
	(connected rate_white year if female_flag==0, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)

	 (rcap lb_asian ub_asian year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(midgreen%40))
	(rcap lb_black ub_black year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(cranberry%40))
	(rcap lb_hispanic ub_hispanic year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(sand%40))
	(rcap lb_white ub_white year if female_flag==0, lwidth(thin) lpattern(solid) lcolor(lavender%40))
	
		,		

	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Lacked transportation", size(small))
	subtitle("Males only") 
	legend(
		order(1 "Asian males" 2 "Black males" 3 "Latino males" 4 "White males" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white%30)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_delaytrans_by_sex_men_only,replace ; 
graph export figure_delaytrans_by_sex_men_only.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**#	3. Ordered number of barriers

use number_barriers_by_years_table_all.dta, clear

#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(line rate_asian year if countflag==1, lcolor(midgreen) lwidth(medium) lpattern(solid) msize(small)) 
	(line rate_black year if countflag==1, lcolor(cranberry) lwidth(medium) lpattern(solid) msize(small)) 
	(line rate_hispanic year if countflag==1, lcolor(sand) lwidth(medium) lpattern(solid) msize(small)) 
	(line rate_white year if countflag==1, lcolor(lavender) lwidth(medium) lpattern(solid) msize(small)) 

	(line rate_asian year if countflag==2, lcolor(midgreen) lwidth(medium) lpattern(longdash) msize(small)) 
	(line rate_black year if countflag==2, lcolor(cranberry) lwidth(medium) lpattern(longdash) msize(small)) 
	(line rate_hispanic year if countflag==2, lcolor(sand) lwidth(medium) lpattern(longdash) msize(small)) 
	(line rate_white year if countflag==2, lcolor(lavender) lwidth(medium) lpattern(longdash) msize(small)) 
	
	(line rate_asian year if countflag==3, lcolor(midgreen) lwidth(medium) lpattern(shortdash) msize(small)) 
	(line rate_black year if countflag==3, lcolor(cranberry) lwidth(medium) lpattern(shortdash) msize(small)) 
	(line rate_hispanic year if countflag==3, lcolor(sand) lwidth(medium) lpattern(shortdash) msize(small)) 
	(line rate_white year if countflag==3, lcolor(lavender) lwidth(medium) lpattern(shortdash) msize(small)) 
	
	(line rate_asian year if countflag==4, lcolor(midgreen) lwidth(medium) lpattern(dash_dot) msize(small)) 
	(line rate_black year if countflag==4, lcolor(cranberry) lwidth(medium) lpattern(dash_dot) msize(small)) 
	(line rate_hispanic year if countflag==4, lcolor(sand) lwidth(medium) lpattern(dash_dot) msize(small)) 
	(line rate_white year if countflag==4, lcolor(lavender) lwidth(medium) lpattern(dash_dot) msize(small))

	
	, 
	
	xlabel(1999(1)2018) xtitle("Year of Interview", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent", size(small))
	subtitle("", size(vsmall)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1  2 3  4)
		size(small) position(10) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title("", size(small))) 
	xsize(8) ysize(5)
	title("")
	scheme(plotplainblind) 
	;
graph save figure_number_of_barriers_vs_years, replace ;
graph export figure_number_of_barriers_vs_years.jpg, as(jpg) name("Graph") quality(100) replace ;


#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**#	4. Mean number of barriers

u mean_number_of_barriers.dta,clear
	
#delimit ;

twoway 
	(connected rate_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(c) mcolor(midgreen%30)
		graphregion(color(none))
		) 
	(connected rate_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry%30)
		graphregion(color(none))
		) 
	(connected rate_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand%30)
		graphregion(color(none))
		) 
	(connected rate_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender%30)
		graphregion(color(none))
		)
		
		(rcap lb_asian ub_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen%30))
		(rcap lb_black ub_black year, lwidth(thin) lpattern(solid) lcolor(cranberry%30))
		(rcap lb_hispanic ub_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand%30))
		(rcap lb_white ub_white year, lwidth(thin) lpattern(solid) lcolor(lavender%30))
		,
		
		
	xlabel(1999(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(0(0.1)0.4, angle(horizontal) format(%9.1f)) ytitle("Estimated mean number of barriers", size(small))
	subtitle("", size(vsmall)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white%30)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
	
graph save "Graph" figure_mean_number_of_barriers.gph, replace ;

graph export figure_mean_number_of_barriers.jpg, as(jpg) name("Graph") quality(100) replace ;

#delimit cr

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

**# 5. Number of barriers by race and ethnicity (histogram)

use nonfinancial_barriers,clear

histogram delaycount, discrete percent xlabel(0(1)5) xtitle("Number of barriers") by(race, legend(off) note("")) addlabel addlabopts(mlabangle(forty_five) mlabgap(2) mlabformat(%9.1f)) legend(off)
graph save "Graph" figure_histogram_number_of_barriers.gph, replace
graph export figure_histogram_number_of_barriers.jpg, as(jpg) name("Graph") quality(100) replace

