
/* 				

Trends in Racial and Ethnic Disparities in Barriers to Timely Medical Care, 1999-2018

César Caraballo, Jeph Herrin, Harlan M. Krumholz, et al.

*/

**# Table of contents
/*
										
Main analysis

	1. Overall
	2. By income level
	3. By sex
	4. By unmet medical needs due to cost
	5. By insurance status
	
*/

capture log using main_analysis.log,replace

**# 1. Trends overall

**# 	1.1 Prevalence of any and each specific barriers

qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o'"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(`G'): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o', replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o',replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o'"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with Whites"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

}


**# 1.2 Ordered number of barriers (ordered logistic regression)

foreach G in asian black hispanic white {
	
use nonfinancial_barriers,clear

	
	qui {                                                         
    putexcel set number_barriers_by_years_table_`G'.xlsx, replace                    
    svy, subpop(`G'): ologit delaycount i.year C_age C_neast C_midwest C_south C_west C_female 
    predict p0-p5
    gen q0=1
    forv i=1/5 {
        local j=`i'-1
        gen q`i'= q`j'-p`j'                   // prob of at least i comorbidities
    }
    noi svy , over(year): mean q0-q5

    putexcel A1=etable
    
}
}

**# 1.3 Mean number of barriers

u nonfinancial_barriers, clear

	 foreach G in asian black hispanic white { 
	
		noi disp "************** `G' **************"
	
		svy, subpop(`G'): regress delaycount C_age C_female C_neast C_midwest C_south C_west year_*   , noconstant 

	}


/*******************************************************************************
********************************************************************************	
********************************************************************************	
*******************************************************************************/

**# 2. Trends by income level

**# 	2.1 Trends among low-income only


qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {

foreach N in 1 2 3 4 5 {

u nonfinancial_barriers, clear

save temp, replace                                       

local zcrit=invnorm(.975)
set seed 20201209                                         
local iters 10000                                         
local lb = round(`iters'*0.025)
local ub = round(`iters'*0.975)

capture postclose rates
postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

qui foreach G in white black asian hispanic allfour { 
	u temp, clear
	svy, subpop(`G'): logit `o' C_age C_neast C_midwest C_south C_west year_*  if lowincome_`N'==1
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+6                            
		gen rate=invlogit(x`n'+x26)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string
save ratefile_`o'_`N', replace
}

use ratefile_`o'_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`o'_`x'
}

save appendedfile_`o', replace 


foreach G in white black hispanic asian allfour {
		use appendedfile_`o', clear
		sort year
		gen U=stderr_`G'^2      
        collapse (mean) rate_`G' U lb_`G' ub_`G' (sd) B=rate_`G' (count) M=rate_`G' , by(year)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_`G'=T^0.5
        drop M B T U
		save collapsedfile_`o'_`G', replace
	} 


use	collapsedfile_`o'_asian, clear

foreach x in white black hispanic allfour {
	merge 1:1 year using collapsedfile_`o'_`x'
	drop _merge
}

save ratefile_`o'_lowinc,replace

use ratefile_`o'_lowinc,clear

qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_lowincome,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among low-income"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among low-income"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' prevalence difference from 1999 to 2018 among low-income"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap difference from 1999 to 2018 among low-income"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with White individuals in 1999 among low-income"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with White individuals in 2018 among low-income"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_lowinc,clear

gen incflag=1
 
save ratefile_`o'_lowinc,replace
}

**# 	2.2 Trends among middle/high-income only


qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {

foreach N in 1 2 3 4 5 {

u nonfinancial_barriers, clear

save temp, replace                                       

local zcrit=invnorm(.975)
set seed 20201209                                         
local iters 10000                                         
local lb = round(`iters'*0.025)
local ub = round(`iters'*0.975)

capture postclose rates
postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

qui foreach G in white black asian hispanic allfour { 
	u temp, clear
	svy, subpop(`G'): logit `o' C_age C_neast C_midwest C_south C_west year_*  if lowincome_`N'==0
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+6                            
		gen rate=invlogit(x`n'+x26)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string
save ratefile_`o'_`N', replace
}

use ratefile_`o'_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`o'_`x'
}

save appendedfile_`o', replace 


foreach G in white black hispanic asian allfour {
		use appendedfile_`o', clear
		sort year
		gen U=stderr_`G'^2      
        collapse (mean) rate_`G' U lb_`G' ub_`G' (sd) B=rate_`G' (count) M=rate_`G' , by(year)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_`G'=T^0.5
        drop M B T U
		save collapsedfile_`o'_`G', replace
	} 


use	collapsedfile_`o'_asian, clear

foreach x in white black hispanic allfour {
	merge 1:1 year using collapsedfile_`o'_`x'
	drop _merge
}

save ratefile_`o'_midhighinc,replace

use ratefile_`o'_midhighinc,clear

qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_midhighincome,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among mid/high-income"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among mid/high-income"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' prevalence difference from 1999 to 2018 among mid/high-income"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap difference from 1999 to 2018 among mid/high-income"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with White individuals in 1999 among mid/high-income"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with White individuals in 2018 among mid/high-income"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_midhighinc,clear

gen incflag=2
 
save ratefile_`o'_midhighinc,replace
}

/*******************************************************************************
********************************************************************************	
********************************************************************************	
*******************************************************************************/

**# 3. Trends by sex

**# 3.1 Trends among women only

qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among females only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & female==1): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_female, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_female,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among females only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among females only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among females only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among females only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among females only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among females only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_female, clear
gen female_flag=1   
save ratefile_`o'_female, replace

}

**# 3.2 Trends among men only


qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among males only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & male==1): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_male, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_male,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among males only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among males only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among males only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among males only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among males only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among males only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_male, clear
gen female_flag=0 
save ratefile_`o'_male, replace

}

/*******************************************************************************
********************************************************************************	
********************************************************************************	
*******************************************************************************/

**# 4. Trends by unmet medical needs due to cost

**# 4.1 Trends among those with unmet medical needs due to cost only

qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among those with unmet needs due to cost only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & badcarecost==1): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_unmet_needs, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_unmet_needs,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among those with unmet needs due to cost only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among those with unmet needs due to cost only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among those with unmet needs due to cost only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among those with unmet needs due to cost only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among those with unmet needs due to cost only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among those with unmet needs due to cost only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_unmet_needs, clear
gen unmet_needs_flag=1   
save ratefile_`o'_unmet_needs, replace

}

**# 4.2 Trends among those without unmet medical needs due to cost only


qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among those without unmet medical needs due to cost only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & badcarecost==0): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_no_unmet_needs, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_no_unmet_needs,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among those without unmet medical needs due to cost only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among those without unmet medical needs due to cost only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among those without unmet medical needs due to cost only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among those without unmet medical needs due to cost only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among those without unmet medical needs due to cost only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among those without unmet medical needs due to cost only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_no_unmet_needs, clear
gen unmet_needs_flag=0 
save ratefile_`o'_no_unmet_needs, replace

}


/*******************************************************************************
********************************************************************************	
********************************************************************************	
*******************************************************************************/

**# 5. Trends by insurance status

**# 5.1 Trends among uninsured only

qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among uninsured only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & noinsurance==1): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_uninsured, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_uninsured,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among uninsured only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among uninsured only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among uninsured only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among uninsured only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among uninsured only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among uninsured only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_uninsured, clear
gen uninsured_flag=1   
save ratefile_`o'_uninsured, replace

}

**# 5.2 Trends among insured only


qui foreach o in delayappt delayhrs delayphone delaytrans delaywait delay_any {
	
	u nonfinancial_barriers, clear
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Main analysis on `o' among insured only"
	noi disp "**********************************************"

	save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & noinsurance==0): logit `o' C_age C_neast C_midwest C_south C_west year_*    
		matrix b=e(b)
		matrix V=e(V)
		drawnorm x1-x26, means(b) cov(V) clear n(`iters')  
		forv y=1999/2018 {
			local n=(`y'-1999)+6                            
			gen rate=invlogit(x`n'+x26)                    
			sort rate
			sum rate
			post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,26])) (r(sd)) (rate[`lb']) (rate[`ub'])
			drop rate
	}
}
	postclose rates
	u ratefile, clear
	reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

	save ratefile_`o'_insured, replace                          

	
qui {
foreach D in black asian hisp {
     gen diff_`D'=(rate_`D' - rate_white)     
     gen diff_`D'_SE = sqrt(stderr_`D'^2+ stderr_white^2)
     gen diff_`D'_lb=diff_`D'-diff_`D'_SE*`zcrit'
     gen diff_`D'_ub=diff_`D'+diff_`D'_SE*`zcrit'
     gen wt_diff_`D'= 1/diff_`D'_SE^2 
}
save ratediff_`o'_insured,replace
}

qui {
foreach R in white black asian hisp allfour {
    gen wt_`R'=1/(stderr_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence of `o' among insured only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_`R' year [aw=wt_`R']       

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in gap of `o' compared with White individuals among insured only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_`P' year [aw=(wt_diff_`P')]       

}
}
 
keep if inlist(year,1999,2018)
sort year

local zcrit=invnorm(.975)

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Prevalence difference from 1999 to 2018 among insured only"
	noi disp "**********************************************"
foreach R in white black asian hispanic allfour {
    local diff=rate_`R'[2]-rate_`R'[1]         
    local SE = sqrt(stderr_`R'[2]^2+stderr_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}

qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' Gap difference from 1999 to 2018 among insured only"
	noi disp "**********************************************"
foreach R in black asian hisp {
    local diff_1=rate_`R'[1]-rate_white[1]         
    local diff_2=rate_`R'[2]-rate_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_`R'[1]^2+stderr_white[1]^2) 
    local SE_2= sqrt(stderr_`R'[2]^2+stderr_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}
}


* 		Quantifying Gap in 1999 

* 		Percentage	95% CI 		P value
qui if year==1999  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 1999 among insured only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '99" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}
}

*		Quantifying Gap in 2018 

* 		Percentage	95% CI 		P value
qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "`o' gap with whites in 2018 among insured only"
	noi disp "**********************************************"
foreach G in asian black hisp  {
    local Pval=2*(1-normal(abs(diff_`G'/diff_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_`G'*100 _col(30) "(" %5.2f diff_`G'_lb*100 "," %5.2f diff_`G'_ub*100 ")" _col(50) "`Pval'"
	
}

}

use ratefile_`o'_insured, clear
gen uninsured_flag=0 
save ratefile_`o'_insured, replace

}


log close


