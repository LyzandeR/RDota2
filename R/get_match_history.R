#' A list of Matches
#'
#' Alist of matches based on various parameters.
#'
#' A list will be returned that contains three elements. The content, the url and the
#' response received from the api.
#'
#' The content element of the list is a list that contains information about the matches.
#' Each element of the matches list is a game. Each game consists of a list of (some) of
#' the following sections:
#'
#' \itemize{
#'   \item \strong{players:} A list of lists containing information about the players.
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
#'   \item \strong{scoreboard:} A huge list containing scoreboard information. Scoreboard might
#'   be missing from some of the games.
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
#' @param date_min (optional) Minimum date range for returned matches (Unix Timestamp).
#'
#' @param date_max (optional) Maximum date range for returned matches (Unix Timestamp).
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
#' @param key The api key obtained from Steam. If you don't have one please visit
#' \url{https://steamcommunity.com/dev} in order to do so. For instructions on the correct way
#' to use this key please visit \url{https://github.com/LyzandeR/RDota2} and check the readme file.
#' You can also see the examples. A key can be made available to all the functions by using
#' \code{key_actions}. The key argument in individual functions should only be used in case the
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
#' get_match_history()
#' get_match_history(language = 'en', key = NULL)
#' get_match_history(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#' \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistory}
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
                              language = 'en',
                              key = NULL) {

 #if key is null look in the environment variables
 if (is.null(key)) {
  key <- get_key()

  #if key is blank space then stop i.e. environment variable has not be set.
  if (is.null(key) || !nzchar(key)) {
   stop(strwrap('The function cannot find an API key. Please register a key by using
                the RDota2::key_actions function. If you do not have a key you can
                obtain one by visiting https://steamcommunity.com/dev.',
                width = 1e10))
  }
 }

 #make sure if tournament_games_only is provided, it is binary
 if (!is.null(tournament_games_only)) {
  if (!all.equal(0, as.numeric(tournament_games_only)) |
      !all.equal(1, as.numeric(tournament_games_only))) {
   stop('If provided tournament_games_only needs to be either 0 or 1')
  }
 }

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #fetching response
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v1/',
                   query = list(hero_id = hero_id,
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
                                language = language),
                   ua)

 #get url
 url <- strsplit(resp$url, '\\?')[[1]][1]

 #check for code status. Any http errors will be converted to something meaningful.
 httr::stop_for_status(resp)

 if (httr::http_type(resp) != "application/json") {
  stop("API did not return json", call. = FALSE)
 }

 #parse response - each element in games is a game(!)
 games <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)[[1]]

 #output
 structure(
  list(
   content = games,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

}


