if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, 
              destfile = "./data/exdata_data_household_power_consumption.zip", 
              method = "curl")
datedownloaded <- date()
unzipped.data <- unzip("./data/exdata_data_household_power_consumption.zip")

data <- read.table(unzipped.data, header = TRUE, 
                   na.strings = "?", sep = ";", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
power <- subset(data , Date == "2007-02-01" | Date == "2007-02-02")
power$datetime <- paste(power$Date, power$Time, sep = " ")
power$datetime <- strptime(power$datetime, format = "%Y-%m-%d %T")

plot3 <- {plot(power$datetime, power$Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering")
          points(power$datetime, power$Sub_metering_2, type = "l", col = "red")
          points(power$datetime, power$Sub_metering_3, type = "l", 
                 col = "blue")
          legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                                        "Sub_metering_3"),
                 col = c("black", "red", "blue"), lty = c(1, 1, 1))
}