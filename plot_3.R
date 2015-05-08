
## Question 3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

setwd("~/Desktop/coursera ")
if(!file.exists("graph2")) dir.create("graph2")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./graph2/FNEI_data.zip", method="curl")
dateDownloaded <- date()


graph <- unzip("./graph2/FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")






library(plyr)
library(ggplot2)
library(dplyr)


edit_NEI <- select(NEI,-(SCC:Pollutant))
head(edit_NEI)

Baltimore_type <- filter(edit_NEI, fips=="24510")
head(Baltimore_type)

Balt_type <- ddply(Baltimore_type, .(year, type), function(Emissions) sum(Emissions$Emissions))
colnames(Balt_type)[3] <- "emissions"
head(Balt_type)

ggplot(data=Balt_type, aes(x=year, y=emissions, group=type, color=type)) +geom_line() + geom_point(size=5,aes(shape=factor(year))) + xlab("Year") + ylab("Emissions in Tons") + ggtitle("Baltimore Emissions (PM2.5) by Type and Year")

ggsave("plot_3.png")
