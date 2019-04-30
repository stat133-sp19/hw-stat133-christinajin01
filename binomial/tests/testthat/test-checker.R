context("Check binomial checker functions")


test_that("check_prob with valid and invalid probabilities",{
  expect_true(check_prob(0.5))
  expect_true(check_prob(1))
  expect_error(ckeck_prob(-1))
  expect_error(check_prob(c(0.5, 0.6)))
})


test_that("check_trials with valid and invalid trials",{
  expect_true(check_trials(0))
  expect_true(check_trials(10))
  expect_error(check_trials(-2))
  expect_error(check_trials(c(2, 3)))
  expect_error(check_trials(0.5))
})


test_that("check_success with valid and invalid number of successes",{
  expect_true(check_success(2, 6))
  expect_true(check_success(1:6, 10))
  expect_error(check_success(-2, 4))
  expect_error(check_success(1.5, 5))
  expect_error(check_success(c(1,2,3), 1))
})