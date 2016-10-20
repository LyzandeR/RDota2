#' Dota Tournament Prizes
#'
#' Dota Tournament Prizes.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a data.frame tournament prizes.
#' Each row of the data.frame is a tournament and the following columns are included:
#'
#' \itemize{
#'   \item \strong{prize_pool:} The prize pool.
#'   \item \strong{league_id:} The league's id.
#' }
#'
#' @param leagueid (optional) The league id to get prize information about.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_tournament_prize_pool(leagueid = 40)
#' get_tournament_prize_pool(leagueid = 65006)
#' get_tournament_prize_pool(language = 'en', key = NULL)
#' get_tournament_prize_pool(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetTournamentPrizePool}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_tournament_prize_pool <- function(leagueid = NULL,
                                      dota_id = 570,
                                      language = 'en',
                                      key = NULL) {

 #get query arguments
 args <- list(leagueid = leagueid, key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetTournamentPrizePool', 'IEconDOTA2', 1, args)

 #convert to data.frame
 dota_result$content <-
  do.call(rbind.data.frame, c(dota_result$content, stringsAsFactors = FALSE))

 #status can be seen in response. No need to be included in data.frame
 dota_result$content$status <- NULL

 #return
 dota_result

}

