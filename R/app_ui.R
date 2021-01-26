#' Basic dropdown module
#' Contains:
#' * dropdown menu
#' * textfield showing the selection from the dropdown (default = None)
drop_down <- function(id) {
  ns <- shiny::NS("dropdown")
  shiny::tagList(
    shiny.semantic::dropdown_input(ns(id), choices = c("stub", "stub")),
    shiny::textOutput(ns(id))
  )}

#' Page layout top module
#' Contains:
#' * dropdown menu 1
#' * dropdown menu 2
double_drop_down <- function(id) {
  ns <- shiny::NS("doubledrop")
  shiny::tagList(
    shiny::div(ns(id), drop_down("1")),
    shiny::div(ns(id), drop_down("2"))
    )
}

#' Sidebar element
#' sidebar menu with one or more tabs
side_bar <- function() {
  semantic.dashboard::sidebarMenu(
    semantic.dashboard::menuItem(tabName = "Vessel", double_drop_down("1")))
}

#' Page layout using semantic.dashbaord
#' * dashboardHeader
#' * dashboardSidebar
#' * dashboardBody
page_main <- function() {
  semantic.dashboard::dashboardPage(
    semantic.dashboard::dashboardHeader(title = "Marine traffic",
                                        color = "blue"),
    semantic.dashboard::dashboardSidebar(side = "left",
                                         size = "thin",
                                         color = "teal",
                                         side_bar()),
    semantic.dashboard::dashboardBody(
      semantic.dashboard::tabItems(
        semantic.dashboard::tabItem(tabName = "vessel",
                                    mod_test_ui("1"),
                                    mod_dropdown_ui("vessel type")
                                    ))
    )
  )
}

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    page_main()
    )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {

  add_resource_path(
    "www", app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "marine"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
