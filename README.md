<!-- README.md is generated from README.Rmd. Please edit that file -->
basu
====

`Basu` is an interactive sample size calculator that exposes a customized version of \[`pwr`\] (<https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html>) package. `Basu` is designed to allow vectorized arguments in calculations, and eventually will be designed to run on OpenCPU using a flexdashboard frontend. In the current version (0.2), Basu customizes the vectorized functions:

-   `v.pwr.t.test`
-   `v.pwr.p.test`
-   `v.pwr.2p.test`
-   `v.pwr.r.test`

which correspend functions of the `pwr_1.2-2` package:

-   `pwr.t.test`
-   `pwr.p.test`
-   `pwr.2p.test`
-   `pwr.r.test`

In addition, the functions `v.pwr.t.test`, `v.pwr.p.test`, and `v.pwr.2p.test` have been customized to take an extra parameter `deff` (design effect). This extra parameter is used *exclusively* in the calculation of the effective sample estimate. It is ignored in all other calculations.

Example
-------

The function could be used:

``` r
v.pwr.t.test(n = c(100, 200),
             d = c(0.2, 0.5),
             sig.level = 0.05,
             type = c("two.sample"),
             alternative = c("two.sided"),
             deff = 1)
```

The function will `expand.grid` `n` and `d` arguments in the combindation of:

1.  `n` = 100, `d` = 0.2, in calculating `power`
2.  `n` = 200, `d` = 0.2, in calculating `power`
3.  `n` = 100, `d` = 0.5, in calculating `power`
4.  `n` = 100, `d` = 0.5, in calculating `power`

### output

The output of the function is a list of sublists that contain all the value(s) of the arguments augmented with `method` and `NOTE` elements. The argument(s) are assigned multiple values, in this case, `n` and `d` are collected in a sequence of combination outputted from `expand.grid` function, which means:

    #> $n
    #>   1   2   3   4 
    #> 100 200 100 200
    #> $d
    #>   1   2   3   4 
    #> 0.2 0.2 0.5 0.5

The argument(s) are outputted multiple values, in this case, `power` is collected in the sequence of `n` and `d` combination from `expand.grid` function, which means:

    #> $power
    #>         1         2         3         4 
    #> 0.2906459 0.5140816 0.9404272 0.9987689

The argument(s) are inputted single value, in this case, `sig.level`, `alternative`, `deff` along with `method` and `note`, are outputted as:

    #> $sig.level
    #> [1] 0.05
    #> 
    #> $alternative
    #> [1] "two.sided"
    #> 
    #> $note
    #> [1] "n is number in *each* group"
    #> 
    #> $method
    #> [1] "Two-sample t test power calculation"
    #> 
    #> $deff
    #> [1] 1
