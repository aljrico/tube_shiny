#' @export
plot_excess_distribution <- function(df, relative = FALSE, month = NA) {
  if (relative) {
    df <- df %>% dplyr::mutate(Excess = Excess / TOTAL)
    xlabel <- "Relative Excess Journey Time"
  } else {
    xlabel <- "Excess Journey Time"
  }
  
  if(!is.na(month)) df <- df %>% filter(Month = month)

  p <- plot_ly(type = 'violin')
  
  i = 0
  p <- df %>%
    plot_ly(type = 'violin') %>%
    add_trace(
      x = ~df[df$Type == 'DT']$Line,
      y = ~df[df$Type == 'DT']$Excess,
      legendgroup = 'DT',
      scalegroup = 'DT',
      name = 'DT',
      side = 'negative',
      box = list(
        visible = T
      ),
      meanline = list(
        visible = T
      )
    ) %>%
    add_trace(
      x = ~df[df$Type == 'SS']$Line,
      y = ~df[df$Type == 'SS']$Excess,
      legendgroup = 'SS',
      scalegroup = 'SS',
      name = 'SS',
      side = 'positive',
      box = list(
        visible = T
      ),
      meanline = list(
        visible = T
      )
    ) %>% 
    layout(
      xaxis = list(
        title = ""  
      ),
      yaxis = list(
        title = xlabel,
        zeroline = F
      )
    )

  return(p)
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

