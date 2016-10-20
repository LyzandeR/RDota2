#' Information about DotaTV-supported leagues
#'
#' Information about DotaTV-supported leagues.
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
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_league_listing()
#' get_league_listing(language = 'en', key = NULL)
#' get_league_listing(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetLeagueListing}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_league_listing <- function(dota_id = 570, language = 'en', key = NULL) {

 #get query arguments
 args <- list(key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetLeagueListing', 'IDOTA2Match', 1, args)

 #convert content to data.frame
 dota_result$content <-
  do.call(rbind.data.frame, c(dota_result$content[[1]][[1]], stringsAsFactors = FALSE))

 #return
 dota_result

}


