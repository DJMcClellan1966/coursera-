## Question 6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

setwd("~/Desktop/coursera ")
if(!file.exists("graph2")) dir.create("graph2")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./graph2/FNEI_data.zip", method="curl")
dateDownloaded <- date()


graph <- unzip("./graph2/FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

names(NEI)
names(SCC)

attach(NEI)
attach(SCC)

library(plyr)
library(dplyr)
library(ggplot2)


edit_NEI <- select(NEI,-(SCC:Pollutant))
head(edit_NEI)

la_balt <- filter(edit_NEI, fips=="24510"| fips=="06037")
head(la_balt)

cars <- filter(la_balt, type=="ON-ROAD")
head(cars)
BaLA<- ddply(cars, function(Emissions) sum(Emissions$Emissions))
colnames(BaLA)[3] <- "emissions"
head(Balt_type)

ggplot(BaLA, aes(x=year, y=emissions, group=fips, color=fips)) +geom_line() +geom_point(size=5,aes(shape=factor(year)))+xlab("year") +ylab("Emissions in Tons")+ggtitle("Baltimore versus Los Angeles Emissions from Vehicles")

ggsave("plot_6.png", width=10, height=5, dpi=100)
