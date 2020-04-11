## Read file 
## Assume: source file has been saved as "hpc.txt" and is in the working dir

hpc <- read.table("hpc.txt", sep=";", skip=66637, nrows=2880, 
                  col.names=c("Date", "Time", "GlobalA", "GlobalR", "Voltage", 
                              "GlobalI", "Sub1", "Sub2", "Sub3"))

## Produce and save a file of Plot 1

hist(hpc$GlobalA, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()