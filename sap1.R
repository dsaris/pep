#DATA WRANGLING raw_kob

library(tidyverse)
library(dplyr)
library(lubridate)


#apply  new section, unit and department, joining by kode seksi
daftar_uk_20 <- daftar_uk_20 %>% 
  select(kode.uk, NAMA.SEKSI, Nama.Unit, Nama.Department) %>% 
  mutate(Corrected.UK.PG = kode.uk)
raw_kob <- raw_kob %>% 
  select(-NAMA.SEKSI.PG, -NAMA.UNIT, -NAMA.DEPARTEMEN)
raw_KOB2 <- left_join(raw_kob, daftar_uk_20, by = "Corrected.UK.PG")

#create date column from YEAR,MONTH,DATE
raw_KOB2 <- raw_KOB2 %>% 
  mutate(date1 = make_date(YEAR, MONTH, DAY),
         tanggal = day(date1),
         bulan = month(date1,label = TRUE),
         tahun = year(date1))



#Grouping by section and total amount
raw_KOB2_seksi <- raw_KOB2 %>% 
 summarize(total = sum(Amount.in.LC))
#save to RDS
saveRDS(raw_KOB2_seksi, file = "data/raw_KOB2_seksi.rds")
saveRDS(raw_KOB2, file = "data/raw_KOB2.rds")

#daftar seksi isNA
View(head(raw_KOB2))





