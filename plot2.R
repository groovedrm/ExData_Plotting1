# Loading libraries
is.installed <- function(mypkg) {
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

#Initialize PNG/Plots
png("plot2.png", width=504, height=504)
distilledTable$Global_active_power = as.numeric(distilledTable$Global_active_power)
plot(distilledTable$DateTime, distilledTable$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()




