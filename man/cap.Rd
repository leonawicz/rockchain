% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ticker.R
\name{cap}
\alias{cap}
\title{Global cryptocurrency market cap}
\usage{
cap(crypto = NULL, convert = "USD")
}
\arguments{
\item{crypto}{character, integer or \code{NULL}, may be a vector. See details.}

\item{convert}{character, may be a vector. Currencies to convert \code{crypto} value. These may be fiat or cryptocurrencies.}
}
\value{
a data frame.
}
\description{
Obtain global cryptocurrency market cap data from \code{coinmarketcap.com}.
}
\details{
Return all tracked cryptocurrencies if \code{crypto = NULL}. Return global aggregate market cap if \code{crypto = "global"}.
If an integer, return the top \code{crypto} cryptocurrencies by market cap.
Otherwise \code{crypto} should be a vector of cryptocurrency ticker symbols, e.g., BTC.
This function is a partial wrapper around \code{\link{ticker}} (when \code{crypto = "global"}).
}
\examples{
\dontrun{
cap()
cap(crypto = "global")
cap(crypto = c("ETH", "LTC"), convert = c("EUR", "GBP", "BTC"))
}
}
\seealso{
\code{\link{ticker}}
}
