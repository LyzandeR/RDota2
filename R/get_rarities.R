#' Dota Store Item Rarities
#'
#' A data.frame of Dota2 Store Item Rarities.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a data.frame with all the store item rarities.
#' Each row of the data.frame is an store item rarity and the following columns are included:
#'
#' \itemize{
#'   \item \strong{name:} Internal rarity name.
#'   \item \strong{id:} Rarity's ID.
#'   \item \strong{order:} Logical order of rarities. From most common to most rare.
#'   \item \strong{color:} Hexadecimal RGB color of the rarity's name.
#'   \item \strong{localized_name:} In-game rarity name.
#' }
#'
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_rarities(language = 'en', key = NULL)
#' get_rarities(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetRarities}
#'
#' @export
get_rarities <- function(dota_id = '570',
                         language = 'en',
                         key = NULL) {

 #get query arguments
 args <- list(key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetRarities', 'IEconDOTA2', 1, args)

 #remove some unnecessary levels
 dota_result$content <-
  do.call(rbind.data.frame, c(dota_result$content[[1]][[2]], stringsAsFactors = FALSE))

 #return
 dota_result

}

