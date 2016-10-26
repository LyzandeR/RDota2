#' A list of Matches
#'
#' A list of matches ordered by a sequence number.
#'
#' A list will be returned that contains three elements. The content, the url and the
#' response received from the api.
#'
#' The content element of the list contains information about the matches. Each match follows
#' exactly the same structure as the match retrieved from get_match_details. Please check that
#' function's help for detailed information.
#'
#' @param start_at_match_seq_num (Optional) The match sequence number to start returning results
#' from.
#'
#' @param matches_requested (Optional) The number of matches to return.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' get_match_history_by_sequence_num()
#' get_match_history_by_sequence_num(language = 'en', key = NULL)
#' get_match_history_by_sequence_num(language = 'en', key = 'xxxxxxxxxxx')
#' }
#'
#' @section Steam API Documentation:
#'  \url{https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistoryBySequenceNum}
#'
#' @inheritParams get_response
#' @inheritParams get_event_stats_for_account
#'
#' @export
get_match_history_by_sequence_num <- function(start_at_match_seq_num = NULL,
                                              matches_requested = NULL,
                                              dota_id = '570',
                                              language = 'en',
                                              key = NULL) {

 #get query arguments
 args <- list(start_at_match_seq_num = start_at_match_seq_num,
              matches_requested = matches_requested,
              key = key,
              language = language)

 #result
 dota_result <- get_response(dota_id, 'GetMatchHistoryBySequenceNum', 'IDOTA2Match', 1, args)

 #remove some unnecessary levels
 dota_result$content <- dota_result$content[[1]][-1]

 #return
 dota_result

}


