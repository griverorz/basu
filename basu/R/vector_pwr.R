#' Backend vectorizer for functions in the pwr package
#'
#' @section Warning: It allows up to 2 vectorized arguments
#' @param ... Any parameters passed to a function in the \\code{pwr} package.
#' @param deff The design effect
#' @return An \\code{rbind} of the result of applying the appropriate function
#'     from the \\code{pwr} package to each combination of the input parameters.
vector_pwr <- function(..., deff=1) {
    args <- as.list(match.call())[-1]

    ## lapply produces an error message probably due to the evaluation
    ## for-loop is safer albeit it is uglier
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