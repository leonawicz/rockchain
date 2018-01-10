#' Available cryptocurrencies.
#'
#' Available cryptocurrencies, Bitcoin and altcoins, on \code{coinmarketcap.com}.
#'
#' @format A data frame with 1398 rows and 3 columns: cryptocurrency \code{id}, \code{name} and ticker \code{symbol}.
#' This data frame provides the list of available cryptocurrencies at the time of package publication.
#' In case this table is out of date, the full current list can always be obtained from the first three columns returned by \code{\link{ticker}}.
"coins"

#' Coin helper functions
#'
#' These helpers return ID, name or ticker symbol for cryptocurrencies based on either of the other two.
#' Symbol inputs are not case sensitive but IDs and names are.
#'
#' @param x a coin id, name or ticker symbol.
#' @name coin_helpers
#'
#' @return a vector the same length as \code{x}.
#'
#' @examples
#' coin_id(c("btc", "Ethereum"))
#' coin_name(c("BTC", "BCH"))
#' coin_symbol("Bitcoin")
NULL

#' @export
#' @rdname coin_helpers
coin_id <- function(x){
  d <- rockchain::coins
  y <- dplyr::filter(d, .data[["name"]] %in% x | .data[["symbol"]] %in% toupper(x))$id
  .valid_coin(x, y)
  y
}

#' @export
#' @rdname coin_helpers
coin_name <- function(x){
  d <- rockchain::coins
  y <- dplyr::filter(d, .data[["id"]] %in% x | .data[["symbol"]] %in% toupper(x))$name
  .valid_coin(x, y)
  y
}

#' @export
#' @rdname coin_helpers
coin_symbol <- function(x){
  d <- rockchain::coins
  y <- dplyr::filter(d, .data[["id"]] %in% x | .data[["name"]] %in% x)$symbol
  .valid_coin(x, y)
  y
}

.valid_coin <- function(x, y){
  if(length(x) > length(y))
    stop("Invalid coin provided. See `rockchain::coins` data set.")
}

#' Unit test wallet data examples.
#'
#' Example downloaded wallet data from the \code{coinmarketcap.com} API.
#'
#' This data is only used for unit testing during package development and maintenance. It only exists so that unit tests can be run when the
#' \code{blockchain.info} API is being extremely fussy and constantly rejecting API calls. This is not a permanent solution. Eventually
#' the data set will be removed and, if necessary, an alternative, more dependable Bitcoin blockchain API will be used instead of \code{blockchain.info}.
#'
#' @format A list of seven wallet lists.
"wlt"
