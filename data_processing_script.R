## Set working directory. You can set this to whatever you want. 
setwd("~/dev/datasciencecoursera/peer_assessment_2")

## Load knitr package (in case you don't already have it.) 
install.packages("knitr")
library(knitr)

## Load dplyr, this will be useful later. 
library(dplyr)

## Download the data. 
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileUrl, "storm_data.csv.bz2", method="curl")

## Read in the data. 
storm_data <- read.csv("storm_data.csv.bz2")

## Use dplyr to group the data. 
storm_data_by_type <- storm_data %>%
      group_by(EVTYPE) %>%
      summarize(fatalities_sum=sum(FATALITIES),
                injury_sum=sum(INJURIES),
                total_pop_health = fatalities_sum+injury_sum)

## Sort the grouped data 
storm_data_type_sorted <- storm_data_by_type[order(-storm_data_by_type$total_pop_health),]


## Get results for the worst kind of events. 
biggest_event <- head(storm_data_type_sorted$EVTYPE, n=1)
event_fatalities <- head(storm_data_type_sorted$fatalities_sum,n=1)
event_injuries <- head(storm_data_type_sorted$injury_sum,n=1)
event_total <- head(storm_data_type_sorted$total_pop_health,n=1)

## Created a barplot for the events. 
barplot(storm_data_type_sorted$total_pop_health)