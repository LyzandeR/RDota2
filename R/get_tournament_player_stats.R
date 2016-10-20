#' Tournament Player Stats
#'
#' Tournament Player Stats.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains information about the matches the player played and
#' information about global stats.
#'
#' @param account_id Player's account id.
#'
#' @param league_id (optional) The league id. Only the International is supported (65006).
#'
#' @param hero_id (optional) A hero id.
#'
#' @param time_frame (optional) Only return stats between this time frame (The parameter format
#' is not yet known i.e. it is not in use just yet according to the API's documentation).
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_tournament_player_stats(account_id = 89550641, league_id = 65006)
#' get_tournament_player_stats(language = 'en', key = NULL)
#' get_tournament_player_stats(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetTournamentPlayerStats}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_tournament_player_stats <- function(account_id,
                                        league_id = NULL,
                                        hero_id = NULL,
                                        time_frame = NULL,
                                        dota_id = 570,
                                        language = 'en',
                                        key = NULL) {

 #get query arguments
 args <- list(account_id = account_id,
              league_id = league_id,
              hero_id = hero_id,
              time_frame = time_frame,
              key = key,
              language = language)

 #result
 get_response(dota_id, 'GetTournamentPlayerStats', 'IDOTA2Match', 2, args)

}


