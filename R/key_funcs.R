# The inner package environment
.RdotaEnv <- new.env(parent = emptyenv())
.RdotaEnv$key <- NULL

# Set key to environment
register_key <- function(value) {

 #set key
 .RdotaEnv$key <- value
 if (!is.null(value) | nzchar(value)) message('Key set successfully')

 ##return
 invisible(value)

}

# Get key from environment
get_key <- function() {

 #just return key
 .RdotaEnv$key

}

#delete key from environment
delete_key <- function() {

 #message to return if key not set
 if (is.null(get_key())) {
  message('No key was set - Nothing to delete')
  return(invisible(NULL))
 }

 #delete key
 rm('key', envir = .RdotaEnv)

 #check if key has been successfully deleted and return message
 if (is.null(get_key())) message('Key deleted successfully')

 #return
 invisible(NULL)

}

#' This function makes the key accessible to all functions.
#'
#' \code{key_actions} will allow the user to register (set), get (retrieve) or delete the key.
#'
#' There are three actions that can be performed in this function:
#' \itemize{
#'   \item \strong{register_key} This action sets the key and at the same time makes it available
#'                               to all the other functions. The key argument in the api calls
#'                               (i.e. functions) should not be used after setting the key with
#'                               \code{key_actions}. It is good practice to store the key in an
#'                               environment variable in .Renviron and then use \code{Sys.getenv()}
#'                               to retrieve it. This technique is described in detail in
#'                               \url{https://github.com/LyzandeR/RDota2} in the readme file.
#'   \item \strong{get_key} Returns the current key.
#'   \item \strong{delete_key} Deletes the key.
#' }
#'
#' @param action Which action to perform. Check the details.
#'
#' @param value The steam key to use. It is used only in the \code{register_key} action. If you
#'        do not have a key, you can get one at \url{https://steamcommunity.com/dev}.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' key_actions(action = 'register_key', value = Sys.getenv('RDota_KEY'))
#' key_actions(action = 'register_key', value = 'xxxxxxxxxxxxx')
#' key_actions(action = 'get_key')
#' key_actions(action = 'delete_key')
#' }
#'
#' @export
key_actions <- function(action = c('register_key', 'get_key', 'delete_key'), value = NULL) {

 #make sure right operation was provided
 action <- match.arg(action)

 if (action == 'register_key' & is.null(value)) {
  stop('if action is register_key, a value (key) must be provided')
 }

 if (action == 'register_key') {
  return(register_key(value))
 } else if (action == 'get_key') {
  return(get_key())
 } else if (action == 'delete_key') {
  return(delete_key())
 }

}


