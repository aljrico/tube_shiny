output$explore_scatter_plot <- renderPlotly({
  tubeshiny::scatter_plot(
    df = values$df_data %>%
      tubeshiny::normalise_excess(check = input$check_normalise) %>%
      tubeshiny::filter_lines(lines = input$scatter_line_filter) %>% 
      tubeshiny::filter_opened(opened_range = input$scatter_slider_opened) %>% 
      tubeshiny::filter_month(month_range = input$scatter_slider_month),
    x = input$scatter_x_lab,
    y = input$scatter_y_lab,
    colour_tag = input$scatter_colour
  )
})
