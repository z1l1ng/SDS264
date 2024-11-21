# from AER_app

library(AER)
library(tidyverse)
library(datasets)
data("faithful")


ui <- fluidPage(
  titlePanel("ERUPTIONS"),
  sidebarLayout(position = "left",
    sidebarPanel(
      selectInput("num_break", label = "Number of bins:",
                  choices = c(10, 20, 35, 50), selected = 20),
      sliderInput("bandw_adjust", label = "Bandwidth adjustment:",
                  min = 0.2, max = 2, value = 1, step = 0.2)
    ),
    mainPanel(
      plotOutput(outputId = "plot")
    )
  )
)

server <- function(input, output) {
      
  output$plot <- renderPlot({
    faithful |>
      ggplot(aes(x = eruptions, y = after_stat(density))) +
      geom_histogram(bins = as.numeric(input$num_break)) +
      geom_density(bw = input$bandw_adjust)
  })
}  

shinyApp(ui = ui, server = server)