# Plot an Histogram
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

subsetted_data <- subset(data, year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))

hist(subsetted_data$Global_active_power, main = "Global Active power", xlab = "Global Active Power (kilowatts)", col = "red")

# Copy plot to PNG file
dev.copy(png, file = "plot1.png")
dev.off()