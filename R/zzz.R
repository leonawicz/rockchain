.onLoad <- function(libname, pkgname){
  options(scipen = 10)
  options(rockchain_antiddos = 10)
}

rockchain_api_time <- new.env()
