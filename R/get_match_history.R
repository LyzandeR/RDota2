#' A list of Matches
#'
#' A list of matches based on various parameters.
#'
#' A list will be returned that contains three elements. The content, the url and the
#' response received from the api.
#'
#' The content element of the list contains a list called matches.
#' Each element of matches list is a match. Each match contains
#' the following sections:
#'
#' \itemize{
#'   \item \strong{match_id:} The match id.
#'   \item \strong{match_seq_num:}A sequence number, representing the order in which
#'   matches were recorded.
#'   \item \strong{start_time:} UNIX timestamp of when the game began.
#'   \item \strong{lobby_type:} Check the API Documentation.
#'   \item \strong{radiant_team_id:} Radiant team id.
#'   \item \strong{dire_team_id:} Dire team id.
#'   \item \strong{players:} A list containing information about the players.
#' }
#'
#' @param hero_id (optional) The hero id. A list of hero ids can be found
#' via the get_heroes function.
#'
#' @param game_mode (optional) The game mode:
#' \itemize{
#'   \item 0 - None
#'   \item 1 - All Pick
#'   \item 2 - Captain's Mode
#'   \item 3 - Random Draft
#'   \item 4 - Single Draft
#'   \item 5 - All Random
#'   \item 6 - Intro
#'   \item 7 - Diretide
#'   \item 8 - Reverse Captain's Mode
#'   \item 9 - The Greeviling
#'   \item 10 - Tutorial
#'   \item 11 - Mid Only
#'   \item 12 - Least Played
#'   \item 13 - New Player Pool
#'   \item 14 - Compendium Matchmaking
#'   \item 16 - Captain's Draft
#' }
#' No 15 does not exist
#'
#' @param skill (optional) Skill bracket.
#' \itemize{
#' \item 0 - Any
#' \item 1 - Normal
#' \item 2 - High
#' \item 3 - Very High
#' }
#'
#' @param date_min (optional) Minimum date range for returned matches (yyyy-mm-dd HH:MM:SS).
#'
#' @param date_max (optional) Maximum date range for returned matches (yyyy-mm-dd HH:MM:SS).
#'
#' @param min_players (optional) Minimum number of players in match.
#'
#' @param account_id (optional) Account ID.
#'
#' @param league_id (optional) League ID.
#'
#' @param start_at_match_id (optional) Matches equal or older than this ID.
#'
#' @param matches_requested (optional) Amount of matches to return (defaults to 25).
#'
#' @param tournament_games_only (optional) Binary (0 or 1). Whether to return tournament matches.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_match_history(matches_requested = 2)
#' get_match_history(matches_requested = 2, date_min = '2015-01-01 16:00:00', hero_id = 1)
#' get_match_history(language = 'en', key = NULL)
#' get_match_history(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#' \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistory}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#' @inheritParams get_scheduled_league_games
#'
#' @export
get_match_history <- function(hero_id = NULL,
                              game_mode = NULL,
                              skill = NULL,
                              date_min = NULL,
                              date_max = NULL,
                              min_players = NULL,
                              account_id = NULL,
                              league_id = NULL,
                              start_at_match_id = NULL,
                              matches_requested = NULL,
                              tournament_games_only = NULL,
                              tz = '',
                              dota_id = 570,
                              language = 'en',
                              key = NULL) {

 #make sure if tournament_games_only is provided, it is binary
 if (!is.null(tournament_games_only)) {
  if (!isTRUE(all.equal(0, as.numeric(tournament_games_only))) &
      !isTRUE(all.equal(1, as.numeric(tournament_games_only)))) {
   stop('tournament_games_only needs to be either 0 or 1')
  }
 }

 #make sure dates are in the right format
 if (!is.null(date_min)) {
  date_min <- as.numeric(as.POSIXct(date_min, tz = tz))
  if (is.na(date_min)) stop('date_min not in the right format. It needs to be yyyy-mm-dd HH:MM:SS')
 }
 if (!is.null(date_max)) {
  date_max <- as.numeric(as.POSIXct(date_max, tz = tz))
  if (is.na(date_max)) stop('date_max not in the right format. It needs to be yyyy-mm-dd HH:MM:SS')
 }


 #get query arguments
 args <- list(hero_id = hero_id,
              game_mode = game_mode,
              skill = skill,
              date_min = date_min,
              date_max = date_max,
              min_players = min_players,
              account_id = account_id,
              league_id = league_id,
              start_at_match_id = start_at_match_id,
              matches_requested = matches_requested,
              tournament_games_only = tournament_games_only,
              key = key,
              language = language)

 #result
 dota_result <- get_response(dota_id, 'GetMatchHistory', 'IDOTA2Match', 1, args)

 #remove some unnecessary levels
 dota_result$content <- dota_result$content[[1]]['matches']

 #return
 dota_result

}


