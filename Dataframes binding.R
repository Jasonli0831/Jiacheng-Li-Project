library(tidyverse)
library(janitor)
library(dplyr)
library(readr)
library(data.table)

#Create a data frame with Citi Bike data from June 2020 to May 2021. Citi Bike's variables in raw datasets
#changed after January 2021, so I need to convert the two formats to identical before binding them.

#Read raw monthly datasets from Citi Bike (June 2020 to January 2021)
df_202006_202101_temp <- list.files(path = "directory for Citi Bike raw data from June 2020 to January 2021", 
                                    pattern = "*.csv", 
                                    full.names = TRUE) %>%
  lapply(read_csv)

#Combine monthly datasets into one data frame. Then clean the datasets by filtering out trips with null station names, 
#trips shorter than 5 minutes and longer than 6 hours. Finally select only desired variables.
df_202006_202101 <- do.call("rbind",df_202006_202101_temp) %>%
  clean_names() %>%
  filter(!is.na(end_station_name), !is.na(end_station_id)) %>%
  mutate(time = difftime(stoptime, starttime, unit = 'hours',)) %>%
  filter(time < 6, time > 0.0833) %>%
  select(start_station_name, 
         end_station_name, 
         start_station_latitude, 
         start_station_longitude, 
         end_station_latitude, 
         end_station_longitude) %>%
  rename(start_name = start_station_name, 
         end_name = end_station_name, 
         start_lat = start_station_latitude, 
         start_lng = start_station_longitude, 
         end_lat = end_station_latitude, 
         end_lng = end_station_longitude)

#Repeat above procedures and create data frame for rides between February 2021 and May 2021
df_202102_202105_temp <- list.files(path = "directory for Citi Bike raw data from February 2021 to May 2021", 
                                    pattern = "*.csv", 
                                    full.names = TRUE) %>%
  lapply(read_csv)

df_202102_202105 <- do.call("rbind",df_202102_202105_temp) %>%
  clean_names() %>%
  filter(!is.na(end_station_name), !is.na(end_station_id)) %>%
  mutate(time = difftime(ended_at, started_at, unit = 'hours',)) %>%
  filter(time < 6, time > 0.0833) %>%
  select(start_station_name, 
         end_station_name, 
         start_lat, 
         start_lng, 
         end_lat, 
         end_lng) %>%
  rename(start_name = start_station_name, 
         end_name = end_station_name)

#Combine the two new data frames created above into one and export it. This contains trips made in one year after reopenning.
df_after_reopen <- rbind(df_202006_202101, df_202102_202105)
write_csv(df_after_reopen, "df_after_reopen.csv")

#Create a data frame with Citi Bike data from June 2020 to May 2021.
#Codes are like above procedures.
df_201903_202002_temp <- list.files(path = "directory for Citi Bike raw data from March 2019 to February 2020", 
                                    pattern = "*.csv", 
                                    full.names = TRUE) %>%
  lapply(read_csv)

df_pre_pandemic <- do.call("rbind",df_201903_202002_temp) %>%
  clean_names() %>%
  filter(!is.na(end_station_name), !is.na(end_station_id)) %>%
  mutate(time = difftime(stoptime, starttime, unit = 'hours',)) %>%
  filter(time < 6, time > 0.0833) %>%
  select(start_station_name, 
         end_station_name, 
         start_station_latitude, 
         start_station_longitude, 
         end_station_latitude, 
         end_station_longitude) %>%
  rename(start_name = start_station_name, 
         end_name = end_station_name, 
         start_lat = start_station_latitude, 
         start_lng = start_station_longitude, 
         end_lat = end_station_latitude, 
         end_lng = end_station_longitude)

write_csv(df_pre_pandemic, "df_pre_pandemic.csv")