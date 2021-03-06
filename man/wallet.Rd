% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wallet.R
\name{wallet}
\alias{wallet}
\title{Get wallet info}
\usage{
wallet(id, satoshi = FALSE, offset = 0, tx_max = 100, max_attempts = 10)
}
\arguments{
\item{id}{character, wallet ID.}

\item{satoshi}{logical, if set to \code{TRUE}, retain Satoshi units from blockchain.info. Otherwise all values are in Bitcoin (\code{Satoshis / 10e7}).}

\item{offset}{integer, shift transaction number retrieval forward by this amount.}

\item{tx_max}{integer, maximum number of transactions to return. Defaults to 100. \code{NULL} will attempt to retrieve all transactions.}

\item{max_attempts}{integer, maximum number of recursive attempts to connect to \code{blockchain.info} in case of connection error.}
}
\value{
a list.
}
\description{
Get wallet info from blockchain.info.
}
\details{
The current implementation of this function grabs information for specified wallets only from \url{blockchain.info}.
Note that it is possible to get a connection error if you make too many API calls too quickly or just get unlucky with \code{blockchain.info} accessibility.
\code{wallet} will attempt connection recursively up to \code{max_attempts} times. The default is ten attempts.
If the first attempt fails, a notification will print to the console.
If not successful after \code{max_attempts} attempts, a failure notification will be printed.
}
\examples{
\dontrun{wallet("1KennyH9grzif79WbaQDHpqgTnm25j4rRj")}
}
