#private function to check if probability is valid
check_prob <- function(prob){
  if (length(prob) != 1) {
    stop("p has to be a number between 0 and 1")
  }
  if (prob <= 1 & prob >= 0) {
    return(TRUE)
  } else {
    stop("p has to be a number between 0 and 1")
  }
}

#private function to check if the number of trials is valid
check_trials <- function(trials){
  if (length(trials) != 1) {
    stop("invalid trials value")
  }
  if (trials == floor(trials) & trials >= 0) {
    return(TRUE)
  } else {
    stop("invalid trials value")
  }
}

#private function to check if the number of successes is valid
check_success <- function(success, trials){
  if(any(success != floor(success) | success < 0)){
    stop("invalid success value")
  } else if (any(success > trials)){
    stop("success cannot be greater than trials")
  } else {
    return(TRUE)
  }
}
