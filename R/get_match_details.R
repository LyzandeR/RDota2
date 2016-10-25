#' Information about a specific match
#'
#' Player and Game information about a specific match ID.
#'
#' A list will be returned that contains three elements. The content,
#' the url and the response received from the api.
#'
#' The content element is a list that contains information about the players participating in
#' a match and also information about the match. The first element of the content list contains
#' information about the players. The following details are included:
#'
#' \itemize{
#'   \item \strong{account_id:} The player's account id.
#'   \item \strong{player_slot:} A player's slot is returned via an 8-bit unsigned integer.
#'     The first bit represent the player's team, false if Radiant and true if dire.
#'     The final three bits represent the player's position in that team, from 0-4.
#'   \item \strong{hero_id:} The hero id.
#'   \item \strong{item_0:} Top-left inventory item.
#'   \item \strong{item_1:} Top-center inventory item.
#'   \item \strong{item_2:} Top-right inventory item.
#'   \item \strong{item_3:} Bottom-left inventory item.
#'   \item \strong{item_4:} Bottom-center inventory item.
#'   \item \strong{item_5:} Bottom-right inventory item.
#'   \item \strong{kills:} Number of times player killed.
#'   \item \strong{deaths:} Number of times player died.
#'   \item \strong{assists:} Number of assists player achieved.
#'   \item \strong{leaver_status:} Integer from 0-6. Check
#'     \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails}.
#'   \item \strong{last_hits:} Number of last hits.
#'   \item \strong{denies:} Number of denies.
#'   \item \strong{level:} Hero level at the end of game.
#'   \item \strong{xp_per_min:} Xp per minute gained.
#'   \item \strong{hero_damage:} Total damage dealt to heroes.
#'   \item \strong{tower_damage:} Total damage dealt to towers.
#'   \item \strong{hero_healing:} Total health healed on heroes.
#'   \item \strong{gold:} Total gold left at the end of game.
#'   \item \strong{gold_spent:} Total gold spent.
#'   \item \strong{scaled_hero_damage:} Undocumented. Possibly damage after armour.
#'   \item \strong{scaled_tower_damage:} Undocumented.
#'   \item \strong{scaled_hero_healing:} Undocumented.
#'   \item \strong{ability_upgrades:} A list of all abilities in order of upgrade.
#' }
#'
#' The rest of the elements of the content list contain information about the match. The following
#' details are included:
#'
#' \itemize{
#'   \item \strong{radiant_win:} Boolean. Whether radiant won or not.
#'   \item \strong{duration:} The duration of a game in seconds.
#'   \item \strong{pre_game_duration:} The pre game duration.
#'   \item \strong{start_time:} Unix Timestamp of when the game began.
#'   \item \strong{match_id:} The match's unique id.
#'   \item \strong{match_seq_num:} A sequence number. It represents the order matches were recorded.
#'   \item \strong{tower_status_radiant:} Tower Status. Check
#'     \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails}.
#'   \item \strong{barracks_status_dire:} Same as above.
#'   \item \strong{cluster:} The server cluster (used for downloading replays).
#'   \item \strong{first_blood_time:} Time in seconds when the first blood occured.
#'   \item \strong{lobby_type:} Type of lobby.
#'   \item \strong{human_players:} Number of human players.
#'   \item \strong{leagueid:} The league id.
#'   \item \strong{positive_votes:} Number of positive votes.
#'   \item \strong{negative_votes:} Number of negative votes.
#'   \item \strong{game_mode:} Game mode.
#'   \item \strong{flags:} Undocumented.
#'   \item \strong{engine:} 0 - source1, 1 - source 2.
#'   \item \strong{radiant_score:} Undocumented.
#'   \item \strong{dire_score:} Undocumented.
#' }
#'
#' @param match_id The match ID you want to get information about. Can be either numeric or
#' .character
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_match_details(match_id = 2686721815)
#' get_match_details(match_id = 2686721815, language = 'en', key = NULL)
#' get_match_details(match_id = 2686721815, language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @section Steam API Documentation:
#' \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails}
#'
#' @export
get_match_details <- function(match_id, dota_id = 570, language = 'en', key = NULL) {

 #get query arguments
 args <- list(match_id = match_id, key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetMatchDetails', 'IDOTA2Match', 1, args)

 #remove some unnecessary levels
 dota_result$content <- dota_result$content[[1]]

 #return
 dota_result

}


