#' @export
normalise_excess <- function(df, check){
  if(check){
    df <- df %>% mutate(Excess = Excess / Scheduled) %>% data.table()
  }
  return(df)
}