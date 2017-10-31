context("data")

test_that("coin helpers return as expected", {
  x1 <- coin_id(c("btc", "Ethereum"))
  x2 <- coin_name(c("BTC", "BCH"))
  x3 <- coin_symbol("Bitcoin")

  expect_identical(x1, c("bitcoin", "ethereum"))
  expect_identical(x2, c("Bitcoin", "Bitcoin Cash"))
  expect_identical(x3, "BTC")
  err <- "Invalid coin provided. See `rockchain::coins` data set."
  purrr::walk(list(coin_id, coin_name, coin_symbol), ~expect_error(.x("a"), err))
})
