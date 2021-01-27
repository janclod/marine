#' dropdown UI Function
#'
#' @description Double drop-down input.
#'
#' @param id, input, output, session Internal parameters for {shiny}.
#'
#' @noRd
mod_dropdown_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::div(
      # Parent drop-down
      shiny::p(paste0("Select vessel type:")),
      shiny.semantic::dropdown_input(ns("dropdown_parent"),
                                     c("vessel_type_1", "vessel_type_2")),
      shiny::p(paste0("Selected vessel type:")),
      shiny::textOutput(ns("out_parent"))),
    # Child drop-down
    shiny::div(
      shiny::p(paste0("Select vessel ID:")),
      shiny.semantic::dropdown_input(ns("dropdown_childparent"),
                                     c("chil_holder", "child_1")),
      shiny::p(paste0("Selected vessel ID:"),
      shiny::textOutput(ns("out_child")))))
}
    
#' dropdown Server Function
#'
#' @noRd
mod_dropdown_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$out <- shiny::renderText(input[["dropdown"]])
    }
  )
}
