#' Backend vectorizer for functions in the pwr package
#'
#' @section Warning: It allows up to 2 vectorized arguments
#' @param ... Any parameters passed to a function in the \\code{pwr} package.
#' @param deff The design effect
#' @return An \\code{rbind} of the result of applying the appropriate function
#'     from the \\code{pwr} package to each combination of the input parameters.
vector_pwr <- function(..., deff) {
    args <- as.list(match.call())[-1]
    
    ## lapply produces an error message probably due to the evaluation
    ## for-loop is safer albeit it is uglier
    for (i in 1:length(args)) {
        args[[i]] <- eval(args[[i]])
    }
    
    pwrf <- args$pwrf; args$pwrf <- NULL

    ## What's the missing argument?
    candargs <- as.list(args(eval(pwrf)))
    
    exist_covars <- args[!unlist(lapply(args, is.null)) & names(args) != "deff"]
    required_covars <- candargs[unlist(lapply(candargs, is.null)) & names(candargs) != ""] 
    missing_covar <- setdiff(names(required_covars), names(exist_covars))

    ## Ensure that proper missing argument is calculated
    ## If p2 is present, then it is calculating mdd (otherwise the function would have broken)
    if (!is.null(args$p2)) {
        missing_covar <- "p1"
    }

    ## If both p2 and something else is included, remove p2
    if (length(missing_covar) > 1 & "p2" %in% missing_covar) {
        missing_covar <- missing_covar["p2" != missing_covar]
    }
    
    if (sum(unlist(lapply(args, function(x) length(x) > 1))) > 2) {
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
      res <- lapply(res, function(x) modifyList(x, list(n=x$n*args$deff)))
    }
    
    if ((args$deff != 1) & !is.null(args$n)) {
        warning("Design effect is being ignored and set to 1")
    }

    res <- lapply(res, unclass)
    res <- lapply(res, function(x) modifyList(x, list("deff"=args$deff,
                                                      "calculated_covar"=missing_covar)))  
    res <- do.call(rbind, res)
    return(basu_output(res))
}


#' Format output for basu dashboard
basu_output <- function(x) {
    x <- as.data.frame(x)

    .reducer <- function(i) {
        if (length(unique(i)) == 1) {
            return(unique(i))
        }
        else return(i)
    }
    
    out <- lapply(x, function(m) .reducer(unlist(m)))
    return(out)
}
