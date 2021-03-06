setwd("~/Desktop/coursera /ExData_Plotting1")
rm(list=ls())
summary("household_power_consumption.txt")

hpc <- read.csv("household_power_consumption.txt",
                sep=";",
                dec=".",
                stringsAsFactors= FALSE,
                na.strings = "?",
                colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)
summary(hpc)

subSet_hpc <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007") ,]
summary(subSet_hpc)

datetime <- strptime(paste(subSet_hpc$Date, subSet_hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower<- as.numeric(subSet_hpc$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
