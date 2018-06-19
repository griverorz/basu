# Basu

TBD

To run:

```
docker run -p 5656:5656 basu
```

Note that the R package is a copy of the `pwr` package with an additional
function JSONize the `power.htest` class that is used as output of all the
functions.

```r
setOldClass("power.htest")
asJSON <- jsonlite:::asJSON
setMethod('asJSON', 'power.htest', function(x, ...) jsonlite:::asJSON(unclass(x), ...))
```
