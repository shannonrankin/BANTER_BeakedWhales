updateEventNames <- function(x, study=c('cces', 'pascal')) {
    subFun <- switch(match.arg(study),
                     'cces' = function(i) {
                         cfile <- gsub('PamGuard64 2_00_16e |Drift-|_Final|_JST|_GoodAngles|\\.sqlite3$', '', i)
                         cfile <- paste0('CCES_', cfile)
                         cfile
                     },
                     'pascal' = function(i) {
                         pfile <- gsub('_MASTER-BW| 15dB| Part|_ETG|\\.sqlite3$', '', i)
                         pfile <- gsub('Station-([0-9\\-]{,6})_(Soundtrap|Card)-([A-z0-9]{,2})(.*)', 'PASCAL_\\1\\3\\4', pfile)
                         pfile
                     }
    )
    newNames <- sapply(names(events(x)), subFun)
    names(newNames) <- NULL
    names(events(x)) <- newNames
    for(e in seq_along(events(x))) {
        id(x[[e]]) <- newNames[e]
        if(!is.null(ancillary(x[[e]])$environmental$event)) {
            ancillary(x[[e]])$environmental$event <- newNames[e]
        }
    }
    x
}
# updated 11/27/2020 to adjust for environmental event names
# how to use - source this file first, then:
# myData_pascal <- updateEventNames(myData_pascal, study='pascal')
# myData_cces <- updateEventNames(myData_cces, study='cces')
