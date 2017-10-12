globalVariables(".data")

#' rockchain: insert text here.
#'
#' The \code{rockchain} package...
#'
#' @docType package
#' @name rockchain
NULL

#' @importFrom magrittr %>%
NULL

#' Get wallet info
#'
#' Get wallet info from blockchain.info.
#'
#' The current implementation of this function grabs information for specified wallets only from \url{blockchain.info}.
#'
#' @param id character, wallet ID.
#'
#' @return a list.
#' @export
#'
#' @examples
#' \dontrun{wallet_info("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")}
wallet_info <- function(id){
  sprintf("https://blockchain.info/rawaddr/%s", id) %>%
    purrr::map(jsonlite::fromJSON) %>%
    purrr::map(~({
      x <- .x
      x[7][[1]] <- tibble::as_data_frame(x[7][[1]])
      x
    })
    )
}

#' Get the current value of a cryptocurrency
#'
#' Get the current value of cryptocurrency in terms of fiat currencies.
#'
#' The current implementation of this function only accepts code{crypto = "BTC"}.
#' \code{crypto} and \code{fiat} are not case sensitive.
#' \code{fiat} may be a vector. If missing, all available fiat currency values are returned.
#'
#' @param crypto character, cryptocurrency trading symbol, e.g. BTC.
#' @param fiat character, fiat currency trading symbol, e.g., USD.
#'
#' @return a data frame.
#' @export
#'
#' @examples
#' coin_value()
coin_value <- function(crypto = "BTC", fiat){
  crypto <- toupper(crypto)
  if(crypto != "BTC") stop("Only 'BTC' is currently available for `symbol`.")
  if(crypto == "BTC") {
    x <- jsonlite::fromJSON("https://blockchain.info/ticker")
    symbols <- names(x)
    x <- purrr::transpose(x) %>% tibble::as_data_frame() %>% tidyr::unnest() %>%
      dplyr::mutate(currency = symbols)
    idx <- c(ncol(x), 2:(ncol(x) - 1))
    x <- dplyr::select(x, idx)
  }
  if(missing(fiat)) return(x)
  fiat <- toupper(fiat)
  if(!inherits(fiat, "character")) stop("Invalid `fiat`")
  dplyr::filter(x, .data[["currency"]] %in% fiat)
}
