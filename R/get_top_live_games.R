#' Top Live Games
#'
#' Returns the top live games by MMR.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a games_list list which contains
#' information about the top live games. The following information is provided for each game
#' (Categories are not documented at the time of writting - please check
#' \url{https://wiki.teamfortress.com/wiki/WebAPI/GetTopLiveGame}):
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
#' get_top_live_game(patner = 1)
#' get_top_live_game(patner = 1, language = 'en', key = NULL)
#' get_top_live_game(patner = 2, language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_top_live_game <- function(partner = 1,
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

 #set a user agent
 ua <- httr::user_agent("http://github.com/lyzander/RDota2")

 #fetching response
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetTopLiveGame/v1/',
                   query = list(partner = partner,
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
 games <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

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


