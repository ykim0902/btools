# btools_dplyrtools.r
# Don Boyd
# 4/22/2015

# tools that generally are helpful with dplyr

#' @title Get quantiles and number of not-NA observations for a vector, return as data frame
#'
#' @description \code{qtiledf} get quantiles and number of not-NA observations for a vector, return as data frame
#' @usage qtiledf(vec, probs)
#' @param vec Numeric vector. No default.
#' @param probs Numeric vector of quantiles. Default is c(0, .1, .25, .5, .75, .9, 1).
#' @details Very little error checking.
#' Useful after dplyr's group_by, in do command, which requires data frame input.
#' @return Data frame with columns as quantiles
#' @keywords qtiledf
#' @export
#' @examples
#' df %>% group_by(year) %>% do(qtiledf(.$marginpct, c(.1, .25, .5, .75, .9)))
qtiledf <- function(vec, probs=c(0, .1, .25, .5, .75, .9, 1)) cbind(n.notNA=sum(!is.na(vec)), as.data.frame(t(quantile(vec, na.rm = TRUE, probs))))


#' @title Get trend, seasonal, remainder for a vector that has time-series data
#'
#' @description \code{stldf} get trend, seasonal, remainder for a vector that has time-series data
#' @usage stldf(vec, freq)
#' @param vec Numeric vector with time-series data. No default.
#' @param freq Frequency of the data. Numeric. Should be 4 (quarterly) or 12 (monthly). No default.
#' @details Returns a data frame with 3 columns: trend, seasonal, remainder. Very little error checking.
#' Useful after dplyr's group_by, in do command, which requires data frame input. Make sure data are sorted by time before using.
#' @return Data frame with 3 columns: trend, seasonal, remainder
#' @keywords stldf
#' @export
#' @examples
#' df %>% group_by(govtype, govname, variable) %>%
#'     arrange(date) %>% # BE SURE DATA HAVE BEEN SORTED BY DATE!!!
#'     do(cbind(., stldf(.$value, 4)))
stldf <- function(vec, freq){ # decompose time series; assume "date" var exists; has minor error handling
  # arguments: numeric vector (vec) and its frequency (freq)
  # return: data frame (tsr) with trend, seasonal, and remainder columns
  lvec <- length(vec)
  badout <- function(lvec) data.frame(trend=rep(NA, lvec), seasonal=rep(NA, lvec), remainder=rep(NA, lvec))
  
  if(lvec < 2 * freq) return(badout(lvec))
  
  varts <- ts(vec, start=1, frequency=freq)
  decomp <- stl(varts, s.window = freq + 1, na.action = na.approx) # na.approx replaces missing values with interpolated values  
  tsr <- data.frame(trend = as.vector(decomp$time.series[, "trend"]), 
                    seasonal = as.vector(decomp$time.series[, "seasonal"]), 
                    remainder = as.vector(decomp$time.series[, "remainder"]))
  if(nrow(tsr) != lvec) return(badout(lvec))
  
  return(tsr)
}