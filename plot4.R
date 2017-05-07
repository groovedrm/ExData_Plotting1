# Loading libraries
is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("lubridate")){
  install.packages("lubridate")
}

library(lubridate)

# Import the file and distill down to just the table we need
inputFile = "household_power_consumption.txt"
baseTable <- read.table(inputFile, header = TRUE, sep = ";", skipNul = TRUE, stringsAsFactors = FALSE)
distilledTable <- baseTable[dmy(baseTable$Date) %in% as.Date(c("2007-02-01","2007-02-02")), ]
distilledTable$DateTime = strptime(paste(distilledTable$Date, distilledTable$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
rm(baseTable)

# Initialize PNG/Plotting Variablws
png("plot4.png", width=504, height=504)
distilledTable$Global_active_power = as.numeric(distilledTable$Global_active_power)
distilledTable$Voltage = as.numeric(distilledTable$Voltage)
distilledTable$Sub_metering_1 = as.numeric(distilledTable$Sub_metering_1)
distilledTable$Sub_metering_2 = as.numeric(distilledTable$Sub_metering_2)
distilledTable$Sub_metering_3 = as.numeric(distilledTable$Sub_metering_3)
distilledTable$Global_reactive_power = as.numeric(distilledTable$Global_reactive_power)

# Use Par Function to Organize Plots
par(mfrow=c(2,2))

# Global Active Power Plot
plot(distilledTable$DateTime, distilledTable$Global_active_power, type="l", xlab="", ylab="Global Active Power", col="Black")

# Voltage Plot
plot(distilledTable$DateTime, distilledTable$Voltage, type="l", xlab="datetime", ylab="Voltage", col="Black")

# Energy Sub Metering Plot
plot(distilledTable$DateTime, distilledTable$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="Black")
lines(distilledTable$DateTime, distilledTable$Sub_metering_2, type="l",  col="Red")
lines(distilledTable$DateTime, distilledTable$Sub_metering_3, type="l", col="Blue" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty, lwd=1, col=c("Black","Red","Blue"), bty = "n")

# Global Reactive Power Plot
plot(distilledTable$DateTime, distilledTable$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", col="Black")

# Finish/close file
dev.off()




