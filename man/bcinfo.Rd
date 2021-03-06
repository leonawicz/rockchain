% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ticker.R
\name{bcinfo}
\alias{bcinfo}
\title{Bitcoin ticker data from blockchain.info}
\usage{
bcinfo(fiat = NULL)
}
\arguments{
\item{fiat}{character, may be a vector. Fiat currencies to convert Bitcoin value. Return all available if \code{NULL}.}
}
\value{
a data frame.
}
\description{
Obtain ticker data for Bitcoin using the \code{blockchain.info} API.
}
\details{
This function is a wrapper around \code{\link{ticker}}.
}
\examples{
\dontrun{
bcinfo()
bcinfo(fiat = c("USD", "EUR", "GBP"))
}
}
\seealso{
\code{\link{ticker}}
}
