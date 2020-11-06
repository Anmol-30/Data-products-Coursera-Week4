
#shiny web application makes it very useful to build various web application with R.

#install the necessary libraries
#install "shiny", "ggplot2" etc

library(shiny)
library(ggplot2)
library(tidyverse)
library(curl)



shinyServer(function(input, output) {
    
    ## loading the dataset required
    
    data(diamonds)
    
    
    
    output$distPlot <- renderPlot({
        
       
        
        diamonds_sub <-
            subset(
                diamonds,
                cut == input$cut &
                    color == input$color &
                    clarity == input$clarity
            )
        
        
        
        p <-
            ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
        p <-
            p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
        p <- p + xlim(0, 6) + ylim (0, 20000)
        p
    }, height = 700)
    
    # displaying the the price summary
    
    output$summary <- renderPrint({
        diamonds_sub <-
            subset(
                diamonds,
                cut == input$cut &
                    color == input$color &
                    clarity == input$clarity
            )
        
        summary(diamonds_sub$price)
    })
    
    # creating the linear model necessary.........
    
    output$predict <- renderPrint({
        diamonds_sub <-
            subset(
                diamonds,
                cut == input$cut &
                    color == input$color &
                    clarity == input$clarity
            )
        
        fit <- lm(price~carat,data=diamonds_sub)
        
        unname(predict(fit, data.frame(carat = input$lm)))
    })
    
    # reset the button
    
    observeEvent(input$showall, {
        distPlot <<- NULL
        
        output$distPlot <- renderPlot({
            p <-
                ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
            p <-
                p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
            p <- p + xlim(0, 6) + ylim (0, 20000)
            p
        }, height = 700)
        
       
        
        output$summary <- renderPrint(summary(diamonds$price))
        
        # create linear model
        
        output$predict <- renderPrint({
            
            fit <- lm(price~carat,data=diamonds)
            
            unname(predict(fit, data.frame(carat = input$lm)))
        })
        
        
    })
    
   
    
    observeEvent(input$appfil, {
        distPlot <<- NULL
        
        output$distPlot <- renderPlot({
            
            
            
            
            diamonds_sub <-
                subset(
                    diamonds,
                    cut == input$cut &
                        color == input$color &
                        clarity == input$clarity
                )
            
            # drawing the diamonds data 
            #also data influences
            p <-
                ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
            p <-
                p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
            p <- p + xlim(0, 6) + ylim (0, 20000)
            p
        }, height = 700)
        
        #  summary
        
        output$summary <- renderPrint({
            diamonds_sub <-
                subset(
                    diamonds,
                    cut == input$cut &
                        color == input$color &
                        clarity == input$clarity
                )
            
            summary(diamonds_sub$price)
        })
        
        # c
        
        output$predict <- renderPrint({
            diamonds_sub <-
                subset(
                    diamonds,
                    cut == input$cut &
                        color == input$color &
                        clarity == input$clarity
                )
            
            fit <- lm(price~carat,data=diamonds_sub)
            
            unname(predict(fit, data.frame(carat = input$lm)))
        })
        
    })
    
})