library(shinytest)

test_that("app works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  # For the time being, ignore snapshots comparison
  # Allow for the generation for platform specific snapshots using suffix param:
  # https://github.com/rstudio/shiny-testing-gha-example/
  expect_pass(testApp("apps/run_app/",
                      compareImages = FALSE,
                      suffix = strsplit(utils::osVersion, " ")[[1]][1]))})
