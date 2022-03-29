
/* 				

Trends in Racial and Ethnic Disparities in BArriers to Timely Medical Care, 1999-2018

César Caraballo, Jeph Herrin, Harlan M. Krumholz, et al.
						

Study population general characteristics
						
*/

use nonfinancial_barriers, clear

* Age, median (IQR) 

foreach R in asian black hispanic white {
	
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(50)
disp "`R' P50:"
return list
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(25) 
disp "`R' P25:"
return list
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(75)
disp "`R' P75:"
return list
}

foreach R in asian black hispanic white {
	
	foreach Y in firstyears midyears lastyears{
			
		_pctile age  if `R'==1 & `Y'==1 [pweight=sampweight_ipums_pooled],p(50)
		disp "`R' `Y' P50:"
		return list
		_pctile age  if `R'==1 & `Y'==1 [pweight=sampweight_ipums_pooled],p(25) 
		disp "`R' `Y' P25:"
		return list
		_pctile age  if `R'==1 & `Y'==1 [pweight=sampweight_ipums_pooled],p(75)
		disp "`R' `Y' P75:"
		return list
}
}

* Age category

svy: tabulate agecat race, col ci
svy, subpop(if firstyears==1): tabulate agecat race, col ci
svy, subpop(if midyears==1): tabulate agecat race, col ci
svy, subpop(if lastyears==1): tabulate agecat race, col ci

* Sex

svy: tabulate sex race, col ci
svy, subpop(if firstyears==1): tabulate sex race, col ci
svy, subpop(if midyears==1): tabulate sex race, col ci
svy, subpop(if lastyears==1): tabulate sex race, col ci

* Citizenship

svy: tabulate uscitizen race, col ci
svy, subpop(if firstyears==1): tabulate uscitizen race, col ci
svy, subpop(if midyears==1): tabulate uscitizen race, col ci
svy, subpop(if lastyears==1): tabulate uscitizen race, col ci

* Education

svy: tabulate education race, col ci
svy, subpop(if firstyears==1): tabulate education race, col ci
svy, subpop(if midyears==1): tabulate education race, col ci
svy, subpop(if lastyears==1): tabulate education race, col ci

* Income level is calculated at the end of this document

* Insurance

svy: tabulate noinsurance race, col ci
svy, subpop(if firstyears==1): tabulate noinsurance race, col ci
svy, subpop(if midyears==1): tabulate noinsurance race, col ci
svy, subpop(if lastyears==1): tabulate noinsurance race, col ci

* Region

svy: tabulate region race, col ci
svy, subpop(if firstyears==1): tabulate region race, col ci
svy, subpop(if midyears==1): tabulate region race, col ci
svy, subpop(if lastyears==1): tabulate region race, col ci

* Marital status

svy: tabulate married race, col ci
svy, subpop(if firstyears==1): tabulate married race, col ci
svy, subpop(if midyears==1): tabulate married race, col ci
svy, subpop(if lastyears==1): tabulate married race, col ci

* Employment status

svy: tabulate workstat race, col ci
svy, subpop(if firstyears==1): tabulate workstat race, col ci
svy, subpop(if midyears==1): tabulate workstat race, col ci
svy, subpop(if lastyears==1): tabulate workstat race, col ci

* Comorbidities

svy: tabulate asthma race, col ci
svy, subpop(if firstyears==1): tabulate asthma race, col ci
svy, subpop(if midyears==1): tabulate asthma race, col ci
svy, subpop(if lastyears==1): tabulate asthma race, col ci

svy: tabulate cancer race, col ci
svy, subpop(if firstyears==1): tabulate cancer race, col ci
svy, subpop(if midyears==1): tabulate cancer race, col ci
svy, subpop(if lastyears==1): tabulate cancer race, col ci

svy: tabulate copd race, col ci
svy, subpop(if firstyears==1): tabulate copd race, col ci
svy, subpop(if midyears==1): tabulate copd race, col ci
svy, subpop(if lastyears==1): tabulate copd race, col ci

svy: tabulate diabetes race, col ci
svy, subpop(if firstyears==1): tabulate diabetes race, col ci
svy, subpop(if midyears==1): tabulate diabetes race, col ci
svy, subpop(if lastyears==1): tabulate diabetes race, col ci

svy: tabulate heartdisease race, col ci
svy, subpop(if firstyears==1): tabulate heartdisease race, col ci
svy, subpop(if midyears==1): tabulate heartdisease race, col ci
svy, subpop(if lastyears==1): tabulate heartdisease race, col ci

svy: tabulate hypertension race, col ci
svy, subpop(if firstyears==1): tabulate hypertension race, col ci
svy, subpop(if midyears==1): tabulate hypertension race, col ci
svy, subpop(if lastyears==1): tabulate hypertension race, col ci

svy: tabulate ckd race, col ci
svy, subpop(if firstyears==1): tabulate ckd race, col ci
svy, subpop(if midyears==1): tabulate ckd race, col ci
svy, subpop(if lastyears==1): tabulate ckd race, col ci

svy: tabulate liverdisease race, col ci
svy, subpop(if firstyears==1): tabulate liverdisease race, col ci 
svy, subpop(if midyears==1): tabulate liverdisease race, col ci
svy, subpop(if lastyears==1): tabulate liverdisease race, col ci

svy: tabulate stroke race, col ci
svy, subpop(if firstyears==1): tabulate stroke race, col ci
svy, subpop(if midyears==1): tabulate stroke race, col ci
svy, subpop(if lastyears==1): tabulate stroke race, col ci

* Smoking Status

svy: tabulate currentsmoker race, col ci
svy, subpop(if firstyears==1): tabulate currentsmoker race, col ci
svy, subpop(if midyears==1): tabulate currentsmoker race, col ci
svy, subpop(if lastyears==1): tabulate currentsmoker race, col ci

* Flu shot in past 12m

svy: tabulate flushot race, col ci
svy, subpop(if firstyears==1): tabulate flushot race, col ci
svy, subpop(if midyears==1): tabulate flushot race, col ci
svy, subpop(if lastyears==1): tabulate flushot race, col ci

* Obesity

svy: tabulate bminew race, col ci
svy, subpop(if firstyears==1): tabulate bminew race, col ci
svy, subpop(if midyears==1): tabulate bminew race, col ci
svy, subpop(if lastyears==1): tabulate bminew race, col ci

/*******************************************************************************

Low-income estimation using multiply imputed variables

*******************************************************************************/

quietly {
	
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
	svy, subpop(`G'): logit lowincome_1 year_*  
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x21, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+1                            
		gen rate=invlogit(x`n'+x21)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,21])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_1, replace                          

****************************************

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
	svy, subpop(`G'): logit lowincome_2 year_*  
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x21, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+1                            
		gen rate=invlogit(x`n'+x21)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,21])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_2, replace                          

****************************************

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
	svy, subpop(`G'): logit lowincome_3 year_* 
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x21, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+1                            
		gen rate=invlogit(x`n'+x21)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,21])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_3, replace  

****************************************

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
	svy, subpop(`G'): logit lowincome_4 year_* 
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x21, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+1                            
		gen rate=invlogit(x`n'+x21)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,21])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_4, replace  

****************************************

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
	svy, subpop(`G'): logit lowincome_5 year_*
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x21, means(b) cov(V) clear n(`iters')  
	forv y=1999/2018 {
		local n=(`y'-1999)+1                            
		gen rate=invlogit(x`n'+x21)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,21])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_5, replace  

****************************************
	
use ratefile_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`x'
}

save appendedfile, replace 


foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		sort year
		gen U=stderr_`G'^2      
        collapse (mean) rate_`G' U lb_`G' ub_`G' (sd) B=rate_`G' (count) M=rate_`G' , by(year)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_`G'=T^0.5
        drop M B T U
		save collapsedfile_`G', replace
	} 

use	collapsedfile_asian, clear

foreach x in white black hispanic allfour {
	merge 1:1 year using collapsedfile_`x'
	drop _merge
}

save ratefile_lowinc,replace
}

use ratefile_lowinc.dta, clear 

gen yeargroup=.
replace yeargroup=1 if year==1999 | year==2000
replace yeargroup=3 if year==2008 | year==2009
replace yeargroup=5 if year==2017 | year==2018


	label var yeargroup "Years"
	label define yeargroup 1 "99-00" 3 "08-09" 5 "17-18"
	label value yeargroup yeargroup 

foreach G in asian black hispanic white {
	
	gen rate1_`G'=rate_`G'*100
	gen lb1_`G'=lb_`G'*100
	gen ub1_`G'=ub_`G'*100
	gen stderr1_`G'=stderr_`G'*100
	
	
}	

mean rate1_* lb1_* ub1_* stderr1_*

collapse rate1_* lb1_* ub1_*, by(yeargroup)


