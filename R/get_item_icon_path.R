#' Icon Paths for items
#'
#' Icon Paths for items.
#'
#' A list will be returned that contains three elements. The content, the url and the response
#' received from the api.
#'
#' There is no documentation for the result of the request as it is still in the TODO (at the
#' moment of writing). Please see the Steam API Documentation below.
#'
#' @param iconname The item icon name.
#'
#' @param icontype (optional) The type of image you want.
#'
#' \itemize{
#'   \item 0 - normal
#'   \item 1 - large
#'   \item 3 - ingame
#' }
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetItemIconPath}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_item_icon_path <- function(iconname,
                               icontype = c('0', '1', '3'),
                               dota_id = 570,
                               language = 'en',
                               key = NULL) {

 #make sure icontype is right
 if (is.numeric(icontype)) {icontype <- as.character(icontype)}
 icontype <- match.arg(icontype)

 #get query arguments
 args <- list(iconname = iconname, icontype = icontype, key = key, language = language)

 #result
 get_response(dota_id, 'GetItemIconPath', 'IEconDOTA2', 1, args)

}

