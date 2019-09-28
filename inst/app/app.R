library(shinydashboard)
library(shiny)
library(shinyjs)


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
    menuItem("Aggregated", tabName = "Aggregated")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "Aggregated",
      fluidRow(
        box(plotOutput('plot_excess_distribution'), status = 'primary'),
        box(plotOutput('plot_excess_distribution2'), status = 'primary')
      )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, skin = 'black')

server <- function(input, output, session) {
  
  values <- reactiveValues(df_data = NULL)
  
  observeEvent(input$csv, {
    values$df_data <- data.table::fread(input$csv$datapath)
    output$plot_excess_distribution <- renderPlot({tubeshiny::plot_excess_distribution(values$df_data)})
    output$plot_excess_distribution2 <- renderPlotly({tubeshiny::plot_excess_distribution2(values$df_data)})
  })

}

shinyApp(ui = ui, server = server)
