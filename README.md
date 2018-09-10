# Basu

`Basu` is an interactive sample size/power calculator that exposes the
[`pwr`](https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html)
package through a customized vectorization. `Basu` is designed to run on OpenCPU
using a flexdashboard frontend. In the current version, `Basu` exposes the
functions:

* `pwr.t.test`
* `pwr.p.test`
* `pwr.2p.test`
* `pwr.r.test`

Notice that `Basu` provides a customized vectorization to the original
`pwr_1.2-2` package through the functions `vector_pwr` and the `v.*` equivalents
to the `pwr.*` functions from the `pwr` package. `vector_pwr` correctly
vectorizes the calculations of `pwr` (the CRAN version of `pwr` is not
vectorized but does not error out if the user passes a vector instead of a
scalar, as expected). The vectorized functions from the `basu` R package are
prefixed by `v.[pwr function]` (for instance, `v.pwr.p.test` to vectorize `pwr.p.test`). 

`basu` also extends the `pwr` package to admit an additional argument `deff` for
the design effect. The design effect only affects the calculation of sample
sizes and it is ignored for all other purposes.

The script `setup.R` installs the dependencies, including `Basu` itself
(uninstalling it if necessary) and runs a local OpenCPU server. The dashboard
can also be run as a Docker container.

```sh
docker build -t basu .
docker run -p 5656:5656 basu
```
