sumMatrix <- function(mlist) {
  require(magrittr)
  mlist <- lapply(mlist, is.null) %>% unlist %>% `!` %>% `[`(mlist, .)
  len <- length(mlist)
  mlist[[len]][is.na(mlist[[len]])] <- 0
  if(len > 1) {
    for (i in len:2) {
      mlist[[i - 1]][is.na(mlist[[i - 1]])] <- 0
      mlist[[i - 1]] <- mlist[[i]] + mlist[[i - 1]]
    }
  }
  return(mlist[[1]])
}
