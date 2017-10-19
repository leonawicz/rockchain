#' Get wallet info
#'
#' Get wallet info from blockchain.info.
#'
#' The current implementation of this function grabs information for specified wallets only from \url{blockchain.info}.
#'
#' @param id character, wallet ID.
#' @param satoshi logical, if set to \code{TRUE}, retain Satoshi units from blockchain.info. Otherwise all values are in bitcoin (\code{Satoshis / 10e7}).
#' @param offset integer, shift transaction number retrieval forward by this amount.
#' @param tx_max integer, maximum number of transactions to return. Defaults to 100. \code{NULL} will attempt to retrieve all transactions.
#'
#' @return a list.
#' @export
#'
#' @examples
#' \dontrun{wallet("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")}
wallet <- function(id, satoshi = FALSE, offset = 0, tx_max = 100){
  url <- "https://blockchain.info/rawaddr/%s?offset="
  url1 <- paste0(url, offset)
  x <- .get_wallet(id, url1, satoshi)
  if(any(purrr::map_lgl(x, ~offset > .x$n_tx - 1)))
    stop("Offset cannot be greater than the number of transactions.")
  incomplete <- purrr::map_lgl(x, ~.x$n_tx > offset + 50)
  if(any(incomplete)){
    url2 <- purrr::map2(x, incomplete,
      ~({
        n <- if(is.null(tx_max)) .x$n_tx else min(.x$n_tx, tx_max)
        paste0(url, if(.y) seq(offset, offset + n - 1, by = 50) else 0)
      })
    )
    x <- .combine_wallet(id, url2, satoshi)
  }
  class(x) <- c("wallet", "list")
  x
}

.get_wallet <- function(id, url, satoshi = FALSE){
  sprintf(url, id) %>% purrr::map(jsonlite::fromJSON) %>% .format_wallet(satoshi)
}

.format_wallet <- function(x, satoshi = FALSE){
  purrr::map(x, ~({
    x <- .x
    x[7][[1]] <- tibble::as_data_frame(x[7][[1]])
    if(!satoshi){
      y <- 10e7
      x$total_received <- x$total_received / y
      x$total_sent<- x$total_sent / y
      x$final_balance <- x$final_balance / y
      x$txs$out <- purrr::map(x$txs$out, ~dplyr::mutate(.x, value = .data[["value"]] / y))
    }
    x
  })
  )
}

.combine_wallet <- function(id, urls, satoshi = FALSE){
  purrr::map2(id, urls, ~({
    x <- .get_wallet(.x, .y, satoshi)
    x[[1]]$txs <- purrr::map(x, "txs") %>% dplyr::bind_rows()
    x[[1]]
    })
  )
}
