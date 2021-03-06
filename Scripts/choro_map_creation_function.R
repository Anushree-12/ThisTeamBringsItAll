# creates a worldmap with plotly that takes in a dataframe and conveys different color
# saturation per country based on the mean.observations variable

library(plotly)
library(dplyr)

# shows interactive map
WorldMap <- function(df) {
   if (nrow(df) == 0) {
    df[1, ] <- c("AFG", 0, 0)
    df[2, ] <- c("USA", 0, 0)
   }  
  df$hover <- with(df, paste("Country:", Country_Code, '<br>', 
                             "Percentage Unemployed:", mean.observations, '<br>',
                             "Total Years and Genders:", occurrences)
                             )
  return(plot_ly(df, type = "choropleth", 
            locations = ~Country_Code,
            locationmode = "world",
            colors = "Purples",
            z = ~mean.observations ,
            text = ~hover
            ) %>%
    colorbar(title = "Percentage of Workforce Unemployed"
            ) %>%
    layout(
      title = "Unemployment Rates Around the World",
      geo = list(scope = "world")
      )
   )
}
