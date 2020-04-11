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

## Produce and save a file of Plot 2

plot(hpc$datetime, hpc$GlobalA, xlab="", 
     ylab="Global Active Power (kilowatts)", type="n")
lines(hpc$datetime, hpc$GlobalA)
dev.copy(png, file="plot2.png")
dev.off()