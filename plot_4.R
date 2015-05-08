

## Question 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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


coal.comb <- subset(SCC, select= c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, coal.comb, by.x="SCC", by.y="SCC", all=TRUE)
NEI_SCC$Emissions <- NEI_SCC$Emissions/1000


coal.plot.1 <- subset(NEI_SCC, grepl("Coal", NEI_SCC$Short.Name, fixed=TRUE), c("Emissions", "year", "type", "Short.Name"))

coal.plot.1<- aggregate(Emissions ~ year, coal.plot.1, sum)
coal.plot.2 <- na.omit(coal.plot.1)
ggplot(data = coal.plot.2, aes(x = year, y = Emissions)) + geom_line() + geom_point(size=5, aes(shape=factor(year))) + xlab("Year") + ylab("Emissions in Tons") + ggtitle ("Total United States Coal Emissions (PM2.5)")


ggsave("plot_4.png", width=10, height=4, dpi=100)


