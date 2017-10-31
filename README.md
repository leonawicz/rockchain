
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
#> # A tibble: 1,234 x 14
#>              id         name symbol  rank price_usd  price_btc
#>  *        <chr>        <chr>  <chr> <chr>     <chr>      <chr>
#>  1      bitcoin      Bitcoin    BTC     1   6132.02        1.0
#>  2     ethereum     Ethereum    ETH     2   307.378  0.0501613
#>  3       ripple       Ripple    XRP     3  0.202405 0.00003303
#>  4 bitcoin-cash Bitcoin Cash    BCH     4   449.369  0.0733328
#>  5     litecoin     Litecoin    LTC     5    56.365 0.00919825
#>  6         dash         Dash   DASH     6   285.386  0.0465723
#>  7          neo          NEO    NEO     7   28.6905 0.00468203
#>  8          nem          NEM    XEM     8  0.199406 0.00003254
#>  9   bitconnect   BitConnect    BCC     9   227.381  0.0371065
#> 10       monero       Monero    XMR    10   88.7478  0.0144828
#> # ... with 1,224 more rows, and 8 more variables: `24h_volume_usd` <chr>,
#> #   market_cap_usd <chr>, available_supply <chr>, total_supply <chr>,
#> #   percent_change_1h <chr>, percent_change_24h <chr>,
#> #   percent_change_7d <chr>, last_updated <chr>

w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
balance(w)
#> [1] 0.09
```

For more details see the [vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
