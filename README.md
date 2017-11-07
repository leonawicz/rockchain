
<!-- README.md is generated from README.Rmd. Please edit that file -->
rockchain
=========

[![Travis-CI Build Status](https://travis-ci.org/leonawicz/rockchain.svg?branch=master)](https://travis-ci.org/leonawicz/rockchain) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/leonawicz/rockchain?branch=master&svg=true)](https://ci.appveyor.com/project/leonawicz/rockchain) [![Coverage Status](https://img.shields.io/codecov/c/github/leonawicz/rockchain/master.svg)](https://codecov.io/github/leonawicz/rockchain?branch=master)

The `rockchain` package provides simple interfaces to [coinmarketcap.com](https://coinmarketcap.com/) ticker and market cap data and [blockchain.info](https://blockchain.info/) ticker and Bitcoin wallet data. The current package does not yet support additional blockchain APIs, but will in the future. For now, it offers cryptocurrency market data retrieval and Bitcoin wallet transaction data retrieval via the two currently available APIs.

Installation
------------

You can install rockchain from github with:

``` r
# install.packages('devtools')
devtools::install_github("leonawicz/rockchain")
```

Example
-------

``` r
library(rockchain)
cap()
#> # A tibble: 1,265 x 15
#>                  id             name symbol  rank price_usd  price_btc
#>  *            <chr>            <chr>  <chr> <chr>     <chr>      <chr>
#>  1          bitcoin          Bitcoin    BTC     1   7122.48        1.0
#>  2         ethereum         Ethereum    ETH     2   298.668  0.0422735
#>  3     bitcoin-cash     Bitcoin Cash    BCH     3   616.899  0.0873158
#>  4           ripple           Ripple    XRP     4  0.205253 0.00002905
#>  5         litecoin         Litecoin    LTC     5   55.2786 0.00782413
#>  6             dash             Dash   DASH     6   285.829  0.0404562
#>  7              neo              NEO    NEO     7   26.0908 0.00369289
#>  8              nem              NEM    XEM     8  0.185554 0.00002626
#>  9           monero           Monero    XMR     9   100.028   0.014158
#> 10 ethereum-classic Ethereum Classic    ETC    10   14.6268 0.00207027
#> # ... with 1,255 more rows, and 9 more variables: `24h_volume_usd` <chr>,
#> #   market_cap_usd <chr>, available_supply <chr>, total_supply <chr>,
#> #   max_supply <chr>, percent_change_1h <chr>, percent_change_24h <chr>,
#> #   percent_change_7d <chr>, last_updated <chr>

w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
#> Recent API call. Waiting for turn. 9.75 seconds until next API call...
#> Recent API call. Waiting for turn. 9.96 seconds until next API call...
balance(w)
#> [1] 0.09
```

For more details see the [vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
