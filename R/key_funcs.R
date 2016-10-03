# The inner package environment
.RdotaEnv <- new.env(parent = emptyenv())
.RdotaEnv$key <- NULL

# Set key to environment
set_key <- function(value) {
 .RdotaEnv$key <- value
 if (!is.null(value) | nzchar(value)) message('Key set successfully')
 invisible(value)
}

# Get key from environment
get_key <- function() {
 .RdotaEnv$key
}

#delete key from environment
delete_key <- function() {
 rm('key', envir = .RdotaEnv)
}

#' This function makes the key accessible to all functions.
#'
#' \code{register_key} will allow the user to set, get (retrieve) or delete the key.
#'
#' There are three operations that can be selected in this function:
#' \itemize{
#'   \item \strong{set_key} This operation sets the key and at the same time makes it available to
#'                          all the other functions. The \code{key} argument in the api calls
#'                          (i.e. functions) should not be used after setting the key with
#'                          \code{register_key}. It is good practice to store the key in an
#'                          environment variable in .Renviron and then use \code{Sys.getenv()} to
#'                          retrieve it. This technique is described in detail in
#'                          \url{https://github.com/LyzandeR/RDota2} in the readme file.
#'   \item \strong{get_key} Returns the current key.
#'   \item \strong{delete_key} Deletes the key.
#' }
#'
#' @param operation Which operation to perform. Check the details.
#'
#' @param value The steam key to use. It is used only in the \code{set_key} operation. If you do not
#'        have a key, you can get one at \url{https://steamcommunity.com/dev}.
#'
#' @return A dota_api object containing the elements described in the details.
#'
#' @examples
#' \dontrun{
#' register_key(operation = 'set_key', value = Sys.getenv('RDota_KEY'))
#' register_key(operation = 'set_key', value = 'xxxxxxxxxxxxx')
#' register_key(operation = 'get_key')
#' register_key(operation = 'delete_key')
#' }
#'
#' @export
register_key <- function(operation = c('set_key', 'get_key', 'delete_key'), value = NULL) {

 #make sure right operation was provided
 operation <- match.arg(operation)

 if (operation == 'set_key') {
  set_key(value)
 } else if (operation == 'get_key') {
  get_key()
 } else if (operation == 'delete_key') {
  delete_key()
 }

 invisible(value)

}


