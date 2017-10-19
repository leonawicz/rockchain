#' Wallet helper functions
#'
#' These helpers are simple getter functions for convenient access to specific wallet information.
#'
#' @param x a wallet list object. See \link{wallet}.
#' @name wallet_helpers
#'
#' @return vectorized results pertaining to each element in \code{x}. For \code{transactions}, a combined data frame with a wallet \code{address} column.
#'
#' @examples
#' \dontrun{
#' x <- wallet("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")
#' hash(x)
#' address(x)
#' received(x)
#' sent(x)
#' balance(x)
#' txn(x)
#' transactions(x)
#' }
NULL

#' @export
#' @rdname wallet_helpers
hash <- function(x){
  .stop_wallet(x)
  purrr::map_chr(x, "hash160")
}

#' @export
#' @rdname wallet_helpers
address <- function(x){
  .stop_wallet(x)
  purrr::map_chr(x, "address")
}

#' @export
#' @rdname wallet_helpers
received <- function(x){
  .stop_wallet(x)
  purrr::map_dbl(x, "total_received")
}

#' @export
#' @rdname wallet_helpers
sent <- function(x){
  .stop_wallet(x)
  purrr::map_dbl(x, "total_sent")
}

#' @export
#' @rdname wallet_helpers
balance <- function(x){
  .stop_wallet(x)
  purrr::map_dbl(x, "final_balance")
}

#' @export
#' @rdname wallet_helpers
txn <- function(x){
  .stop_wallet(x)
  purrr::map_int(x, "n_tx")
}

#' @export
#' @rdname wallet_helpers
transactions <- function(x){
  id <- address(x)
  purrr::map2(x, id, ~dplyr::mutate(.x$txs, address = .y)) %>%
    dplyr::bind_rows()
}

.stop_wallet <- function(x) if(!"wallet" %in% class(x)) stop("Input is not a `wallet` list.")
