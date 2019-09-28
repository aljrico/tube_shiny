#' @export
plot_excess_ts <- function(df, relative = FALSE){
  
  if (relative) {
    df <- df %>% mutate(Excess = Excess / TOTAL)
    xlabel <- "Relative Excess Journey Time"
  } else {
    xlabel <- "Excess Journey Time"
  }
  
  y_tags <- df$Line %>% unique()
  colours <- gameofthrones::gameofthrones(option = "Margaery", n = length(y_tags))
  
  p <- plotly::plot_ly(type = 'scatter', colors = colours)
  
  for (i in seq_along(y_tags)) {
    
    d <- df[Line == y_tags[[i]]][["Excess"]]
    
    p <- 
      plotly::add_trace(
        p, 
        y = d, 
        name = y_tags[[i]], 
        mode = 'lines'
      )
    
  }
  
  gg <- 
    p %>% 
    plotly::layout(yaxis = list(title = xlabel), xaxis = list(title = 'Month'))
  
  return(gg)
}

