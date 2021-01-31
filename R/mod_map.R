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
mod_map_server <- function(id, vessel_id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      output$map <- leaflet::renderLeaflet({
        if (nchar(vessel_id()) > 0) {
          pts <- get_gps_loc(get_data(), vessel_id())
          ctr_lng <- (pts$loc1[1] + pts$loc2[1]) / 2
          ctr_lat <- (pts$loc1[2] + pts$loc2[2]) / 2
          leaflet::leaflet() %>%
            leaflet::setView(lng = ctr_lng, lat = ctr_lat, zoom = 8) %>%
            leaflet::addProviderTiles("Esri.WorldStreetMap") %>%
            leaflet::addMarkers(lng = pts$loc1[1],
                                lat = pts$loc1[2],
                                popup = pts$dist) %>%
            leaflet::addMarkers(lng = pts$loc2[1],
                                lat = pts$loc2[2],
                                popup = pts$dist)
        } else {
          ctr_lng <- 18.4
          ctr_lat <- 54.2
          leaflet::leaflet() %>%
            leaflet::setView(lng = ctr_lng, lat = ctr_lat, zoom = 6) %>%
            leaflet::addProviderTiles("Esri.WorldStreetMap")
        }
      })
    }
  )
}
