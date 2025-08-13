library(rmarkdown)
library(pbapply)
library(utils)
library(here)
library(tinytex)

# print(path)
setwd("/Users/florenciaruiz/Downloads/Data-Portal-Brief-Generator")
extra_text <- ""
dir.create('Briefs')


#################################
### Set the folders

# Zip the last version of the briefs
# files2zip <- dir('Briefs', full.names = TRUE)
# zip(zipfile = 'Briefs/briefs_prev_version', files = files2zip)

# # Delete the last version of the briefs (except the zip file)
files2delete <- list.files("Briefs", include.dirs = T, full.names = T, recursive = T)
print(files2delete)
files2delete <- files2delete[!files2delete %in% 'Briefs/briefs_prev_version.zip']
unlink(files2delete, recursive=TRUE)

# Create log folder
dir.create('Briefs/Logs')
dir.create('Briefs/For Print')


#################################
### Run the briefs generator

# Run setup for database and functions
source("HC_2page_functions.R")

# # #### FILTER ##########################
# # Create a vector of the values you want to filter
# selected_wbcodes <- c("AUS", "ARG", "AFG", "ETH", "CAN", "JPN")
# x <- subset(x, wbcode %in% selected_wbcodes)
# countrynamet <- x[["wbcountryname"]]
# countrycodes <- x[["wbcode"]]
# # #####################################

# Set progress bar
pb = txtProgressBar(min = 0, max = length(countrynamet), initial = 0, style=3) 
error_countries <- c()

# Flor:
# En macOS con MacTeX, este es el symlink correcto
Sys.setenv(PATH = paste("/Library/TeX/texbin", Sys.getenv("PATH"), sep=":"))
# Verifica:
system("which pdflatex")
system("pdflatex --version")  # debería decir TeX Live 2025
# ----

# Loop over each country with progress bar
for (i in 1:length(countrynamet)) {
    country <- countrynamet[i]
    wbcode <- countrycodes[i]
    
    tryCatch({
      
      output_folder <- file.path("/Users/florenciaruiz/Downloads/Data-Portal-Brief-Generator/Briefs", country) 
      output_file   <- file.path(output_folder, paste0(country, extra_text)) 
      
      dir.create(output_folder)
      
      # Copy necessary files to output directory
      file.copy(from = file.path("Graphs", paste0("p2_", wbcode, "_stages", extra_text, ".png")),
                to = "/Users/florenciaruiz/Downloads/Data-Portal-Brief-Generator",
                overwrite = TRUE)
  
      ## Render Rmd to PDF
      render(
        input = "/Users/florenciaruiz/Downloads/Data-Portal-Brief-Generator/HC_1page_design.Rmd",
        output_format="pdf_document", #keep_tex= TRUE, #keep_md=TRUE,
        output_file = output_file, 
        params = list(countrynamet = country),
        clean = FALSE,
        quiet = TRUE,
      )
  
      
      # Remove files
      file.remove(file.path("/Users/florenciaruiz/Downloads/Data-Portal-Brief-Generator", paste0("p2_", wbcode, "_stages", extra_text, ".jpg")))
  
      ## Move the log to briefs/Logs folder
      log_filename <- paste0(country, extra_text, ".log")
      destination_path <- paste0("Briefs/Logs/", log_filename)
  
      # Move the file
      file.rename(log_filename, destination_path)
      
    }, error = function(e) {
      # Error handling code
      cat("\nError occurred for country:", country, "\n")
      cat("Error message:", conditionMessage(e), "\n")
      # Append the country to the error_countries vector
      error_countries <<- c(error_countries, country)
    })
    
    setTxtProgressBar(pb,i)
  
}

close(pb)
print("All briefs created!")

# Check if there were any errors
if (length(error_countries) > 0) {
  cat("\nErrors occurred for the following countries:\n")
  print(error_countries)
} else {
  cat("\nAll countries processed successfully!\n")
}

