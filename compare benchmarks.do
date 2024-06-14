* Compare benchmarks
use "C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator\Data\Data_Output\benchmarking_19_ene_2024_all.dta", clear

collapse (count) value, by(code year gender)
keep if year==2021|year==2022
reshape wide value, i(code gender) j(year)