context("rockchain")

test_that("api info is correct", {
  x <- apis()
  expect_equal(nrow(x), 2)
  expect_equal(ncol(x), 3)
  expect_identical(names(x), c("api", "ticker", "wallet"))
  expect_identical(unique(x$api), c("coinmarketcap.com", "blockchain.info"))
  expect_is(x, "tbl_df")
  expect_is(x$ticker, "logical")
  expect_is(x$wallet, "logical")
})

test_that("fiat_symbols info is correct", {
  x1 <- fiat_symbols()
  x2 <- fiat_symbols(api ="coinmarketcap.com")
  x3 <- fiat_symbols(api = "blockchain.info")
  expect_is(x1, "tbl_df")
  expect_is(x2, "character")
  expect_is(x3, "character")
  expect_identical(names(x1), c("currency", "coinmarketcap.com", "blockchain.info"))
})
