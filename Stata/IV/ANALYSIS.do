use "final data/regressions_35k.dta", clear

********************
*    PREPARATION   *
********************

rename outages_in_community_percentage outages_in_community_per
winsor2 employment female age agesq loglight outages_in_community_per outages_in_community_dummy cell_PSU ln_temperature ln_tp, by(year country)
drop employment
rename employment_w employment
drop female
rename female_w female
drop age
rename age_w age
drop agesq
rename agesq_w agesq
drop loglight
rename loglight_w loglight
drop outages_in_community_per
rename outages_in_community_per_w outages_in_community_percentage
drop outages_in_community_dummy
rename outages_in_community_dummy_w outages_in_community_dummy
drop cell_PSU
rename cell_PSU_w cell_PSU
drop ln_temperature
rename ln_temperature_w ln_temperature
drop ln_tp
rename ln_tp_w ln_tp


*********************
*    FIRST STAGE    *
*********************

reghdfe outages_in_community_dummy loglight age  agesq  female  cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea)
estimates store fs1
reghdfe outages_in_community_percentage loglight age  agesq  female  cell_PSU ln_temperature ln_tp  [pw= withinwt],  abs(education country year) cl(uniqueea)
estimates store fs2

esttab fs1 fs2, star(* 0.10 ** 0.05 *** 0.01)

**************************
*    MAIN REGRESSIONS    *
**************************

***general***
//OLS
reghdfe employment outages_in_community_dummy age agesq  female  cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 5% level
estimates store c1a
//SECOND STAGE
ivreghdfe employment age  agesq  female  cell_PSU ln_temperature ln_tp (outages_in_community_dummy = loglight) [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 10% level
estimates store c1b
//REDUCED FORM
reghdfe employment loglight  age  agesq  female  cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 10% level
estimates store c1c

summarize employment

***gender interaction term***
//OLS
generate outages_female = outages_in_community_dummy * female
reghdfe employment outages_in_community_dummy outages_female age agesq  female  cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea) //effect for males negative, interaction term significant and positive
estimates store c2a
lincom outages_in_community_dummy + outages_female //effect for females is insignificant
//SECOND STAGE
generate loglight_female = loglight * female
ivreghdfe employment (outages_in_community_dummy outages_female = loglight loglight_female) female age  agesq cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea)
lincom outages_in_community_dummy + outages_female //effect for females is insignificant
estimates store c2b
//REDUCED FORM
reghdfe employment loglight loglight_female age  agesq  female  cell_PSU ln_temperature ln_tp [pw= withinwt],  abs(education country year) cl(uniqueea) //effect for males negative, interaction term significant and positive
estimates store c2c
lincom loglight + loglight_female //effect for females is insignificant

***male subsample***
//OLS
reghdfe employment outages_in_community_dummy age agesq  female  cell_PSU ln_temperature ln_tp if female == 0 [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 5% level
estimates store c3a
//SECOND STAGE
ivreghdfe employment age  agesq  female  cell_PSU ln_temperature ln_tp (outages_in_community_dummy = loglight) if female == 0  [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 10% level
estimates store c3b
//REDUCED FORM
reghdfe employment loglight  age  agesq  female  cell_PSU ln_temperature ln_tp if female == 0  [pw= withinwt],  abs(education country year) cl(uniqueea) //significant at 10% level
estimates store c3c
esttab c3a c3b c3c, star(* 0.10 ** 0.05 *** 0.01)

summarize employment if female == 0

***female subsample***
//OLS
reghdfe employment outages_in_community_dummy age agesq  female  cell_PSU ln_temperature ln_tp if female == 1 [pw= withinwt],  abs(education country year) cl(uniqueea)
estimates store c4a
//SECOND STAGE
ivreghdfe employment age  agesq  female  cell_PSU ln_temperature ln_tp (outages_in_community_dummy = loglight) if female == 1  [pw= withinwt],  abs(education country year) cl(uniqueea) 
estimates store c4b
//REDUCED FORM
reghdfe employment loglight  age  agesq  female  cell_PSU ln_temperature ln_tp if female == 1  [pw= withinwt],  abs(education country year) cl(uniqueea)
estimates store c4c
esttab c4a c4b c4c, star(* 0.10 ** 0.05 *** 0.01)

summarize employment if female == 1

esttab c1a c1b c1c c2a c2b c2c, star(* 0.10 ** 0.05 *** 0.01)
esttab c3a c3b c3c c4a c4b c4c, star(* 0.10 ** 0.05 *** 0.01)






