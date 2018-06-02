library(tidyverse)
library(dplyr)
library(tibble)
library(magrittr)


FAO2010 = read.csv("C:\\Users\\Guy\\Desktop\\SPAM2010\\FAO2010.csv")
spam2005V3r2_global_A_TA= read.csv("C:\\Users\\Guy\\Desktop\\SPAM2010\\spam2005_v32\\spam2005V3r2_global_A_TA.csv")
countrykeys_210518 = readRDS("C:\\Users\\Guy\\Desktop\\SPAM2010\\countrykeys_210518.RDS")

FAO2010selected = FAO2010%>%select("Area.Code","Area","Item.Code","Item","Element.Code","Element","Unit","Y2010","Y2010F")


sapply(FAO2010selected, class)
sapply(countrykeys_210518, class)
cols = 3

as.integer(countrykeys_210518$raste_code)
FAO2010selectedJoined = FAO2010selected %>% left_join(countrykeys_210518, by = c("Area.Code" = "fao_code"))
as.character(countrykeys_210518$raste_code)
as.character(FAO2010selected$Area.Code)

FAO2010selectedJoined = FAO2010selected %>% left_join(countrykeys_210518, by = c("Area.Code" = "fao_code"))


