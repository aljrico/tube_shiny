library(shinydashboard)
library(shiny)
library(shinyjs)
library(tidyverse)
library(data.table)
library(gameofthrones)
library(plotly)


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
    menuItem("Summary", tabName = "Summary"),
    menuItem("Explore", tabName = "Explore")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "Summary",
      fluidRow(
        box(plotlyOutput("plot_excess_ts"), status = "primary"),
        box(plotOutput("plot_excess_distribution"), status = "primary"),
        box(plotlyOutput("plot_excess_distribution2"), status = "primary"),
        box(plotlyOutput("plot_excess_boxplot"), status = "primary")
      )
    ),
    tabItem(
      tabName = "Explore",
      fluidRow(

      )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, skin = "black")

server <- function(input, output, session) {
  values <- reactiveValues(df_data = NULL)

  observeEvent(input$csv, {
    values$df_data <- data.table::fread(input$csv$datapath)
    
    output$plot_excess_distribution <- renderPlot({
      tubeshiny::plot_excess_distribution(values$df_data)
    })
    
    output$plot_excess_distribution2 <- renderPlotly({
      tubeshiny::plot_excess_distribution2(values$df_data)
    })
    
    output$plot_excess_boxplot <- renderPlotly({
      tubeshiny::plot_excess_boxplot(values$df_data)
    })
    
    output$plot_excess_ts <- renderPlotly({
      tubeshiny::plot_excess_ts(values$df_data)
    })
  })
}

shinyApp(ui = ui, server = server)
