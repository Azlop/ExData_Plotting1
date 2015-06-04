# Plot a Line graph
library(lubridate)

# Download file and unzip it
destinationFilePath <- file.path("household_power_consumption.zip")
if(!file.exists(destinationFilePath)){
    file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = file_url, destfile = destinationFilePath, method = "curl")
}
unzip(zipfile = destinationFilePath, exdir = ".")

data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                   colClasses = c(rep("character", 2), rep("numeric", 7)))

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

subsetted_data <- subset(data, year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))

# Combine Date and Time columns for weekdays
subsetted_data$Date.Time <- subsetted_data$Date + subsetted_data$Time

with(subsetted_data, plot(subsetted_data$Date.Time, subsetted_data$Sub_metering_1, xlab = "", type = "l", ylab = "Energy sub metering"))
with(subsetted_data, lines(subsetted_data$Date.Time, subsetted_data$Sub_metering_2, type = "l", col = "red"))
with(subsetted_data, lines(subsetted_data$Date.Time, subsetted_data$Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1))

# Copy plot to PNG file
dev.copy(png, file = "plot3.png")
dev.off()