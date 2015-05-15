#' Manage Database Connections
#' 
#' Functions used to start and stop database connections. 
#' 
#' @name DBConnections
#' @param conn A RPostgreSQL connection object. 
#' @param config Configuration object created by LoadConfiguration.
#' @return For \code{StartDBConnection}, a RPostgreSQL connection object.
#' @seealso To build a \code{config} object, see \code{\link{LoadConfiguration}}.
#' @details
#' \code{StartDBConnection} starts a database connection specified by \code{config}.
#' \code{StopDBConnection} closes out the database connection contained in the \code{conn} object.
#' \code{TestDBConnection} attempts to start and stop a database connection based on \code{config}.
#' @examples
#' \dontrun{
#' # Start and End Database Connection
#'  library(nwisnfie)
#'  config <- LoadConfiguration("~/nwisnfie2/config.yaml")
#'  conn <- StartDBConnection(config)
#'  StopDBConnection(conn)
#' # or equivalently:
#'  TestDBConnection(config)
#' }
NULL

#' @rdname DBConnections
StartDBConnection <- function(config){
  library(RPostgreSQL)  
  driver <- DBI::dbDriver("PostgreSQL")
  conn <- DBI::dbConnect(driver, 
                         host      = config$db$host,
                         port      = config$db$port,
                         dbname    = config$db$name, 
                         user      = config$db$user, 
                         password  = config$db$pass)
  
  .message("Database login successful.", config = config)
  return(conn)
}

#' @rdname DBConnections
StopDBConnection <- function(conn, config){
  cc <- DBI::dbDisconnect(conn)
  .message("Database logout successful.", config = config)
}

#' @rdname DBConnections
TestDBConnection <- function(config){
  conn <- StartDBConnection(config)
  StopDBConnection(conn = conn, config = config)
}
