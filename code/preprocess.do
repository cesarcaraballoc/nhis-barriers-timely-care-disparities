
/* 				

Trends in Racial and Ethnic Disparities in BArriers to Timely Medical Care, 1999-2018

César Caraballo, Jeph Herrin, Harlan M. Krumholz, et al.
						
						
Preprocessing, study sample creation, variables of interest.	

	1. Independent variables
	2. Dependent variables
	3. Other descriptive variables of interest
	4. Other indicators
	5. Exclusions, centering, and saving file

*/

clear all

use "nhis_99-18.dta" 

/*

Important note:

The data file used above was obtained from the Integrated Public Use Microdata
Series website (https://nhis.ipums.org/nhis/), containing NHIS data from years 
1999 to 2018.

When generating the variables of interest, inspect each variable encoding. 
Their underlying values may have changed from the ones in the version that we used.

*/

	  
keep if astatflg==1



* 0. Fixing weights.

************ Correcting for pooled years ************************

gen sampweight_ipums_pooled = sampweight / 20

gen strata_ipums_pooled = strata / 20

gen psu_ipums_pooled = psu / 20


********************* Using survey set ************************

svyset [pw=sampweight_ipums_pooled], strata(strata_ipums_pooled) psu(psu_ipums_pooled)



/*******************************************************************************
********************************************************************************	

1. Independent variables

********************************************************************************	
*******************************************************************************/

/*

	1.1 Race/Ethnicity

*/

gen race=.
replace race=1 if racea==100 & hispyn==1
replace race=3 if racea==200 & hispyn==1
replace race=7 if (racea>201 & racea<889) & hispyn==1
replace race=5 if (racea>=400 & racea<500) & hispyn==1
replace race=9 if hispyn==2

label variable race "Race/Ethnicity"
label define race 	1 "NH White" 3 "NH Black" 5 "NH Asian" 7 "NH Other" 9 "Hispanic"
label value race race


gen white=0
replace white=1 if race==1

gen black=0
replace black=1 if race==3

gen asian=0
replace asian=1 if race==5

gen otherrace=0 
replace otherrace=1 if race==7

gen hispanic=0
replace hispanic=1 if race==9

gen allfour=0
replace allfour=1 if race==1 | race==3 | race==5 | race==9
 
/*

	1.2 Mulitply imputed low-income level indicators

*/

foreach G in 1 2 3 4 5 {
gen lowincome_`G'=.
replace lowincome_`G'=0 if povimp`G' >=8 & povimp`G'!=98
replace lowincome_`G'=1 if povimp`G' <8

label variable lowincome_`G' "Low Income (<200% Federal Poverty Limit)"
	label define lowincome_`G' 0 "No" 1 "Yes"
	label value lowincome_`G' lowincome_`G'

	
}

/*

2.3 Foregone or delayed medical care due to cost
	
*/

* Foregone care

gen nocarecost=.
replace nocarecost=0 if ybarcare==1
replace nocarecost=1 if ybarcare==2

label variable nocarecost "Foregone Medical Care Due to Cost"
label define nocarecost 0 "No" 1 "Yes"
label value nocarecost nocarecost
	
* Delayed care

gen latecarecost=.
replace latecarecost=0 if delaycost==1
replace latecarecost=1 if delaycost==2

label variable latecarecost "Delayed Medical Care Due to Cost"
label define latecarecost 0 "No" 1 "Yes"	
label value latecarecost latecarecost
	
* Foregone prescriptions
 
gen nomedscost=.
replace nomedscost=0 if ybarmeds==0 | ybarmeds==1
replace nomedscost=1 if ybarmeds==2

label variable nomedscost "Foregone Prescriptions Due to Cost"
label define nomedscost 0 "No" 1 "Yes"
label value nomedscost nomedscost

* Composite 

gen badcarecost=.
replace badcarecost=0 if (nocarecost==0 & latecarecost==0 & nomedscost==0)
replace badcarecost=1 if (nocarecost==1 | latecarecost==1 | nomedscost==1)

label variable badcarecost "Foregone/Delayed Medical Care Due to Cost"
label define badcarecost 0 "No" 1 "Yes"
label value badcarecost badcarecost

/*******************************************************************************
********************************************************************************	

2. Dependent variables

********************************************************************************	
*******************************************************************************/

/*

Nonfinancial barriers to health care

*/

foreach var in delayappt delayhrs delayphone delaytrans delaywait {
	
	label drop `var'_lbl
	replace `var'=. if `var'>2
	replace `var'=0 if `var'==1
	replace `var'=1 if `var'==2
	tab `var',m
}

gen delay_any=.
replace delay_any=0 if delayappt==0 & delayhrs==0 & delayphone==0 & delaytrans==0 & delaywait==0 
replace delay_any=1 if delayappt==1 | delayhrs==1 | delayphone==1 | delaytrans==1 | delaywait==1 

egen delaycount=rowtotal(delayappt delayhrs delayphone delaytrans delaywait)

/*******************************************************************************
********************************************************************************	

3. Other descriptive variables of interest

********************************************************************************	
*******************************************************************************/

/*

	3.1 Female sex indicator

*/ 

gen female=0
replace female=1 if sex==2

gen male=0
replace male=1 if sex==1

/*

	3.2 Marital status

*/ 

gen married=.
replace married=1 if marstat>14 & marstat<98
replace married=3 if marstat<14
replace married=. if marstat==99

label variable married "Marital Status"
	label define married 1 "Not Married" 3 "Married" 
	label value married married

/*

	3.3 Education level

*/ 

gen education=.
replace education=1 if educ <200
replace education=2 if educ >=200 
replace education=3 if educ >=300 
replace education=4 if educ >=400 & educ <995
replace education=. if educ >995

lab var education "Education Recode"
lab def education 1 "Less than high school" 2 "High school diploma or GED" 3 "Some college" 4 "Bachelor's degree or higher" 
lab val education education

/*

	3.4 Family size

*/ 

gen family=.
replace family=1 if famsize==1
replace family=3 if famsize==2
replace family=7 if famsize>=3 & famsize<.

label variable family "Family Size"
	label define family 1 "1" 3 "2" 7 "≥3"
	label value family family

/*

	3.5 BMI

*/ 
 
gen bmicat=.
replace bmicat=0 if bmi<18.5
replace bmicat=1 if bmi>=18.5 & bmi<25 
replace bmicat=2 if bmi>=25 & bmi<30
replace bmicat=3 if bmi>=30 & bmi<35
replace bmicat=4 if bmi>=35 & bmi<=60  

lab var bmicat "BMI Category"
lab def bmicat 0 "Underweight" 1 "Normal" 2 "Overweight" 3 "Obese" 4 "Severely Obese"
lab val bmicat bmicat

gen bminew=.
replace bminew=0 if bmicat==0 | bmicat==1 | bmicat==2 
replace bminew=1 if bmicat==3 | bmicat==4

lab var bminew "Obese"
lab def bminew 0 "No" 1 "Yes"
lab val bminew bminew

/*

	3.6 Smoking status

*/ 

gen smokestatnew=.
replace  smokestatnew=0 if  smokestatus2==30
replace smokestatnew=1 if smokestatus2==20
replace smokestatnew=2 if smokestatus2==11 | smokestatus2==12
lab var smokestatnew "Smoking status"
lab def smokestatnew 0 "Never smoker" 1 "Former smoker" 2 "Current everyday/someday smoker"
lab val smokestatnew smokestatnew

gen currentsmoker=.
replace currentsmoker=0 if  smokestatnew==0 | smokestatnew==1
replace currentsmoker=1 if  smokestatnew==2
lab var currentsmoker "Current everyday/someday Smoker"
lab def currentsmoker 0 "No" 1 "Yes" 
lab val currentsmoker currentsmoker

/*

	3.4 Flu shot 

*/ 

replace vacflush12m=. if vacflush12m>2

gen flushot=.
replace flushot=0 if  vacflush12m==1 
replace flushot=1 if  vacflush12m==2 
lab var flushot "Flu Shot in past 12 m"
lab def flushot 0 "No" 1 "Yes" 
lab val flushot flushot

gen noflushot=.
replace noflushot=0 if  flushot==1 
replace noflushot=1 if  flushot==0
lab var noflushot "NO Flu Shot in past 12 m"
lab def noflushot 0 "Received flu shot" 1 "No flu shot" 
lab val noflushot noflushot



/*

	3.5 Employment/work status

*/ 

gen workstat=.
replace workstat=1 if empstat>9 & empstat<29
replace workstat=3 if empstat==40
replace workstat=7 if empstat==30
replace workstat=. if empstat>40

label var workstat "Work Status"
label def workstat 1 "With a Job or Working" 3 "Not in Labor Force" 7 "Unemployed" 
label value workstat workstat

/*

	3.6 US citizenship

*/ 

gen uscitizen=.
replace uscitizen=0 if citizen==1
replace uscitizen=1 if citizen==2
replace uscitizen=. if citizen==7 | citizen==8 | citizen==9


label var uscitizen "U.S. Citizenship Status"
label define uscitizen 0 "Not U.S. citizen" 1 "U.S. citizen" 
label value uscitizen uscitizen

/*

	3.7 Age categories and age group indicators

*/ 

gen agecat=.
replace agecat=1 if age<40
replace agecat=3 if age>=40 & age<65
replace agecat=5 if age>=65 & age<.

label var agecat "Age Category"
label define agecat 1 "18–39 years" 3 "40–64 years" 5 "≥65 years"
label value agecat agecat

gen age_cate=.
	replace age_cate=1 if age>=18
	replace age_cate=2 if age>=25 
	replace age_cate=3 if age>=30
	replace age_cate=4 if age>=35
	replace age_cate=5 if age>=40 
	replace age_cate=6 if age>=45
	replace age_cate=7 if age>=50 
	replace age_cate=8 if age>=55
	replace age_cate=9 if age>=60
	replace age_cate=10 if age>=65
	replace age_cate=11 if age>=70
	replace age_cate=12 if age>=75
	replace age_cate=13 if age>=80
	
	tab age_cate, gen(age_group)
	

/*

	3.8 No insurance coverage
	
*/

gen noinsurance=.
replace noinsurance=0 if hinotcove==1
replace noinsurance=1 if hinotcove==2
replace noinsurance=. if hinotcove==9 

label variable noinsurance "Insurance Coverage"
	label define noinsurance 0 "Insured" 1 "Uninsured"
	label value noinsurance noinsurance
	
/*

3.9 Individual chronic conditions
	
*/
 

*** Diabetes


gen dibev=.
replace dibev=0 if diabeticev==1 | diabeticev==3
replace dibev=1 if diabeticev==2 
lab var dibev "Ever told had diabetes"
lab def dibev 0 "No" 1 "Yes" 
lab val dibev dibev

*** HTN


gen htnev=.
replace htnev=0 if  hypertenev==1 
replace htnev=1 if  hypertenev==2 
lab var htnev "Ever told had Hypertension"
lab def htnev 0 "No" 1 "Yes" 
lab val htnev htnev


*** MI and Stroke

gen everstroke=.
replace everstroke=0 if  strokev==1 
replace everstroke=1 if  strokev==2 
lab var everstroke "Ever told had Stroke"
lab def everstroke 0 "No" 1 "Yes" 
lab val everstroke everstroke


*** Cancer

gen canev=.
replace canev=0 if  cancerev==1 
replace canev=1 if  cancerev==2 
lab var canev "Ever told had Cancer"
lab def canev 0 "No" 1 "Yes" 
lab val canev canev


*** Asthma

gen asthma=.
replace asthma=0 if  asthmaev==1 
replace asthma=1 if  asthmaev==2 
lab var asthma "Ever told had Asthma"
lab def asthma 0 "No" 1 "Yes" 
lab val asthma asthma


*** COPD: Emphysema/Chronic bronchitis

gen copdev=.
replace copdev=0 if  emphysemev==1 | cronbronyr==1
replace copdev=1 if  emphysemev==2 | cronbronyr==2
lab var copdev "Ever told had COPD"
lab def copdev 0 "No" 1 "Yes" 
lab val copdev copdev



*** Heart disease (CAD, MI, Angina, other heart conditions)


gen heartds=.
replace heartds=0 if  cheartdiev==1 | angipecev==1 | heartconev==1 | heartattev==1 
replace heartds=1 if  cheartdiev==2 | angipecev==2 | heartconev==2 | heartattev==2 
lab var heartds "Ever told had Any Heart Disease"
lab def heartds 0 "No" 1 "Yes" 
lab val heartds heartds


**** Chronic liver condition

gen cld_new=.
replace cld_new=0 if  liverconyr==1 
replace cld_new=1 if  liverconyr==2 
lab var cld_new "Ever told had Chronic liver condition"
lab def cld_new 0 "No" 1 "Yes" 
lab val cld_new cld_new


** Weak or failing kidneys


gen kidneyds=.
replace kidneyds=0 if  kidneywkyr==1 
replace kidneyds=1 if  kidneywkyr==2 
lab var kidneyds "Told had weak/failing kidneys in past 12m"
lab def kidneyds 0 "No" 1 "Yes" 
lab val kidneyds kidneyds


/*

3.10 Number of chronic conditions and multimorbidity indicator
	
*/

egen conditions=rowtotal(dibev htnev everstroke canev asthma copdev heartds cld_new kidneyds)

gen missingconditions=0

replace missingconditions=1 if dibev==. & htnev==. &  everstroke==. &  canev==. &  asthma==. &  copdev==. &  heartds==. &  cld_new==. &  kidneyds==. 

replace conditions=. if missingconditions==1


gen multimorbid=.
replace multimorbid=0 if conditions<2
replace multimorbid=1 if conditions>=2 & conditions<.
label var multimorbid "with multimorbidity (>=2 conditions)"

rename dibev diabetes
rename htnev hypertension 
rename everstroke stroke 
rename canev cancer 
rename copdev copd 
rename heartds heartdisease 
rename cld_new liverdisease
rename kidneyds ckd

/*******************************************************************************
********************************************************************************	

4. Other indicators

********************************************************************************	
*******************************************************************************/

/*

	4.1 Groups of years

*/ 

gen yearcat=.
replace yearcat=1 if year <2004
replace yearcat=3 if year >=2004 & year <2009
replace yearcat=7 if year >=2009 & year <2013
replace yearcat=9 if year >=2013

label var yearcat "Years"
label define yearcat 1 "1999–2003" 3 "2004–2008" 7 "2009–2013" 9 "2014–2018"
label value yearcat yearcat

gen firstyears=0
replace firstyears=1 if year==1999 | year==2000
label var firstyears "1999-2000"
label define firstyears 1 "Yes" 0 "No, other yrs"
label value firstyears firstyears

gen midyears=0
replace midyears=1 if year==2008 | year==2009
label var midyears "2008-2009"
label define midyears 1 "Yes" 0 "No, other yrs"
label value midyears midyears
 
gen lastyears=0
replace lastyears=1 if year==2017 | year==2018
label var lastyears "2017-2018"
label define lastyears 1 "Yes" 0 "No, other yrs"
label value lastyears lastyears

/*

	4.2 Single year indicators

*/ 

forvalues i=1999/2018 {
	gen year_`i'=0
	replace year_`i'=1 if year==`i'	
	}

/*

	4.3 Region indicators

*/ 

gen neast=0
replace neast=1 if region==1

gen midwest=0
replace midwest=1 if region==2

gen south=0
replace south=1 if region==3

gen west=0
replace west=1 if region==4


/*******************************************************************************
********************************************************************************	

5. Exclusions, centering, and saving file

********************************************************************************	
*******************************************************************************/

drop if hispyn>6 | racea>=900

drop if race==7

drop if delay_any==.


mcenter age
mcenter neast
mcenter midwest
mcenter south
mcenter west
mcenter female  

compress

save nonfinancial_barriers.dta, replace

