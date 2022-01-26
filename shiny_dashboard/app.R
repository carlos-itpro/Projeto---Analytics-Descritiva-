library(shinythemes)
library(ggmap)

body <- dashboardBody(
  fluidRow(
    tabBox(
      title = tagList(shiny::icon("building"), "ATIVIDADES PREDOMINANTES"),
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset1", height = "200px",
      side = "left",
      tabPanel("Visualização", h4("Ramos de negócios mais presentes por bairro.")),
      selectInput("bairro","Selecione o bairro:",choices = sort(unique(database$nome_bairro)))
      
    ),
    tabBox(
      title = tagList(shiny::icon("building"), "OFERTA DE SERVIÇOS"),
      side = "left", height = "200px",
      selected = "Visualização",
      tabPanel("Visualização", h4("Bairros com maior oferta do serviço.")),
      selectInput("atividade","Selecione o ramo de negócio:",choices = sort(unique(database$desc_atividade)))
    
    ),
    box(
      title = "TOP 5 - ATIVIDADES", width = 6, solidHeader = TRUE, status = "primary",
      h4("Principais ramos de negócio"),
      tableOutput("plot1")
    ),
    box(
      title = "TOP 5 - BAIRROS", width = 6, solidHeader = TRUE, status = "primary",
      h4("Maior oferta do serviço"),
      plotOutput("plot2")
    )
    
  ),

  fluidRow(
    
    box(
      title = "GEOLOCALIZAÇÃO", width = 12, solidHeader = TRUE, status = "primary",
      h4("Distribuição geográfica das empresas"),
      plotOutput("plot3", height = 750)
    )
  )
)

shinyApp(
  ui = dashboardPage(
    skin = "black",
    dashboardHeader(title = "Analytics Descritiva - Empresas do Recife",
                    titleWidth = 450),
    dashboardSidebar(
      width = 350,
      sidebarMenu(
        menuItem('Painel', tabName = 'plots', icon = icon("dashboard")),
        menuItem("Código Fonte", icon = icon("file-code-o"), 
                 href = "https://github.com/carlos-itpro/Projeto-Analytics-Descritiva"),
        width = 650    
      ),
      disable = FALSE
    ),
    body
  ),
  server = function(input, output) {
    # The currently selected tab from the first box
    output$tabset1Selected <- renderText({
      input$tabset1
    })
  
    output$plot2 <- renderPlot({
      
      ggplot(head(filter(frequentes_2,desc_atividade == input$atividade),5)) +
        geom_col( aes (x = n, y = nome_bairro, fill = n), show.legend = TRUE) +
        xlab("Quantidade") + 
        ylab("Bairro") + 
        guides(fill=guide_legend(title="Qtde"))
      
    })
    
    output$plot1 <- renderTable(
      head(filter(frequentes,nome_bairro == input$bairro),5)
    )
    
    output$plot3 <- renderPlot({
      
      theme_set(theme_bw())
      empresas <- subset(database,desc_atividade == input$atividade )
      qmplot(longitude, latitude, data=empresas, source = "stamen", extent = "normal", maptype = "toner-lite",
             color = I("red"),
             xlab = "Longitude", ylab = "Latitude")
      
    })
    
    }
)