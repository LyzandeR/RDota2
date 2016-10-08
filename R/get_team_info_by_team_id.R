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
#' get_team_info_by_team_id()
#' get_team_info_by_team_id(teams_requested = 10)
#' get_team_info_by_team_id(language = 'en', key = NULL)
#' get_team_info_by_team_id(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_team_info_by_team_id <- function(start_at_team_id = NULL,
                                     teams_requested = NULL,
                                     language = 'en',
                                     key = NULL) {

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

 #make sure matches_requested is positive number
 if (!is.null(teams_requested)) {
  if (as.integer(teams_requested) < 0 | is.na(as.numeric(teams_requested))) {
   stop('matches_requested must be positive')
  }
 }

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #fetching response
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetTeamInfoByTeamID/v1/',
                   query = list(start_at_team_id = start_at_team_id,
                                teams_requested = teams_requested,
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
 teams <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)[[1]][-1]

 #output
 structure(
  list(
   content = teams,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

 }


