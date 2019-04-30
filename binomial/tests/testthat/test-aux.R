context("Check binomial auxiliary functions")

test_that("aux_mean returns the correct value",{
  expect_equal(aux_mean(10,0.1),1)
  expect_equal(aux_mean(20,0.2),4)
  expect_equal(aux_mean(30,0.3),9)
})


test_that("aux_variance returns the correct value",{
  expect_equal(aux_variance(10,0.1),0.9)
  expect_equal(aux_variance(20,0.2),3.2)
  expect_equal(aux_variance(30,0.3),6.3)
})

test_that("aux_mode returns the correct value",{
  expect_equal(aux_mode(10,0.1),1)
  expect_equal(aux_mode(20,0.2),4)
  expect_equal(aux_mode(3,0.5),c(1, 2))
})

test_that("aux_skewness returns the correct value",{
  expect_equal(aux_skewness(10,0.3),0.2760262, tolerance = 1e-5)
  expect_equal(aux_skewness(20,0.2),0.3354102, tolerance = 1e-5)
  expect_equal(aux_skewness(30,0.5),0)
})

test_that("aux_kurtosis returns the correct value",{
  expect_equal(aux_kurtosis(10,0.3),-0.1238095, tolerance = 1e-5)
  expect_equal(aux_kurtosis(20,0.2),0.0125, tolerance = 1e-5)
  expect_equal(aux_kurtosis(30,0.3),-0.04126984, tolerance = 1e-5)
})