# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(sf)
library(adehabitatLT)
library(dplyr)
library(mapview)
    
function(input, output) {

    # Filters
    bears <- reactive({
        bears <- readRDS("./bears.rds")
    })

    # Render selectInput 
    output$selIDs <- renderUI({
        IDs.name <- as.vector(unique(bears()$ID_Animal))
        selectInput("selIDs","Choose IDs", choices=IDs.name, multiple=TRUE)    
    })

    # Render selectInput 
    output$selYears <- renderUI({
        years.name <- as.vector(unique(bears()$year))
        selectInput("selYears","Choose years", choices=years.name, multiple=TRUE)
    })

    # Subset so that only the selected rows are in model.data
    bears <- reactive({
        req(input$selIDs)
        req(input$selYears)
        data <- readRDS("./bears.rds")
        return(subset(data, ID_Animal %in% input$selIDs))
    })

    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        dplyr::select(bears(), -year, -geometry)
    }))

    # Filter data based on selections
    output$map_v <- mapview::renderMapview({ 
        mapview(breweries)
    })

}