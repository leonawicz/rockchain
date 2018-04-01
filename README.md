<!-- README.md is generated from README.Rmd. Please edit that file -->
rockchain <a hef="https://github.com/leonawicz/rockchain/blob/master/data-raw/rockchain.png?raw=true" _target="blank"><img src="https://github.com/leonawicz/rockchain/blob/master/inst/rockchain.png?raw=true" style="margin-bottom:5px;" width="120" align="right"></a>
=========================================================================================================================================================================================================================================================================

[![Travis-CI Build
Status](https://travis-ci.org/leonawicz/rockchain.svg?branch=master)](https://travis-ci.org/leonawicz/rockchain)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/leonawicz/rockchain?branch=master&svg=true)](https://ci.appveyor.com/project/leonawicz/rockchain)
[![Coverage
Status](https://img.shields.io/codecov/c/github/leonawicz/rockchain/master.svg)](https://codecov.io/github/leonawicz/rockchain?branch=master)

The `rockchain` package provides simple interfaces to
[coinmarketcap.com](https://coinmarketcap.com/) ticker and market cap
data and [blockchain.info](https://blockchain.info/) ticker and Bitcoin
wallet data. The current package does not yet support additional
blockchain APIs, but will in the future. For now, it offers
cryptocurrency market data retrieval and Bitcoin wallet transaction data
retrieval via the two currently available APIs.

Installation
------------

You can install rockchain from github with:

    # install.packages('devtools')
    devtools::install_github("leonawicz/rockchain")

Example
-------

    library(rockchain)
    cap()
    #> # A tibble: 1,596 x 15
    #>    id         name       symbol rank  price_usd price_btc `24h_volume_usd`
    #>    <chr>      <chr>      <chr>  <fct>     <dbl>     <dbl>            <dbl>
    #>  1 bitcoin    Bitcoin    BTC    1      6756     1.00            4087320000
    #>  2 ethereum   Ethereum   ETH    2       379     0.0565          1085240000
    #>  3 ripple     Ripple     XRP    3         0.493 0.0000737        224946000
    #>  4 bitcoin-c~ Bitcoin C~ BCH    4       660     0.0984           286396000
    #>  5 litecoin   Litecoin   LTC    5       113     0.0169           253058000
    #>  6 eos        EOS        EOS    6         5.76  0.000859         204308000
    #>  7 cardano    Cardano    ADA    7         0.148 0.0000221        108073000
    #>  8 stellar    Stellar    XLM    8         0.200 0.0000299         64707400
    #>  9 neo        NEO        NEO    9        48.2   0.00719           58079400
    #> 10 iota       IOTA       MIOTA  10        1.06  0.000158          25621200
    #> # ... with 1,586 more rows, and 8 more variables: market_cap_usd <dbl>,
    #> #   available_supply <dbl>, total_supply <dbl>, max_supply <dbl>,
    #> #   percent_change_1h <dbl>, percent_change_24h <dbl>,
    #> #   percent_change_7d <dbl>, last_updated <dbl>

    w <- wallet("115p7UMMngoj1pMvkpHijcRdfJNXj6LrLn")
    #> Recent API call. Waiting for turn. 9.9 seconds until next API call...
    #> Recent API call. Waiting for turn. 9.95 seconds until next API call...
    balance(w)
    #> [1] 0.2694557

For more details see the
[vignette](https://leonawicz.github.io/rockchain/articles/rockchain.html).
