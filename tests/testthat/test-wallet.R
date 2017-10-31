context("wallet_helpers")

test_that("wallet helpers return as expected", {
  skip_on_cran()
  skip_on_appveyor()

  if(identical(Sys.getenv("TRAVIS"), "true")){
    x <- rockchain::wlt[[1]]
  } else {
    x <- wallet("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")
    if(nrow(x[[1]]$txs) == 0){
      cat("blockchain.info wallet API inaccessible. Falling back on local data.\n")
      x <- rockchain::wlt[[1]]
    }
  }

  expect_error(hash(list()), "Input is not a `wallet` list.")
  expect_is(hash(x), "character")
  expect_is(address(x), "character")
  expect_is(received(x), "numeric")
  expect_is(sent(x), "numeric")
  expect_is(balance(x), "numeric")
  expect_is(txn(x), "integer")
  expect_is(transactions(x), "tbl_df")
})

test_that("wallet returns as expected", {
  skip_on_cran()
  skip_on_appveyor()

  if(identical(Sys.getenv("TRAVIS"), "true")){
    x <- rockchain::wlt[2:7]
    x1 <- x[[1]]
    x2 <- x[[2]]
    x3 <- x[[3]]
    x4a <- x[[4]]
    x4b <- x[[5]]
    x5 <- x[[6]]
  } else {
    id <- "115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn"
    n <- 20
    x1 <- wallet(id, max_attempts = n)
    x2 <- wallet(id, satoshi = TRUE, max_attempts = n)
    x3 <- wallet(id, offset = 10, max_attempts = n)
    x4a <- wallet(id, offset = 10, tx_max = NULL, max_attempts = n)
    x4b <- wallet(id, offset = 10, tx_max = 1000, max_attempts = n)
    x5 <- wallet(id, offset = 100, max_attempts = n)
    if(any(purrr::map_int(list(x1, x2, x3, x4a, x4b, x5), ~nrow(.x[[1]]$txs) == 0))){
      cat("blockchain.info wallet API inaccessible. Falling back on local data.\n")
      x <- rockchain::wlt[2:7]
      x1 <- x[[1]]
      x2 <- x[[2]]
      x3 <- x[[3]]
      x4a <- x[[4]]
      x4b <- x[[5]]
      x5 <- x[[6]]
    }
  }

  purrr::walk(list(x1, x2, x3, x4a, x4b), ~expect_is(.x, c("wallet", "list")))
  expect_equal(10e7 * x1[[1]]$total_received, x2[[1]]$total_received)
  expect_equal(10e7 * x1[[1]]$total_sent, x2[[1]]$total_sent)
  expect_equal(10e7 * x1[[1]]$final_balance, x2[[1]]$final_balance)
  expect_equal(10e7 * dplyr::bind_rows(x1[[1]]$txs$out)$value, dplyr::bind_rows(x2[[1]]$txs$out)$value)
  purrr::walk(list(x1, x2, x3, x4a, x4b), ~expect_equal(txn(.x), 115))
  purrr::walk2(list(x1, x2, x3, x4a, x4b), c(100, 100, 100, 105, 105),
               ~expect_equal(nrow(.x[[1]]$txs), .y))
  expect_identical(x4a, x4b)

  x <- dplyr::slice(x1[[1]]$txs, 11) %>% dplyr::select(-inputs, -out, -result)
  y <- dplyr::slice(x3[[1]]$txs, 1) %>% dplyr::select(-inputs, -out, -result)
  expect_identical(x, y)
  x <- dplyr::slice(x3[[1]]$txs, 91) %>% dplyr::select(-inputs, -out, -result, -rbf) # note rbf appearance
  y <- dplyr::slice(x5[[1]]$txs, 1) %>% dplyr::select(-inputs, -out, -result)
  expect_identical(x, y)
})
