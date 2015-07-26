#Reading data, loading the used librarys.
library(dplyr)
data  <- readRDS("./summarySCC_PM25.rds")
dataSCC  <- readRDS("./Source_Classification_Code.rds")

#The subsetting data and plotting scrypt.
summary  <- data[data$fips == "24510",] %>%
    group_by(year) %>%
    summarise(emissions = sum(Emissions))
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
with(summary, barplot(emissions, year, ylim = c(0, max(emissions)), ylab = "Emissions (tons)",
                      names.arg = year, xlab = "Year", main = "Total emissions from PM2.5 in Baltimore City"))
dev.off()