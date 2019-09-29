find_numerical_variables <- function(df){
  df <- data.table(values$df_data)
  l <- lapply(df, is.numeric) %>% unlist()
  c <- df[,..l] %>% colnames()
  return(c)
}

output$parameters_scatter <- renderUI({
  vars <- find_numerical_variables(values$df_data)
  ui_elements <- 
    list(
    selectInput(inputId = "scatter_x_lab", label = "X Variable", choices = vars),
    selectInput(inputId = "scatter_y_lab", label = "Y Variable", choices = vars)
  )
  
  do.call(tagList, ui_elements)

})
