logInUI <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      id = "login",
      style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
      wellPanel(
        h2("LOG IN", class = "text-center", style = "padding-top: 0;color:#333; font-weight:600;"),
        textInput(
          ns("userName"),
          placeholder = "Username",
          label = tagList(icon("user"), "Username")
        ),
        passwordInput(
          ns("passwd"),
          placeholder = "Password",
          label = tagList(icon("unlock-alt"), "Password")
        ),
        br(),
        textOutput(ns("missing")),
        br(),
        div(
          style = "text-align: center;",
          actionButton(
            ns("login"),
            "LOG IN",
            style = "color: white; background-color:#3c8dbc;
                                 padding: 10px 15px; width: 150px; cursor: pointer;
                                 font-size: 18px; font-weight: 600;"
          ),
          br(),
          actionLink(ns("signup"), "SIGN UP")
        ),
        br(),
        br(),
        textOutput(ns("res")),
        br()
      )
    )
  )
}

logIn <- function(input, output, session) {
  output$missing <- renderText(
    validate(
      need(input$userName != '', label= "User name"),
      need(input$passwd != '', label= "Password")
    )
  )
  
  observeEvent(input$signup, {
    change_page("signup")
  })
  
  observeEvent(input$login, isolate({
    req(input$userName)
    req(input$passwd)
    res <- performanceLogIn(input$userName, input$passwd)
    output$res <- renderText(res)
  }))
}

performanceLogIn <- function(userName, password){
  db <-
    dbConnect(
      MySQL(),
      dbname = databaseName,
      host = options()$mysql$host,
      port = options()$mysql$port,
      user = options()$mysql$user,
      password = options()$mysql$password
    )
  query <- sprintf(
    "select * from User where userName= '%s' and password = '%s'",
    userName,
    password
  )
  response <- dbGetQuery(db,query)
  if(nrow(response)==0){
    res <- "Wrong user or password"
  }else{
    res <- "Welcome!"
  }
  dbDisconnect(db)
  return(res)
}
