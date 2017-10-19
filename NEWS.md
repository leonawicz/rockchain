# rockchain 0.0.1

* Added functions and documentation, including improvement to `wallet`.
    * Renamed `wallet_info` to `wallet`.
    * Added wallet helper functions.
    * Generalized `wallet` to handled paged results from blockchain.info and take additional arguments including a transaction number offset and maximum number of transactions to download.
    * By default, wallet now returns bitcoin value rather than sataoshi.

# rockchain 0.0.0.9000

* Initialized development of `rockchain` and set up package scaffolding.
