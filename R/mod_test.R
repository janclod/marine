#' test UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_test_ui <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("button"), label = "potato"),
    textOutput(ns("out"))
  )
}
    
#' test Server Function
#'
#' @noRd
mod_test_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      count <- reactiveVal(0)
      observeEvent(input$button, {
        count(count() + 1)
      })
      output$out <- renderText({
        count()
      })
      count
    }
  )
}
