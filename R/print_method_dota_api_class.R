#' print method for dota_api class
#'
#' print method for dota_api class
#'
#' A method to print a dota_api object. Only the content will be printed on screen for a dota_api
#' object because this is of interest to the user. The dota_api object will usually be a list of
#' three elements containing the request url and the response apart from the content.
#'
#' @param x A dota_api object.
#' @param ...	further arguments passed to or from other methods. See ?print.
#'
#' @return Prints the content element of the dota_api list.
#'
#' @export
print.dota_api <- function(x, ...) {

 #print a message
 cat("<RDota2 ", x$url, ">\n\n", sep = "")

 #print the content
 print(x$content, ...)

 #return the object
 invisible(x)
}
