library(shiny)
library(ggplot2)

# Define UI for a line plot and a table
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving-investing Modalities"),
   
   # Slider Bars
   fluidRow(
        column(4,
        sliderInput("initial", "Initial Amount",
                    min = 0, 
                    max = 100000, 
                    step = 500,
                    value = 1000,
                    pre = "$")
        ),
        column(4,
        sliderInput("return", "Return Rate (in %)",
                    min = 0, 
                    max = 20, 
                    step = 0.1,
                    value = 5)
        ),
        column(4,
        sliderInput("years", "Years",
                    min = 0, 
                    max = 50, 
                    step = 1,
                    value = 10)
        ),
      
        column(4,
        sliderInput("contrib", "Annual Contribution",
                    min = 0, 
                    max = 50000,
                    step = 500,
                    value = 2000,
                    pre = "$")
        ),
        column(4,
        sliderInput("growth", "Growth Rate (in %)",
                    min = 0, 
                    max = 20, 
                    step = 0.1,
                    value = 2)
        ),
        column(4,
        selectInput("facet", "Facet?", 
                    choices = list("Yes", "No"), 
                    selected = "No")
        )
      ),
      
      # Show a lineplot and a table
      mainPanel(
        titlePanel("Timelines"),
        plotOutput("timelines", width = "150%"),
        titlePanel("Balances"),
        verbatimTextOutput("balances")
        #tags$head(tags$style("#balances{width: 600px;}"))
      )
)

# Define server logic required to draw the plot and table
server <- function(input, output) {
   
  # Define functions for future_value, annnuity, and growing annuity
  
  #' @title future value
  #' @description calculates future value of an investment
  #' @param amount initial invested amount
  #' @param rate annual rate of return
  #' @param years number of years
  #' @return computed future value
  future_value <- function(amount, rate, years) {
    return(amount*(1+rate)^years)
  }
  
  #' @title Future value of Annuity
  #' @description calculates future value of annuity
  #' @param contrib contributed amount
  #' @param rate annual rate of return
  #' @param years number of years
  #' @return computed future value of annuity
  annuity <- function(contrib, rate, years) {
    return(contrib*(((1+rate)^years-1)/rate))
  }
  
  #' @title Future value of Growing Annuity
  #' @description calculates future value of growing annuity
  #' @param contrib contributed amount
  #' @param rate annual rate of return
  #' @param growth annual growth rate
  #' @param years number of years
  #' @return computed future value of growing annuity
  growing_annuity <- function(contrib, rate, growth, years) {
    return(contrib*(((1+rate)^years-(1+growth)^years)/(rate-growth)))
  }
  
  # Create the table for the three modes
  modalities <- reactive({
    # Save the inputs
    initial = input$initial
    r = input$return/100
    yrs = input$years
    contrib = input$contrib
    g = input$growth/100
    
    # Initialize empty vectors
    mode1 = rep(0, yrs+1)
    mode2 = rep(0, yrs+1)
    mode3 = rep(0, yrs+1)
    
    # Add in initial amount
    mode1[1] = initial
    mode2[1] = initial
    mode3[1] = initial
    
    # Add in the value for the rest of the years
    for (i in 1:yrs) {
      mode1[i+1] = future_value(amount = initial, rate = r, years = i)
      mode2[i+1] = future_value(amount = initial, rate = r, years = i) +
        annuity(contrib = contrib, rate = r, years = i)
      mode3[i+1] = future_value(amount = initial, rate = r, years = i) +
        growing_annuity(contrib = contrib, rate = r, growth = g, years = i)
    }
    
    # Create the dataframe
    modalities <- data.frame(year = seq(0, yrs), 
                             no_contrib = mode1, 
                             fixed_contrib = mode2, 
                             growing_contrib = mode3)
    modalities
  })
  
   # Plot output
   output$timelines <- renderPlot({
     df = modalities()
     
     yrs = input$years
     df = data.frame(year = rep(df$year, 3), 
                      value = c(df$no_contrib, df$fixed_contrib, df$growing_contrib),
                      Mode = factor(c(rep("no_contrib",yrs+1),
                                      rep("fixed_contrib",yrs+1),
                                      rep("growing_contrib",yrs+1)
                      ), levels = c("no_contrib", "fixed_contrib", "growing_contrib")))
     
     # No facetting
     if (input$facet == "No") {
       ggplot(df, aes(x = year, y = value, color = Mode)) +
         geom_line(size = 0.5)+
         geom_point(size = 0.5) + 
         labs(title = "Three Modes of Investing", x = "Year", y = "Value", color = "Mode")
      
     } else {
       # Facetting
       ggplot(df, aes(x = year, y = value))+
         geom_line(aes(color = Mode), size = 0.5) +
         geom_point(aes(color = Mode), size = 0.5) +
         geom_area(aes(fill= Mode), alpha = 0.5) +
         facet_wrap(~Mode) +
         labs(title = "Three Modes of Investing", x = "Year", y = "Value")
     }
   })
   
   # Table output
   output$balances <- renderPrint({
     modalities()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

