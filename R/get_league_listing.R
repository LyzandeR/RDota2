#' Information about DotaTV-supported leagues
#'
#' \code{add_css_caption} will return a data.frame with information about DotaTV-supported leagues.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content is probably the most useful part for the user since it is a data.frame containing the
#' information about the DotaTV-supported leagues. It consists of the five following columns:
#' \itemize{
#'   \item \strong{leagues:} The leagues supported in-game via DotaTV.
#'   \item \strong{name:} The league name.
#'   \item \strong{leagueid:} The ID of the league (unique).
#'   \item \strong{description:} A description containing information about the league.
#'   \item \strong{tournament_url:} The website of the link.
#' }
#'
#' @param key The api key obtained from Steam. If you don't have one please visit
#' \url{https://steamcommunity.com/dev} in order to do so. For instructions on the correct way
#' to use this key please visit \url{https://github.com/LyzandeR/RDota2} and check the readme file.
#' You can also see the examples. A key can be made available to all the functions by using
#' \code{register_key}. The key argument in individual functions should only be used in case the
#' user needs to work with multiple keys.
#'
#' @param language The ISO639-1 language code for returning all the information in the corresponding
#' language. If the language is not supported, english will be returned. For a complete list of the
#' ISO639-1 language codes please visit \url{https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes}.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_league_listing(language = 'en', key = NULL)
#' get_league_listing(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_league_listing <- function(language = 'en', key = NULL) {

 #if key is null look in the environment variables
 if (is.null(key)) {
  key <- get_key()

  #if key is blank space then stop i.e. environment variable has not be set.
  if (!nzchar(key) | is.null(key)) {
   stop(strwrap('The function cannot find an API key. Please register a key by using
                the RDota2::register_key function. If you do not have a key you can
                obtain one by visiting https://steamcommunity.com/dev.',
                width = 1e10))
  }
 }

 #set a user agent
 ua <- user_agent("http://github.com/lyzander/RDota2")

 resp <- GET('http://api.steampowered.com/IDOTA2Match_570/GetLeagueListing/v1/',
             query = list(key = key, language = language), ua)

 #get url
 url <- strsplit(resp$url, '\\?')[[1]][1]

 #check for code status. Any http errors will be converted to something meaningful.
 stop_for_status(resp)

 if (http_type(resp) != "application/json") {
  stop("API did not return json", call. = FALSE)
 }

 #parse response
 parsed <- jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)
 #convert to a data.frame
 df <- do.call(rbind.data.frame, c(parsed[[1]][[1]], stringsAsFactors = FALSE))

 #output
 structure(
  list(
   content = df,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

}

#print method for dota_api
print.dota_api <- function(x, ...) {
 cat("<RDota2 ", x$url, ">\n\n", sep = "")
 str(x$content)
 invisible(x)
}
