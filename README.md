
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
#> # A tibble: 1,398 x 15
#>    id      name    symbol rank  price_~ price_~ `24h_vo~ market_~ availab~
#>    <chr>   <chr>   <chr>  <fct>   <dbl>   <dbl>    <dbl>    <dbl>    <dbl>
#>  1 bitcoin Bitcoin BTC    1     1.46e+4 1.00e+0  1.81e10  2.44e11  1.68e 7
#>  2 ethere~ Ethere~ ETH    2     1.34e+3 9.17e-2  9.72e 9  1.30e11  9.69e 7
#>  3 ripple  Ripple  XRP    3     2.01e+0 1.37e-4  5.46e 9  7.78e10  3.87e10
#>  4 bitcoi~ Bitcoi~ BCH    4     2.70e+3 1.85e-1  1.85e 9  4.57e10  1.69e 7
#>  5 cardano Cardano ADA    5     7.64e-1 5.23e-5  2.35e 8  1.98e10  2.59e10
#>  6 liteco~ Liteco~ LTC    6     2.49e+2 1.71e-2  1.05e 9  1.36e10  5.47e 7
#>  7 nem     NEM     XEM    7     1.47e+0 1.01e-4  1.07e 8  1.33e10  9.00e 9
#>  8 iota    IOTA    MIOTA  8     3.66e+0 2.50e-4  2.32e 8  1.02e10  2.78e 9
#>  9 stellar Stellar XLM    9     5.57e-1 3.81e-5  2.62e 8  9.96e 9  1.79e10
#> 10 dash    Dash    DASH   10    1.09e+3 7.44e-2  2.40e 8  8.48e 9  7.81e 6
#> # ... with 1,388 more rows, and 6 more variables: total_supply <dbl>,
#> #   max_supply <dbl>, percent_change_1h <dbl>, percent_change_24h <dbl>,
#> #   percent_change_7d <dbl>, last_updated <dbl>

w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
#> Recent API call. Waiting for turn. 9.8 seconds until next API call...
#> Recent API call. Waiting for turn. 9.97 seconds until next API call...
balance(w)
#> [1] 0.2094557
```

For more details see the [vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
