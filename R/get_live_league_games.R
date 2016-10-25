#' Information about Live League Matches
#'
#' In-game League Matches and Information about them.
#'
#' A list will be returned that contains three elements. The content (a huge list with all the
#' games), the url and the response received from the api.
#'
#' The content element of the list contains a games list  which has information about the
#' live league games. Each element of the games list is a game. Each game consists of the
#' following sections (list elements):
#'
#' \itemize{
#'   \item \strong{players:} A list of lists containing information about the players.
#'   \item \strong{radiant_team:} A list with information about the radiant team.
#'   \item \strong{dire_team:} A list with information about the dire team..
#'   \item \strong{lobby_id:} The lobby id.
#'   \item \strong{match_id:} The match id.
#'   \item \strong{spectators:} The number of spectators.
#'   \item \strong{series_id:} The series id.
#'   \item \strong{game_number:} The game number.
#'   \item \strong{league_id:} The league id.
#'   \item \strong{stream_delay_s:} The stream delay in secs.
#'   \item \strong{radiant_series_wins:} Radiant series wins.
#'   \item \strong{dire_series_wins:} Dire series wins.
#'   \item \strong{series_type:} Series type.
#'   \item \strong{league_series_id:} The league series id.
#'   \item \strong{league_game_id:} The league game id.
#'   \item \strong{stage_name:} The name of the stage.
#'   \item \strong{league_tier:} League tier.
#'   \item \strong{scoreboard:} A huge list containing scoreboard information.
#' }
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetLiveLeagueGames}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @examples
#' \dontrun{
#' get_live_league_games()
#' get_live_league_games(language = 'en', key = NULL)
#' get_live_league_games(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_live_league_games <- function(dota_id = 570, language = 'en', key = NULL) {

 #get query arguments
 args <- list(key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetLiveLeagueGames', 'IDOTA2Match', 1, args)

 #remove some unnecessary levels
 dota_result$content <- dota_result$content[[1]]

 #return
 dota_result

}


