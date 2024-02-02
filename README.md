BANTER for Beaked Whales

This repository is related to the submitted manuscipt (currently in review of revisions at Ecological Informatics):

Open-Source machine learning BANTER acoustic classification of beaked whale echolocation pulses

Abstract:
Passive acoustic monitoring is increasingly used for assessing populations of marine mammals; however, analysis of large datasets is limited by our ability to easily classify sounds detected. Classification of beaked whale acoustic events, in particular, requires evaluation of multiple lines of evidence by expert analysts. Here we present a highly automated approach to acoustic detection and classification using supervised machine learning and open source software methods. Data from four large scale surveys of beaked whales (northwestern North Atlantic, southwestern North Atlantic, Hawaii, and eastern North Pacific) were analyzed using PAMGuard (acoustic detection), PAMpal (acoustic analysis) and BANTER (hierarchical random forest classifier). Overall classification accuracy ranged from 88% for the southwestern North Atlantic data to 97% for the northwestern North Atlantic. Results for many species could likely be improved with increased sample sizes, consideration of alternative automated detectors, and addition of relevant environmental features. These methods provide a highly automated approach to acoustic detection and classification using open source methods that can be readily adopted for other species and geographic regions.


Datasets:
Four datasets were considered for this analysis: NAtlantic, SAtlantic, Hawaii, and East Pacific.

Data for the East Pacific (U.S. West Coast) is available on Fighshare:
https://figshare.com/projects/Beaked_Whale_Acoustic_Events_from_Drifting_Acoustic_Recordings_during_NOAA_s_CCES_2018_Survey/94511

The Detection Data (https://figshare.com/articles/dataset/CCES_2018_Acoustic_Study_Detection_Data/23319938) is used in this analysis.

If you would like to conduct a similar analysis on your datasets, you can analyze your data using:
- Pamguard softwater (pamguard.org),
- PAMpal (https://cran.r-project.org/web/packages/PAMpal/index.html), (Tutorial: https://taikisan21.github.io/PAMpal/)(Tutorial: https://figshare.com/projects/PAMpal_Tutorial_and_Dataset/137197)
- BANTER (https://cran.r-project.org/web/packages/banter/index.html), (Manual: https://taikisan21.github.io/PAMpal/banterGuide.html)



    
