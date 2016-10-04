#' Information about a specific match
#'
#' Player information about a specific match ID.
#'
#' A list will be returned that contains four elements. The content_player, the content_game,
#' the url and the response received from the api.
#'
#' The content_player element is a list that contains information about the players participating in
#' a match. The information included (as elements of the list):
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
#'     /url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails}.
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
#' The content_game element is a list that contains information about the match. The information
#' included included (as elements of the list):
#'
#' \itemize{
#'   \item \strong{radiant_win:} Boolean. Whether radiant won or not.
#'   \item \strong{duration:} The duration of a game in seconds.
#'   \item \strong{pre_game_duration:} The pre game duration.
#'   \item \strong{start_time:} Unix Timestamp of when the game began.
#'   \item \strong{match_id:} The match's unique id.
#'   \item \strong{match_seq_num:} A sequence number. It represents the order matches were recorded.
#'   \item \strong{tower_status_radiant:} Tower Status. Check
#'     /url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails}.
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
#' get_match_details(match_id = 2686721815)
#' get_match_details(match_id = 2686721815, language = 'en', key = NULL)
#' get_match_details(match_id = 2686721815, language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_match_details <- function(match_id, language = 'en', key = NULL) {

 #if key is null look in the environment variables
 if (is.null(key)) {
  key <- get_key()

  #if key is blank space then stop i.e. environment variable has not be set.
  if (is.null(key) || !nzchar(key)) {
   stop(strwrap('The function cannot find an API key. Please register a key by using
                the RDota2::register_key function. If you do not have a key you can
                obtain one by visiting https://steamcommunity.com/dev.',
                width = 1e10))
  }
 }

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #fetching response
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/v1',
                   query = list(key = key, language = language, match_id = match_id),
                   ua)

 #get url
 url <- strsplit(resp$url, '\\?')[[1]][1]

 #check for code status. Any http errors will be converted to something meaningful.
 httr::stop_for_status(resp)

 if (httr::http_type(resp) != "application/json") {
  stop("API did not return json", call. = FALSE)
 }

 #parse response - each element in players is a player(!)
 parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

 #output
 structure(
  list(
   content_players = parsed[[1]][[1]],
   content_game = parsed[[1]][-1],
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

 }


