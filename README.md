
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
#> # A tibble: 1,415 x 15
#>    id      name    symbol rank  price_~ price_~ `24h_vo~ market_~ availab~
#>    <chr>   <chr>   <chr>  <fct>   <dbl>   <dbl>    <dbl>    <dbl>    <dbl>
#>  1 bitcoin Bitcoin BTC    1     1.38e+4 1.00e+0  1.28e10  2.32e11  1.68e 7
#>  2 ethere~ Ethere~ ETH    2     1.25e+3 9.11e-2  5.59e 9  1.21e11  9.69e 7
#>  3 ripple  Ripple  XRP    3     2.02e+0 1.46e-4  3.96e 9  7.81e10  3.87e10
#>  4 bitcoi~ Bitcoi~ BCH    4     2.57e+3 1.87e-1  1.16e 9  4.35e10  1.69e 7
#>  5 cardano Cardano ADA    5     8.35e-1 6.07e-5  2.46e 8  2.17e10  2.59e10
#>  6 liteco~ Liteco~ LTC    6     2.34e+2 1.70e-2  7.56e 8  1.28e10  5.47e 7
#>  7 nem     NEM     XEM    7     1.40e+0 1.02e-4  6.89e 7  1.26e10  9.00e 9
#>  8 stellar Stellar XLM    8     6.76e-1 4.91e-5  4.00e 8  1.21e10  1.79e10
#>  9 iota    IOTA    MIOTA  9     3.59e+0 2.61e-4  1.37e 8  9.97e 9  2.78e 9
#> 10 eos     EOS     EOS    10    1.43e+1 1.04e-3  2.34e 9  8.58e 9  5.99e 8
#> # ... with 1,405 more rows, and 6 more variables: total_supply <dbl>,
#> #   max_supply <dbl>, percent_change_1h <dbl>, percent_change_24h <dbl>,
#> #   percent_change_7d <dbl>, last_updated <dbl>

w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
#> Recent API call. Waiting for turn. 9.83 seconds until next API call...
#> Recent API call. Waiting for turn. 9.98 seconds until next API call...
balance(w)
#> [1] 0.2094557
```

For more details see the [vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
