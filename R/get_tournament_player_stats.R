#' Tournament Player Stats
#'
#' Tournament Player Stats.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains information about the matches the player played and
#' information about global stats.
#'
#' @param account_id Player's account id.
#'
#' @param league_id (optional) The league id. Only the International is supported.
#'
#' @param hero_id (optional) A hero id.
#'
#' @param time_frame (optional) Only return stats between this time frame (The parameter format
#' is not yet known i.e. it is not in use just yet).
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
#' get_tournament_player_stats()
#' get_tournament_player_stats(teams_requested = 10)
#' get_tournament_player_stats(language = 'en', key = NULL)
#' get_tournament_player_stats(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @export
get_tournament_player_stats <- function(account_id = NULL,
                                        league_id = NULL,
                                        hero_id = NULL,
                                        time_frame = NULL,
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
 resp <- httr::GET('http://api.steampowered.com/IDOTA2Match_570/GetTournamentPlayerStats/v2/',
                   query = list(account_id = account_id,
                                league_id = league_id,
                                hero_id = hero_id,
                                time_frame = time_frame,
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
 player <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)

 #output
 structure(
  list(
   content = player,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

}


