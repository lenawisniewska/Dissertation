use "/Users/lenawisniewska/Desktop/Diss/OLS data/R7.dta", replace

//seeing the total number of observations
count

//relabelling gender by text not number
//rename Q101 GENDER

//label define gender_lbl 1 male 2 female -1 missing

label values GENDER gender_lbl //use country_lbl labels for variable COUNTRY
	
tabulate GENDER	

tabout GENDER using "gender_tableR7.tex", replace style(tex) ///
    c(freq)	

//relabelling urban/rural by text not number

//label define urbrur_lbl 1 urban 2 rural 3 semiurban 460 periurban

label values URBRUR urbrur_lbl
	
tabulate URBRUR	

tabout URBRUR using "urbrur_tableR7.tex", replace style(tex) ///
    c(freq)	

//relabelling countries by text not number
//FIX THIS USING

label drop country_lbl

label define country_lbl ///
1 "Benin" 2 "Botswana" 3 "Burkina Faso" 4 "Cape Verde" 5 "Cameroon" 6 "Cote d'Ivoire" ///
7 "Eswatini" 8 "Gabon" 9 "Gambia" 10 "Ghana" 11 "Guinea" 12 "Kenya" ///
13 "Lesotho" 14 "Liberia" 15 "Madagascar" 16 "Malawi" 17 "Mali" 18 "Mauritius" ///
19 "Morocco" 20 "Mozambique" 21 "Namibia" 22 "Niger" 23 "Nigeria" ///
24 "São Tomé and Príncipe" 25 "Senegal" 26 "Sierra Leone" 27 "South Africa" ///
28 "Sudan" 29 "Tanzania" 30 "Togo" 31 "Tunisia" 32 "Uganda" ///
33 "Zambia" 34 "Zimbabwe"
 //mapping between numeric values and text labels 

label values COUNTRY country_lbl //use country_lbl labels for variable COUNTRY

tabulate COUNTRY

tabout COUNTRY using "country_tableR7.tex", replace style(tex) ///
    c(freq)
		
save "/Users/lenawisniewska/Desktop/Diss/OLS data/R7.dta", replace

