

allRasters = list.files("../spam2005_tif", pattern = ".tif$", full.names = TRUE)

cmask = raster("CountriesMask.tif")

for(pth in allRasters) {
  tmp = raster(pth)
  if(!compareRaster(tmp, cmask, res = TRUE, orig = TRUE)) {
    resample(x = tmp, y = cmask, filename = pth, overwrite = TRUE)
  } 
}
