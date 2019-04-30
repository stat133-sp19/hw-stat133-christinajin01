#private auxiliary function to calculate the mean
aux_mean <- function(trials, prob){
  return(trials * prob)
}

#private auxiliary function to calculate the variance
aux_variance <- function(trials, prob){
  return(trials * prob * (1-prob))
}

#private auxiliary function to calculate the mode
aux_mode <- function(trials,prob){
  m <- trials * prob + prob
  if (m == floor(m)) {
    return(c(m-1, m))
  } else {
    return(floor(m))
  }
}

#private auxiliary function to calculate the skewness
aux_skewness <- function(trials, prob){
  return((1 - 2 * prob) / sqrt(trials * prob * (1-prob)))
}

#private auxiliary function to calculate the kurtosis
aux_kurtosis <- function(trials, prob){
  return((1 - 6 * prob * (1 - prob)) / (trials * prob * (1-prob)))
}