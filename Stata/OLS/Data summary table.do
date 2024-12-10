use "merged_droppedvars_OLS.dta", clear

generate No_educ = 0
replace No_educ = 1 if edu == 1

generate Informal = 0
replace Informal = 1 if edu == 2

generate Primary = 0
replace Primary = 1 if edu == 3

generate Secondary = 0
replace Secondary = 1 if edu == 4

generate Tertiary = 0
replace Tertiary = 1 if edu == 5

summarize No_educ
summarize Informal
summarize Primary
summarize Secondary
summarize Tertiary

* Select a few variables for the table
keep employ outage No_educ Informal Primary Secondary Tertiary age female pct_cov_234G

* Generate summary statistics using esttab
estpost summarize employ outage No_educ Informal Primary Secondary Tertiary age female pct_cov_234G

* Produce the table
esttab using summary_stats.rtf, ///
    cells("mean sd min max count") ///
    label ///
    title("Afrobarometer") ///
    alignment(c) ///
    varwidth(25) ///
    nomtitle replace
		
save "merged_droppedvars_vartable.dta", replace
