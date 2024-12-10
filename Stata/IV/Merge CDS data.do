import delimited "/Users/lenawisniewska/Desktop/Diss/IV data/2_metre_temperature_2014_to_2018.csv", clear
save "/Users/lenawisniewska/Desktop/Diss/IV data/temperature.dta", replace

import delimited "/Users/lenawisniewska/Desktop/Diss/IV data/mean_total_precipitation_rate_2014_to_2018.csv", clear
save "/Users/lenawisniewska/Desktop/Diss/IV data/precipitation.dta", replace

import delimited "/Users/lenawisniewska/Desktop/Diss/IV data/convective_available_potential_energy_2014_to_2018", clear
save "/Users/lenawisniewska/Desktop/Diss/IV data/CAPE.dta", replace

//finding year averages for temperature
use "/Users/lenawisniewska/Desktop/Diss/IV data/temperature.dta", clear
rename metretemperature temperature
generate str_longitude = string(longitude)
generate str_latitude = string(latitude)
generate longitude_latitude = str_longitude + "," + str_latitude
collapse (mean) avyrtemp = temperature, by(longitude_latitude year)
save "average_temperature_by_id_year.dta", replace

use "average_temperature_by_id_year.dta", clear
split longitude_latitude, parse(,) gen(part)
rename part1 longitude
rename part2 latitude
destring longitude, replace
destring latitude, replace
generate str_year = string(year)
generate id = longitude_latitude + "," + str_year
save "/Users/lenawisniewska/Desktop/Diss/IV data/temperatureFINAL.dta", replace

//same for precipitation
use "/Users/lenawisniewska/Desktop/Diss/IV data/precipitation.dta", clear
rename meantotalprecipitationrate precipitation
generate str_longitude = string(longitude)
generate str_latitude = string(latitude)
generate longitude_latitude = str_longitude + "," + str_latitude
collapse (mean) avyrprecip = precipitation, by(longitude_latitude year)
save "average_precipitation_by_id_year.dta", replace

use "average_precipitation_by_id_year.dta", clear
split longitude_latitude, parse(,) gen(part)
rename part1 longitude
rename part2 latitude
destring longitude, replace
destring latitude, replace
generate str_year = string(year)
generate id = longitude_latitude + "," + str_year
save "/Users/lenawisniewska/Desktop/Diss/IV data/precipitationFINAL.dta", replace

//same for CAPE
use "/Users/lenawisniewska/Desktop/Diss/IV data/CAPE.dta", clear
rename convectiveavailablepotentialener CAPE
generate str_longitude = string(longitude)
generate str_latitude = string(latitude)
generate longitude_latitude = str_longitude + "," + str_latitude
collapse (mean) avyrCAPE = CAPE, by(longitude_latitude year)
save "average_CAPE_by_id_year.dta", replace

use "average_CAPE_by_id_year.dta", clear
split longitude_latitude, parse(,) gen(part)
rename part1 longitude
rename part2 latitude
destring longitude, replace
destring latitude, replace
generate str_year = string(year)
generate id = longitude_latitude + "," + str_year
save "/Users/lenawisniewska/Desktop/Diss/IV data/CAPEFINAL.dta", replace

//mergining the 3
use "/Users/lenawisniewska/Desktop/Diss/IV data/temperatureFINAL.dta", clear
local files "precipitationFINAL.dta CAPEFINAL.dta"
foreach file in `files' {
    merge 1:1 id using "/Users/lenawisniewska/Desktop/Diss/IV data/`file'", force    
     drop _merge
}

generate CAPE_p = avyrCAPE*avyrprecip
save "CDSfinal.dta", replace
