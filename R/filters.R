#' @export
filter_lines <- function(df, lines){
  df %>% 
    filter(Line %in% lines) %>% 
    data.table() %>% 
    return()
}

#' @export
filter_opened <- function(df, opened_range){
  df %>% 
    filter(Opened <= max(opened_range)) %>% 
    filter(Opened >= min(opened_range)) %>% 
    data.table() %>% 
    return()
}

#' @export
filter_month <- function(df, month_range){
  df %>% 
    filter(Month <= max(month_range)) %>% 
    filter(Month >= min(month_range)) %>% 
    data.table() %>% 
    return()
}