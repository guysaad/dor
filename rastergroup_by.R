rasterGroup_by <- function(rMask, rData, stats.) {
  # rMask is a categorical raster used as groups
  # rData is a list of rasters containing data
  # stats is a list a functions to be applied to the data 
    # and to provide summary statistics of it.
  # use ... to add extra arguments to stats function, etc. rm.na = TRUE
  args <- as.list(match.call())
  if(!is.list(stats.)) stats. %<>% 'c'(.)
  if(!is.list(rData))  rData  %<>% 'c'(.)
  
  nameFUN  <- args$stats. %>% lapply(deparse) %>% unlist
  if(nameFUN[[1]] == "c") nameFUN %<>% `[`(2:length(.))
  nameRAST <- args$rData  %>% lapply(deparse) %>% unlist
  if(nameRAST[[1]] == "c") nameRAST %<>% `[`(2:length(.))
  vals <- rMask %>% getValues %>% unique %>% `[`(!is.na(.))

  lapply(rData, function(rast) {
    lapply(vals, function(cat.) {
      tmp <- rMask
      tmp[tmp != cat.] <- NA
      tmp %<>% `*` (rast) %>% `/`(cat.)
      tmp %<>% getValues %>% `[`(!is.na(.))
      # apply stats
      lapply(stats., function(f) {
        f(tmp)
      }) %>% unlist -> statVector
     names(statVector) <- nameFUN
     return(statVector)
    }) -> statsVectors
    names(statsVectors) <- vals
    return(statsVectors)
      }) -> statsRasters
    names(statsRasters) <- nameRAST
    return(statsRasters)
  }
  
  


#rasterGroup_by(rMask =  comb$cross.raster, 
 #              rData = c(yield, blwater),
  #             stats. = c(mean, sd)) %>% as.data.frame()
