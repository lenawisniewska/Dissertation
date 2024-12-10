use "/Users/lenawisniewska/Desktop/Diss/OLS data/R6.dta", replace

//seeing the total number of observations
count

//seeing the number of observations per country
forval i = 1/36 {
    di "Count for COUNTRY == `i':"
    count if COUNTRY == `i'
}

//relabelling countries by text not number
//label define country_lbl 1 "Algeria" 2 "Benin" 3 "Botswana" 4 "Burkina Faso" 5 "Burundi" 6 "Cameroon" ///
//7 "Cape Verde" 8 "Cote d'Ivoire" 9 "Egypt" 10 "Gabon" 11 "Ghana" 12 "Guinea" 13 "Kenya" ///
//14 "Lesotho" 15 "Liberia" 16 "Madagascar" 17 "Malawi" 18 "Mali" 19 "Mauritius" 20 "Morocco" ///
//21 "Mozambique" 22 "Namibia" 23 "Niger" 24 "Nigeria" 25 "São Tomé and Príncipe" 26 "Senegal" ///
//27 "Sierra Leone" 28 "South Africa" 29 "Sudan" 30 "Swaziland" 31 "Tanzania" 32 "Togo" ///
//33 "Tunisia" 34 "Uganda" 35 "Zambia" 36 "Zimbabwe" //mapping between numeric values and text labels 

label values COUNTRY country_lbl //use country_lbl labels for variable COUNTRY

//creating LaTeX table with number of observations per country
tabulate COUNTRY

ssc install tabout

pwd

cd "/Users/lenawisniewska/Desktop/STATAoutput"

tabout COUNTRY using "country_table.tex", replace style(tex) ///
    c(freq)

//relabelling gender by text not number
//rename Q101 GENDER

//label define gender_lbl 1 male 2 female

label values GENDER gender_lbl //use country_lbl labels for variable COUNTRY
	
tabulate GENDER	

tabout GENDER using "gender_table.tex", replace style(tex) ///
    c(freq)	
	
//relabelling urban/rural by text not number

//label define urbrur_lbl 1 urban 2 rural 3 semiurban 460 periurban

label values URBRUR urbrur_lbl
	
tabulate URBRUR	

tabout URBRUR using "urbrur_table.tex", replace style(tex) ///
    c(freq)
	
save "/Users/lenawisniewska/Desktop/Diss/OLS data/R6.dta", replace
