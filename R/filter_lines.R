#' @export
filter_lines <- function(df, lines){
  df %>% 
    filter(Line %in% lines) %>% 
    data.table() %>% 
    return()
}