#' @title Binomial choose
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k number of successes or a vector of number of successes
#' @return number of combinations in which k successes can occur in n trials
#' @export
#' @examples
#' How many combinations if there are 2 successes in 5 trials?
#' bin_choose(n = 5, k = 2)
#' How many combinations if there are 0 successes in 5 trials?
#' bin_choose(5, 0)
#' How many combinations if there are 1 to 3 successes in 5 trials?
#' bin_choose(5, 1:3)
bin_choose <- function(n,k) {
  if (any(k > n)){
    stop("k cannot be greater than n")
  }
  return(factorial(n) / (factorial(k) * factorial(n-k)))
}


#' @title Binomial probability
#' @description calculates the probability of a specified number of successes in a specified number of trials with certain probability
#' @param success number of successes or a vector of number of successes
#' @param trials number of trials
#' @param prob probability of successes
#' @return probability of a specified number of successes in a specified number of trials with certain probability
#' @export
#' @examples
#' What is the probability of getting 2 successes in 5 trials? (assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' What are the probabilities of getting 2 or less successes in 5 trials? (assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
bin_probability <- function(success, trials, prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  return(bin_choose(trials, success) * prob^success *(1-prob)^(trials-success))
}


#' @title Binomial distribution
#' @description creates a dataframe for the probability of each number of successes with specified probability in a specified number of trials
#' @param trials number of trials
#' @param prob probability of successes
#' @return a data frame indicating the probabality of each number of successes
#' @export
#' @examples
#' What is the binomial distribution with prob of success = 0.5 in 5 trials?
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  dat <- data.frame(success, probability)
  class(dat) <- c("bindis", "data.frame")
  return(dat)
}


#' @export
#' @examples
#' Plot a binomial probability distribution
#' dis1 <- bin_distribution(trials = 5, prob = 0.5)
#' plot(dis1)
plot.bindis <- function(x){
  return(barplot(x$probability,
                 xlab = "successes",
                 ylab = "probability",
                 names.arg = x$success))
}


#' @title Binomial cumulative
#' @description Creates a dataframe for cumulative probability of each success with specified probability in a specified number of trials
#' @param trials number of trials
#' @param prob probability of success
#' @return create a data frame of cumilative probability of a binomial distribution
#' @export
#' @examples
#' Find a binomial cumulative probability distribution
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob){
  dat <- bin_distribution(trials, prob)
  cumulative <- vector()
  for (i in 1:(trials+1)) {
    cumulative[i] <- sum(dat$probability[1:i])
  }
  dat$cumulative <- cumulative
  class(dat) <- c("bincum", "data.frame")
  return(dat)
}

#' @export
#' @examples
#' Display a line graph of a binomial cumilative distribution
#' dis2 <- bin_cumulative(trials = 5, prob = 0.5)
#' plot(dis2)
plot.bincum <- function(x) {
  plot(x$success, x$cumulative, type = "o",
       xlab = "successes", ylab ="probability")
}


#' @title Binomial variable
#' @description generates a binomial random variable object
#' @param trials number of trials
#' @param prob probability of success
#' @return An object of class "binvar"
#' @export
#' @examples
#' Bulid a binomial variable
#' bin1 <- bin_variable(trials = 10, prob = 0.3)
#' Summarize a binomial variable with statistics
#' summary(bin1)
bin_variable <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  object <- list(
    trials = trials,
    prob = prob
  )
  class(object) <- "binvar"
  return(object)
}

#' @export
print.binvar <- function(x){
  cat('"Binomial variable"\n\n')
  cat('Parameters\n')
  cat(sprintf("- number of trials: %s\n", x$trials))
  cat(sprintf("- prob of success : %s", x$prob))
}

#' @export
summary.binvar <- function(x){
  out <- list(
    trials = x$trials,
    prob = x$prob,
    mean = aux_mean(x$trials, x$prob),
    variance = aux_variance(x$trials,x$prob),
    mode = aux_mode(x$trials,x$prob),
    skewness = aux_skewness(x$trials,x$prob),
    kurtosis = aux_kurtosis(x$trials,x$prob))
  class(out) <- "summary.binvar"
  return(out)
}

#' @export
print.summary.binvar <- function(x){
  cat('"Summary Binomial"\n\n')
  cat('Parameters\n')
  cat(sprintf("- number of trials: %s\n", x$trials))
  cat(sprintf("- prob of success : %s\n\n", x$prob))
  cat('Measures\n')
  cat(sprintf("- mean    : %s\n", x$mean))
  cat(sprintf("- variance: %s\n", x$variance))
  cat(sprintf("- mode    : %s\n", x$mode))
  cat(sprintf("- skewness: %s\n", x$skewness))
  cat(sprintf("- kurtosis: %s\n", x$kurtosis))
}



#' @title Binomial mean
#' @description calculates the mean of a binomal distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return the mean of a binomal distribution
#' @export
#' @examples
#' What is the mean of number of successes in 10 trials with prob of success = 0.3?
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bin_mean <- aux_mean(trials, prob)
  return(bin_mean)
}


#' @title Binomial variance
#' @description calculates the variance of a binomal distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return the variance of a binomal distribution
#' @export
#' @examples
#' What is the variance of number of successes in 10 trials with prob of success = 0.3?
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bin_variance <- aux_variance(trials, prob)
  return(bin_variance)
}


#' @title Binomial mode
#' @description calculates the mode of a binomal distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return the mode of a binomal distribution
#' @export
#' @examples
#' What is the mode of number of successes in 10 trials with prob of success = 0.3?
#' bin_mode(10, 0.3)
bin_mode <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bin_mode <- aux_mode(trials, prob)
  return(bin_mode)
}

#' @title Binomial skewness
#' @description calculates the skewness of a binomal distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return the skewness of a binomal distribution
#' @export
#' @examples
#' What is the skewness of number of successes in 10 trials with prob of success = 0.3?
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bin_skewness <- aux_skewness(trials, prob)
  return(bin_skewness)
}


#' @title Binomial kurtosis
#' @description calculates the kurtosis of a binomal distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return the kurtosis of a binomal distribution
#' @export
#' @examples
#' What is the kurtosis of number of successes in 10 trials with prob of success = 0.3?
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bin_kurtosis <- aux_kurtosis(trials, prob)
  return(bin_kurtosis)
}
