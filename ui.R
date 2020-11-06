#shiny web application makes it very useful to build various web application with R.

#install the necessary libraries


library(shiny)
library(ggplot2)



data("dataset--diamonds")


shinyUI(fluidPage(
    
    # Application title
    
    titlePanel("diamonds--carat versus price"),
    
    
    sidebarLayout(
        sidebarPanel(
            h4("Select the Variables accordingly"),
            
            selectInput("cut",
                        "Select Type",
                        (sort(
                            unique(diamonds$cut), decreasing = T
                        ))),
            
            selectInput("color",
                        "Select Colour",
                        (sort(
                            unique(diamonds$color)
                        ))),
            
            selectInput("clarity",
                        "Select the type of clarity",
                        (sort(
                            unique(diamonds$clarity), decreasing = T
                        ))),
            
            actionButton("showall",
                         "Display"),
            
            actionButton("appfil",
                         "Reset"),
            
            h4("Final Summary"),
            
            verbatimTextOutput("summary"),
            
            sliderInput(
                "lm",
                "Carat",
                min = min(diamonds$carat),
                max = max(diamonds$carat),
                value = max(diamonds$carat) / 2,
                step = 0.1
            ),
            
            h4("Final predicted price"),
            
            verbatimTextOutput("predict"),
            
            width = 4
        ),
        
       
        
        mainPanel(tabsetPanel(
            tabPanel("Plot", plotOutput("distPlot")),
            
            tabPanel(
                "About the application",
                br(),
                
                helpText(
                    "It displays the relationship between price and carat. The app displayes various aspects of the dataset."
                ),
                
                br(),
                
                helpText(
                    "You can edit and check varying values of the price based on different carat value according to your needs."
                ),
                
                br(),
                
                helpText(
                    "At last the final summary is shown based on your selection."
                )),
            
            tabPanel(
                "About the daatset",
                
                br(),
                
                helpText("Dataset-:"),
                
                br(),
                
                tags$a(
                    "Click here to see data.",
                    href = "http://ggplot2.tidyverse.org/reference/diamonds.html"
                )
            )
            
        ))
    )
))