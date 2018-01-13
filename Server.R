# Loads packages to use shiny, rsconnect, and dplyr functions.
library(shiny)
library(dplyr)
library(rsconnect)

# Sources scripts files to use their functions that manipulate the unemployment data.
source('./scripts/choro_map_creation_function.R')
source('./scripts/choro_map_data_function.R')

# Accesses data as a dataframe from the International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, and year.
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# The Shiny server allows interactivity from user input, via widgets, to output corresponding data to the 
# respective output.
shinyServer(function(input, output) { 
  
  # Creates a choropleth map that looks at the unemployment rates in each country.
  output$GlobalMap <- renderPlotly({
    return(
      WorldMap(
        FilterMapData(df,
                      input$radio2, 
                      input$radio1,
                      input$slider2[1],
                      input$slider2[2],
                      input$select
        )
      )
    )
  })
})


