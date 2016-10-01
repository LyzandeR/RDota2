get_league_listing <- function(language = 'en', key = NULL) {

 #if key is null look in the environment variables
 if (is.null(key)) {
  key <- Sys.getenv('RDota_KEY')

  #if key is blank space then stop i.e. environment variable has not be set.
  if (!nzchar(key)) {
   stop(strwrap('You have not provided a key OR the RDota_KEY environent variable could not
               be loaded from your home path. If you do not have a key you can obtain one by
               visiting https://steamcommunity.com/dev. Check the details in ?get_league_listing.',
                width = 1e10))
  }
 }

 resp <- GET('http://api.steampowered.com/IDOTA2Match_570/GetLeagueListing/v1/',
             query = list(key = key,
                          language = language))
 url <- strsplit(resp$url, '\\?')[[1]][1]

 #check for code status. Any http errors will be converted to something meaningful.
 stop_for_status(resp)

 if (http_type(resp) != "application/json") {
  stop("API did not return json", call. = FALSE)
 }

 #parse response
 parsed <- jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)
 #convert to a data.frame
 df <- do.call(rbind.data.frame, c(parsed[[1]][[1]], stringsAsFactors = FALSE))

 #output
 structure(
  list(
   content = df,
   url = url,
   response = resp
  ),
  class = "dota_api"
 )

}

#print method for dota_api
print.dota_api <- function(x, ...) {
 cat("<RDota2 ", x$url, ">\n\n", sep = "")
 str(x$content)
 invisible(x)
}
