# btools_utilities.r
# Don Boyd
# 4/22/2015


#****************************************************************************************************
#
#                String manipulation functions ####
#
#****************************************************************************************************

#' @title Capitalize first letter of each word
#'
#' @description \code{capwords} capitalize first letter of each word
#' @usage capwords(s, strict=FALSE)
#' @param s The string to capitalize words of
#' @param strict TRUE or FALSE
#' @details All white space is removed from the trailing (right) side of the string.
#' @return The initial-capped result.
#' @keywords capwords
#' @export
#' @examples
#' capwords("string to capitalize words in")
capwords <- function(s, strict=FALSE) {
  cap <- function(s) paste(toupper(substring(s,1,1)), 
                           {s <- substring(s,2); if(strict) tolower(s) else s},
                           sep = "", 
                           collapse = " " )
  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
}


#' @title Trim leading white space in strings
#'
#' @description \code{trimlead} trims leading white space in strings
#' @usage trimlead(s)
#' @param s The string to trim.
#' @details All white space is removed from the leading (left) side of the string.
#' @return The trimmed string.
#' @keywords trimlead
#' @export
#' @examples
#' trimlead("   original string has leading and trailing spaces   ")
trimlead <- function(s) {sub("^\\s+", "", s)}


#' @title Trim trailing white space in strings
#'
#' @description \code{trimtrail} trims trailing white space in strings
#' @usage trimtrail(s)
#' @param s The string to trim.
#' @details All white space is removed from the trailing (right) side of the string.
#' @return The trimmed string.
#' @keywords trimtrail
#' @export
#' @examples
#' trimtrail("   original string has leading and trailing spaces   ")
trimtrail <- function(s) {sub("\\s+$", "", s)}


#' @title Trim white space at either end of strings
#'
#' @description \code{trim.ws} trims white space around strings
#' @usage trim.ws(s)
#' @param s The string to trim.
#' @details All white space is removed from the ends.
#' @return The trimmed string.
#' @keywords trim.ws
#' @export
#' @examples
#' trim.ws("   original string has leading and trailing spaces   ")
trim.ws <- function(s) {gsub("^\\s+|\\s+$", "", s)}



#****************************************************************************************************
#
#                Numeric manipulation functions ####
#
#****************************************************************************************************

#' @title Convert character to numeric
#'
#' @description \code{cton} converts character to numeric
#' @usage cton(cvar)
#' @param cvar The character string input. No default.
#' @details Replaces spaces, comma, $, and percent sign in a string with NULL and then converts to numeric.
#' Keeps letters so that scientific notation will be evaluated properly.
#' Also look at \code{extract_numeric} in package stringr
#' @keywords cton
#' @export
#' @examples
#' char <- "$198,234.75"
#' cton(char)
cton <- function(cvar) {as.numeric(gsub("[ ,$%]", "", cvar))}


#' @title Convert NA to zero
#'
#' @description \code{naz} converts NA to zero
#' @usage naz(vec)
#' @param vec The vector to convert
#' @details Converts all NAs in a vector to zero.
#' @return The revised vector.
#' @keywords naz
#' @export
#' @examples
#' naz(NA)
naz <- function(vec) {return(ifelse(is.na(vec), 0, vec))}


#' @title Zero-pad leading characters in a numeric value.
#'
#' @description \code{zpad} converts NA to zero
#' @usage zpad(nvec, outlen=2)
#' @param nvec The numeric vector to zero-pad.
#' @param outlen The length of the string to be returned. Default is 2.
#' @details Zero-pads on the left all numeric in a vector, returning strings of length outlen.
#' @return Zero-padded strings of length outlen.
#' @keywords zpad
#' @export
#' @examples
#' zpad(1, 4)
zpad <- function(nvec, outlen=2){
  padcode <- paste0("%0", outlen, "i")
  return(sprintf(padcode, round(nvec)))
}


#****************************************************************************************************
#
#                Miscellaneous functions ####
#
#****************************************************************************************************

#' @title Show head and tail of a vector, matrix, table, data frame or function
#'
#' @description \code{ht} head and tail of a vector, matrix, table, data frame or function
#' @usage ht(df, nrecs=6)
#' @param df The object. No default.
#' @param nrecs number of records, rows, whatever to show at head and at tail
#' @details show head and tail of a vector, matrix, table, data frame or function
#' @keywords ht
#' @export
#' @examples
#' ht(mtcars, 4)
ht <- function(df, nrecs=6){
  print(head(df, nrecs))
  print(tail(df, nrecs))
}


#' @title Describe memory usage and collect garbage
#'
#' @description \code{memory} describe memory usage and collect garbage
#' @usage memory(maxnobjs=5)
#' @param maxnobjs The number of objects to display. Default is 5.
#' @details Describes memory usage and collects garbage 
#' @keywords memory
#' @export
#' @examples
#' memory(4)
memory <- function(maxnobjs=5){
  # function for getting the sizes of objects in memory
  objs <- ls(envir = globalenv())
  nobjs <- min(length(objs), maxnobjs)

  getobjs <- function() {
    f <- function(x) utils::object.size(get(x)) / 1048600
    sizeMB <- sapply(objs, f)
    tmp <- data.frame(sizeMB)
    tmp <- cbind(name=row.names(tmp), tmp) %>% arrange(desc(sizeMB))
    # tmp <- tmp[order(-tmp$sizeMB), ]
    row.names(tmp) <- NULL
    tmp$sizeMB <- formatC(tmp$sizeMB, format="f", digits=2, big.mark=",", preserve.width="common")
    return(tmp)
  }
  
  print(paste0("Memory available: ", utils::memory.size(NA)))
  print(paste0("Memory in use before: ", utils::memory.size()))
  
  if(nobjs>0){
    print("Memory for selected objects: ")
    print(head(getobjs(), nobjs))
  }
  print(gc())
  print(paste0("Memory in use after: ", utils::memory.size()))
}


#****************************************************************************************************
#
#                Rolling mean and sum functions ####
#
#****************************************************************************************************

# the rollmean versions are fast but cannot handle NA input values
# the rollapply version is slower but handles NAs, so use it - that's what I do

#' @title Get 4-period moving average (3 lags + current)
#'
#' @description \code{ma4} get 4-period moving average
#' @usage ma4(x)
#' @param x The vector to operate on.
#' @details 4-period moving average
#' @keywords ma4
#' @export
#' @examples
#' ma4(7:21)
ma4 <- function(x) {
  # note that this requires zoo, which is on the Depends line in the Description file
  zoo::rollapply(x, 4, function(x) mean(x, na.rm=TRUE), fill=NA, align="right")
}

#' @title Get 4-period moving sum (3 lags + current)
#'
#' @description \code{sum4} get 4-period moving sum
#' @usage sum4(x)
#' @param x The vector to operate on.
#' @details 4-period moving sum
#' @keywords sum4
#' @export
#' @examples
#' sum4(7:21)
sum4 <- function(x) ma4(x) * 4


