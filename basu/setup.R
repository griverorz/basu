r <- getOption('repos')
r['CRAN'] <- 'http://cran.us.r-project.org'
options(repos = r)

install.packages(c("rmarkdown",
                   "htmltools",
                   "flexdashboard"))

rmarkdown::render(input="index.Rmd", output_file="inst/www/index.html")

## devtools::uninstall()
devtools::build(".")
devtools::install(".")

opencpu:::ocpu_start_server()
browseURL("http://localhost:5656/ocpu/library/basu/www/index.html")
