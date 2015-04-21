# btools_datadocumentation.r
# Don Boyd
# 4/21/2015



#' @name popst
#' @title Dataset with annual state population
#' @description Dataset with postal abbreviation, year, value (thousands), and esttype (estimate type)
#' Intercensal (July) estimates wherever possible, but only decennial was available in 1970, 1980
#' @docType data
#' @usage popst
#' @format A data frame with 1 row per state per year
#' @source Census Bureau, as prepared by Boyd
#' @author Don Boyd, 2015-04-21
NULL


#' @name qpopst
#' @title Dataset with quarterly state population
#' @description Dataset with postal abbreviation, date, value (thousands)
#' See popst for details of annual data.
#' Interpolated from annual to quarterly by Boyd.
#' @docType data
#' @usage qpopst
#' @format A data frame with 1 row per state per date (first day of quarter)
#' @source Census Bureau, as prepared by Boyd
#' @author Don Boyd, 2015-04-21
NULL


#' @name recessions
#' @title Dataset with start and end dates of recessions
#' @description Dataset with start and end dates of recessions, and first date of quarters in which recession started and ended
#' @docType data
#' @usage recessions
#' @format A data frame with 1 row per recession
#' @source National Bureau of Economic Research (NBER)
#' http://www.nber.org/cycles.html
#' @author Don Boyd, 2015-04-21
NULL


#' @name stcodes
#' @title Dataset with state codes and names
#' @description Dataset with postal abbreviation, fips and Census codes, and state name
#' @docType data
#' @usage stcodes
#' @format A data frame with 1 row per state
#' @source Census Bureau, other
#' @author Don Boyd, 2015-01-06
NULL


