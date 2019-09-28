library(plotly)


y_tags <- df$Line %>% unique()

traces_list <- list()
spaces_list <- list()

colours <- gameofthrones::gameofthrones(option = "Margaery", n = length(y_tags))

p <- plot_ly(type = 'scatter', mode = 'lines', fill = 'tozeroy')

for (i in seq_along(y_tags)) {
  
  d <- density(df[Line == y_tags[[i]]][["Excess"]])

  p <- 
    add_trace(
    p, 
    x = d$x,
    y = d$y, 
    name = y_tags[[i]]
    )

}

p %>% 
  layout(xaxis = list(title = 'Excess'),
       yaxis = list(title = 'Density'))


diamonds1 <- diamonds[which(diamonds$cut == "Fair"),]
density1 <- density(diamonds1$carat)

diamonds2 <- diamonds[which(diamonds$cut == "Ideal"),]
density2 <- density(diamonds2$carat)

p <- plot_ly(type = 'scatter', mode = 'lines', fill = 'tozeroy') %>%
  add_trace(x = ~density1$x, y = ~density1$y, name = 'Fair cut') %>% 
  add_trace(x = ~density2$x, y = ~density2$y, name = 'Ideal cut') %>%
  layout(xaxis = list(title = 'Carat'),
         yaxis = list(title = 'Density'))
p
