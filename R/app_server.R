#' Bundel server functions
#' @noRd
server_functions <- function() {
  mod_dropdown_server("1")
}

#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  server_functions()
}
