#' Vectorizes power calculations for t-test of means.
#'
#' \code {v.pwr.t.test} computes power of test or determine paramaters to obtain
#' target power. It allows up to 2 vectorize arguments.
#' @section Warning: The function only takes up to 2 vectorize arguments.
#'
#' @param d Effect size, - difference between the means divided by the pooled
#'   standard deviation. Could input a single numerical value or a vector of
#'   values, applies to all parameters.
#' @param n Number of observations.
#' @param sig.level Significant level.
#' @param power Power of test.
#' @param alternative A character string specifying the alternative hypothesis.
#'   Must be one of "two.sided" (default), "greater" or "less".
#' @param type Type of t test: one- two- or -paired-samples. Two samples is
#'   default.
#' @param deff Design effect.
#' @return A list of sublists contain values(s) of the arguments augmented with
#'   'method' and 'NOTE' elements. The argument(s) are assigned/computed
#'   multiple values will be returned in a sequence of expanding combination,
#'   while the argument(s) inputted single value will be returned only one
#'   single value.
#' @export
v.pwr.t.test <- function(n = NULL,
                         d = NULL,
                         sig.level = 0.05,
                         power = NULL,
                         type = c("two.sample", "one.sample", "paired"),
                         alternative = c("two.sided", "less","greater"),
                         deff = 1){
    argnames <- names(as.list(match.call()))[-1]
    args <- sapply(argnames, function(x) get(x), simplify = FALSE)
    if (sum(unlist(lapply(args , function(x) length(x) != 1))) > 2)
      stop("only enter multiple values of up to 2 arguments")
    newargs <- expand.grid(args, stringsAsFactors = FALSE)
    newargs$deff <- NULL
    out <- lapply(split(newargs, seq(nrow(newargs))),
                  function(x) do.call(pwr:::pwr.t.test,x))
    if (deff != 1 & is.null(n)) {
      out <- lapply(out, function(x) modifyList(x, list(n=x$n*deff)))
    }
    if ((deff != 1) & !is.null(n)) {
      warning("design effect is being ignored and set to 1")
    }
    out <- lapply(out, function(x) structure(c(unclass(x),deff = deff)))
    out <- do.call(Map, c(c, out))
    out <- lapply(out, function(x)
        if(length(unique(x)) == 1) {x <- unique(x)}
        else {x <- x})
    return(out)
  }
