
#example <- c("Afghanistan", "Argentina", "Australia", "Spain", "Iceland")
example <- c("Afghanistan")
# Loop over each country
for (country in example) {
  output_file <- paste0("Example_",country,".pdf")
  rmarkdown::render(input = "HC_2page_design.Rmd", output_format = "pdf_document",
                    output_file = output_file, params = list(countrynamet = country))
}


