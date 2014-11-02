# btools_dates.r
# Don Boyd
# 11/2/2014

# Now that I use lubridate, very few date functions are necessary


#' @title Create a date from month, day, year
#'
#' @description \code{mdyfn} create a date from month, day, year
#' @usage mdyfn(m, d, y)
#' @param m the month input. No default.
#' @param d the day input. No default.
#' @param y the year input. No default.
#' @details You must ensure that the inputs are acceptable (e.g., month is in 1:12). The function does not check.
#' @keywords mdyfn
#' @export
#' @examples mdyfn(10, 1, 1988)
mdyfn <- function(m, d, y) {as.Date(ISOdate(y, m, d))}

#' @title Create a date for start of quarter, from quarter, year
#'
#' @description \code{qy} create a date for start of quarter, from quarter, year
#' @usage qy(q, y)
#' @param q the quarter input. No default.
#' @param y the year input. No default.
#' @details You must ensure that the inputs are acceptable (e.g., quarter is in 1:4). The function does not check.
#' @keywords qy
#' @export
#' @examples qy(2, 1985)
qy <- function(q, y) {mdyfn(q*3-2, 1, y)}

