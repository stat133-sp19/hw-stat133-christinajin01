context("Check binomial functions")

test_that("bin_choose returns the correct value",{
  expect_equal(bin_choose(n =5, k =2),10)
  expect_equal(bin_choose(5,0),1)
  expect_equal(bin_choose(5,1:3),c(5,10,10))
  expect_error(bin_choose(3,4))
})

test_that("bin_probability returns the correct value",{
  expect_equal(bin_probability(2, 5, 0.5),0.3125)
  expect_equal(bin_probability(0:2, 5, 0.5),c(0.03125, 0.15625, 0.31250))
  expect_equal(bin_probability(55, 100, 0.45),0.01075277)
})

test_that("bin_distribution returns the correct binomial distribution",{
  dat1 <- bin_distribution(5, 0.5)
  expect_length(dat1, 2)
  expect_equal(dat1$success, 0:5)
  expect_equal(dat1$probability, c(0.03125,0.15625,0.31250,0.31250,0.15625,0.03125))
})

test_that("bin_cumulative returns the correct cumulative probability",{
  dat2 <- bin_cumulative(5, 0.5)
  expect_length(dat2, 3)
  expect_equal(dat2$success, 0:5)
  expect_equal(dat2$cumulative, c(0.03125, 0.18750, 0.50000, 0.81250, 0.96875, 1.00000))
})
