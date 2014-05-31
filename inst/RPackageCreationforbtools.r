# RPackageCreationforbtools.r
# Don Boyd
# 5/31/2014

# http://www.molecularecologist.com/2013/11/using-github-with-r-and-rstudio/
# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# http://adv-r.had.co.nz/Package-basics.html
# https://github.com/klutometis/roxygen#roxygen2
# http://cran.r-project.org/doc/manuals/R-exts.html#Data-in-packages
# https://sites.google.com/site/hackoutwiki/developers-corner/developing-r-packages


# The following SSH key was added to your account:
#   
#   GitHub for Windows - Don-PC
# 75:4b:6d:82:41:88:79:28:e1:b2:7a:01:66:93:61:8f
# 
# If you believe this key was added in error, you can remove the key and disable
# access at the following location:
#   
#   https://github.com/settings/ssh

getOption("defaultPackages")


# install.packages("devtools")
# find_rtools()
# devtools::install_github("klutometis/roxygen")
# devtools::install_github("yihui/roxygen2") # I installed from CRAN

library(devtools)
library(roxygen2)

setwd("E:\\R\\BoydPackages\\")
# create("btools") only run this when needed

# then, create the functions and get into the R subdirectory for the package


# REPEAT the steps below each time the package is revised
# documentation (must be in the r files with functions)
setwd("./btools")
document()


# install
setwd("..")
install("btools")


# optionally install from github
# http://kbroman.github.io/github_tutorial/
# setwd("..")
install_github('btools','donboyd5')



# remove.packages("btools")


# here is a good example of how to document a function

#' @title Sum of Vector Elements
#'
#' @description
#' \code{sum} returns the sum of all the values present in its arguments.
#'
#' @details
#' This is a generic function: methods can be defined for it directly
#' or via the \code{Summary} group generic.  For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.'
sum <- function(..., na.rm = TRUE) {}





