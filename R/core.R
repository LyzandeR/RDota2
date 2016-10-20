#' The engine of the request functions
#'
#' The function used to fetch the response content inside the the API functions.
#'
#' This function is of no particular use to the user, but might be useful for anyone who
#' would like to dive deeper into the package development. This function is used to GET the
#' response's content from Steam's API. The function is the core function of the rest of
#' the get_* family functions.
#'
#' @param dota_id Can take one of three values.
#'
#' \itemize{
#'  \item 570 - Dota 2 (default)
#'  \item 816 - Dota 2 Internal Test
#'  \item 205790 - Dota 2 Beta Test
#' }
#'
#' @param dota_api_method The api method.
#'
#' @param dota_api_category One of IDOTA2Match or IEconDOTA2.
#'
#' @param api_version The api version.
#'
#' @param args The query arguments for GET.
#'
#' @return A response to be used in the rest of the get_* family functions.
#'
#' %makes documentation available but removes function from index
#' @keywords internal
#'
#' @export
get_response <- function(dota_id, dota_api_method, dota_api_category, api_version, args) {

 #make sure key is set
 if (is.null(args$key)) {
  args$key <- get_key()

  #if key is blank space then stop i.e. environment variable has not be set.
  if (is.null(args$key) || !nzchar(args$key)) {
   stop(strwrap('The function cannot find an API key. Please register a key by using
                the RDota2::key_actions function. If you do not have a key you can
                obtain one by visiting https://steamcommunity.com/dev.',
                width = 1e10))
  }
 }

 #make sure dota_id is one of 570, 816, 205790
 if (!as.character(dota_id) %in% c('570', '816', '205790')) {
  stop('dota_id needs to be one of 570, 816, 205790')
 }

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #craft request url
 request_url <- sprintf('http://api.steampowered.com/%s_%s/%s/v%s',
                       dota_api_category,
                       dota_id,
                       dota_api_method,
                       api_version)

 #get response
 resp <- httr::GET(request_url,
                   query = args,
                   ua)

 #get url
 url <- strsplit(resp$url, '\\?')[[1]][1]

 #check for code status. Any http errors will be converted to something meaningful.
 httr::stop_for_status(resp)

 if (httr::http_type(resp) != "application/json") {
  stop("API did not return json", call. = FALSE)
 }

 #response
 content <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

 #output
 structure(
  list(
   content = content,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

}
