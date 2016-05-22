library(dplyr)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#aggregate (group by) year and sum
agg <- aggregate(NEI$Emissions, list(NEI$year), sum)
colnames(agg) <- c("year","sum")

#plot1
options(scipen=5)
png(file = 'plot1.png')
barplot(agg$sum, main = "PM2.5 Emission Over the Years",
        names.arg = agg$year, col = "dark gray", xlab = "Year", 
        ylab = "PM2.5 Emissions (tons)", ylim = c(0, 8000000))
lines(agg$sum, col = "black", lwd = 3)
points(agg$sum, lwd = 2, pch = 19, col = "black")
dev.off()
