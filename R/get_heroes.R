#' Dota Heroes
#'
#' A data.frame of Dota2 Heroes.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' The content element of the list contains a data.frame with all the heroes. Each row of the
#' data.frame is a hero and the following columns are included:
#'
#' \itemize{
#'   \item \strong{name:} Hero's name.
#'   \item \strong{id:} Hero's ID.
#'   \item \strong{localized_name:} Name of the hero in-game.
#' }
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_heroes()
#' get_heroes(language = 'en', key = NULL)
#' get_heroes(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetHeroes}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_heroes <- function(dota_id = 570,
                       language = 'en',
                       key = NULL) {

 #get query arguments
 args <- list(key = key, language = language)

 #result
 dota_result <- get_response(dota_id, 'GetHeroes', 'IEconDOTA2', 1, args)

 #convert content to data.frame
 dota_result$content <-
  do.call(rbind.data.frame, c(dota_result$content[[1]][[1]], stringsAsFactors = FALSE))

 #return
 dota_result

}

