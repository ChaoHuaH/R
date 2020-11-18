
# Build R package ####

# createa pkg project
library(usethis)
usethis::create_package("C:/Rproject/pkgXXXX")


# five components for building a pkg ####

# 1. DESCRIPTION
# other pkgs used need to put in DESCRIPTION
usethis::use_package("diptest")
usethis::use_package("dplyr")

# 2. R/:
# put R code

# 3. man/:
# edit roxygen comments in .R
# then use devtools::document() produce .Rd file in man/

# 4. data/:
# store data set in data/ by usethis::use_data()
# save another R file R/data.R: data description
usethis::use_data(sample_data)

# R/data.R

#' Prices of 50,000 round cut diamonds.
#'
#' A dataset containing the prices and other attributes of almost 54,000
#' diamonds.
#'
#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{price}{price, in US dollars}
#'   \item{carat}{weight of the diamond, in carats}
#'   ...
#' }
"diamonds"

# 5. NAMESPACE:
# similar to man, annotate roxygen comments in .R
# use devtools::document() produce .Rd file
# NAMESPACE is an important file bucause it indicate which function is export or import



# using other package ####
# list on the DESCRIPTION Imports, when the pkg install, other pkgs would be intalled as well
# (1) don't use often: pkg::func()
# (2) use @importFrom pkg fun
# (3) use often:@import package (not recommend, make the code harder to read)



# CHECK THE PACKAGE ####
devtools::check()

# check pkg with NOTE: no visible binding for global variable 'xxxx'
# save another globals.R, list all the variables in NOTE
utils::globalVariables(c("variable1", "variable2", "variable3", "variable4"))




## use devtools::document() produce .Rd file
#' Title ABC
#'
#' \code{test_func} the Description xxxxxx
#'
#' The detail yyyyyy
#'
#' @param x parameter x
#' @param y parameter y
#'
#' @return the Value zzzz
#'
#' @examples
#' test_func(x = 1, y = 3)
#'
#' @importFrom stringr str_pad
#'
#' @export
test_func = function(x , y) {}








