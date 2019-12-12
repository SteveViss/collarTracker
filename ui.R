
fluidPage(
    titlePanel("Collar explorer"),
    sidebarPanel(
        uiOutput('selIDs'),
        uiOutput('selYears')
    ),
    mainPanel(
        fluidRow(
            column(12,
                DT::dataTableOutput("table")
            ),
            column(12,
                mapview::mapviewOutput("map_v", width = "100%", height = 400)
            )
        )
    )
)