cd "/Users/lenawisniewska/Desktop/Diss"

use "final data/regressions_35k.dta", clear

//ssc install estout

summarize avyrprecip
replace ln_tp = ln(12*avyrprecip*1000)

summarize ln_temperature
replace ln_temperature = ln(avyrtemp-273.15)
summarize ln_temperature

generate noeduc = 0
replace noeduc = 1 if education == 0
summarize noeduc

generate informal = 0
replace informal = 1 if education == 1
summarize informal

generate primary = 0
replace primary = 1 if education == 2 | education == 3
summarize primary

generate secondary = 0
replace secondary = 1 if  education == 4 | education == 5 
summarize secondary

generate tertiary = 0
replace tertiary = 1 if education == 6 | education == 7 | education == 8 | education == 9
summarize tertiary

estpost summarize employment outages_in_community_dummy outages_in_community_percentage ///
    noeduc informal primary secondary tertiary age female cell_PSU ln_temperature ln_tp loglight

* Export the summary statistics as a LaTeX table
esttab using "summary_stats.tex", replace ///
    cells("mean(fmt(%9.3f)) sd(fmt(%9.3f)) min(fmt(%g)) max(fmt(%g))") ///
    label nonotes ///
    title("Summary Statistics") ///
	alignment(c c c c c)
  
***********************
*    VISUALISATION    *
***********************

binscatter outages_in_community_dummy loglight, n(10) name(plot1, replace)
binscatter outages_in_community_percentage loglight, n(10) name(plot2, replace)
graph combine plot1 plot2, col(2) name(firststage, replace) xsize(10) ysize(5)
graph export "firststage_10.jpg", as(jpg) replace
