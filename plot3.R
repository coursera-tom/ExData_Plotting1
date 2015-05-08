# acquire data set
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "data/household_power_consumption.zip"
unzipfile <- "household_power_consumption.txt"
if(!file.exists("data")) {
  dir.create("data")
}
if(!file.exists(zipfile)) {
  download.file(url, destfile=zipfile, method="curl")
}
conn <- unz(zipfile, unzipfile)
# read the header
headers <- read.csv(conn, sep=";",  na.strings="?", nrows=1, header=F, 
                    stringsAsFactors=FALSE) 
# read data of 02/01/2007 and 02/02/2007
conn <- unz(zipfile, unzipfile)
dat <- read.csv(conn, sep=";",  na.strings="?", skip=66637, nrows=(69516-66636), 
                header=F, stringsAsFactors=FALSE) 
names(dat) <- headers

# convert Date and Time
dat$Date <- strptime(paste(dat$Date,dat$Time), format="%d/%m/%Y %H:%M:%S")

# plotting
png("plot3.png")
with(dat, {
  plot(Date, Sub_metering_1,type="l", col="black", ylab="Energy sub metering", xlab="")
  lines(Date, Sub_metering_2,type="l",  col="red")
  lines(Date, Sub_metering_3,type="l",  col="blue") })
legend("topright",lty=1, col=c("black","red","blue",bty='n',cex=0.5), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
       
dev.off()


