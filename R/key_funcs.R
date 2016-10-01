# The inner package environment
.RdotaEnv <- new.env(parent = emptyenv())
.RdotaEnv$key <- NULL

# Set token to environment
register_key <- function(value) {
 .RdotaEnv$key <- value
 return(value)
}

# Get token from environment
get_key <- function() {
 .RdotaEnv$key
}

delete_key <- function() {
 rm('key', envir = .RdotaEnv)
}





