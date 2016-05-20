library(dplyr)

setwd("C:\\Users\\Renato\\Desktop\\exdata-data-NEI_data")

## input data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#transform year to factor
NEI <- transform(NEI, year = factor(year))

# filter only Baltimore city
NEI_Balt <- filter(NEI, fips == "24510")

#aggregate (group by) year and sum
agg <- aggregate(NEI_Balt$Emissions, list(NEI_Balt$year), sum)
colnames(agg) <- c("year","sum")

#plot2
windows()
png(file = 'plot2.png')
barplot(agg$sum, main = "PM2.5 Emission in Baltimore City Over the Years",
        names.arg = agg$year, col = "dark gray", ylab = "PM2.5 Emissions (tons) ",
        ylim = c(0,3500))
lines(agg$sum, col = "black", lwd = 3)
points(agg$sum, lwd = 2, pch = 19, col = "black")
dev.off()
