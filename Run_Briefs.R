
# Loop over each country
for (country in countrynamet) {
  output_file <- paste0("brief_", country, ".pdf")
  rmarkdown::render(input = "HC_2page_design.Rmd", output_format = "pdf_document",
                    output_file = output_file, params = list(countrynamet = country))
}

