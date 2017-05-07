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

# Initialize PNG/Plots
png("plot3.png", width=504, height=504)
distilledTable$Sub_metering_1 = as.numeric(distilledTable$Sub_metering_1)
distilledTable$Sub_metering_2 = as.numeric(distilledTable$Sub_metering_2)
distilledTable$Sub_metering_3 = as.numeric(distilledTable$Sub_metering_3)

# Start plotting
plot(distilledTable$DateTime, distilledTable$Sub_metering_1, type="l", xlab="", ylab="Global Active Power (kilowatts)", col="Black")
lines(distilledTable$DateTime, distilledTable$Sub_metering_2, type="l",  col="Red")
lines(distilledTable$DateTime, distilledTable$Sub_metering_3, type="l", col="Blue" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty, lwd=1, col=c("Black","Red","Blue"))

# Finish/close file
dev.off()




