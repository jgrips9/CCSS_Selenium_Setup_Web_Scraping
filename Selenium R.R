
#Install packages
install.packages("RSelenium")
install.packages("wdman")
install.packages("netstat")
install.packages("getPass")
install.packages("magick")
install.packages("dplyr")
install.packages("tesseract")
install.packages("tidyverse")

#Load packages
library(RSelenium)
library(wdman)
library(netstat)
library(getPass)
library(magick)
library(dplyr)
library(tesseract)
library(tidyverse)

#Install selenium features. 
selenium()
selenium_object = selenium(retcommand = TRUE, check = FALSE)
binman::list_versions("chromedriver")

#Check version of java
system("java -version")

#Launch chromedriver
remote_driver <- rsDriver(
  browser = "chrome",
  chromever = "145.0.3800.82",
  phantomver = NULL,
  check = FALSE,
  verbose = TRUE
)


remDr <- remote_driver[["client"]]
remDr$maxWindowSize()

#Go to page. 
remDr$navigate('https://statements.cornell.edu/pollack.cfm')

#Find links
article<-remDr$findElement(using = 'xpath', "//a[@class='cu-statement-title']")

#Click on first article
article$clickElement()

#Go back. 
remDr$goBack()

articles<-remDr$findElements(using = 'xpath', "//a[@class='cu-statement-title']")
for(i in 1:5){
  
  # Refetch links on each iteration
  articles <- remDr$findElements(using = 'xpath', "//a[@class='cu-statement-title']")
  
  # Click the i-th article
  articles[[i]]$clickElement()
  
  # Wait for page to load
  Sys.sleep(2)
  
  # Go back
  remDr$goBack()
  
  Sys.sleep(2)
}

#Perform a search.
search<-remDr$findElement(using = 'xpath', "//input[@id='search-query']")
search$clickElement()

search$sendKeysToElement(list("Some news"))

search$sendKeysToElement(list(key = "enter"))
