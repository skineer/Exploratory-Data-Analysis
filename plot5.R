library(dplyr)
library(ggplot2)
library(sqldf)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## select vehicle emissions
colnames(SCC)[3] <- 'ShortName'
vehi <- sqldf("select distinct(SCC) from SCC where ShortName like '%vehicle%'")

#filter vehicle and baltimore city
vehi_emi <- filter(NEI, SCC %in% as.vector(vehi$SCC))
vehi_balt <- filter(vehi_emi, fips == '24510')

#aggregate (group by) year and sum
agg <- aggregate(vehi_balt$Emissions, list(vehi_balt$year), sum)
colnames(agg) <- c("year", "sum")

#plot5
options(scipen=5)
png(file = 'plot5.png')
barplot(agg$sum, main = "PM2.5 Emissions from Vehicle Sources in Baltimore City",
        names.arg = agg$year, col = "dark gray", xlab = "Year",
        ylab = "PM2.5 Emissions (tons)", ylim = c(0, 80))
lines(agg$sum, col = "black", lwd = 3)
points(agg$sum, lwd = 2, pch = 19, col = "black")
dev.off()
