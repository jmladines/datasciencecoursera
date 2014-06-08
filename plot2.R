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

#Extract the Week of day from Dates. Add as a new column
feb07$Weekday <- weekdays(feb07$DateTime, abbreviate=TRUE)


#Create the plot
with(feb07, plot(DateTime,Global_active_power,
                 xlab=" ",
                 ylab="Global Active Power (kilowatts)",
                 cex.lab=0.80, cex.axis=0.75,
                 type="l"))


#Create the png file for the plot
dev.copy(png, file="plot2.png",width=480,height=480)
dev.off()
