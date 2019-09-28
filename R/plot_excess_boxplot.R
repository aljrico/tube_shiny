#' @export
plot_excess_boxplot <- function(df, relative = FALSE, month = NA) {
  if (relative) {
    df <- df %>% mutate(Excess = Excess / TOTAL)
    xlabel <- "Relative Excess Journey Time"
  } else {
    xlabel <- "Excess Journey Time"
  }
  
  if(!is.na(month)) df <- df %>% filter(Month = month)
  
  
  
  y_tags <- df$Line %>% unique()
  colours <- gameofthrones::gameofthrones(option = "Margaery", n = length(y_tags))
  
  p <- plotly::plot_ly(type = 'box', colors = colours)
  
  for (i in seq_along(y_tags)) {
    
    d <- df[Line == y_tags[[i]]][["Excess"]]
    
    p <- 
      plotly::add_trace(
        p, 
        y = d, 
        name = y_tags[[i]]
      )
    
  }
  
  gg <- 
    p %>% 
    plotly::layout(yaxis = list(title = xlabel))
  return(gg)
}

