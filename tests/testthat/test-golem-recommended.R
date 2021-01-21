test_that("app ui", {
  skip("Issue #1")
  ui <- app_ui()
  expect_shinytaglist(ui)
})

test_that("app server", {
  skip("Issue #2")
  server <- app_server
  expect_is(server, "function")
})

# Configure this test to fit your need
test_that(
  "app launches",{
    skip("Issue #3")
    skip_on_cran()
    skip_on_travis()
    skip_on_appveyor()
    x <- processx::process$new(
      "R", 
      c(
        "-e", 
        "pkgload::load_all(here::here());run_app()"
      )
    )
    Sys.sleep(5)
    expect_true(x$is_alive())
    x$kill()
  }
)








