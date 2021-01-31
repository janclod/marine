library(shinytest)

test_that("app works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  # Allow for the geenration for platform specific snapshots
  expect_pass(testApp("apps/run_app/",
                      suffix = strsplit(utils::osVersion, " ")[[1]][1]))})
