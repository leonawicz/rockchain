#' Get wallet info
#'
#' Get wallet info from blockchain.info.
#'
#' The current implementation of this function grabs information for specified wallets only from \url{blockchain.info}.
#' Note that it is possible to get a connection error if you make too many API calls too quickly or just get unlucky with \code{blockchain.info} accessibility.
#' \code{wallet} will attempt connection recursively up to \code{max_attempts} times. The default is ten attempts.
#' If the first attempt fails, a notification will print to the console.
#' If not successful after \code{max_attempts} attempts, a failure notification will be printed.
#'
#' @param id character, wallet ID.
#' @param satoshi logical, if set to \code{TRUE}, retain Satoshi units from blockchain.info. Otherwise all values are in Bitcoin (\code{Satoshis / 10e7}).
#' @param offset integer, shift transaction number retrieval forward by this amount.
#' @param tx_max integer, maximum number of transactions to return. Defaults to 100. \code{NULL} will attempt to retrieve all transactions.
#' @param max_attempts integer, maximum number of recursive attempts to connect to \code{blockchain.info} in case of connection error.
#'
#' @return a list.
#' @export
#'
#' @examples
#' \dontrun{wallet("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")}
wallet <- function(id, satoshi = FALSE, offset = 0, tx_max = 100, max_attempts = 10){
  url <- "https://blockchain.info/rawaddr/%s?offset="
  url1 <- paste0(url, offset)
  x <- .get_wallet(id, url1, satoshi, max_attempts)
  if(!is.list(x)) return(invisible())
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
    x <- .combine_wallet(id, url2, satoshi, max_attempts)
    if(!is.list(x)) return(invisible())
  }
  class(x) <- c("wallet", "list")
  x
}

.antiddos <- function(x, sec = getOption("rockchain_antiddos", 10)){
  wait <- 0
  if(!is.null(rockchain_api_time[[x]])){
    wait <- as.numeric(get(x, rockchain_api_time)) + sec - as.numeric(Sys.time())
    if(wait > 0){
      cat("Recent API call. Waiting for turn.", round(wait, 2), "seconds until next API call...\n")
      Sys.sleep(wait)
    } else {
      wait <- 0
    }
  }
  assign(x, Sys.time(), envir = rockchain_api_time)
  return(wait)
}

.try_wallet <- function(url, id){
  tryCatch({
    purrr::map(sprintf(url, id), ~({
      .antiddos("bci")
      curl <- RCurl::getCurlHandle(useragent = paste("rockchain", packageVersion("rockchain")))
      json <- rawToChar(RCurl::getURLContent(curl = curl, url = .x, binary = TRUE))
      assign("bci", Sys.time(), envir = rockchain_api_time)
      out <- jsonlite::fromJSON(json)
    })
    )
  }, error = function(e) { "Please wait for connection...\n" }) # nolint
}

.get_wallet <- function(id, url, satoshi = FALSE, max_attempts = 10){
  fail_message <- "All connection attempts failed. Try increasing `max_attempts`.\n"
  x <- .try_wallet(url, id)
  attempt <- 1
  while(is.character(x) & attempt <= max_attempts) {
    if(attempt == 1) cat(x)
    attempt <- attempt + 1
    x <- .try_wallet(url, id)
  }
  if(is.list(x)) .format_wallet(x, satoshi) else message(fail_message)
}

.format_wallet <- function(x, satoshi = FALSE){
  purrr::map(x, ~({
    x <- .x
    x$txs <- tibble::as_data_frame(x$txs) %>% dplyr::arrange(desc(.data[["tx_index"]]))
    if(!satoshi){
      y <- 1e8
      x$total_received <- x$total_received / y
      x$total_sent<- x$total_sent / y
      x$final_balance <- x$final_balance / y
      x$txs$out <- purrr::map(x$txs$out, ~dplyr::mutate(.x, value = .data[["value"]] / y))
    }
    x
  })
  )
}

.combine_wallet <- function(id, urls, satoshi = FALSE, max_attempts = 10){
  purrr::map2(id, urls, ~({
    x <- .get_wallet(.x, .y, satoshi, max_attempts)
    offset <- as.numeric(utils::tail(strsplit(.y, "=")[[1]], 1))
    x[[1]]$txs <- purrr::map2(x, offset, ~.x[["txs"]]) %>% dplyr::bind_rows()
    x[[1]]
    })
  )
}
