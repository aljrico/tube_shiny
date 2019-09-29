#' @export
normalise_excess <- function(df, check){
  if(check){
    df <- df %>% 
      mutate(Excess = round(Excess / Scheduled, 2)) %>%
      data.table()
  }
  return(df)
}