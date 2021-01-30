#' Read csv data into dataframe.
#'
#' @description The file needs to be in the inst/extdata folder
#'
#' @param file File path.
#'
#' @examples
#' \dontrun{
#' df <- get_data()
#' df <- get_data(file = "file.csv")
#' }
get_data <- function(file = "ships_trim.csv") {
  f_path <- system.file("extdata", file, package = "marine")
  if (!file.exists(f_path)) {
    stop("Missing data file!")
  }
  utils::read.csv(f_path)
}

#' Gets the list of unique vessel IDs.
#'
#' @description Gets the list of unique vessels' ID.
#' The vessels' ID can be filtered based on vessel type.
#'
#' @param df the dataframe containing the SHIP_ID column.
#' @param ship_type the ship_type contained in the ship_type column of the df.
#'
#' @examples
#' \dontrun{
#' get_vessel_id(dataframe)
#' get_vessel_id(dataframe, ship_type == "Cargo")
#' }
get_vessel_id <- function(df, ship_type = NULL) {
  if (is.null(ship_type)) {
    unique(as.character(df$SHIP_ID))
  } else {
    dic <- stats::setNames(as.list(c(0, 1, 2, 3, 6, 7, 8, 9)),
                    c("Unspecified",
                      "Navigation",
                      "Fishing",
                      "Tug",
                      "Passenger",
                      "Cargo",
                      "Tanker",
                      "Pleasure"))
    s_t <- base::get(ship_type, dic)
    filtered_df <- dplyr::filter(df, df$SHIPTYPE == s_t)
    unique(as.character(filtered_df$SHIP_ID))
  }
}

#' List of unique vessel types.
#'
#' @description Gets the list of unique vessels' types.
#' It looks in the ship_type column of the dataframe and
#' returned the list of unique types.
#'
#' @param df the dataframe containing the ship_type column.
#'
#' @examples
#' \dontrun{
#' get_vessel_type(dataframe)
#' }
get_vessel_type <- function(df) {
  unique(as.character(df$ship_type))
}

#' Get the longitude and latitude for given vessel ID.
#'
#' @description Looks up the GPS coordinate for the given vessel ID.
#' Finds the observation when it sailed the longest distance
#' between two consecutive observations
#'
#' @param vessel_id SHIPID found in the dataframe.
#'
#' @examples
#' \dontrun{
#' get_gps_loc()
#' }
get_gps_loc <- function(vessel_id = 2334324) {
  # Write logic
  c(12, 34)
}