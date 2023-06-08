# load appropriate programs
library (PAMpal)
library (PAMmisc)
library (rfigshare)

#Authenticate Figshare access, if needed
rfigshare::fs_auth() #authenticate Figshare access, if needed

#get information on repository files for https://figshare.com/account/projects/94511/articles/23319938
data.details <- rfigshare::fs_details(23319938) 
#download acoustics study from Figshare
data <- download.file( url = file.path("https://ndownloader.figshare.com/files", data.details$files[[3]]$id), destfile = file.path(data.dir, data.details$files[[3]]$name))

# reassign species names for Ann-O-Mate
specMap <- data.frame(
  old = unique(species(data)),
  new = NA)
specMap$new <- c('Ziphius cavirostris', 'possible Ziphiidae', 'Ziphiidae', 
                 'Mesoplodon carlhubbsi', 'BW43', 'Berardius bairdii', 
                 'Cross Seamount beaked whale', 'Mesoplodon stejnegeri')

# save beaked whale data as myData
anno <- prepAnnotation(data, specMap = specMap, mode='event',
                       source = 'figshare.com',
                       source_id = 22959786, 
                       annotator = 'Anne Simonis, https://figshare.com/articles/online_resource/CCES_2018_Final_Acoustic_Report/19358036',
                       annotation_id = anno$event,
                       annotation_date = 2019,
                       annotation_info_url = 'https://figshare.com/articles/dataset/BWEventClips_CCES2018/22959786',
                       recording_info_url = 'https://figshare.com/articles/online_resource/CCES_2018_Final_Acoustic_Report/19358036',
                       type = 'echolocation click event',
                       contact = 'shannon.rankin@noaa.gov')



