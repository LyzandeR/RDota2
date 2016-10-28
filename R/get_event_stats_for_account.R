#' Event Stats for Accounts
#'
#' Event Stats for Accounts.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api. Event points and actions seem to be returned from the api but none
#' of them have been documented in the api.
#'
#' @param eventid The league id of the compendium.
#'
#' @param accountid The account id.
#'
#' @param key The api key obtained from Steam. If you don't have one please visit
#'  \url{https://steamcommunity.com/dev} in order to do so. For instructions on the correct way
#'  to use this key please visit \url{https://github.com/LyzandeR/RDota2} and check the readme file.
#'  You can also see the examples. A key can be made available to all the functions by using
#'  \code{key_actions}. The key argument in individual functions should only be used in case the
#'  user needs to work with multiple keys.
#'
#' @param language The ISO639-1 language code for returning all the information in the corresponding
#' language. If the language is not supported, english will be returned. For a complete list of the
#' ISO639-1 language codes please visit \url{https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes}.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetEventStatsForAccount}
#'
#' @examples
#' \dontrun{
#' get_event_stats_for_account(eventid = 65006, accountid = 89550641)
#' }
#'
#' @inheritParams get_response
#'
#' @export
get_event_stats_for_account <- function(eventid,
                                        accountid,
                                        dota_id = 570,
                                        language = 'en',
                                        key = NULL) {

 #get query arguments
 args <- list(eventid = eventid, accountid = accountid, key = key, language = language)

 #result
 get_response(dota_id, 'GetEventStatsForAccount', 'IEconDOTA2', 1, args)

}

