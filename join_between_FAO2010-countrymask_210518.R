# edits: cleaned code; removed unnecessary code chuncks; removed unnecessary dependencies
# added globals: pathes to data - easier to modify in case the code needs to run on a different computer.
# formated code: use <- instead of =; Keep spaces before and after  <-.; try to align code lines; simplify variabls names
# added comments to coe
library(dplyr)

path_fao         <- "..\\data\\FAOSTAT_production.csv" # "C:\\Users\\Guy\\Desktop\\SPAM2010\\FAO2010.csv"
path_spam        <- "D:\\Dropbox\\GitHub\\SPAM18\\data\\spam2005_v32\\spam2005V3r2_global_A_TA.csv" #"C:\\Users\\Guy\\Desktop\\SPAM2010\\spam2005_v32\\spam2005V3r2_global_A_TA.csv"
path_countrykeys <- "D:\\Dropbox\\GitHub\\SPAM18\\data\\countrykeys_210518.rds" # "C:\\Users\\Guy\\Desktop\\SPAM2010\\countrykeys_210518.RDS"

fao <- read.csv(path_fao, stringsAsFactors = FALSE)
# you need to load the production first (spam2005V3r2_global_P_TA)
# write next line as a function that gets a path, a technology and an indicator and load a the relevant spamfile
spam_a_ta   <- read.csv(path_spam, stringsAsFactors = FALSE)
countrykeys <- readRDS(path_countrykeys)


fao <- fao[c("Area.Code","Area","Item.Code","Item","Element.Code","Element","Unit","Y2010","Y2010F")] # use a subset function to subset variables `[`
fao <- left_join(fao, countrykeys, by = c("Area.Code" = "raste_code")) # can also use merge()

# continute script to calculate the variabels according to the methodology
