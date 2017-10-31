globalVariables(".data")

#' rockchain: a blockchain package for R.
#'
#' Access blockchain and cryptocurrency data.
#'
#' The \code{rockchain} package provides simple interfaces to \href{https://coinmarketcap.com/}{coinmarketcap.com} ticker and market cap data and
#' \href{https://blockchain.info/}{blockchain.info} ticker and Bitcoin wallet data.
#' The current package does not yet support additional blockchain APIs.
#' It does not offer functionality beyond cryptocurrency market data retrieval and Bitcoin wallet transaction data retrieval.
#'
#' @docType package
#' @name rockchain
NULL

#' @importFrom magrittr %>%
NULL

#' Available APIs
#'
#' Get available APIs.
#'
#' This function returns a data frame containing a column of APIs and logical columns indicating whether an API is available for ticker
#' information or for wallet information.
#'
#' @return a data frame.
#' @export
#'
#' @examples
#' apis()
apis <- function(){
  api <- c("coinmarketcap.com", "blockchain.info")
  ticker_api <- c(TRUE, TRUE)
  wallet_api <- c(FALSE, TRUE)
  tibble::data_frame(api = api, ticker = ticker_api, wallet = wallet_api)
}

#' Valid fiat ticker symbols
#'
#' Get valid fiat currency ticker symbols for available ticker/market cap APIs.
#'
#' @param api character or \code{NULL}, the API. See \code{\link{apis}}.
#'
#' @return a data frame if \code{api = NULL}, otherwise a vector.
#' @seealso \code{\link{apis}}
#' @export
#'
#' @examples
#' fiat_symbols()
#' fiat_symbols(api = "coinmarketcap.com")
#' fiat_symbols(api = "blockchain.info")
fiat_symbols <- function(api = NULL){
  cmc <- c(
    "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD",
    "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP",
    "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR", "USD")
  bci <- c(
    "USD", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "DKK", "EUR", "GBP", "HKD",
    "INR", "ISK", "JPY", "KRW", "NZD", "PLN", "RUB", "SEK", "SGD", "THB", "TWD")
  if(is.null(api)){
    x <- sort(unique(c(cmc, bci)))
    tibble::data_frame(currency = x, coinmarketcap.com = x %in% cmc, blockchain.info = x %in% bci)
  } else {
    ticker_apis <- apis()$api[apis()$ticker]
    if(!api %in% ticker_apis) stop("Invalid `api`. See `apis()`.")
    switch(api, coinmarketcap.com = cmc, blockchain.info = bci)
  }
}
