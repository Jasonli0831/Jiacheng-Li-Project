library(tidyverse)
library(janitor)
library(dplyr)
library(readr)
library(data.table)

#The first section of the codes aims to create a dataframe with Citi Bike rider data from June 2020 to May 2021.Citi Bike's CSV data variables
#changed after January 2021, so I need to convert the two formats to identical and bind them afterwards.

#Create a dataframe for datasets from June 2020 to January 2021
df_202006_202101_temp <- list.files(path = "C:/Users/jason/OneDrive - The Ohio State University/Desktop/Jiacheng Li Project/Post lockdown (202006-202101)", 
                                    pattern = "*.csv", 
                                    full.names = TRUE) %>%
  lapply(read_csv)

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
#Create a dataframe for datasets from Feburary 2021 to May 2021
df_202102_202105_temp <- list.files(path = "C:/Users/jason/OneDrive - The Ohio State University/Desktop/Jiacheng Li Project/Post lockdown (202102-202105)", 
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

df_after_reopen <- rbind(df_202006_202101, df_202102_202105)

write_csv(df_after_reopen, "df_after_reopen.csv")

#The following section of the codes aims to create a dataframe with Citi Bike rider data from March 2019 to February 2020.
df_201903_202002_temp <- list.files(path = "C:/Users/jason/OneDrive - The Ohio State University/Desktop/Jiacheng Li Project/Pre lockdown (201903-202002)", 
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