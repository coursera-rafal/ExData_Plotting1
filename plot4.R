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
Data$DateTime <-as.POSIXct(paste(Data$Date, Data$Time))

# Create png chart --------------------------------------------------------
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Data, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()

