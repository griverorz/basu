setOldClass("power.htest")
asJSON <- jsonlite:::asJSON
setMethod('asJSON', 'power.htest', function(x, ...) jsonlite:::asJSON(unclass(x), ...))
