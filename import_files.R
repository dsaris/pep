library(kableExtra)
library(knitr)
library(tidyverse)
library(stringr)
library(DT)
library(lubridate)
library(scales)

#Import data from google drive realisasi bulanan

#KOB JAN-AGT
real_kob_2020_agt <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQRCjDFPAbRWG29tZi-ElqxltS79tuT4Yhn4LfTUYJVufwjtad25YJp4rsFPCrC1SEg_4A_V3IITH6B/pub?gid=0&single=true&range=A1:AK21613&chrome=false&output=csv")

#KOB SEP-DES
real_kob_2020_sep <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQUYsfUgVYlVMpSWUj0U20y7GjAFgdPdNQhMxry-_31ekA_9i1KIlNHoiDgI0H0N1ady3g2SGQUICBU/pub?gid=0&single=true&output=csv")

real_kob_2020_okt <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT8rvKbveA6zpqnmjRLfpkFszVZWSVHhLsx0Ldxhpj_SRv5L7aO9oBKGEVzjqeWPiDCY_a45FFRMYwc/pub?gid=0&single=true&output=csv")

real_kob_2020_nop <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQIvsNVJyuQNIpTzUzQ-ja9F0VTE9kCNby-EeLX5bvfDoMY_0SPkkXkpytVJ21iaUub526CVokhPVeX/pub?gid=0&single=true&output=csv")

real_kob_2020_des <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRTg75PePS-rwn6bt7OpCbvn4CBNbhjiYZHgYmKjlh1OhVBdmCOx9VugmsAufPP2AbPPDbm_8NkEh7c/pub?gid=0&single=true&output=csv")
#Gabungkan realisasi 2020
real_kob_2020 <- rbind(real_kob_2020_agt, real_kob_2020_sep, real_kob_2020_okt, real_kob_2020_nop, real_kob_2020_des)


#tulis csv


write.csv(real_kob_2020,"data/real_kob_2020.csv", row.names = FALSE)

saveRDS(real_kob_2020, file = "data/real_kob_2020.rds")

raw_kob <- readRDS(file = "data/real_kob_2020.rds")


#import file daftar unit kerja 2020

daftar_uk_20 <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSTW8D3_kHHwzaG28UnZPq6_8ZK9ckH1LF-sLYDc_-4iEvdulhD0QJK7ij_rL8qWWISKcY6RxMhyet1/pub?gid=1209260409&single=true&output=csv")

saveRDS(daftar_uk_20, file = "data/daftar_uk_20.rds")


daftar_uk_20 <- daftar_uk_20 %>% 
  select(kode.uk, NAMA.SEKSI, Nama.Unit, Nama.Department) %>% 
  mutate(CORRECTED.UK.PG = kode.uk)
raw_kob <- raw_kob %>% 
  select(-NAMA.SEKSI.PG, -NAMA.UNIT, -NAMA.DEPARTEMEN)
raw_KOB2 <- merge(raw_kob, daftar_uk_20, by = "CORRECTED.UK.PG")


