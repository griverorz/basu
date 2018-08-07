#' Vectorizes power calculations for correlation test.
#'
#' \code {v.pwr.r.test} computes power of test or determine paramaters to obtain
#' target power. It allows up to 2 vectorize arguments.
#' @section Warning: The function only takes up to 2 vectorize arguments.
#'
#' @param r Linear correlation coefficient. Could input a single numerical value or a vector of
#'   values, applies to all parameters.
#' @param n Number of observations.
#' @param sig.level Significant level.
#' @param power Power of test.
#' @param alternative A character string specifying the alternative hypothesis.
#'   Must be one of "two.sided" (default), "greater" or "less".
#' @return A list of sublists contain values(s) of the arguments augmented with
#'   'method' and 'NOTE' elements. The argument(s) are assigned/computed
#'   multiple values will be returned in a sequence of expanding combination,
#'   while the argument(s) inputted single value will be returned only one
#'   single value.
#' @export
v.pwr.r.test <- function(n = NULL,
                         r = NULL,
                         sig.level = 0.05,
                         power = NULL,
                         alternative = c("two.sided", "less","greater")){
    argnames <- names(as.list(match.call()))[-1]
    args <- sapply(argnames, function(x) get(x), simplify = FALSE)
    if (sum(unlist(lapply(args , function(x) length(x) != 1))) > 2)
        stop("only enter multiple values of up to 2 arguments")
    newargs <- expand.grid(args, stringsAsFactors = FALSE)
    newargs$deff <- NULL
    out <- lapply(split(newargs, seq(nrow(newargs))),
                      function(x) do.call(pwr::pwr.r.test,x))
    out <- lapply(out, function(x) structure(unclass(x)))
    out <- do.call(Map, c(c, out))
    out <- lapply(out, function(x)
        if(length(unique(x)) == 1) {x <- unique(x)}
        else {x <- x})
    return(out)
    }
