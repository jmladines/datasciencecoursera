#read the text file 
data <- read.table("household_power_consumption.txt", 
                   sep=";",
                   nrows=100000,
                   header=TRUE,
                   na.strings = "?", 
                   as.is=TRUE, 
                   dec=".")

#Convert Dates for subsetting the data
d <- as.Date(data[,1], format='%d/%m/%Y')
data$Date <- d

#Subset the dataframe
row.names=NULL
feb07 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

#Convert other character columns to numeric
gap <- as.numeric(as.character(feb07$Global_active_power))
feb07$Global_active_power <- gap

grp <- as.numeric(as.character(feb07$Global_reactive_power))
feb07$Global_reactive_power <- grp

v <- as.numeric(as.character(feb07$Voltage))
feb07$Voltage <- v

gi <- as.numeric(as.character(feb07$Global_intensity))
feb07$Global_intensity <- gi

#Create histogram - plot1
axis(side=2, 
     at=c(0,200,400,600,800,1000,1200), 
     labels=c("0","200","400","600","800","1000","1200"))
with(feb07, {
     hist(feb07$Global_active_power, 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency",
     cex.main=1.0, cex.lab=0.80, cex.axis=0.75,
     ylim=c(0,1300),
     col="red")
     })    

#Create the png file for the plot
dev.copy(png, file="plot1.png",width=480,height=480)
dev.off()

