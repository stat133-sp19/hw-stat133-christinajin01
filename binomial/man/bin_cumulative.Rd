% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/binomialfunctions.R
\name{bin_cumulative}
\alias{bin_cumulative}
\title{Binomial cumulative}
\usage{
bin_cumulative(trials, prob)
}
\arguments{
\item{trials}{number of trials}

\item{prob}{probability of success}
}
\value{
create a data frame of cumilative probability of a binomial distribution
}
\description{
Creates a dataframe for cumulative probability of each success with specified probability in a specified number of trials
}
\examples{
Find a binomial cumulative probability distribution
bin_cumulative(trials = 5, prob = 0.5)
}
