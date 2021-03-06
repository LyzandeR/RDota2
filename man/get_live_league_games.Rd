% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_live_league_games.R
\name{get_live_league_games}
\alias{get_live_league_games}
\title{Information about Live League Matches}
\usage{
get_live_league_games(dota_id = 570, language = "en", key = NULL)
}
\arguments{
\item{dota_id}{Can take one of three values.

\itemize{
 \item 570 - Dota 2 (default)
 \item 816 - Dota 2 Internal Test
 \item 205790 - Dota 2 Beta Test
}}

\item{language}{The ISO639-1 language code for returning all the information in the corresponding
language. If the language is not supported, english will be returned. For a complete list of the
ISO639-1 language codes please visit \url{https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes}.}

\item{key}{The api key obtained from Steam. If you don't have one please visit
\url{https://steamcommunity.com/dev} in order to do so. For instructions on the correct way
to use this key please visit \url{https://github.com/LyzandeR/RDota2} and check the readme file.
You can also see the examples. A key can be made available to all the functions by using
\code{key_actions}. The key argument in individual functions should only be used in case the
user needs to work with multiple keys.}
}
\value{
A dota_api object containing the elements described in the details.
}
\description{
In-game League Matches and Information about them.
}
\details{
A list will be returned that contains three elements. The content (a huge list with all the
games), the url and the response received from the api.

The content element of the list contains a games list  which has information about the
live league games. Each element of the games list is a game. Each game consists of the
following sections (list elements):

\itemize{
  \item \strong{players:} A list of lists containing information about the players.
  \item \strong{radiant_team:} A list with information about the radiant team.
  \item \strong{dire_team:} A list with information about the dire team..
  \item \strong{lobby_id:} The lobby id.
  \item \strong{match_id:} The match id.
  \item \strong{spectators:} The number of spectators.
  \item \strong{series_id:} The series id.
  \item \strong{game_number:} The game number.
  \item \strong{league_id:} The league id.
  \item \strong{stream_delay_s:} The stream delay in secs.
  \item \strong{radiant_series_wins:} Radiant series wins.
  \item \strong{dire_series_wins:} Dire series wins.
  \item \strong{series_type:} Series type.
  \item \strong{league_series_id:} The league series id.
  \item \strong{league_game_id:} The league game id.
  \item \strong{stage_name:} The name of the stage.
  \item \strong{league_tier:} League tier.
  \item \strong{scoreboard:} A huge list containing scoreboard information.
}
}
\section{Steam API Documentation}{

 \url{https://wiki.teamfortress.com/wiki/WebAPI/GetLiveLeagueGames}
}
\examples{
\dontrun{
get_live_league_games()
get_live_league_games(language = 'en', key = NULL)
get_live_league_games(language = 'en', key = 'xxxxxxxxxxx')
}

}

