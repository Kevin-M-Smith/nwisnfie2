#' Parses configuration file and returns a \code{config} object. 
#' 
#' @param configFile Character vector describing path to configuration file in YAML format. 
#' @return Configuration object used by many functions in the \code{nwisnifie2} package.
#' @seealso For proper formatting of the configuration file, see \code{\link{Configuration File}}.
#' @examples
#' \dontrun{
#' # Load Configuration File and Start Database Connection
#'  library(nwisnfie)
#'  config <- LoadConfiguration("~/nwisnfie2/config.yaml")
#'  conn <- StartDBConnection(config)
#' }
LoadConfiguration <- function(configFile = "config.yaml") {
  config <- yaml::yaml.load_file(configFile)
}
