library(dplyr)
library(ggplot2)
library(sqldf)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## select coal
colnames(SCC)[3] <- 'ShortName'
coal <- as.vector(sqldf("select distinct(SCC) from SCC where ShortName like '%coal%'"))

#aggregate (group by) year and sum
coal_fuel <- filter(NEI, SCC %in% as.vector(coal$SCC))
agg <- aggregate(coal_fuel$Emissions, list(coal_fuel$year), sum)
colnames(agg) <- c("year", "sum")

#plot4
options(scipen=5)
png(file = 'plot4.png')
barplot(agg$sum, main = "PM2.5 Emissions from Coal Combustion-Related Sources",
        names.arg = agg$year, col = "dark gray", xlab = "Year",
        ylab = "PM2.5 Emissions (tons)", ylim = c(0, 610000))
lines(agg$sum, col = "black", lwd = 3)
points(agg$sum, lwd = 2, pch = 19, col = "black")
dev.off()
