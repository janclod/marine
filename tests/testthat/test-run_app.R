library(shinytest)

test_that("app works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  # Allow for the generation for platform specific snapshots using suffix param
  # 
  expect_pass(testApp("apps/run_app/",
                      compareImages = FALSE,
                      suffix = strsplit(utils::osVersion, " ")[[1]][1]))},)
