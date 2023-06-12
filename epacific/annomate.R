#### Annomate Example ####
# Updated 2023-02-06
# requires PAMpal 0.18.0 and PAMmisc 1.11.0

# data must have GPS and species assigned
library(PAMpal)
library(here)
here()


data <- readRDS('epacific/epacific_study.rds')
specMap <- data.frame(
  old = unique(species(data)),
  new = NA)
specMap$new <- c('Ziphius cavirostris', 'possible Ziphiidae', 'Ziphiidae', 
                 'Mesoplodon carlhubbsi', 'BW43', 'Berardius bairdii', 
                 'Cross Seamount beaked whale', 'Mesoplodon stejnegeri')

anno <- prepAnnotation(data, specMap = specMap, mode='event',
                       source = 'figshare.com',
                       source_id = 22959786, 
                       annotator = 'Anne Simonis, Jenny Trickey',
                       annotation_date = 2019,
                       annotation_info_url = 'https://figshare.com/articles/dataset/BWEventClips_CCES2018/22959786',
                       recording_info_url = 'https://figshare.com/articles/online_resource/CCES_2018_Final_Acoustic_Report/19358036',
                       type = 'echolocation click event',
                       contact = 'shannon.rankin@noaa.gov')

anno$annotation_id = anno$event

library(PAMmisc)
# to get figshare data you will need the article id and your personal token
# i recommend storing your token in an external file instead of typing it in here
# also DO NOT commit this file to any repository
figToken <- readRDS(file = "epacific/figtoken.rds")
figId <- 22959786
figshareData <- getFigshareInfo(figToken, figId)

anno <- matchRecordingUrl(anno, figshareData)
# will give you warnings and messages about missing fields
checkAnnotation(anno)
# if you need to fix any manually, write to csv then read back in
annoFile <- 'AnnomateExport_epacific_rankin2023.csv'
write.csv(anno, file=annoFile, row.names = FALSE)
# go fix stuff
anno <- read.csv(annoFile, stringsAsFactors = FALSE)
# recheck to see if all seems fine
checkAnnotation(anno)
# add to acoustic study for storage
data <- addAnnotation(data, anno)
# this creates CSV ready for figshare, will also repeat messages from the check
export_annomate(data, file=annoFile)