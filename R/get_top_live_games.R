#' Top Live Games
#'
#' Returns the top live games by MMR.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a games_list list which contains
#' information about the top live games. The following information is provided for each game
#' (Categories are not documented at the time of the release - please check
#' the Steam API Documentation link below:
#'
#' \itemize{
#'   \item \strong{activate_time}
#'   \item \strong{deactivate_time}
#'   \item \strong{server_steam_id}
#'   \item \strong{lobby_id}
#'   \item \strong{league_id}
#'   \item \strong{lobby_type}
#'   \item \strong{game_time}
#'   \item \strong{delay}
#'   \item \strong{spectators}
#'   \item \strong{game_mode}
#'   \item \strong{average_mmr}
#'   \item \strong{sort_score}
#'   \item \strong{last_update_time}
#'   \item \strong{radiant_lead}
#'   \item \strong{radiant_score}
#'   \item \strong{dire_score}
#'   \item \strong{players}
#' }
#'
#' @param partner The documentation does not specify what this parameter should be but it seems
#' like numbers from 1-3 return results of live games.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_top_live_game(partner = 1)
#' get_top_live_game(partner = 1, language = 'en', key = NULL)
#' get_top_live_game(partner = 2, language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetTopLiveGame}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_top_live_game <- function(partner = 1,
                              dota_id = 570,
                              language = 'en',
                              key = NULL) {

 #get query arguments
 args <- list(partner = partner, key = key, language = language)

 #result
 get_response(dota_id, 'GetTopLiveGame', 'IDOTA2Match', 1, args)

}


