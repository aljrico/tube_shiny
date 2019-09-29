find_numerical_variables <- function(df){
  df <- data.table(values$df_data)
  l <- lapply(df, is.numeric) %>% unlist()
  c <- df[,..l] %>% colnames()
  return(c)
}

find_categorical_variables <- function(df){
  df <- data.table(values$df_data)
  cols <- colnames(df)
  output <- c()
  for(c in cols) if((df[[c]] %>% unique() %>% length()) < 0.15*nrow(df)) output <- c(output, c)
  
  return(output)
}

output$parameters_scatter <- renderUI({
  num_vars <- find_numerical_variables(values$df_data)
  cat_vars <- find_categorical_variables(values$df_data)
  lines <- values$df_data$Line %>% unique()
  ui_elements <- 
    list(
    selectInput(inputId = "scatter_x_lab", label = "X Variable", choices = num_vars, selected = "Month"),
    selectInput(inputId = "scatter_y_lab", label = "Y Variable", choices = num_vars, selected = "Excess"),
    selectInput(inputId = 'scatter_colour', label = 'Colour',   choices = c('None', cat_vars), selected = 'Line'),
    shinyWidgets::pickerInput(
      inputId = "scatter_line_filter", 
      label = "Filter by Line", 
      choices = lines, 
      selected = lines,
      options = list(
        `actions-box` = TRUE, 
        size = 10,
        `selected-text-format` = "count > 3"
      ), 
      multiple = TRUE
    )
  )
  
  do.call(tagList, ui_elements)

})
