% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/binomialfunctions.R
\name{bin_probability}
\alias{bin_probability}
\title{Binomial probability}
\usage{
bin_probability(success, trials, prob)
}
\arguments{
\item{success}{number of successes or a vector of number of successes}

\item{trials}{number of trials}

\item{prob}{probability of successes}
}
\value{
probability of a specified number of successes in a specified number of trials with certain probability
}
\description{
calculates the probability of a specified number of successes in a specified number of trials with certain probability
}
\examples{
What is the probability of getting 2 successes in 5 trials? (assuming prob of success = 0.5)
bin_probability(success = 2, trials = 5, prob = 0.5)
What are the probabilities of getting 2 or less successes in 5 trials? (assuming prob of success = 0.5)
bin_probability(success = 2, trials = 5, prob = 0.5)
}
