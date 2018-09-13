#' Vectorized pwr.2p.test
#' @export
v.pwr.2p.test <- function(..., deff=1, p2=NULL, h=NULL) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.2p.test, deff=deff)
    if (is.null(h) & !is.null(p2)) {
        out$mdd <- p1_from_ES(out$h, p2)
    }    
    return(out)
}


#' Vectorized pwr.p.test
#' @export
v.pwr.p.test <- function(..., deff=1, p2=NULL, h=NULL) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.p.test, deff=deff)
    if (is.null(h) & !is.null(p2)) {
        out$mdd <- p1_from_ES(out$h, p2)
    }
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

##' Calculate difference from effect size
p1_from_ES <- function(h, p2, alternative) {
    p1 <- sin((h + 2*asin(sqrt(p2)))/2)^2
    return(p1)
}
