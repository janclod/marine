shiny::testServer(mod_dropdown_server, {
  session$setInputs(dropdown_parent = "test_dp",
                    dropdown_child = "test_dc")
  expect_equal(output$out_parent, "test_dp")
  expect_equal(output$out_child, "test_dc")
  # Update input for the dropdowns
  session$setInputs(dropdown_parent = "Cargo",
                    dropdown_child = "2764")
  expect_equal(output$out_parent, "Cargo")
  expect_equal(output$out_child, "2764")
  # Testing re-activity of the child drop-down
  expect_equal(dropdown_child_react(), "2764")
})