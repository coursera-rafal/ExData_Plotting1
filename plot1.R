DownloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DownloadFile <- "./household_power_consumption.zip"
TxtFile <- "./Data/household_power_consumption.txt"


# Download source ---------------------------------------------------------
if (!file.exists(TxtFile)) {
  download.file(DownloadURL, DownloadFile)
  unzip(DownloadFile, overwrite = T, exdir = "./Data")
}


# Read data ---------------------------------------------------------------
ReadData <- read.csv(TxtFile, sep=';', na.strings="?",skip = 66636)
colnames(ReadData) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",

                                                "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Subset dates ------------------------------------------------------------
Data <- subset(ReadData, Date %in% c("1/2/2007","2/2/2007"))
Data$Date <- as.Date(Data$Date, format="%d/%m/%Y")


# Create png chart --------------------------------------------------------
png("plot1.png", width=480, height=480)
hist(Data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
