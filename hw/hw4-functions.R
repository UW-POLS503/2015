# (C) 2012 Christopher Adolph, GPL >= 2.
# From simcf package, https://github.com/chrisadolph/tile-simcf
logitBound <- function (x, base = exp(1), forceAny = FALSE, forceAll = FALSE) {
    any <- as.numeric(x > 0)
    all <- as.numeric(x >= 1)
    logit <- suppressWarnings(log(x/(1 - x), base = base))
    logit[(any == 0) | (all == 1)] <- 0
    if (forceAny || any(!any)) {
        if (forceAll | sum(all)) {
            return(cbind(any, all, logit))
        }
        else {
            return(cbind(any, logit))
        }
    }
    else {
        if (sum(all)) {
            return(cbind(all, logit))
        }
        else {
            return(cbind(logit))
        }
    }
}

logBound <- function (x, base = exp(1), forceAny = FALSE) {
    any <- as.numeric(x > 0)
    log <- suppressWarnings(log(x, base = base))
    log[!any] <- 0
    if (forceAny | any(!any)) {
        return(cbind(any, log))
    }
    else {
        return(cbind(log))
    }
}
