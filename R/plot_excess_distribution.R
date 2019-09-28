#' @export
plot_excess_distribution <- function(df, relative = FALSE, month = NA) {
  if (relative) {
    df <- df %>% dplyr::mutate(Excess = Excess / TOTAL)
    xlabel <- "Relative Excess Journey Time"
  } else {
    xlabel <- "Excess Journey Time"
  }
  
  if(!is.na(month)) df <- df %>% filter(Month = month)

  gg <-
    df %>%
    ggplot(aes(x = Excess, y = reorder(Line, -Excess), fill = reorder(Line, -Excess))) +
    ggridges::geom_density_ridges2() +
    theme_minimal() +
    scale_fill_got_d(option = "Margaery", guide = FALSE) +
    ylab("") +
    xlab("Excess Journey Time")

  return(gg)
}

#' @export
plot_excess_distribution2 <- function(df, relative = FALSE, month = NA) {
  if (relative) {
    df <- df %>% dplyr::mutate(Excess = Excess / TOTAL)
    xlabel <- "Relative Excess Journey Time"
  } else {
    xlabel <- "Excess Journey Time"
  }
  
  if(!is.na(month)) df <- df %>% filter(Month = month)
  
  y_tags <- df$Line %>% unique()
  colours <- gameofthrones::gameofthrones(option = "Margaery", n = length(y_tags))
  
  p <- plotly::plot_ly(type = 'scatter', mode = 'lines', fill = 'tozeroy', colors = colours)
  
  for (i in seq_along(y_tags)) {
    
    d <- density(df[Line == y_tags[[i]]][["Excess"]])
    
    p <- 
      plotly::add_trace(
        p, 
        x = d$x,
        y = d$y, 
        name = y_tags[[i]]
      )
    
  }
  
  gg <- 
    p %>% 
    plotly::layout(xaxis = list(title = 'Excess'), yaxis = list(title = 'Density'))
  
  return(gg)
}

