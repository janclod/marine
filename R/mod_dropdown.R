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
    shiny::p(paste0("Select ", id, ":")),
    shiny.semantic::dropdown_input(ns("dropdown"),
                                   "parent_holder"),
    shiny::p(paste0("Selected ", id, ":"),
    shiny::textOutput(ns("out"))
  ))
}
    
#' dropdown Server Function
#'
#' @noRd 
mod_dropdown_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$out <- renderText(input[["dropdown"]])
    }
  )
}
    
## To be copied in the UI
# mod_dropdown_ui("dropdown_ui_1")
    
## To be copied in the server
# callModule(mod_dropdown_server, "dropdown_ui_1")
 
