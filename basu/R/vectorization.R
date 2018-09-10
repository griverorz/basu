#' Vectorized pwr.2p.test
#' @export
v.pwr.2p.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.2p.test, deff=deff)
    return(out)
}


#' Vectorized pwr.p.test
#' @export
v.pwr.p.test <- function(..., deff=1) {
    out <- vector_pwr(..., pwrf=pwr:::pwr.p.test, deff=deff)
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
cohen.ES <- pwr:::cohen.ES
