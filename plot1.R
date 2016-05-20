library(dplyr)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#transform year to factor
NEI <- transform(NEI, year = factor(year))

#aggregate (group by) year and sum
agg <- aggregate(NEI$Emissions, list(NEI$year), sum)
colnames(agg) <- c("year","sum")

#plot1
windows()
png(file = 'plot1.png')
barplot(agg$sum, main = "PM2.5 Emission Over the Years",
        names.arg = agg$year, col = "dark gray")
lines(agg$sum, col = "black", lwd = 3)
points(agg$sum, lwd = 2, pch = 19, col = "black")
dev.off()
