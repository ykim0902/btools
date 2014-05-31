# btools_dates.r
# Don Boyd
# 5/27/2014


#' @title Extract year from a date
#'
#' @description \code{year} extract year from a date
#' @usage year(dt)
#' @param dt The date input. No default.
#' @details extract year from a date
#' @keywords year
#' @export
#' @examples year("2012-05-01")
year<-function(dt) {as.POSIXlt(dt)$year + 1900}


#' @title Extract month from a date
#'
#' @description \code{month} extract month from a date
#' @usage month(dt)
#' @param dt The date input. No default.
#' @details extract month from a date
#' @keywords month
#' @export
#' @examples month("2012-05-01")
month<-function(dt) {as.POSIXlt(dt)$mon + 1}

#' @title Get the quarter for a given date
#'
#' @description \code{qtr} get the quarter for a given date
#' @usage qtr(dt)
#' @param dt The date input. No default.
#' @details get the quarter for a given date
#' @keywords qtr
#' @export
#' @examples qtr("2012-05-01")
qtr<-function(dt) {floor((month(dt)-1)/3)+1}

#' @title Create a date from month, day, year
#'
#' @description \code{mdy} create a date from month, day, year
#' @usage mdy(m, d, y)
#' @param m the month input. No default.
#' @param d the day input. No default.
#' @param y the year input. No default.
#' @details You must ensure that the inputs are acceptable (e.g., month is in 1:12). The function does not check.
#' @keywords mdy
#' @export
#' @examples mdy(10,1,1988)
mdy<-function(m,d,y) {as.Date(ISOdate(y,m,d))}

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
qy<-function(q,y) {mdy(q*3-2,1,y)}


#' @title Add dmonths (delta-months) to a date
#'
#' @description \code{dmonths} add dmonths (delta-months) to a date
#' @usage dmonths(dt, dm)
#' @param dt The date input. No default.
#' @param dm The number of months to add. Can be negative. No default.
#' @details You must ensure that the inputs are acceptable .
#' @keywords dmonths
#' @export
#' @examples dmonths(as.Date("2012-05-01"), 8)
dmonths<-function(dt, dm){ # give a date and delta-months and it returns the date as incremented; assumes day is first day of month
  # add the specified number of months (dm) (positive or negative) to the date sent to the function (indate)
  m<-month(dt)
  y<-year(dt)
  mos<-y*12+m
  newmos<-mos+dm
  newy<-(newmos-1) %/% 12  # get integer number of years in the new number (modulus)
  newm<-newmos %% 12 # get number of months
  newm<-ifelse(newm==0,12,newm) # December will yield 0, so fix that
  newdate<-mdy(newm,1,newy)
  return(newdate)
}
