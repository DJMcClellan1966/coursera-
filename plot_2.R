## Question 2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

setwd("~/Desktop/coursera ")
if(!file.exists("graph2")) dir.create("graph2")

## download data and save to file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./graph2/FNEI_data.zip", method="curl")
dateDownloaded <- date()

## unzip file and read files
graph <- unzip("./graph2/FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## clean data
library(dplyr)
Baltimore <- filter(NEI, fips=="24510")
summary(Baltimore)
head(Baltimore)
length(Baltimore$Emissions)
length(Baltimore$year)

## base plot
Baltimore.total <- tapply(Baltimore$Emissions, Baltimore$year, sum)
plot(names(Baltimore.total), Baltimore.total, type="b", main="Baltimore Emission Totals 1999 to 2008", xlab="year", ylab=expression("Baltimore"-pm[2.5]-"Emissions in Tons"))

## save
dev.copy(png, file="plot_2.png", width=720, height=480)
