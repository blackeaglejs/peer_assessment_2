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

