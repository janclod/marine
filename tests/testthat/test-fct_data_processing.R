test_that("read csv", {
  expect_silent(get_data())
  expect_error(get_data(file = "potato.csv"))
  df <- get_data()
  df_col <- colnames(df)
  # Check that we have 20 columns
  expect_true(ncol(df) == 20)
  # Check column names
  expect_true("LAT" %in% df_col)
  expect_true("LON" %in% df_col)
  expect_true("SPEED" %in% df_col)
  expect_true("COURSE" %in% df_col)
  expect_true("HEADING" %in% df_col)
  expect_true("DESTINATION" %in% df_col)
  expect_true("FLAG" %in% df_col)
  expect_true("LENGTH" %in% df_col)
  expect_true("SHIPNAME" %in% df_col)
  expect_true("SHIPTYPE" %in% df_col)
  expect_true("SHIP_ID" %in% df_col)
  expect_true("WIDTH" %in% df_col)
  expect_true("DWT" %in% df_col)
  expect_true("DATETIME" %in% df_col)
  expect_true("PORT" %in% df_col)
  expect_true("date" %in% df_col)
  expect_true("week_nb" %in% df_col)
  expect_true("ship_type" %in% df_col)
  expect_true("port" %in% df_col)
  expect_true("is_parked" %in% df_col)
  # Check dataframe is not empty
  expect_true(nrow(df) > 1)
  # Check returned type
  expect_type(df, "list")
})

test_that("get list of vessel ID", {
  df <- get_data()
  expect_silent(get_vessel_id(df))
  #################
  ## Without filter
  vessel_ids <- get_vessel_id(df)
  # Check returned type is vector
  expect_vector(vessel_ids)
  # Check elements are of type character
  expect_true(is.character(vessel_ids))
  # Check for duplicates
  expect_true(anyDuplicated(vessel_ids) == 0)
  # Check that we have the right number of elements
  n_elements <- length(unique(df$SHIP_ID))
  expect_equal(length(vessel_ids), n_elements)
  ##############
  ## With filter, DO NOT CHANGE ship_type
  # The SHIPID corresponding to ship_type is hard-coded
  vessel_ids_filtered <- get_vessel_id(get_data(), ship_type = "Cargo")
  # Check returned type is vector
  expect_vector(vessel_ids_filtered)
  # Check elements are of type character
  expect_true(is.character(vessel_ids_filtered))
  # Check for duplicates
  expect_true(anyDuplicated(vessel_ids_filtered) == 0)
  # Check that we have the right number of elements
  # Filtered using correct SHIPTYPE corresponding to the Tanker ship_type
  filtered_df <- dplyr::filter(df, SHIPTYPE == 7)
  n_elements_filtered <- length(unique(filtered_df$SHIP_ID))
  expect_equal(length(vessel_ids_filtered), n_elements_filtered)
  # Filtered using wrong SHIPTYPE corresponding to the Pleasure ship_type
  filtered_df_wrong <- dplyr::filter(df, SHIPTYPE == 9)
  n_elements_filtered_wrong <- length(unique(filtered_df_wrong$SHIP_ID))
  expect_false(length(vessel_ids_filtered) == n_elements_filtered_wrong)
  # Check that the filtered variable contains less elements compared to the
  # unfiltered variable
  expect_true(length(vessel_ids) > length(vessel_ids_filtered))
})

test_that("get list of vessel types", {
  expect_silent(get_vessel_type(get_data()))
  vessel_type <- get_vessel_type(get_data())
  expect_vector(vessel_type)
  expect_true(is.character(vessel_type))
  expect_true(anyDuplicated(vessel_type) == 0)
  expect_true(length(vessel_type) > 1)
})

test_that("get gps coordinates of given vessel ID", {
  expect_silent(get_gps_loc(get_data(), vessel_id = "2764"))
  locs <- get_gps_loc(get_data(), vessel_id = "2764")
  expect_type(locs, "list")
  expect_true("loc1" %in% names(locs))
  expect_true("loc2" %in% names(locs))
  expect_true("dist" %in% names(locs))
  expect_length(locs$loc1, 2)
  expect_length(locs$loc2, 2)
  expect_length(locs$dist, 1)
  expect_true(-180 < locs$loc1[1] && locs$loc1[1] < 180)
  expect_true(-180 < locs$loc2[1] && locs$loc2[1] < 180)
  expect_true(-90 < locs$loc1[2] && locs$loc1[2] < 90)
  expect_true(-90 < locs$loc2[2] && locs$loc2[2] < 90)
  expect_true(locs$dist > 0)
  expect_true(is.numeric(locs$loc1))
  expect_true(is.numeric(locs$loc2))
  expect_type(locs$dist, "character")
})
