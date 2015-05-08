# Question 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

setwd("~/Desktop/coursera")
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

Baltimore_type <- filter(edit_NEI, fips=="24510")
head(Baltimore_type)

Auto_Baltimore <- filter(Baltimore_type, type=="ON-ROAD")
head(Auto_Baltimore)


Balt_type <- ddply(Auto_Baltimore, .(year, type), function(Emissions) sum(Emissions$Emissions))
colnames(Balt_type)[3] <- "emissions"
head(Balt_type)


ggplot(data=Balt_type, aes(x=year, y=emissions, group=type, color=type)) +geom_line() +geom_point(size=5,aes(shape=factor(year)))+ xlab ("Year") + ylab("Emissions in Tons") + ggtitle("Baltimore Emissions from motor vehicles")



ggsave("plot_5.png", width=10, height=4, dpi=100)
