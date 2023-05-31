*------------------------------------------------------------------------------*
*					 RUN ALL - SCRIPT for FULL PROCESSING					   
*------------------------------------------------------------------------------*
cls
set more off
*--------------------------------Directories-------------------------------*
global root "C:\Users\Nico\Documents\World Bank\Data Portal\Data Portal & Brief Generator"
*global root "C:\Users\llohi\Documents\WB\Data Portal"
*global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\"


*----------------------------------Globals---------------------------------*
cd "${root}"
global portal    	  	"$root\Data"
global data_raw 	  	"$portal\Data_Raw"
global data_processed 	"$portal\Data_Processed"

global date			  	"24_may_2023" // Date when the full process is run
global extra			""			  // Placeholder for testing, just add "_test" or something like that to avoid overwrite db

*----------------------------------Scripts---------------------------------*

** 01 - Collects indicators via APIs
// python script "$root\01_API_access.py"

** 01 - Processes all raw indicators and generates "$data_processed\complete_series_wmetadata"
// do "$root\02_clean_data"

** 02 - Adds Metadata for all indicators
do "$root\03_clean_metadata"

** xx - Missing data reports
do "$root\missing_data"