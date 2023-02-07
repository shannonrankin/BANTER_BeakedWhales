##Spotgps2Pamguard.R
#Jay gave me a spot track for each drift (2 spots for most drifts), but these are
#not in the correct time. He then gave me a script that he used to fix the files, as
#well as a 'fixed' file with UTC time (this is AllSpotTrackswUTC.csv )
#Unfortunately, the column names are not suitable for addPgGps
#so, first I must change those columns, then resave, then I can add the GPS
#to the pamguard database

#clean if needed
rm(list=ls())

#Run if your computer is set to GMT
Sys.setenv(TZ='GMT')

library(dplyr)
library(plyr)
library(purrr)
library(tidyr)

##Take all *.csv files and merge into one dataframe, and add the filename as an extra column
setwd("E:/beaker.banter.2/pacwest/pascal/spot")
temp <- purrr::map_dfr(list.files(pattern="*.csv", full.names = TRUE),
                       ~read.csv(.x) %>% mutate(file = sub(".csv$", "", basename(.x))))

#Separate the filename column to separate the station#
pascal_AllSpot_UTC <-temp %>%
  separate(file, c("info", "station"), sep="station")

#Rename filenames
colnames(pascal_AllSpot_UTC)
pascal_AllSpot_UTC <- rename(pascal_AllSpot_UTC, c("dateTime" ="UTC", "spotID" = "Name", 
                                               "long" ="Longitude",  "lat" = "Latitude"))
colnames(pascal_AllSpot_UTC)
#write as a csv
write.csv(pascal_AllSpot_UTC, "pascal_AllSpot_UTC.csv")

#view unique stations/SpotIDs to help select appropriate spotIDs
pascalSpotStations <- read.csv("pascal_AllSpot_UTC.csv")
spotSumm <- distinct(pascal_AllSpot_UTC[,c("Name", "station")])


#Change working directory to databases
setwd("E:/beaker.banter.2/pacwest/pascal/databases")
library(PAMmisc)

#Add GPS to Pamguard
#Note: repeat for each database
myDb <- "Station-28_Soundtrap-J_MASTER-BW.sqlite3"
myGps <- "pascal_AllSpot_UTC.csv"
addPgGps(db = myDb, gps = myGps, source = "csv", format = '%m/%d/%Y %H:%M:%S')








