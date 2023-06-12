# Data Portal & Brief Generator

## Description

Codes for creating WB HCP Data Portal and WB HCP Briefs. Most data is directly downloaded from relevant International organizations' portals, except from UNICEF that is accesed via API. Data_Raw contains dowloaded data requiered to run everything, without it, you wont be able to run the code.

## Getting Started

### Dependencies

* Stata 17 or higher
* Python 3 or higher
* R???
* Pandas
* [Pandasdmx](https://pandasdmx.readthedocs.io/en/v1.0/)

### Set up

Go to 00_run_all.do in root folder and check the set-up section. These options are available:

* Set the correct *path* of the repository (required)
* Change the *date* for the current version (recomended)
* Add some *extra* name for the output, useful for testing changes (optional). 

With this changes, the final output will be:
{path}\Data\Data_Output\complete_series_wmd_{date}_{extra}

### Executing program

00_run_all.do executes everything you need for creating the Data Portal Dataset + Briefs. You can either mute the sections of Data Portal or Briefs in order to run only a subsection of the code:

* Scripts 01 to 04 creates the Data Portal Dataset (complete_series_wmd)
* Scripts 05 to 08 generates the Dataset required for creating the Briefs
* Scripts 08 to 10 creates the Briefs PDFs

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

* 0.1
    * Initial Release

<!-- ## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details -->

## Relevant links

* [World Bank Human Capital Project](https://www.worldbank.org/en/publication/human-capital)