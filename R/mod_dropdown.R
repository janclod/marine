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
      shiny.semantic::dropdown_input(ns("dropdown_child"),
                                     c("chil_holder", "child_1")),
      shiny::p(paste0("Selected vessel ID:"),
      shiny::textOutput(ns("out_child")))))
}
    
#' dropdown Server Function
#'
#' @noRd
mod_dropdown_server <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      output$out_parent <- shiny::renderText(input[["dropdown_parent"]])
      output$out_child <- shiny::renderText(input[["dropdown_child"]])
      # Update second drop-down when input in first drop-down
      # Make the input of the first drop-down reactive
      # This is necessary to make the update action work within a Shiny module
      # For more info see:
      # https://community.rstudio.com/
      # t/observeevent-issues-in-shiny-modules/67509/14
      dropdown_parent <- shiny::reactive(input$dropdown_parent)
      # Observe the event using the reactive input
      shiny::observeEvent(dropdown_parent(), {
        shiny.semantic::update_dropdown_input(session,
                                             "dropdown_child",
                                             choices = c("UPDATED1", "UP2"))
        },
        ignoreInit = TRUE)
      # This is necessary to communicate with another module
      # In this specific case, we want this module to communicate with
      # the map module.
      return(
        reactive({
          input$dropdown_child
        }))
    }
  )
}
