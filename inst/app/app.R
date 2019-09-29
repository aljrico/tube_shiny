library(shinydashboard)
library(shiny)
library(shinyjs)
library(tidyverse)
library(data.table)
library(gameofthrones)
library(plotly)
library(DT)


header <- dashboardHeader(title = "Tube Performance")

sidebar <- dashboardSidebar(
  fileInput(
    inputId = "csv",
    label = "Chooose CSV",
    accept = c(
      "text/csv",
      "text/comma-separated-values,text/plain",
      ".csv"
    )
  ),
  sidebarMenu(
    menuItem("Home", tabName = "Home", icon = icon('home')),
    menuItem("Summary", tabName = "Summary", icon = icon('chart-line')),
    menuItem("Explore", tabName = "Explore", icon = icon('search')),
    checkboxInput(inputId = 'check_normalise', label = 'Normalise Excess Value', value = FALSE, width = NULL)
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = 'Home',
      fluidRow(box(includeMarkdown("misc/README.md"), width = 12, status = 'warning'))
    ),
    tabItem(
      tabName = "Summary",
      fluidRow(
        box(plotlyOutput("plot_excess_ts"), status = "primary"),
        box(plotlyOutput("plot_excess_distribution"), status = "primary"),
        box(plotlyOutput("plot_excess_distribution2"), status = "primary"),
        box(plotlyOutput("plot_excess_boxplot"), status = "primary")
      )
    ),
    tabItem(
      tabName = "Explore",
      fluidRow(
        box(DTOutput('show_dt'), width = 12),
        box(uiOutput('parameters_scatter')),
        box(plotlyOutput('explore_scatter_plot'))
      )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, skin = "black")

server <- function(input, output, session) {
  values <- reactiveValues(df_data = NULL)

  observeEvent(input$csv, {
    values$df_data <- data.table::fread(input$csv$datapath)
    source("server/summary_plots.R", local = TRUE)
    source('server/show_table.R', local = TRUE)
    source('ui/parameters_scatter.R', local = TRUE)  
    source('server/explore_scatter_plot.R', local = TRUE)
  })


}

shinyApp(ui = ui, server = server)
