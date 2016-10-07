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
#'   \item \strong{players:} A list of lists containing information about the players.
#'   \item \strong{radiant_team} A list of radiant team infomation.
#'   \item \strong{dire_team} A list of dire team infomation.
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
#' @param date_min (optional) A date of the format "yyyy-mm-dd HH:MM:SS". See examples for details.
#'        Return games from this date onwards.
#'
#' @param date_max (optional) A date of the format "yyyy-mm-dd HH:MM:SS". See examples for details.
#'        Return games up to this date
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
#' @param ... arguments to be passed to as.POSIXct internally. This comes in handy when setting
#' a tize zone with tz. Dates will be converted to UNIX timestamps before passed on to the API.
#'
#' @return A dota_api object containing the elements described in the details.
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
                                       language = 'en',
                                       key = NULL,
                                       ...) {

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

 #make sure dates are in the right format
 if (!is.null(date_min)) {
  min_date <- as.numeric(as.POSIXct(date_min, ...))
  if (is.na(date_min)) stop('date_min not in the right format. It needs to be yyyy-mm-dd HH:MM:SS')
 }
 if (!is.null(date_max)) {
  date_max <- as.numeric(as.POSIXct(date_max, ...))
  if (is.na(date_max)) stop('max_date not in the right format. It needs to be yyyy-mm-dd HH:MM:SS')
 }

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #fetching response
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetLiveLeagueGames/v1/',
                   query = list(date_min  = date_min,
                                date_max  = date_max,
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


