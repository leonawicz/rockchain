#' Convert Bitcoin units
#'
#' Convert among different units of measure for Bitcoin.
#'
#' This complete conversion function, \code{convert_btc}, converts a value \code{x} among the following units: BTC, mBTC, bits and satoshi.
#' These are the recommended ways of specifying the \code{from} and \code{to} arguments, though BTC and mBTC
#' may be passed as btc and mbtc, respectively. BTC may also be written out as Bitcoin/bitcoin and will also be internally converted to BTC.
#'
#' Three shorthand functions, \code{mBTC}, \code{bits} and \code{satoshi}, are also available if you forget the conversion.
#' These assume the input is Bitcoin and multiply your value straight to mBTC, bits or satoshi, respectively. See examples.
#'
#' @param x a numeric value.
#' @param from the units of \code{x}.
#' @param to new units.
#'
#' @return numeric value.
#' @export
#' @name convert_btc
#'
#' @examples
#' convert_btc(1, "BTC", "mBTC")
#' convert_btc(1, "BTC", "bits")
#' convert_btc(1, "BTC", "satoshi")
#' convert_btc(0.001, "mBTC", "bits")
#' convert_btc(1, "mBTC", "bitcoin")
#' convert_btc(100, "satoshi", "bits")
#' satoshi(1e-8)
#' bits(1e-6)
#' mbtc(0.001)

#' @export
#' @rdname convert_btc
convert_btc <- function(x, from = "BTC", to = "bits"){
  if(tolower(from) == "bitcoin") from <- "BTC"
  if(tolower(to) == "bitcoin") to <- "BTC"
  from <- gsub("btc", "BTC", from)
  to <- gsub("btc", "BTC", to)
  if(!all(c(from, to) %in% c("BTC", "mBTC", "bits", "satoshi")))
    stop("Valid units include BTC, mBTC, bits and satoshi.")
  if(from == to) return(x)
  if(from == "BTC"){
    if(to == "mBTC") return(x * 1000)
    if(to == "bits") return(x * 1e6)
    if(to == "satoshi") return(x * 1e8)
  }
  if(from == "mBTC"){
    if(to == "BTC") return(x / 1000)
    if(to == "bits") return(x * 1000)
    if(to == "satoshi") return(x * 1e5)
  }
  if(from == "bits"){
    if(to == "BTC") return(x / 1e6)
    if(to == "mBTC") return(x / 1000)
    if(to == "satoshi") return(x * 100)
  }
  if(from == "satoshi"){
    if(to == "BTC") return(x / 1e8)
    if(to == "mBTC") return(x / 1e5)
    if(to == "bits") return(x / 100)
  }
}

#' @export
#' @rdname convert_btc
satoshi <- function(x) x / 1e8

#' @export
#' @rdname convert_btc
bits <- function(x) x / 1e6

#' @export
#' @rdname convert_btc
mbtc <- function(x) x / 1000
