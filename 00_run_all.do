*------------------------------------------------------------------------------*
*					 RUN ALL - SCRIPT for FULL PROCESSING					   
*------------------------------------------------------------------------------*
cls
set more off
*--------------------------------Directories-------------------------------*
global root "D:\Laboral\World Bank\Data-Portal-Brief-Generator"
*global root "C:\Users\llohi\Documents\WB\Data Portal"
*global root "C:\Users\Jessie\Documents\Meli\Banco Mundial\HC and Climate Change\Data Portal\"

*----------------------------------Globals---------------------------------*
cd "${root}"
global portal    	  	"$root\Data"                
global data_raw 	  	"$portal\Data_Raw"          // Data from APIs, manual downloads, etc. DO NOT DELETE.         
global data_processed 	"$portal\Data_Processed"    // Intermediate data generated by the scripts
global data_output	 	"$portal\Data_Output"       // Outputs generated by the sctipts to be used for Portal

global date			  	"08_jun_2023" // Date when the full process is run
global extra			""			  // Placeholder for testing, just add "_test" or something like that to avoid overwrite db

*-------------------------------Create Folders-------------------------------*
foreach path in "$data_raw" "$data_processed" "$data_output" "$data_processed\Country codes\" {
    display "`path'"
    capture local list: dir "`path'" dir "*" // Finds all (*) dirs matching the local path
    display _rc
    if _rc!=0 shell mkdir "`path'"
}

*----------------------------------Scripts---------------------------------*
** 01 - Collects indicators via APIs
// python script "$root\01_API_access.py"

** 02 - Processes all raw indicators and generates "$data_processed\complete_series_wmetadata"
do "$root\02_clean_data"

** 03 - Adds Metadata for all indicators
// do "$root\03_clean_metadata"

** 04 - Missing data reports
// do "$root\04_missing_data"