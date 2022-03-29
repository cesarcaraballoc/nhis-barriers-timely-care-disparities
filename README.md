# Trends in Racial and Ethnic Disparities in Barriers to Timely Medical Care Among US Adults, 1999 to 2018
We include here the code used to obtain the data presented in tables and figures in the study "Trends in Racial and Ethnic Disparities in Barriers to Timely Medical Care Among US Adults, 1999 to 2018". The study is available from https://doi.org/10.1101/2022.02.07.22270599 

Citation: Caraballo C, Ndumele CD, Roy B, Lu Y, Riley C, Herrin J, Krumholz HM. Trends in Racial and Ethnic Disparities in Barriers to Timely Medical Care Among US Adults, 1999 to 2018. medRxiv. 2022.02.07.22270599. doi: https://doi.org/10.1101/2022.02.07.22270599


## Replication File Read Me

In these files, we included the code used to obtain the data presented in tables and figures in the main paper and its supplemental material. We also included the dataset codebook. 

All the data used in this study are publicly available. We obtained the data from the Integrated Public Use Microdata Series website (https://nhis.ipums.org/nhis/). [1]

Below, we describe each of the Stata .do files. These .do files use the special bookmark comment –**#– to facilitate the inspection of its contents using Stata's Do-file Editor Navigation Control.

### preprocess.do
•	Describes the study sample creation and generation of variables of interest. 
•	Used for Figure S1.

### population_general_characteristics.do
•	Estimates the study population characteristics by race and ethnicity. 
•	Produces results for Table 1 and Table S1. 

### analysis.do*
•	Estimates the annual prevalence of barriers to timely medical care by race and ethnicity, along with its racial/ethnic differences, annualized rate of change, and absolute change from 1999 to 2018. 
•	Produces results for Table 2, Tables S2-S8, Figures 1-3, and Figures S2-S8.

### figures.do*
•	Produces Figures 1-3 and Figures S2-S8.     


* This .do file uses the special bookmark comment **# to facilitate the inspection of its contents using Stata's Do-file Editor Navigation Control.

### Reference: 
1. Lynn A. Blewett, Julia A. Rivera Drew, Miriam L. King and Kari C.W. Williams. IPUMS Health Surveys: National Health Interview Survey, Version 6.4 [dataset]. Minneapolis, MN: IPUMS, 2019. https://doi.org/10.18128/D070.V6.4 
