library(rmarkdown)
# Loop over each country
for (country in countrynamet) {
  output_file <- paste0(country) 
  render(input = "AM_june23tex.Rmd", output_format="pdf_document"(keep_md=TRUE, keep_tex=TRUE),
         output_file = output_file, params = list(countrynamet = country))
}

