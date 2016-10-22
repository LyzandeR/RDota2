#' Dota Items
#'
#' Dota Items.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a data.frame with all the items. Each row of the
#' data.frame is an item and the following columns are included:
#'
#' \itemize{
#'   \item \strong{id:} Item's ID.
#'   \item \strong{name:} Item's tokenised name.
#'   \item \strong{cost:} Item's in-game cost.
#'   \item \strong{secret_shop:} Boolean. Whether it is sold in the secret shop.
#'   \item \strong{side_shop:} Boolean. Whether it is sold in the side shop.
#'   \item \strong{recipe:} Boolean. Whether it is a recipe.
#'   \item \strong{localized_name:} Localised name of item.
#' }
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_game_items()
#' get_game_items(dota_id = 570, language = 'en', key = NULL)
#' get_game_items(dota_id = 570, language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetGameItems}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_game_items <- function(dota_id = 570,
                           language = 'en',
                           key = NULL) {

 #get query arguments
 args <- list(key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetGameItems', 'IEconDOTA2', 1, args)

 #convert content to data.frame
 dota_result$content <-
  do.call(rbind.data.frame, c(dota_result$content[[1]][[1]], stringsAsFactors = FALSE))

 #return
 dota_result

}
