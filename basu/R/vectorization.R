#' Expand pwr.2p.test to take p2 argument
#' @export
pwr.2p.test <- function(h=NULL,
                        n=NULL,
                        sig.level=NULL,
                        power=NULL,
                        alternative = c("two.sided", "less", "greater"),
                        p2=NULL) {
    calc_h <- !"h" %in% names(as.list(match.call())[-1])   
    
    if (!is.null(p2) & (is.null(n) & is.null(sig.level) & is.null(power))) {
        stop("To calculate p1, please provide n, sig.level, and power")
    }
    out <- pwr:::pwr.2p.test(h=h,
                             n=n,
                             sig.level=sig.level,
                             power=power,
                             alternative=alternative)    
    
    if (calc_h & !is.null(p2)) {
        if (alternative == "greater" | alternative == "less") {
            alternative <- "one.sided"
        }
        
        out <- stats:::power.prop.test(n=n,
                                       p2=p2,
                                       sig.level=sig.level,
                                       power=power,
                                       alternative=alternative)

        if (alternative == "one.sided") {
            out$note <- paste(out$note, "ignoring direction of alternative")
        }
    }
    return(out)
}


#' Vectorized pwr.2p.test
#' @export
v.pwr.2p.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr.2p.test, deff=deff)
    return(out)
}


#' Expand pwr.p.test to take p2 argument
#' @export
pwr.p.test <- function(h=NULL,
                       n=NULL,
                       sig.level=NULL,
                       power=NULL,
                       alternative = c("two.sided", "less", "greater"),
                       p2=NULL) {
    calc_h <- !"h" %in% names(as.list(match.call())[-1])
    
    if (!is.null(p2) & (is.null(n) | is.null(sig.level) | is.null(power))) {
        stop("To calculate p1, please provide n, sig.level, and power")
    }
    
    out <- pwr:::pwr.p.test(h=h,
                            n=n,
                            sig.level=sig.level,
                            power=power,
                            alternative=alternative)
    
    if (calc_h & !is.null(p2)) {
        stop("Calculation of p1 not available for one sample tests")
    }

    return(out)
}


#' Vectorized pwr.p.test
#' @export
v.pwr.p.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr.p.test, deff=deff)
    return(out)
}


#' Vectorized pwr.t.test
#' @export
v.pwr.t.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.t.test, deff=deff)
    return(out)
}


#' Vectorized pwr.r.test
#' @export
v.pwr.r.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.r.test, deff=deff)
    return(out)
}


#' Cohen effect size
#' @export
cohen.ES <- function(...) {
    out <- pwr:::cohen.ES(...)
    return(unclass(out))
}
