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


## Load ggplot2 for plots. 
library(ggplot2)

## Created a barplot for the events. 
ggplot(data=head(storm_data_type_sorted),aes(x=EVTYPE,y=total_pop_health)) +
      geom_bar(stat="identity") + 
      xlab("Type of event") +
      ylab("Total injuries and fatalities") + 
      ggtitle("Worst Weather Events for Population Health")

## The second question involves economic consequences.I'm subsetting this time for that.
## But first, we need to multiply the damage data by a multiplier. 
storm_data_multiplier <- storm_data
if(storm_data_multiplier$PROPDMGEXP=='h') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*100
} else if (storm_data_multiplier$PROPDMGEXP=='H') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*100
} else if (storm_data_multiplier$PROPDMGEXP=='k') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000
} else if (storm_data_multiplier$PROPDMGEXP=='K') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000
} else if (storm_data_multiplier$PROPDMGEXP=='m') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000000
} else if (storm_data_multiplier$PROPDMGEXP=='M') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000000
} else if (storm_data_multiplier$PROPDMGEXP=='b') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000000000
} else if (storm_data_multiplier$PROPDMGEXP=='B') {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG*1000000000
} else {
      storm_data_multiplier$PROPDMG <- storm_data_multiplier$PROPDMG
}

if(storm_data_multiplier$CROPDMGEXP=='h') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*100
} else if (storm_data_multiplier$PROPDMGEXP=='H') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*100
} else if (storm_data_multiplier$PROPDMGEXP=='k') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000
} else if (storm_data_multiplier$PROPDMGEXP=='K') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000
} else if (storm_data_multiplier$PROPDMGEXP=='m') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000000
} else if (storm_data_multiplier$PROPDMGEXP=='M') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000000
} else if (storm_data_multiplier$PROPDMGEXP=='b') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000000000
} else if (storm_data_multiplier$PROPDMGEXP=='B') {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG*1000000000
} else {
      storm_data_multiplier$CROPDMG <- storm_data_multiplier$PROPDMG
}

## Subset the data and summarize. 
storm_data_by_dmg <- storm_data_multiplier %>%
      group_by(EVTYPE) %>%
      summarize(property_damage_sum = sum(PROPDMG),
                crop_damage_sum = sum(CROPDMG),
                total_damage=property_damage_sum+crop_damage_sum)

## Sort the data. 
storm_data_total_dmg_sorted <- storm_data_by_dmg[order(-storm_data_by_dmg$total_damage),]
storm_data_prop_dmg_sorted <- storm_data_by_dmg[order(-storm_data_by_dmg$property_damage_sum),]
storm_data_crop_dmg_sorted <- storm_data_by_dmg[order(-storm_data_by_dmg$crop_damage_sum),]

## Get results for the worst kind of events.
### Total Damage
biggest_event_total_dmg <- head(storm_data_total_dmg_sorted$EVTYPE, n=1)
highest_prop_total_dmg <- head(storm_data_total_dmg_sorted$property_damage_sum,n=1)
highest_crop_total_dmg <- head(storm_data_total_dmg_sorted$crop_damage_sum,n=1)
highest_total_dmg <- head(storm_data_total_dmg_sorted$total_damage,n=1)
### Property Damage
biggest_event_prop_dmg <- head(storm_data_prop_dmg_sorted$EVTYPE, n=1)
highest_prop_dmg <- head(storm_data_prop_dmg_sorted$property_damage_sum,n=1)
### Crop Damage
biggest_event_crop_dmg <- head(storm_data_crop_dmg_sorted$EVTYPE,n=1)
highest_crop_dmg <- head(storm_data_crop_dmg_sorted$crop_damage_sum,n=1)

## Created a barplot for the economic damage 
ggplot(data=head(storm_data_dmg_sorted),aes(x=EVTYPE,y=total_damage)) +
      geom_bar(stat="identity") + 
      xlab("Type of event") +
      ylab("Total Damage in Dollars") + 
      ggtitle("Worst Weather Events for Economic Damage")