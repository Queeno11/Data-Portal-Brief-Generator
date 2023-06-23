

<h1 align="center">Data Portal & Brief Generator</h1>

<p align="center"><i>Unnoficial repo for the WB HCP Data Portal & Two-page Briefs</i></p>

<div align="center">
<a href="https://www.worldbank.org/en/publication/human-capital">
    <img src="https://github.com/Queeno11/Data-Portal-Brief-Generator/blob/dbf0e3bf626258b10b32becce86424e36b5ade47/HCP_logo.png" alt="Logo" width="auto" height="100">
</a>
</div>


## Description
This repository contains the scripts for generating the WB HCP Data Portal dataset and generating the WB HCP Briefs (data and pdfs). Most of the data is obtained by directly downloading from the portals of relevant international organizations. However, data from UNICEF is accessed via API. 

The 'Data_Raw' directory contains the downloaded data required to run all the code. Please note that without this data, the code will not be executable.

## Getting Started

### Dependencies

* Stata 17 or higher
* Python 3.1 or higher
* Pandas  1.4.1 or higher
* [Pandasdmx 1.0](https://pandasdmx.readthedocs.io/en/v1.0/)
* R 4.3 or higher
* [R Markdown 2.22](https://rmarkdown.rstudio.com)

### Set up

Go to 00_run_all.do in root folder and check the set-up section. These options are available:

* Set the correct *path* of the repository (required)
* Change the *date* for the current version (recomended)
* Add some *extra* name for the output, useful for testing changes (optional). 

With this changes, the main outputs are: 

* The Data Portal Dataset: {path}\Data\Data_Output\complete_series_wmd_{date}_{extra}
* The two-page Briefs folder: {path}\Briefs (Note: full pipeline with R scripts not implemented yet)

### Executing program

00_run_all.do executes everything you need for creating the Data Portal Dataset and the Briefs pdfs. You can either mute the sections of Data Portal or Briefs in order to run only a subsection of the code:

* Scripts 01 to 04 creates the Data Portal Dataset (complete_series_wmd)
* Scripts 05 to 08 generates the Datasets and Charts required for creating the Briefs
* Scripts 09 to 11 creates the Briefs PDFs (not implemented yet in run_all, just run the file run_briefs.R)

## Adding Indicators to the Data Portal Database

In order to add new indicators to the Data Portal Database, it is requiered to incorporate their names and information into the metadata.xlsx file. This file serves as a centralized repository for essential details about the indicators, including their original names, Data Portal names, source information, and descriptions.

For indicators to be included also in the Briefs, it is required to include a rank for the indicator, and both the corresponing dimension (i.e. Education, Health or Labor) and the stage of life. It is also required to add the texts in the briefs_texts.xlsx.

## Code Structure - What each script does


![Pipeline of the code](https://github.com/Queeno11/Data-Portal-Brief-Generator/blob/aeb692939696927108f9c16c12c4db483081d2d4/UML%20long.png)


<!-- ## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
``` -->

<!-- ## Authors

Contributors names and contact info

Dominique Pizzie  
[@DomPizzie](https://twitter.com/dompizzie) -->

## Version History
* 0.3. jun-23-23
    * Added new indicators based on GP's comments.
    * New text generation algorithm (testing). The code 08_text_for_graphs was mostly rewritten to include the new indicators.
    * New file briefs_texts.xlsx that allows a unique sentence for each indicator presentation in the briefs.
    * Fixed bug that prevented graphs from generating when no data was available.
    * Full pipeline unification update: Locals after code 6 are now fully integrated, so there's no need for copy-paste. Still missing R section and pdfs heading and footer.
    * Fixed minor metadata bugs. It still needs to work on the integration of comp_series.dta, but probably will work on it when we integrate all inputs in APIs.
* 0.2. jun-16-23
    * Added many new indicators to briefs 
    * Automation of the indicator selection for the briefs by adding a ranking in the metadata file
    * Briefs indicator selection ranking based on both stage of life and dimension (before this, the selection was only made by stage of life) 
    * Data from UNICEF accesed via API
    * Unified metadata file
    * Comparison with previous indicator (~5 years before) for the Briefs
    * Full pipeline unification (not fully implemented)
* 0.1. may-23-23
    * Initial Release

<!-- ## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details -->

## Relevant links

* [World Bank Human Capital Project](https://www.worldbank.org/en/publication/human-capital)
* [Briefs and Data Portal](https://www.worldbank.org/en/publication/human-capital#Data)