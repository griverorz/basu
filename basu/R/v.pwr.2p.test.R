#' Vectorizes power calculations for two proportions. (same sample size)
#'
#' \code {v.pwr.2p.test} computes power of test or determine paramaters to obtain
#' target power. It allows up to 2 vectorize arguments.
#' @section Warning: The function only takes up to 2 vectorize arguments.
#'
#' @param h Effect size, could input a single numerical value or a vector of
#'   values, applies to all parameters.
#' @param n Number of observations.
#' @param sig.level Significant level.
#' @param power Power of test.
#' @param alternative A character string specifying the alternative hypothesis.
#'   Must be one of "two.sided" (default), "greater" or "less".
#' @param deff Design effect.
#' @return A list of sublists contain values(s) of the arguments augmented with
#'   'method' and 'NOTE' elements. The argument(s) are assigned/computed
#'   multiple values will be returned in a sequence ofy expanding combination,
#'   while the argument(s) inputted single value will be returned only one
#'   single value.
#' @export
v.pwr.2p.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.2p.test, deff=1)
    return(out)
}


vector_pwr <- function(..., deff=1) {
    
    args <- as.list(match.call())[-1]
    for (i in 1:length(args)) {
        args[[i]] <- eval(args[[i]])
    }

    pwrf <- args$pwrf; args$pwrf <- NULL
    
    if (sum(lapply(args, function(x) length(x) > 1) > 2)) {
        stop("More than two arguments are vectors")
    }

    if (length(deff) > 1) {
        stop("Design effect can only be a single value")
    }
    
    newargs <- expand.grid(args, stringsAsFactors = FALSE)
    newargs$deff <- NULL
    res <- lapply(split(newargs, seq(nrow(newargs))),
                  function(x) do.call(pwrf, x))
    
    if (args$deff != 1 & is.null(args$n)) {
      res <- lapply(res, function(x) modifyList(x, list(n=args$n*deff)))
    }
    
    if ((args$deff != 1) & !is.null(args$n)) {
        warning("Design effect is being ignored and set to 1")
    }

    res <- lapply(res, unclass)
    res <- lapply(res, function(x) modifyList(x, list("deff"=args$deff)))

    res <- do.call(rbind, res)
    return(res)
}
