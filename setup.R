r <- getOption('repos')
r['CRAN'] <- 'http://cran.us.r-project.org'
options(repos = r)

install.packages(c("rmarkdown",
                   "pwr",
                   "htmltools",
                   "flexdashboard",
                   "opencpu"), dependencies=TRUE)

rmarkdown::render(input="index.Rmd", output_file="basu/inst/www/index.html")

if ("basu" %in% rownames(installed.packages())) {
    devtools::uninstall("basu")
}

devtools::build("./basu")
devtools::install("./basu")

opencpu:::ocpu_start_server()
browseURL("http://localhost:5656/ocpu/library/basu/www/index.html")
