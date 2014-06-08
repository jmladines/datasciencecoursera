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

#Date Time
DT <- paste(feb07[,1],feb07[,2], sep=" ")
DateTime <- strptime(DT, format="%Y-%m-%d %H:%M:%S")
feb07$DateTime <- DateTime

#Convert other character columns to numeric
gap <- as.numeric(as.character(feb07$Global_active_power))
feb07$Global_active_power <- gap

grp <- as.numeric(as.character(feb07$Global_reactive_power))
feb07$Global_reactive_power <- grp

v <- as.numeric(as.character(feb07$Voltage))
feb07$Voltage <- v

gi <- as.numeric(as.character(feb07$Global_intensity))
feb07$Global_intensity <- gi

sm1 <- as.numeric(as.character(feb07$Sub_metering_1))
feb07$Sub_metering_1 <- sm1

sm2 <- as.numeric(as.character(feb07$Sub_metering_2))
feb07$Sub_metering_2 <- sm2

sm3 <- as.numeric(as.character(feb07$Sub_metering_3))
feb07$Sub_metering_3 <- sm3

#Extract the Week of day from Dates. Add as a new column
feb07$Weekday <- weekdays(feb07$DateTime, abbreviate=TRUE)

Energy_sub_metering <- feb07$Sub_metering_3

par(mfrow = c(2,2), mar = c(4,4,1,1))

#Create the plot1
with(feb07, plot(DateTime,Global_active_power,
                 xlab=" ",
                 ylab="Global Active Power",
                 cex.lab=0.80, cex.axis=0.75,
                 type="l"))

#Create plot2
with(feb07, plot(DateTime,Voltage,
                 xlab="datetime",
                  ylab="Voltage",
                 cex.lab=0.80, cex.axis=0.75,
                 type="l"))

#Create the plot3
Energy_sub_metering <- feb07$Sub_metering_3
par(col.lab="white",col.axis="white",tck=0)
with(feb07, plot(DateTime, Sub_metering_1, type="l", col="black"), ylim=c(0,40))
par(new=TRUE)
with(feb07, plot(DateTime, Sub_metering_2, type="l",col="red",ylim=c(0,40)))
par(new=TRUE,col.axis="black",col.lab="black",tck=-0.025, cex.lab=0.80)
with(feb07, plot(DateTime, Energy_sub_metering, type="l",col="blue",ylim=c(0,40)))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), cex=1,lwd=1, x.intersp=1, xjust=0, bty="n")

#Create plot4
with(feb07, plot(DateTime,Global_reactive_power,
                 xlab="date time",
                 ylab="Global_reactive_power",
                 cex.lab=0.80, cex.axis=0.75,
                 type="l"))

#Create the png file for the plot
dev.copy(png, file="plot3.png",width=669,height=480)
dev.off()