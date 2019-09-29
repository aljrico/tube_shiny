

output$plot_excess_distribution <- renderPlotly({
  tubeshiny::plot_excess_distribution(values$df_data %>% tubeshiny::normalise_excess(check = input$check_normalise))
})

output$plot_excess_distribution2 <- renderPlotly({
  tubeshiny::plot_excess_distribution2(values$df_data %>% tubeshiny::normalise_excess(check = input$check_normalise))
})

output$plot_excess_boxplot <- renderPlotly({
  tubeshiny::plot_excess_boxplot(values$df_data %>% tubeshiny::normalise_excess(check = input$check_normalise))
})

output$plot_excess_ts <- renderPlotly({
  tubeshiny::plot_excess_ts(values$df_data %>% tubeshiny::normalise_excess(check = input$check_normalise))
})
