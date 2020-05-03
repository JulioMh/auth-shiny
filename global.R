################################
# LIBRARY
################################

library(shiny)
library(shinythemes)
library(DBI)
library(RMySQL)
library(shiny.router)
library(stringr)

################################
# MODULES
################################
source("modules/auth/logIn.R")
source("modules/auth/signUp.R")

################################
# PAGES
################################
router <- make_router(
  route("login", logInUI("login")),
  route("signup", signUpUI("signup"))
)

################################
# DATABASE
################################
options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3308,
  "user" = "root",
  "password" = "root"
))
databaseName <- "db"