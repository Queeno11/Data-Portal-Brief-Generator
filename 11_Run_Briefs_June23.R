library(rmarkdown)

setwd('D:/Laboral/World Bank/Data-Portal-Brief-Generator')

# Run setup for database and functions
source("09_HC_2page_Func.R")

# Loop over each country
for (i in seq_along(countrynamet)) {
  country <- countrynamet[i]
  wbcode <- countrycodes[i]
  
  output_folder <- file.path("Briefs", country) 
  output_file   <- file.path(output_folder, country) 
  dir.create(output_folder)
  
  ## Render Rmd to PDF
  render(
    input = "D:/Laboral/World Bank/Data-Portal-Brief-Generator/10_AM_june23tex.Rmd", output_format="pdf_document", #(keep_md=TRUE, keep_tex=TRUE),
     output_file = output_file, 
     params = list(countrynamet = country),
     clean = TRUE
   )

  ## Move the log to briefs/Logs folder
  log_filename <- paste0(country, ".log")
  destination_path <- paste0("Briefs/Logs/", log_filename)
  
  # Move the file
  file.rename(log_filename, destination_path)
  
  ## Move the EPS graphs to the PDF folder
  eps_filename <- paste0("p2_", wbcode, "_stages.eps")
  eps_path <- paste0("Graphs/", eps_filename)
  destination_path <- file.path(output_folder, eps_filename)
  
  # Move the file
  file.rename(eps_path, destination_path)
  
}
warnings()
help(render)