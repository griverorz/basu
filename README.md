# Basu

`Basu` is an interactive sample size calculator that exposed a customized
version of the
[`pwr`](https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html)
package. `Basu` is designed to run on OpenCPU using a flexdashboard frontend. In
the current version (0.1.1), `Basu` exposes the functions:

* `pwr.t.test`
* `pwr.p.test`
* `pwr.2p.test`
* `pwr.r.test`

Notice that `Basu` makes some changes to the original `pwr_1.2-2` package.
First, it provides an `asJSON` method to JSONize the output of the `power.htest`
class that is used as common output in `pwr`. This function is needed to
interact with OpenCPU. This is the relevant piece of code:

```r
setOldClass("power.htest")
asJSON <- jsonlite:::asJSON
setMethod('asJSON', 'power.htest', function(x, ...) jsonlite:::asJSON(unclass(x), ...))
```

Second, the functions `pwr.t.test`, `pwr.p.test`, and
`pwr.2p.test` have been customized to take an extra parameter `deff` (design
effect). This extra parameter is used _exclusively_ in the calculation of the
effective sample estimate. It is ignored in all other calculations. Finally,
`Basu` contains some basic prettification of the `pwr` (mainly, capitalizing
words in the output). 

The script `setup.R` installs the dependencies, including `Basu` itself
(uninstalling it if necessary) and runs a local OpenCPU server. It can also be
run as a Docker container.

```sh
docker build -t basu .
docker run -p 5656:5656 basu
```

