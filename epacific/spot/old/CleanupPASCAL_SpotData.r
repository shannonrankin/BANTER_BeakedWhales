# Cleans up Spot location data from "CleanupPASCAL_SpotData.r"
#    to convert to UTC, eliminate speed outliers and filter out locations before and after deployment
#    also estimates deployment duration and distances traveled.

library(geosphere)

##############################################################################################
# get deployment and retrieve times in Excel format and convert to R format
DeployRetrTimes= read.csv("j:/Jay/ACOUSTIC/Buoy Recorder/PASCAL/DateTimeDataReconciliation.csv")
DeployTime= as.POSIXct((DeployRetrTimes$UTC_DeployTime-2)*24*60*60,origin='1900-01-01',tz='gmt')
RetrTime= as.POSIXct((DeployRetrTimes$UTC_RetrTime-2)*24*60*60,origin='1900-01-01',tz='gmt')


######################################################################################################
## read Spot geolocation info and save in a single file with UTC times added
# NOTE downloaded Spot data were in local time (UTC - 7)
setwd("j:\\Jay\\ACOUSTIC\\Buoy Recorder\\PASCAL\\SpotLocations by Station")
sumKms= rep(NA,30); sumHrs= rep(NA,30)
for (iStation in 1:30) {
  SpotData= read.csv(file=paste("2017-08-04_spotTrack-station",as.character(iStation),".csv",sep=""))
  
  # convert date/time to UTC and store as number  
  UTC=  strptime(SpotData$dateTime, "%m/%d/%Y %H:%M", tz="gmt") + (7*60*60)
  # eliminate positions that are < deploy and > retrieve time
  SpotData= SpotData[(UTC > DeployTime[iStation]) & (UTC < RetrTime[iStation]),]  
  
  #eliminate distance outliers
  n= length(SpotData$lat)
  dist= distGeo(cbind(SpotData$long[1:(n-1)],SpotData$lat[1:(n-1)]),cbind(SpotData$long[2:n],SpotData$lat[2:n])) / 1000   #distance in km
  dist[n]= 0
  #cat(iStation,max(dist),which.max(dist),"\n")
  outliers= which(dist>2) + 1
  if (length(outliers) > 0) {
    SpotData$lat[outliers]= NA
    SpotData= SpotData[!is.na(SpotData$lat),]
  }
  # recalculate distances without outliers
  n= length(SpotData$lat)
  dist= distGeo(cbind(SpotData$long[1:(n-1)],SpotData$lat[1:(n-1)]),cbind(SpotData$long[2:n],SpotData$lat[2:n])) / 1000   #distance in km
  #cat(iStation,max(dist),which.max(dist),"\n")
  
  # re-convert date/time to UTC and store as number  
  UTC=  strptime(SpotData$dateTime, "%m/%d/%Y %H:%M", tz="gmt") + (7*60*60)
  
  # compile all good positions into new dataframe
  if (iStation == 1) {
    SpotData_wUTC= data.frame(Station=iStation,dateTime=SpotData$dateTime,spotID=SpotData$spotID,lat=SpotData$lat,long=SpotData$long,UTC)
  } else {
    SpotData_wUTC= rbind(SpotData_wUTC,data.frame(Station=iStation,dateTime=SpotData$dateTime,spotID=SpotData$spotID,lat=SpotData$lat,long=SpotData$long,UTC))
  }
  
  sumKms[iStation]= sum(dist)
  sumHrs[iStation]= (as.numeric(UTC[1])-as.numeric(UTC[n]))/(60*60)
  cat(iStation,"   Tot Dist= ",sumKms[iStation],"km   Tot Hrs=",sumHrs[iStation],"hrs   AvgSpeed=",sumKms[iStation]/sumHrs[iStation]," km/hr \n")
}
TotKms= sum(sumKms[c(1:13,15:22)])
TotHrs= sum(sumHrs[c(1:13,15:22)])
write.csv(SpotData_wUTC,file="j:\\Jay\\ACOUSTIC\\Buoy Recorder\\PASCAL\\AllSpotTracks wUTC.csv")
cat("Overall","   Tot Dist= ",TotKms,"km   Tot Hrs=",TotHrs,"hrs   AvgSpeed=",TotKms/TotHrs," km/hr \n")



