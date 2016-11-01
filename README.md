# RDota2

#### Released Version

[![CRAN version](http://www.r-pkg.org/badges/version/RDota2)](https://cran.r-project.org/package=RDota2)

#### Build Status

[![Travis-CI Build Status](https://travis-ci.org/LyzandeR/RDota2.svg?branch=master)](https://travis-ci.org/LyzandeR/RDota2)

#### Description

This is an R Steam API client specifically designed for Valve's game Dota2.

## Installation

To install the latest released version from CRAN you just need to run on your console:

```r
install.packages('RDota2')
```

To install the development version you need to have the `devtools` package installed. To install devtools type in your console: `install.packages('devtools')`.

Then to install RDota2 run the following on your console:

```R
devtools::install_github('lyzander/RDota2')
```

## Usage

The typical workflow of RDota2 would include registering a key on R and then using the get_* family functions to access the API.

#### Steam API key

To register a key on R in order to use Steam API through RDota2 you firstly need to get a key from Steam. You will need a steam account in order to request a key.
To get a key please visit [Steam Community](https://steamcommunity.com/login/home/?goto=%2Fdev%2Fapikey).

#### Registering a key on R

The typical way of working with RDota2 is to register a key on R (**once in every section**) and then that key will automatically be used within each one of the get_* family functions.

In order to register a key on R you need to use the `key_actions` function in the following way:

```R
#load installed package 
library(RDota2)

#register key on R. xxxxxx is the key you received from Steam.
key_actions(action = 'register_key', value = 'xxxxxxxx')
```

Instead of specifying the key on your console / script (where it would be visible to anyone), good practice dictates to save it in an environment variable. This is a very easy to do process and you only need to do it once. The key will always be made easily available in your R sessions after this. In order to store the key in an environment variable you would need to do the following (the following procedure has been
taken from the Appendix of [Best practices for writing an API package](https://cran.r-project.org/package=httr)): 

1. Identify your home directory. If you don't know which one it is just run `normalizePath("~/")` in the R console. 
2. In your home directory create a file called .Renviron (it shouldn't have an extension, like for example .txt). If questioned, YES you do want to use a file name that begins with a dot. Note that by default dotfiles are usually hidden. But within RStudio, the file browser will make .Renviron visible and therefore easy to edit in the future.
3. In the .Renviron file type a line like `RDota_KEY=xxxxxxxx`, where RDota_KEY will be the name of the R environment variable and xxxxxxxx will be your individual Steam API Key. Make sure the last line in the file is empty (if it isn’t R will silently fail to load the file). If you’re using an editor that shows line numbers, there should be two lines, where the second one is empty.
4. Restart your R session if you were using one, since .Renviron is parsed at the start of an R session.
5. Access the key on your R session using `Sys.getenv`.

So, the best practice would be to register your key in the following way:

```R
#load installed package 
library(RDota2)

#register key on R. Sys.getenv('RDota_KEY') will retrieve the value of the  
#RDota_KEY environment variable which is saved in your .Renviron file.
key_actions(action = 'register_key', value = Sys.getenv('RDota_KEY'))

#now you can use any of the get_*family functions without specifying a key e.g.
get_heroes()
```

Each of the `get_*` family functions has a key argument which should only be used if you work with multiple keys. 

## Links
   
To read the tutorial and documentation for RDota2 please visit [RDota2](https://cran.r-project.org/web/packages/RDota2/vignettes/RDota2.html).

To find out about the Steam API Documentation you can visit [Steam](https://steamcommunity.com/linkfilter/?url=http://wiki.teamfortress.com/wiki/WebAPI).

To see the released version you can visit [CRAN](https://cran.r-project.org/package=RDota2).