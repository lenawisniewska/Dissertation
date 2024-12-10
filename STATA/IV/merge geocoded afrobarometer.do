clear

//ROUND 6: import files, merge into 1, keep only some variables 

import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r6.xlsx", firstrow
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r6.dta", replace

clear
import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r6.xlsx", firstrow
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r6.dta", replace

clear
import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r6.xlsx", firstrow
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r6.dta", replace

clear
import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r6.xlsx", firstrow
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r6.dta", replace

clear
import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r6.xlsx", firstrow
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r6.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r6.dta", clear
tostring respno, replace
generate Round = 6
tostring Round, replace
generate respno_Round = respno + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r6.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r6.dta", clear
tostring respno, replace
generate Round = 6
tostring Round, replace
generate respno_Round = respno + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r6.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r6.dta", clear
tostring respno, replace
generate Round = 6
tostring Round, replace
generate respno_Round = respno + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r6.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r6.dta", clear
tostring respno, replace
generate Round = 6
tostring Round, replace
generate respno_Round = respno + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r6.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r6.dta", clear
tostring respno, replace
generate Round = 6
tostring Round, replace
generate respno_Round = respno + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r6.dta", replace

* Start with the first file
use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r6.dta", clear

* List of other files to merge
local files "MOZ_r6.dta TAN_r6.dta SAF_r6.dta NIG_r6.dta"

* Loop through files and merge
foreach file in `files' {
    merge 1:1 respno_Round using "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/`file'", force
    
     drop _merge
}

save "merged_R6.dta", replace

use "merged_R6.dta", clear
rename q101 gender
rename q94 electricity
rename q95 employment
rename q97 education
rename q1 age
rename q96a occupation
rename ea_svc_d cell
describe dateintr
gen year = year(dateintr)  // Extract the year
summarize year
keep respno country Round respno_Round gender electricity employment education age cell eanumb year latitude longitude
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/merge_r6_dropped.dta", replace

//NOW REPEAT FOR ROUND 7
//clear
//import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r7.xlsx", firstrow
//save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r7.dta", replace

//clear
//import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r7.xlsx", firstrow
//save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r7.dta", replace

//clear
//import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r7.xlsx", firstrow
//save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r7.dta", replace

//clear
//import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r7.xlsx", firstrow
//save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r7.dta", replace

//clear
//import excel "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r7.xlsx", firstrow
//save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r7.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r7.dta", clear
tostring RESPNO, replace
//generate Round = 7
//generate country = 24
tostring Round, replace
//generate respno_Round = RESPNO + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/NIG_r7.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r7.dta", clear
tostring RESPNO, replace
//generate Round = 7
//generate country = 11
tostring Round, replace
//generate respno_Round = RESPNO + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r7.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r7.dta", clear
tostring RESPNO, replace
//generate Round = 7
//generate country = 21
tostring Round, replace
generate respno_Round = RESPNO + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/MOZ_r7.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r7.dta", clear
tostring RESPNO, replace
//generate Round = 7
//generate country = 31
tostring Round, replace
//generate respno_Round = RESPNO + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/TAN_r7.dta", replace

use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r7.dta", clear
tostring RESPNO, replace
//generate Round = 7
//generate country = 28
tostring Round, replace
//generate respno_Round = RESPNO + "_" + Round
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/SAF_r7.dta", replace

//MERGE:
use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/GHA_r7.dta", clear
local files "MOZ_r7.dta TAN_r7.dta SAF_r7.dta NIG_r7.dta"
foreach file in `files' {
    merge 1:1 respno_Round using "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/`file'", force    
     drop _merge
}
save "merged_R7.dta", replace

use "merged_R7.dta", clear
rename Q101 gender
rename Q93 electricity
rename Q94 employment
rename Q97 education
rename Q1 age
rename Q96B occupation
rename EA_SVC_D cell
rename RESPNO respno
rename EANUMB eanumb
rename DATEINTR dateintr
rename EA_GPS_LA latitude
destring latitude, replace
rename EA_GPS_LO longitude
destring longitude, replace
gen dateintr_date = date(dateintr, "MDY")  // Convert to Stata date format
format dateintr_date %td                  // Apply Stata date format
gen year = year(dateintr_date)  // Extract the year
summarize year
keep respno country Round respno_Round gender electricity employment education age cell eanumb year latitude longitude
save "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/merge_r7_dropped.dta", replace

//NOW MERGING BOTH DATASETS
use "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/merge_r6_dropped.dta", clear
sort respno_Round
merge 1:1 respno_Round using "/Users/lenawisniewska/Desktop/Diss/IV data/afrobarometer data/merge_r7_dropped.dta"
save "finalafrobarometerIV.dta", replace

use "finalafrobarometerIV.dta", clear
summarize latitude
summarize longitude
levelsof year
