#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
ui <- fluidPage(
  router_ui()
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  router(input, output)
  callModule(logIn, "login")
  callModule(signUp, "signup")
}

# Run the application
shinyApp(ui = ui, server = server)
