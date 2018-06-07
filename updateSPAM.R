# dependencies

library(raster)

# Functions
source("rastergroup_by.R")
# load index files


cropindex = read.csv("FAO-SPAM.csv", stringsAsFactors = FALSE)

# GLOBAL VARIABLES

spamCrop = cropindex$SPAM.short.name[1]

patt = sprintf("%s_[A-Z]{2}_%s", "P", toupper(spamCrop))

fnames = list.files("../spam2005_tif",pattern = ".tif$",full.names = T)
fnames = grep(patt, fnames, value = TRUE)


r = setNames(lapply(fnames,raster) , nm=c("A","H","I","L","R","S"))

cmask = raster("CountriesMask.tif")

for(i in seq_along(r)) {
  if(!compareRaster(r[[i]], cmask, res = TRUE, orig = TRUE)) {
    r[[i]] = resample(x = r[[i]], y = cmask) # in order to save use filename arg instead of allocation to r[[i]], see ?resample for deatils 
    print(i)
  } 
}

r_tst = rasterGroup_by(rMask = cmask, rData = r[["A"]], stats. = sum)
