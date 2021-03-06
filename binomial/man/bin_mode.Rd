% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/binomialfunctions.R
\name{bin_mode}
\alias{bin_mode}
\title{Binomial mode}
\usage{
bin_mode(trials, prob)
}
\arguments{
\item{trials}{number of trials}

\item{prob}{probability of success}
}
\value{
the mode of a binomal distribution
}
\description{
calculates the mode of a binomal distribution
}
\examples{
What is the mode of number of successes in 10 trials with prob of success = 0.3?
bin_mode(10, 0.3)
}
