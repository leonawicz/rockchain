# rockchain 0.3.1 (Release date: 2018-01-10)

* Added Bitcoin unit conversion functions.
* Updated `coins` metadata data set, readme, introduction vignette, unit tests and function documentation.

# rockchain 0.3.0

* Added integer option to `cap` and `ticker` to return the top n cryptocurrencies by market cap via the `coinmarketcap.com` API.
* Added `coins` metadata data set and related helper functions for direct access to stored cryptocurrency IDs, names and symbols.
* Added introduction vignette content.
* Added unit tests.
* Updated documentation.

# rockchain 0.2.0

* Refactored `wallet` and related support functions.
* Addressed issue with intermittent `blockchain.info` connectivity.
* Updated documentation.

# rockchain 0.1.0

* Refactored `ticker` and add related functions.
* Updated documentation.

# rockchain 0.0.1

* Added functions and documentation, including improvement to `wallet`.
    * Renamed `wallet_info` to `wallet`.
    * Added wallet helper functions.
    * Generalized `wallet` to handled paged results from blockchain.info and take additional arguments including a transaction number offset and maximum number of transactions to download.
    * By default, wallet now returns bitcoin value rather than sataoshi.

# rockchain 0.0.0.9000

* Initialized development of `rockchain` and set up package scaffolding.
