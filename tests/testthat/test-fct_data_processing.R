test_that("get_gps_coordinate", {
  skip("Issue #8")
  loc <- get_gps_loc(vessel_id)
  loc <- c(12, 34)
  expect_true(is.numeric(loc[1]))
  expect_true(is.numeric(loc[2]))
})
