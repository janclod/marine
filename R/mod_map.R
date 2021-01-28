#' map UI Function
#'
#' @description Shows map.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @importFrom magrittr %>%
#'
#' @noRd
mod_map_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    leaflet::leafletOutput(ns("map"))
  )
}
    
#' map Server Function
#'
#' @noRd
mod_map_server <- function(id, point) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      output$map <- leaflet::renderLeaflet({
        leaflet::leaflet() %>%
          leaflet::setView(lng = 23, lat = 45, zoom = 6) %>%
          leaflet::addProviderTiles("Esri.WorldStreetMap") %>%
          leaflet::addMarkers(23, 45, popup = point())
        })
    }
  )
}
