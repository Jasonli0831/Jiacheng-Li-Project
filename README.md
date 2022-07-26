# Citi Bike Recreational Rides Pattern Change of after COVID-19 Pandemic and It's Implication
## Purpose of the Project ##
The repository contains R codes and cleaned datasets that helps analyze New York City's Citi Bike recreational rides pattern change after COVID-19 reopening. By counting pre- and post- pandemic trip frequencies of each selected route and calculate the percentage difference, we can see if there is a positive shift of user preferences after the pandemic hits. The purpose of the project is to assist Citi Bike decide whether increasing station density near or along recreational routes is necessary in its future expansion plan.
## Code Style and Installation ##
Data analysis and visualization are written in R. Cleaned datasets are stored in three CSV files.

**Jiacheng Li Project.Rproj** is Rproj file.

**Dataframes binding.R** is the first R script you want to open when running the project. The file reads 24 monthly Citi Bike raw datasets, cleans them, and combines them into two large datasets (12 months per dataset). Raw datasets are too large to upload to github. Users can find all raw datasets on Citi Bike's System Data Website (https://ride.citibikenyc.com/system-data). Note that datasets variables changed slightly after January 2021. Therefore, it's important to keep datasets with same format into one folder. The output of this R script should be two csv files called "df_pre_pandemic" and "df_after_reopen". The two cleaned datasets are also too large for github upload. Below is a screenshot of the format of the cleaned datasets.\
![image](https://user-images.githubusercontent.com/107653447/180928689-cb181bb9-d13a-4c33-a4db-bc258007b02a.png)

**Filter Stations.R** is the second R scripte you want to open. The file first reads the two cleaned datasets created from "Dataframes binding.R". It will then count trip frequencies of desired routes and calculate the percentage difference between the two timeframes. The outputs of this R script are "central_park_southern_loops_percentage_change.csv", "east_river_greenway_percentage_change.csv", "hudson_river_greenway_percentage_change.csv".

**Plot.R** is the R script file that creates three barcharts using percentage difference CSV files.

**central_park_southern_loops_percentage_change.csv** is the CSV file that contains selected loop trips near southern Central Park, their respective pre-pandemic and post-reopening trips, and respective rides percentage difference between the two periods.\
**east_river_greenway_percentage_change.csv** is the CSV file that contains selected routes along East River greenway, their respective pre-pandemic and post-reopening trips for each route, and respective rides percentage difference between the two periods.\
**east_river_greenway_percentage_change.csv** is the CSV file that contains selected routes along Hudson River greenway, their respective pre-pandemic and post-reopening trips, and respective rides percentage difference between the two periods.
