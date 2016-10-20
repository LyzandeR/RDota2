#' Team Information
#'
#' Team information from team id.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains the teams list of which each element is a team. For each
#' team different information is provided. Usually the following are included:
#'
#' \itemize{
#'   \item \strong{name:} Team's name.
#'   \item \strong{tag:} The team's tag.
#'   \item \strong{time_created:} Unix timestamp of when the team was created.
#'   \item \strong{calibration_games_remaining: :} Undocumented (possibly number of games until
#'   a ranking score can be dedided).
#'   \item \strong{logo:} The UGC id for the team logo.
#'   \item \strong{logo_sponsor:} The UGC id for the team sponsor logo.
#'   \item \strong{country_code:} The team's ISO 3166-1 country-code.
#'   \item \strong{url:} Team's url which they provided.
#'   \item \strong{games_played:} Number of games played.
#'   \item \strong{player_*_account_id:} Player's account id. Will be as many columns as players.
#'   \item \strong{admin_account_id:} Team's admin id.
#'   \item \strong{league_id_*:} Undocumented (Probably leagues they participated in). Will be as
#'   many columns as leagues.
#'   \item \strong{series_type:} Series type.
#'   \item \strong{league_series_id:} The league series id.
#'   \item \strong{league_game_id:} The league game id.
#'   \item \strong{stage_name:} The name of the stage.
#'   \item \strong{league_tier:} League tier.
#'   \item \strong{scoreboard:} A huge list containing scoreboard information.
#' }
#'
#' @param start_at_team_id (optional) Team id to start returning results from .
#'
#' @param teams_requested (optional) The number of teams to return.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetTeamInfoByTeamID}
#'
#' @examples
#' \dontrun{
#' get_team_info_by_team_id()
#' get_team_info_by_team_id(teams_requested = 10)
#' get_team_info_by_team_id(language = 'en', key = NULL)
#' get_team_info_by_team_id(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_team_info_by_team_id <- function(start_at_team_id = NULL,
                                     teams_requested = NULL,
                                     dota_id = 570,
                                     language = 'en',
                                     key = NULL) {

 #make sure matches_requested is positive number
 if (!is.null(teams_requested)) {
  if (as.integer(teams_requested) < 0 | is.na(as.numeric(teams_requested))) {
   stop('matches_requested must be positive')
  }
 }

 #get query arguments
 args <- list(start_at_team_id = start_at_team_id,
              teams_requested = teams_requested,
              key = key,
              language = language)

 #result
 dota_result <- get_response(dota_id, 'GetTeamInfoByTeamID', 'IDOTA2Match', 1, args)

 #remove some unnecessary levels
 dota_result$content <- dota_result$content[[1]][-1]

 #return
 dota_result

}

