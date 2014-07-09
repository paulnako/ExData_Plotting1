if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/exdata_data_household_power_consumption.zip", method = "curl")
datedownloaded <- date()
unzipped.data <- unzip("./data/exdata_data_household_power_consumption.zip")

data <- read.table("household_power_consumption.txt", header = TRUE, 
                   na.strings = "?", sep = ";", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
power <- subset(data , Date == "2007-02-01" | Date == "2007-02-02")
power$Date <- paste(power$Date, power$Time, sep = " ")
power$Date <- strptime(power$Date, format = "%Y-%m-%d %H:%M:%S")

plot1 <- hist(power$Global_active_power, main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)", col = "red")
