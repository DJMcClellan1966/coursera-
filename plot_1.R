setwd("~/Desktop/coursera ")
if(!file.exists("graph2")) dir.create("graph2")

## Download data to file on computer.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./graph2/FNEI_data.zip", method="curl")
dateDownloaded <- date()

## Question 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## unzip file and read NEI and SCC
graph <- unzip("./graph2/FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## gather iformation about data
summary(NEI)
summary(SCC)
names(NEI)
names(SCC)
class(NEI)
class(SCC)

## attach files to work with data easier
attach(NEI)
attach(SCC)

## more information
length(Emissions)
length(year)


total <- tapply(Emissions, year, sum)

##base plot
plot(names(total),total, type="b",pch=25, main="Total Emissions", xlab="year", ylab=expression("Total"-PM[2.5]-"Emissions in Tons"))

## save plot
dev.copy(png, file="plot_1.png", width=720, height=480)
