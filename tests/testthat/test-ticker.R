context("ticker")

test_that("ticker, cap and bcinfo return as expected", {
  x1 <- ticker()
  x1b <- cap()

  x2 <- ticker(crypto = 5)
  x2b <- cap(crypto = 5)

  x3 <- ticker(crypto = c("ETH", "LTC"), convert = c("EUR", "GBP", "BTC"))
  x3b <- cap(crypto = c("ETH", "LTC"), convert = c("EUR", "GBP", "BTC"))

  x4 <- ticker(convert = NULL, api = "blockchain.info")
  x4b <- bcinfo()

  x5 <- ticker("LTC")
  x5b <- cap("LTC")

  purrr::walk(list(x1, x2, x3, x4, x5), ~expect_is(.x, "tbl_df"))
  purrr::walk2(list(x1, x2, x3, x4, x5), list(x1b, x2b, x3b, x4b, x5b), ~expect_identical(dim(.x), dim(.y)))
  expect_equal(c(nrow(x2), nrow(x2b)), c(5, 5))
  expect_equal(c(nrow(x3), nrow(x3b)), c(2, 2))
  expect_equal(c(nrow(x5), nrow(x5b)), c(1, 1))
  expect_equal(ncol(x1) + 3 * 3 - 1, ncol(x3)) # 3 cols per new currency - 1 Bitcoin duplicate

  err <- "Invalid coin provided. See `rockchain::coins` data set."
  purrr::walk(list(ticker, cap), ~expect_error(.x("a"), err))
  err <- "Cannot combine 'global' with individual coin symbols for `crypto`."
  expect_error(cap(crypto = c("BTC", "global")), err)
})
