#' @export
scatter_plot <- function(df, x, y){
  df <- data.table(df)
  p <- plot_ly(type = 'scatter', mode = 'markers')
  p <- p %>% add_trace(x = df[[x]], y = df[[y]])
  return(p)
}
