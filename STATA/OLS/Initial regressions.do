use "merged_droppedvars.dta", clear

//ssc install reghdfe
//ssc install ftools

tabulate COUNTRY_label

keep if COUNTRY_label == "Botswana" | COUNTRY_label == "Burkina Faso" | COUNTRY_label == "Cameroon" | ///
COUNTRY_label == "Cote d'Ivoire" | COUNTRY_label == "Cape Verde" | COUNTRY_label == "Gabon" | ///
COUNTRY_label == "Gambia" | COUNTRY_label == "Ghana" | COUNTRY_label == "Guinea" | ///
COUNTRY_label == "Lesotho" | COUNTRY_label == "Liberia" | COUNTRY_label == "Madagascar" | ///
COUNTRY_label == "Malawi" | COUNTRY_label == "Mauritius" | COUNTRY_label == "Mali" | ///
COUNTRY_label == "Mozambique" | COUNTRY_label == "Namibia" | COUNTRY_label == "Niger" | ///
COUNTRY_label == "Nigeria" | COUNTRY_label == "Senegal" | COUNTRY_label == "Sierra Leone" | ///
COUNTRY_label == "South Africa" | COUNTRY_label == "Swaziland" | COUNTRY_label == "Zambia" | ///
COUNTRY_label == "Zimbabwe"

tabulate COUNTRY_label

save "OLSdata.dta", replace

use "OLSdata.dta", clear

tabulate EMPLOYMENT

generate employ = .
replace employ = 1 if EMPLOYMENT == 2 | EMPLOYMENT == 3
replace employ = 0 if EMPLOYMENT == 1
replace employ = . if inlist(EMPLOYMENT, -1, 98, 8, 9, 0)

replace AGE = . if inlist(AGE, 999, 998, -1, 98)

generate outage = .
replace outage = 1 if ELECTRICITY == 0 | ELECTRICITY == 1 | ELECTRICITY == 2 | ELECTRICITY == 3 | ELECTRICITY == 4
replace outage = 0 if ELECTRICITY == 5
replace outage = . if inlist(ELECTRICITY, -1, 98, 9)

generate unskill = .
replace unskill = 1 if occupation == 3 | occupation == 4 | occupation == 5 | occupation == 6 
replace unskill = 0 if occupation == 7 | occupation == 8 | occupation == 9 | occupation == 10 | occupation == 11 | occupation == 12

generate female = 1
replace female = 0 if GENDER == 1

rename AGE age

generate agesq = age^2

generate edu = .
replace edu = 1 if EDUCATION == 0 
replace edu = 2 if EDUCATION == 1
replace edu = 3 if EDUCATION == 2 | EDUCATION == 3
replace edu = 4 if EDUCATION == 4 | EDUCATION == 5
replace edu = 5 if EDUCATION == 6 | EDUCATION == 7 | EDUCATION == 8
replace edu = . if EDUCATION == 99 | EDUCATION == 98 | EDUCATION == -1
label define edu_labels 1 "No educ" 2 "Informal" 3 "Primary" 4 "Secondary" 5 "Teriary"
label values edu edu_labels

generate pct_cov_234G = .
replace pct_cov_234G = 1 if cell == 1
replace pct_cov_234G = 0 if cell == 0

rename COUNTRY ctycode

rename Round Afro_round 

gen date_var = date(DATEINTR, "MDY")  // Convert string to date
format date_var %td                   // Apply Stata date format
gen year = year(date_var)         // Extract year

gen outage_female = outage*female

reghdfe employ outage female age agesq pct_cov_234G, abs (edu ctycode year)


reghdfe employ outage female age agesq pct_cov_234G outage_female edu if unskill==0, abs (ctycode year)
reghdfe employ outage female age agesq pct_cov_234G outage_female edu if unskill==1, abs (ctycode year)



reghdfe employ outage female age agesq pct_cov_234G outage_female i.edu if unskill==1, abs (ctycode year)
reghdfe employ outage female age agesq pct_cov_234G outage_female i.edu if unskill==0, abs (ctycode year)


reghdfe employ outage female age agesq pct_cov_234G outage_female i.edu if unskill==0 & female==0, abs (ctycode year)


reghdfe employ outage female age agesq pct_cov_234G outage_female edu unskill, abs (ctycode year)

reghdfe employ outage female age agesq pct_cov_234G, abs (edu ctycode Afro_round)

reg employ outage female age agesq pct_cov_234G

save "merged_droppedvars_OLS.dta", replace
