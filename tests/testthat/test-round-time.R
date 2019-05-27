test_that("rounding time works", {
  inputs <- c("00:00:00", "00:02:00", "23:59:00", "23:56:00")
  outputs <- c("00:00:00", "00:00:00", "00:00:00", "23:55:00")
  expect_equal(strftime(roundTime(timeStringToDate(inputs), 5), format = "%T"), outputs)

})

test_that("non-integer minutes fail", {
  expect_error(roundTime(Sys.time, 0.5))
})
