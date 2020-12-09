#DATA WRANGLING raw_kob

library(tidyverse)
library(dplyr)

glimpse(raw_kob)
glimpse(tail(raw_kob))

#apply  new section, unit and department, joining by kode seksi
daftar_uk_20 <- daftar_uk_20 %>% 
  select(kode.uk, NAMA.SEKSI, Nama.Unit, Nama.Department) %>% 
  mutate(Corrected.UK.PG = kode.uk)
raw_kob <- raw_kob %>% 
  select(-NAMA.SEKSI.PG, -NAMA.UNIT, -NAMA.DEPARTEMEN)
raw_KOB2 <- left_join(raw_kob, daftar_uk_20, by = "Corrected.UK.PG")


#Grouping by section and tottal amount
raw_KOB2_seksi <- raw_KOB2 %>% 
  group_by(NAMA.SEKSI) %>% 
 summarize(total = sum(Amount.in.LC))
#save to RDS
saveRDS(raw_KOB2_seksi, file = "data/raw_KOB2_seksi.rds")
saveRDS(raw_KOB2, file = "data/raw_KOB2.rds")

#daftar seksi isNA
View(filter(raw_KOB2, is.na(NAMA.SEKSI)))





