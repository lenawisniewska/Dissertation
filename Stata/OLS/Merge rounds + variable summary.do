//renaming variables so they're consistent across the two datasets, dropping all other variables 

use "/Users/lenawisniewska/Desktop/Diss/OLS data/R7.dta", clear

decode COUNTRY, generate(COUNTRY_label)

generate Round = 7

//rename Q101 GENDER

rename Q93 ELECTRICITY

rename Q94 EMPLOYMENT

rename Q97 EDUCATION

rename Q8A NOFOOD

rename Q8B NOWATER

rename Q8C NOMEDICINE

rename Q8D NOFUEL

rename Q8E NOINCOME

rename Q1 AGE

rename Q96B occupation

tostring RESPNO, replace
tostring Round, replace

generate RESPNO_Round = RESPNO + "_" + Round

list RESPNO Round RESPNO_Round if _n <= 10

rename EA_SVC_D cell

keep RESPNO RESPNO_Round COUNTRY COUNTRY_label URBRUR GENDER DATEINTR Round ELECTRICITY EMPLOYMENT EDUCATION NOFOOD NOWATER NOMEDICINE NOFUEL NOINCOME AGE cell occupation

save "/Users/lenawisniewska/Desktop/Diss/OLS data/R7_droppedvars.dta", replace

//repeating for R6 dataset

use "/Users/lenawisniewska/Desktop/Diss/OLS data/R6.dta", clear

decode COUNTRY, generate(COUNTRY_label)

//generate Round = 6

//rename Q101 GENDER

//rename Q94 ELECTRICITY

//rename Q95 EMPLOYMENT

//rename Q97 EDUCATION

//rename Q8A NOFOOD

//rename Q8B NOWATER

//rename Q8C NOMEDICINE

//rename Q8D NOFUEL

//rename Q8E NOINCOME

rename Q1 AGE

rename Q96A occupation

tostring RESPNO, replace
tostring Round, replace

generate RESPNO_Round = RESPNO + "_" + Round

list RESPNO Round RESPNO_Round if _n <= 10

rename EA_SVC_D cell

keep RESPNO RESPNO_Round COUNTRY COUNTRY_label URBRUR GENDER DATEINTR Round ELECTRICITY EMPLOYMENT EDUCATION NOFOOD NOWATER NOMEDICINE NOFUEL NOINCOME AGE cell occupation

save "/Users/lenawisniewska/Desktop/Diss/OLS data/R6_droppedvars.dta", replace

//now merging:

use "/Users/lenawisniewska/Desktop/Diss/OLS data/R7_droppedvars.dta", clear

sort RESPNO_Round

merge 1:1 RESPNO_Round using "/Users/lenawisniewska/Desktop/Diss/OLS data/R6_droppedvars.dta"

save "merged_droppedvars.dta", replace

//now I can provide summary statistics for variables of interest in the merged datset
