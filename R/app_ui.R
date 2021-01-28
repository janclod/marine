#' Sidebar element
#' sidebar menu with one or more tabs
#' @noRd
side_bar <- function() {
  semantic.dashboard::sidebarMenu(
    semantic.dashboard::menuItem(tabName = "vessel_browser",
                                 text = "Browser"))
}

#' Page layout using semantic.dashbaord
#' * dashboardHeader
#' * dashboardSidebar
#' * dashboardBody
#' @noRd
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
        semantic.dashboard::tabItem(tabName = "vessel_browser",
                                    mod_dropdown_ui("1"),
                                    mod_map_ui("1")
                                    ))
    )
  )
}

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
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
