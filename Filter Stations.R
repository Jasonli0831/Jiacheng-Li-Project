library(tidyverse)
library(janitor)
library(dplyr)
library(readr)
library(data.table)

#import the two filtered dataframes to current environment
df_pre_pandemic <- read_csv("df_pre_pandemic.csv")
df_after_reopen <- read_csv("df_after_reopen.csv")

#I choose to analyse the recreational bikeshare usage pattern change in three selected
#areas/ routes: East River Greenway, Central Park Southern Loops, and Hudson River Greenway

#filter the routes along the east river greenway before pandemic and after 
#reopen
pre_east_river_greenway <- filter(df_pre_pandemic, 
                                start_name %in% c("FDR Drive & E 35 St"), 
                                end_name %in% c("Stanton St & Mangin St", 
                                                "Cherry St",
                                                "E 60 St & York Ave",
                                                "E 82 St & East End Ave",
                                                "East End Ave & E 86 St"))
                        
post_east_river_greenway <- filter(df_after_reopen, 
                                 start_name %in% c("FDR Drive & E 35 St"), 
                                 end_name %in% c("Stanton St & Mangin St", 
                                                 "Cherry St",
                                                 "E 60 St & York Ave",
                                                 "E 82 St & East End Ave",
                                                 "East End Ave & E 86 St"))

#count rides for each individual end station before pandemic and after reopen
pre_east_river_greenway_freq <- data.frame(table(pre_east_river_greenway $ end_name)) %>%
  mutate(group = "A (pre pandemic)")
post_east_river_greenway_freq <- data.frame(table(post_east_river_greenway $ end_name)) %>%
  mutate(group = "B (after reopen)")

#create and export bikeshare usage percentage change dataframe
east_river_greenway_percent_change <- pre_east_river_greenway_freq %>%
  left_join(post_east_river_greenway_freq, by = c("Var1")) %>%
  rename(end_station = Var1,
         pre_pandemic_rides = Freq.x,
         after_reopen_rides = Freq.y) %>%
  mutate(percentage_change = (after_reopen_rides - pre_pandemic_rides) * 100 / pre_pandemic_rides) %>%
  mutate_if(is.numeric, ~round(., 2)) %>%
  select(end_station, pre_pandemic_rides, after_reopen_rides, percentage_change)

east_river_greenway_percent_change <- cbind(start_station = "FDR Drive & E 35 St", east_river_greenway_percent_change)
write_csv(east_river_greenway_percent_change, "east_river_greenway_percentage_change.csv")

#create and export the dataframe for barplot
east_river_greenway <- rbind(pre_east_river_greenway_freq, post_east_river_greenway_freq) %>%
  rename(end_station = Var1,
         rides = Freq)
write_csv(east_river_greenway, "east_river_greenway.csv")

#Central Park Southern Loops
#filter the routes for central park southern loops before pandemic and after 
#reopen
pre_central_park_s_6_ave <- filter(df_pre_pandemic,
                                   start_name %in% c("Central Park S & 6 Ave"), 
                                   end_name %in% c("Central Park S & 6 Ave")) %>%
  count(start_name)

post_central_park_s_6_ave <- filter(df_after_reopen,
                                   start_name %in% c("Central Park S & 6 Ave"), 
                                   end_name %in% c("Central Park S & 6 Ave")) %>%
  count(start_name)

pre_grand_army_plaza_central_park_s <- filter(df_pre_pandemic,
                                   start_name %in% c("Grand Army Plaza & Central Park S"), 
                                   end_name %in% c("Grand Army Plaza & Central Park S")) %>%
  count(start_name)

post_grand_army_plaza_central_park_s <- filter(df_after_reopen,
                                    start_name %in% c("Grand Army Plaza & Central Park S"), 
                                    end_name %in% c("Grand Army Plaza & Central Park S")) %>%
  count(start_name)

pre_7_ave_central_park_south <- filter(df_pre_pandemic,
                                   start_name %in% c("7 Ave & Central Park South"), 
                                   end_name %in% c("7 Ave & Central Park South")) %>%
  count(start_name)

post_7_ave_central_park_south <- filter(df_after_reopen,
                                    start_name %in% c("7 Ave & Central Park South"), 
                                    end_name %in% c("7 Ave & Central Park South")) %>%
  count(start_name)

pre_5_ave_e_63_st <- filter(df_pre_pandemic,
                                   start_name %in% c("5 Ave & E 63 St"), 
                                   end_name %in% c("5 Ave & E 63 St")) %>%
  count(start_name)

post_5_ave_e_63_st <- filter(df_after_reopen,
                                    start_name %in% c("5 Ave & E 63 St"), 
                                    end_name %in% c("5 Ave & E 63 St")) %>%
  count(start_name)

pre_central_park_west_w_68_st <- filter(df_pre_pandemic,
                                   start_name %in% c("Central Park West & W 68 St"), 
                                   end_name %in% c("Central Park West & W 68 St")) %>%
  count(start_name)

post_central_park_west_w_68_st <- filter(df_after_reopen,
                                    start_name %in% c("Central Park West & W 68 St"), 
                                    end_name %in% c("Central Park West & W 68 St")) %>%
  count(start_name)

pre_central_park_west_w_72_st <- filter(df_pre_pandemic,
                                   start_name %in% c("Central Park West & W 72 St"), 
                                   end_name %in% c("Central Park West & W 72 St")) %>%
  count(start_name)

post_central_park_west_w_72_st <- filter(df_after_reopen,
                                    start_name %in% c("Central Park West & W 72 St"), 
                                    end_name %in% c("Central Park West & W 72 St")) %>%
  count(start_name)

#count rides for each individual end station before pandemic and after reopen
pre_central_park_southern_loops_freq <- rbind(pre_central_park_s_6_ave,
                                     pre_grand_army_plaza_central_park_s,
                                     pre_7_ave_central_park_south,
                                     pre_5_ave_e_63_st,
                                     pre_central_park_west_w_68_st,
                                     pre_central_park_west_w_72_st) %>%
  mutate(group = "A (pre pandemic)")

post_central_park_southern_loops_freq <- rbind(post_central_park_s_6_ave,
                                      post_grand_army_plaza_central_park_s,
                                      post_7_ave_central_park_south,
                                      post_5_ave_e_63_st,
                                      post_central_park_west_w_72_st,
                                      post_central_park_west_w_72_st) %>%
  mutate(group = "B (after reopen)")

#create and export bikeshare usage percentage change dataframe
central_park_southern_loops_percent_change <- pre_central_park_southern_loops_freq %>%
  left_join(post_central_park_southern_loops_freq, by = c("start_name")) %>%
  rename(station_name = start_name,
         pre_pandemic_rides = n.x,
         after_reopen_rides = n.y) %>%
  mutate(percentage_change = (after_reopen_rides - pre_pandemic_rides) * 100 / pre_pandemic_rides) %>%
  mutate_if(is.numeric, ~round(., 2)) %>%
  select(station_name, pre_pandemic_rides, after_reopen_rides, percentage_change)
write_csv(central_park_southern_loops_percent_change, "central_park_southern_loops_percent_change.csv")

#create and export the dataframe for barplot
central_park_southern_loops <- rbind(pre_central_park_southern_loops_freq, post_central_park_southern_loops_freq) %>%
  rename(rides = n)
write_csv(central_park_southern_loops, "central_park_southern_loops.csv")

#Hudson River Greenway
#filter the routes along the hudson river greenway before pandemic and after 
#reopen
pre_hudson_river_greenway <- filter(df_pre_pandemic,
                                    start_name %in% c("12 Ave & W 40 St"),
                                    end_name %in% c("Pier 40 - Hudson River Park",
                                                    "West St & Chambers St",
                                                    "Bus Slip & State St",
                                                    "Riverside Blvd & W 67 St",
                                                    "Riverside Dr & W 72 St",
                                                    "Riverside Dr & W 82 St",
                                                    "Riverside Dr & W 91 St",
                                                    "Riverside Dr & W 104 St"))

post_hudson_river_greenway <- filter(df_after_reopen,
                                     start_name %in% c("12 Ave & W 40 St"),
                                     end_name %in% c("Pier 40 - Hudson River Park",
                                                     "West St & Chambers St",
                                                     "Bus Slip & State St",
                                                     "Riverside Blvd & W 67 St",
                                                     "Riverside Dr & W 72 St",
                                                     "Riverside Dr & W 82 St",
                                                     "Riverside Dr & W 91 St",
                                                     "Riverside Dr & W 104 St"))

#count rides for each individual end station before pandemic and after reopen
pre_hudson_river_greenway_freq <- data.frame(table(pre_hudson_river_greenway $ end_name)) %>%
  mutate(group = "A (pre pandemic)")
post_hudson_river_greenway_freq <- data.frame(table(post_hudson_river_greenway $ end_name)) %>%
  mutate(group = "B (after reopen)")

#create and export bikeshare usage percentage change dataframe
hudson_river_greenway_percent_change <- pre_hudson_river_greenway_freq %>%
  left_join(post_hudson_river_greenway_freq, by = c("Var1")) %>%
  rename(end_station = Var1,
         pre_pandemic_rides = Freq.x,
         after_reopen_rides = Freq.y) %>%
  mutate(percentage_change = (after_reopen_rides - pre_pandemic_rides) * 100 / pre_pandemic_rides) %>%
  mutate_if(is.numeric, ~round(., 2)) %>%
  select(end_station, pre_pandemic_rides, after_reopen_rides, percentage_change)

hudson_river_greenway_percent_change <- cbind(start_station = "12 Ave & W 40 St", hudson_river_greenway_percent_change)
write_csv(hudson_river_greenway_percent_change, "hudson_river_greenway_percentage_change.csv")

#create and export the dataframe for barplot
hudson_river_greenway <- rbind(pre_hudson_river_greenway_freq, post_hudson_river_greenway_freq) %>%
  rename(end_station = Var1,
         rides = Freq)
write_csv(hudson_river_greenway, "hudson_river_greenway.csv")