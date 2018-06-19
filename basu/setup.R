## index build process:
rmarkdown::render(input="index.Rmd", output_file="inst/www/index.html")

## Package build process:
devtools::uninstall()
devtools::build(".")
devtools::install(".")

opencpu:::ocpu_start_server()
browseURL("http://localhost:5656/ocpu/library/basu/www/index.html")
