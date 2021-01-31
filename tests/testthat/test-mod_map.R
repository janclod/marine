shiny::testServer(mod_map_server,
                  args = list(vessel_id = function() vessel_id <- "2764"), {
  expect_silent(mod_map_server("test",
                               vessel_id = function() vessel_id <- "2764"))
  expect_silent(mod_map_server("test",
                               vessel_id = function() vessel_id <- ""))
  expect_type(output$map, "character")
  expect_snapshot_output(output$map)
})
