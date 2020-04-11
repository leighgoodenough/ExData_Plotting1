## Read file 
## Assume: source file has been saved as "hpc.txt" and is in the working dir

hpc <- read.table("hpc.txt", sep=";", skip=66637, nrows=2880, 
                  col.names=c("Date", "Time", "GlobalA", "GlobalR", "Voltage", 
                              "GlobalI", "Sub1", "Sub2", "Sub3"))

## Set up "Date" and "Time" columns as a single "datetime" column of 
## class POSIXlt

install.packages("tidyr")
library(tidyr)
hpc <- unite_(hpc, "datetime", c("Date","Time"), sep=" ")
hpc$datetime <- strptime(hpc$datetime, "%d/%m/%Y %H:%M:%S")

## Produce and save a file of Plot 4

par(mfcol=c(2,2))
with(hpc, {
    plot(hpc$datetime, hpc$GlobalA, xlab="", 
         ylab="Global Active Power (kilowatts)", type="n")
    lines(hpc$datetime, hpc$GlobalA)
})
with(hpc, {
    with(hpc, {
        plot(hpc$datetime, hpc$Sub1, xlab="", 
             ylab="Energy sub metering", type="n")
        lines(hpc$datetime, hpc$Sub1)
    })
    with(hpc, lines(hpc$datetime, hpc$Sub2, col="red"))
    with(hpc, lines(hpc$datetime, hpc$Sub3, col="blue"))
    legend("topright", pch="_", cex=.8, bty="n", col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
with(hpc, {
    plot(hpc$datetime, hpc$Voltage, xlab="datetime", ylab="Voltage", type="n")
    lines(hpc$datetime, hpc$Voltage)
})
with(hpc, {
    plot(hpc$datetime, hpc$GlobalR, xlab="datetime", 
         ylab="Global_reactive_power", type="n")
    lines(hpc$datetime, hpc$GlobalR)
})
dev.copy(png, file="plot4.png")
dev.off()
par(mfcol=c(1,1))