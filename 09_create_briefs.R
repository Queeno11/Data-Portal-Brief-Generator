library(rmarkdown)
library(pbapply)
library(utils)

path <- commandArgs(trailingOnly = TRUE)
print(path)
setwd(path)

#################################
### Set the folders

# Zip the last version of the briefs
files2zip <- dir('Briefs', full.names = TRUE)
zip(zipfile = 'Briefs/briefs_prev_version', files = files2zip)

# Delete the last version of the briefs (except the zip file)
files2delete <- list.files("Briefs", include.dirs = T, full.names = T, recursive = T)
print(files2delete)
files2delete <- files2delete[!files2delete %in% 'Briefs/briefs_prev_version.zip']
unlink(files2delete, recursive=TRUE)

# Create log folder
dir.create('Briefs/Logs')

#################################
### Run the briefs generator

# Run setup for database and functions
source("HC_2page_functions.R")
# Set progress bar
pb = txtProgressBar(min = 0, max = length(countrynamet), initial = 0, style=3) 

# Loop over each country with progress bar
for (i in 1:length(countrynamet)) {
    country <- countrynamet[i]
    wbcode <- countrycodes[i]
    
    output_folder <- file.path("Briefs", country) 
    output_file   <- file.path(output_folder, country) 
    dir.create(output_folder)
    
    ## Render Rmd to PDF
    suppressWarnings(
      capture.output(
        render(
          input = "D:/Laboral/World Bank/Data-Portal-Brief-Generator/HC_2page_design.Rmd", output_format="pdf_document", 
          keep_tex = TRUE, #keep_md=TRUE,
          output_file = output_file, 
          params = list(countrynamet = country),
          clean = TRUE,
          quiet = TRUE,
        )
      )
    )

    ## Move the log to briefs/Logs folder
    log_filename <- paste0(country, ".log")
    destination_path <- paste0("Briefs/Logs/", log_filename)

    # Move the file
    file.rename(log_filename, destination_path)
    
    # ## Copy the EPS graphs to the PDF folder
    # eps_filename <- paste0("p2_", wbcode, "_stages.eps")
    # eps_path <- paste0("Graphs/", eps_filename)
    # destination_path <- file.path(output_folder, eps_filename)
    
    # # Copy the file
    # file.copy(eps_path, destination_path)

    
  setTxtProgressBar(pb,i)
  
}

close(pb)