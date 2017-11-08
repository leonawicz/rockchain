#' Global cryptocurrency market cap
#'
#' Obtain global cryptocurrency market cap data from \code{coinmarketcap.com}.
#'
#' Return all tracked cryptocurrencies if \code{crypto = NULL}. Return global aggregate market cap if \code{crypto = "global"}.
#' If an integer, return the top \code{crypto} cryptocurrencies by market cap.
#' Otherwise \code{crypto} should be a vector of cryptocurrency ticker symbols, e.g., BTC.
#' This function is a partial wrapper around \code{\link{ticker}} (when \code{crypto = "global"}).
#'
#' @param crypto character, integer or \code{NULL}, may be a vector. See details.
#' @param convert character, may be a vector. Currencies to convert \code{crypto} value. These may be fiat or cryptocurrencies.
#'
#' @return a data frame.
#' @seealso \code{\link{ticker}}
#' @export
#'
#' @examples
#' \dontrun{
#' cap()
#' cap(crypto = "global")
#' cap(crypto = c("ETH", "LTC"), convert = c("EUR", "GBP", "BTC"))
#' }
cap <- function(crypto = NULL, convert = "USD"){
  if(!is.null(crypto) && length(crypto) == 1 && crypto == "global"){
    purrr::map(convert, ~.cmc_global("https://api.coinmarketcap.com/v1/global/?convert=", .x)) %>%
      dplyr::bind_rows()
  } else if(!is.null(crypto) && length(crypto) > 1 && "global" %in% crypto){
    stop("Cannot combine 'global' with individual coin symbols for `crypto`.")
  } else {
    ticker(crypto, convert, api = "coinmarketcap.com")
  }
}

.cmc_global <- function(x, convert){
  x <- tibble::as_data_frame(jsonlite::fromJSON(paste0(x, convert)))
  if(convert != "USD") x <- dplyr::select(x, c(7, 8, 3:6))
  names(x)[1:2] <- c("total_market_cap", "total_24h_volume")
  dplyr::mutate(x, currency = convert) %>% dplyr::select(c(7, 1:6))
}

#' Bitcoin ticker data from blockchain.info
#'
#' Obtain ticker data for Bitcoin using the \code{blockchain.info} API.
#'
#' This function is a wrapper around \code{\link{ticker}}.
#'
#' @param fiat character, may be a vector. Fiat currencies to convert Bitcoin value. Return all available if \code{NULL}.
#'
#' @return a data frame.
#' @seealso \code{\link{ticker}}
#' @export
#'
#' @examples
#' \dontrun{
#' bcinfo()
#' bcinfo(fiat = c("USD", "EUR", "GBP"))
#' }
bcinfo <- function(fiat = NULL){
  if(any(!fiat %in% fiat_symbols("blockchain.info"))) stop("Invalid `fiat` symbol.")
  ticker(convert = fiat, api = "blockchain.info")
}

#' Cryptocurrency ticker/market cap data
#'
#' Get cryptocurrency ticker/market cap data from a specified API.
#'
#' The current implementation of this function offers two common APIs: \code{coinmarketcap.com} and \code{blockchain.info}.
#' \code{coinmarketcap.com} returns ticker/market cap information for many different cryptocurrencies and their value
#' can be expressed in any of several fiat currencies (e.g., USD) or other cryptocurrencies (e.g. BTC).
#' \code{blockchain.info} is specific to Bitcoin. It only returns Bitcoin information, which can be expressed in any of several fiat currencies.
#'
#' \code{crypto} and \code{convert} are not case sensitive to cryptocurrency ticker symbols. Both arguments are handled somewhat different for each API.
#' For simplicity, there are available wrapper functions,
#' \code{\link{cap}} and \code{\link{bcinfo}}, that help separate the APIs and what information you intend to obtain from each.
#'
#' \code{crypto} and \code{convert} may be vectors, though of course for \code{blockchain.info}, \code{crypto} is simply ignored.
#' For \code{coinmarketcap.com}, the default \code{crypto = NULL} will return all available cryptocurrencies tracked by \code{coinmarketcap.com}.
#' If an integer, the top \code{crypto} cryptocurrencies by market cap are returned by the \code{coinmarketcap.com} API.
#'
#' \code{convert} may be \code{NULL}. This is handled differently by each API. For \code{coinmarketcap.com}, USD is assumed in order to limit the number of API calls.
#' For \code{blockchain.info} all available fiat currency-Bitcoin ticker pairs are returned.
#'
#' @param crypto character, integer or \code{NULL}. See details.
#' @param convert character or \code{NULL}, conversion currency trading symbol. See details.
#' @param api character, the API to use. Defaults to \code{"coinmarketcap.com"}. See \code{\link{apis}}.
#'
#' @return a data frame. Available columns depend on the selected API.
#' @seealso \code{\link{cap}}, \code{\link{bcinfo}}
#' @export
#'
#' @examples
#' \dontrun{
#' ticker()
#' ticker(crypto = 5)
#' ticker(crypto = c("ETH", "LTC"), convert = c("EUR", "GBP", "BTC"))
#' ticker(api = "blockchain.info")
#' }
ticker <- function(crypto = NULL, convert = "USD", api = "coinmarketcap.com"){
  if(length(api) > 1) stop("Choose one API. See `apis()` for available APIs.")
  if(is.character(convert)) convert <- toupper(convert)
  if(is.character(crypto)) crypto <- toupper(crypto)
  if(api == "coinmarketcap.com") x <- .ticker_cmc(crypto, convert)
  if(api == "blockchain.info") x <- .ticker_bcinfo(convert)
  x
}

.ticker_cmc <- function(crypto, convert){
  if(length(convert) == 1){
    x <- jsonlite::fromJSON(.ticker_url("coinmarketcap.com", crypto, convert))
  } else {
    x <- jsonlite::fromJSON(.ticker_url("coinmarketcap.com", crypto, convert[1]))
    convert <- convert[-1]
    convert <- convert[convert != "USD"]
    if(length(convert)){
      x2 <- purrr::map(convert, ~.cmc_convert_cols(crypto, .x)) %>% dplyr::bind_cols()
      x <- dplyr::bind_cols(x, x2)
    }
  }
  if(length(crypto) > 1) x <- dplyr::filter(x, .data[["symbol"]] %in% crypto)
  tibble::as_data_frame(x) %>% dplyr::mutate_at(4, factor) %>% dplyr::mutate_at(5:15, as.numeric)
}

.ticker_bcinfo <- function(convert){
  x <- jsonlite::fromJSON("https://blockchain.info/ticker")
  symbols <- names(x)
  x <- purrr::transpose(x) %>% tibble::as_data_frame() %>% tidyr::unnest() %>%
    dplyr::mutate(currency = symbols)
  if(!is.null(convert)) x <- dplyr::filter(x, .data[["currency"]] %in% convert)
  x
}

.ticker_url <- function(x, crypto, convert){
  if(x == "coinmarketcap.com"){
    if(is.null(crypto) || is.character(crypto)){
      cmc <- "https://api.coinmarketcap.com/v1/ticker/?convert="
    } else if(is.numeric(crypto)){
      cmc <- paste0("https://api.coinmarketcap.com/v1/ticker/?limit=", as.integer(crypto), "&convert=")
    }
    if(is.character(crypto) && length(crypto) == 1)
      cmc <- gsub("/ticker/", paste0("/ticker/", coin_id(crypto), "/"), cmc) # nolint
  }
  switch(x, coinmarketcap.com = paste0(cmc, convert), blockchain.info = "https://blockchain.info/ticker")
}

.cmc_convert_cols <- function(crypto, convert){
  x <- jsonlite::fromJSON(.ticker_url("coinmarketcap.com", crypto, convert))
  y <- names(x)
  drops <- c("price_usd", "price_btc", "24h_volume_usd", "market_cap_usd")
  keeps <- c("price_", "24h_vo", "market")
  idx <- which(!y %in% drops & substr(y, 1, 6) %in% keeps)
  dplyr::select(x, idx)
}
