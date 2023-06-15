
# Loop over each country
for (country in countrynamet) {
  output_file <- paste0("brief_", country, ".pdf")
  rmarkdown::render(input = "AM_2023_HC.Rmd", output_format = "pdf_document",
                    output_file = output_file, params = list(countrynamet = country))
}

