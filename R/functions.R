# Loading data
url <- paste0("https://warin.ca/datalake/Req/req_data.csv")
path <- file.path(tempdir(), "temp.csv")
if (httr::http_error(url)) { # network is down = message (not an error anymore)
  message("No Internet connection or the server is in maintenance mode.")
  return(NULL)
} else { # network is up = proceed to download via curl
  message("Req: downloading remote dataset.")
  with(options(timeout = max(300, getOption("timeout"))),curl::curl_download(url, path))
} # /if - network up or down
# Reading data
csv_file <- file.path(paste0(tempdir(), "/temp.csv"))
req_data <- read.csv(csv_file)

## Load libraries
library(roxygen2)
library(readr)
library(dplyr)
library(lubridate)

req_industry <- base::unique(req_data$COD_ACT_ECON_CAE)
req_active <- base::unique(req_data$active_company)
req_num_employee <- base::unique(req_data$COD_INTVAL_EMPLO_QUE)
req_date_creation <- base::unique(req_data$DAT_INIT_NOM_ASSUJ)

# Function 1 Data collection
#' data_inputs
#'
#' @description This function takes the data inputs of industry, an active dummy , the number of employees, and the creation date and returns the corresponding businesses
#' @description If any/all inputs are left blank, all possible observations are called
#'
#' @param industry The type of industry a business is classified under, according to the Registraire des entreprises
#' @param active a dummy variable equal to 1 if a company exists currently
#' @param num_employee a range of employees employed by the business
#' @param creation_date date the business was created (all else equal, all businesses before a specified date will be called)
#'
#' @return All corresponding businesses in Quebec
#' @export
#' @import dplyr lubridate
#'
#' @examples Req_data()
Req_data <- function(industry = req_industry,
                     active = req_active,
                     num_employee = req_num_employee,
                     creation_date = req_date_creation) {
  COD_ACT_ECON_CAE <- COD_ACT_ECON_CAE2 <- active_company <- COD_INTVAL_EMPLO_QUE <- DAT_INIT_NOM_ASSUJ <- NULL
  if (missing(creation_date)) {
    out <- dplyr::filter(req_data,
                         COD_ACT_ECON_CAE %in% industry | COD_ACT_ECON_CAE2 %in% industry,
                         active_company %in% active,
                         COD_INTVAL_EMPLO_QUE %in% num_employee)
  } else {
    out <- dplyr::filter(req_data,
                         COD_ACT_ECON_CAE %in% industry | COD_ACT_ECON_CAE2 %in% industry,
                         active_company %in% active,
                         COD_INTVAL_EMPLO_QUE %in% num_employee,
                         lubridate::ymd(DAT_INIT_NOM_ASSUJ) >= lubridate::ymd(creation_date))
  }

  ### Regardez juste si on peut enlever le warning lorsque creation_date est laissé vide
  return(out)
}

# Function 2 Industry symbols query
#' industry_query
#'
#' @description This function provides an industry code to the corresponding inputted industry number
#'
#' @param industry The name of the industry (If a full name isn't specified, all industries with a matching string will be called)
#'
#' @return The corresponding industry code
#' @export
#' @import
#'
#' @examples Req_industry(industry="Boulangeries et pâtisseries)
Req_industry <- function(industry) {
  req_industry_natural_language <- req_data %>% select("COD_ACT_ECON_CAE", "VAL_DOM_FRAN") %>% unique() %>% arrange(VAL_DOM_FRAN)
  if (missing(industry)) {
    req_industry_natural_language
  } else {
    req_industry_natural_language[grep(industry, req_industry_natural_language$VAL_DOM_FRAN, ignore.case = TRUE), ]
  }
}


# Function 3 Employee symbols query
#' employee_query
#'
#' @description This function provides a table displaying the range of employees that corresponds to the number of employees code, and vice-versa
#'
#' @return table displaying the ranges of employees in businesses and the corresponding codes
#' @export
#' @import
#'
#' @examples Req_employee()
Req_employee <- function() {
  req_employee_natural_language <- req_data %>% select("COD_INTVAL_EMPLO_QUE", "num_employees") %>% unique() %>% arrange(COD_INTVAL_EMPLO_QUE)
  req_employee_natural_language
}


