
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
#> # A tibble: 100 x 15
#>              id         name symbol   rank    price_usd  price_btc
#>           <chr>        <chr>  <chr> <fctr>        <dbl>      <dbl>
#>  1      bitcoin      Bitcoin    BTC      1 11455.300000 1.00000000
#>  2     ethereum     Ethereum    ETH      2   465.503000 0.04085340
#>  3 bitcoin-cash Bitcoin Cash    BCH      3  1545.480000 0.13563400
#>  4       ripple       Ripple    XRP      4     0.250417 0.00002198
#>  5         iota         IOTA  MIOTA      5     2.776470 0.00024367
#>  6         dash         Dash   DASH      6   761.527000 0.06683300
#>  7     litecoin     Litecoin    LTC      7   101.047000 0.00886808
#>  8 bitcoin-gold Bitcoin Gold    BTG      8   322.052000 0.02826390
#>  9      cardano      Cardano    ADA      9     0.136738 0.00001200
#> 10       monero       Monero    XMR     10   201.181000 0.01765600
#> # ... with 90 more rows, and 9 more variables: `24h_volume_usd` <dbl>,
#> #   market_cap_usd <dbl>, available_supply <dbl>, total_supply <dbl>,
#> #   max_supply <dbl>, percent_change_1h <dbl>, percent_change_24h <dbl>,
#> #   percent_change_7d <dbl>, last_updated <dbl>

w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
#> Recent API call. Waiting for turn. 9.8 seconds until next API call...
#> Recent API call. Waiting for turn. 9.95 seconds until next API call...
balance(w)
#> [1] 0.09
```

For more details see the [vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
