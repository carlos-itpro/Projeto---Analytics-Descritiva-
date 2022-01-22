#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

  
  navbarPage(
    theme = shinythemes::shinytheme("yeti"), 
    "Projeto Analytics Descritiva",
    tabPanel("Atividades Predominantes Por Bairro"),
    tabPanel("Bairros com Maior Potencial de Incomodo"),
    tabPanel("Oferta de Serviços por Bairro")
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

