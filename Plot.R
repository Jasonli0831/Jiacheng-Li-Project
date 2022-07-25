library(tidyverse)
library(janitor)
library(dplyr)
library(readr)
library(data.table)
library(ggplot2)

#Imports the percentage change files
df_central_park_southern_loops <- read_csv("central_park_southern_loops_percentage_change.csv")
df_east_river_greenway <- read_csv("east_river_greenway_percentage_change.csv")
df_hudson_river_greenway <- read_csv("hudson_river_greenway_percentage_change.csv")

#Create and print horizontal ridership percentage change barplot for central park southern loops
barchart_central_park_southern_loops <- ggplot(df_central_park_southern_loops,
                                            aes(x = station_name,
                                                y = percentage_change,
                                                fill = percentage_change)) + 
  geom_bar(stat = "identity",
           position = "dodge") + 
  ggtitle("Central Park Southern Loops Rides Percentage Change") +
  xlab("Station Name") + 
  ylab("Percentage Change") +
  guides(fill=guide_legend(title="Percentage Change")) + 
  coord_flip()
print(barchart_central_park_southern_loops)

#Create and print horizontal ridership percentage change barplot for east river greenway routes 
barchart_east_river_greenway <- ggplot(df_east_river_greenway,
                                       aes(x = end_station,
                                           y = percentage_change,
                                          fill = percentage_change)) + 
  geom_bar(stat = "identity",
           position = "dodge") + 
  ggtitle("East River Greenway Rides Percentage Change (Start Station: FDR Drive & E 35 St)") +
  xlab("End Station") + 
  ylab("Percentage Change") +
  guides(fill=guide_legend(title="Percentage Change")) + 
  coord_flip()
print(barchart_east_river_greenway)

#Create and print horizontal ridership percentage change barplot for hudson river greenway routes
barchart_hudson_river_greenway <- ggplot(df_hudson_river_greenway,
                                         aes(x = end_station,
                                             y = percentage_change,
                                             fill = percentage_change)) + 
  geom_bar(stat = "identity",
           position = "dodge") +
  ggtitle("Hudson River Greenway Rides Percentage Change (Start Station: 12 Ave & W 40 St)") +
  xlab("End Station") + 
  ylab("Percentage Change") +
  guides(fill=guide_legend(title="Percentage Change")) +
  coord_flip()
print(barchart_hudson_river_greenway)