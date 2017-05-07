# Import the file and distill down to just the table we need
inputFile = "household_power_consumption.txt"
baseTable <- read.table(inputFile, header = TRUE, sep = ";", skipNul = TRUE, stringsAsFactors = FALSE)
distilledTable <- baseTable[baseTable$Date %in% c("1/2/2007","2/2/2007"), ]

# Clean up memory
rm(baseTable)

# Initialize PNG/Plots
png("plot1.png", width=504, height=504)
distilledTable$Global_active_power = as.numeric(distilledTable$Global_active_power)
hist(distilledTable $Global_active_power,
	main = "Global Active Power",
	xlab = "Global Active Power (kilowatts)",
	ylab = "Frequency",
	col = "Red"
)

dev.off()




