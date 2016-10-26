#' Scheduled League Games
#'
#' A list of scheduled league matches.
#'
#' A list will be returned that contains three elements. The content, the url and the
#' response received from the api.
#'
#' The content element of the list contains a games list with information about the matches.
#' Each element of the games list is a game. Each game consists of (some) of
#' the following sections:
#'
#' \itemize{
#'   \item \strong{league_id:} The unique league id.
#'   \item \strong{game_id:} A unique game id.
#'   \item \strong{teams:} A list of the participating teams.
#'   \item \strong{starttime:} Unix Timestamp of start time.
#'   \item \strong{comment:} Description of game.
#'   \item \strong{final:} Whether the game is a final or not.
#' }
#'
#' @param date_min (optional) A date of the format "yyyy-mm-dd HH:MM:SS". See examples for details.
#'        Return games from this date onwards.
#'
#' @param date_max (optional) A date of the format "yyyy-mm-dd HH:MM:SS". See examples for details.
#'        Return games up to this date
#'
#' @param tz A time zone specification if date_min and/or date_max are used. See
#'  \link{as.POSIXct}. "" (default) is the current time zone and "GMT" is UTC.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetScheduledLeagueGames}
#'
#' @examples
#' \dontrun{
#' get_scheduled_league_games()
#' get_scheduled_league_games(language = 'en', key = NULL)
#' get_scheduled_league_games(language = 'en', key = 'xxxxxxxxxxx')
#' get_scheduled_league_games(date_min = '2016-06-01 00:00:00',
#'                            date_max = '2016-09-07 00:00:00')
#' }
#'
#' @export
get_scheduled_league_games <- function(date_min  = NULL,
                                       date_max  = NULL,
                                       tz = '',
                                       dota_id = '570',
                                       language = 'en',
                                       key = NULL) {

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
 args <- list(date_min = date_min, date_max = date_max, key = key, language = language)

 #result
 get_response(dota_id, 'GetScheduledLeagueGames', 'IDOTA2Match', 1, args)


}


