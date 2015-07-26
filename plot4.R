#Reading data, loading the used librarys.
library(dplyr)
library(ggplot2)
library(data.table)
data  <- readRDS("./summarySCC_PM25.rds")
dataSCC  <- readRDS("./Source_Classification_Code.rds")

#The subsetting data and plotting scrypt.
data$Pollutant  <- as.factor(data$Pollutant)
data$year  <-  as.factor(data$year)
#dataCoalSCC  <- dataSCC[dataSCC$EI.Sector %like% "Coal",]
dataCoalSCC  <- filter(dataSCC, SCC.Level.One %like% "Comb", EI.Sector %like% "Coal")
dataCoal  <- data[data$SCC %in% dataCoalSCC$SCC,]
summary  <- dataCoal %>%
    group_by(year) %>%
    summarise(emissions = sum(Emissions))
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data = summary, aes(x = year, y = emissions))+
    geom_bar(stat = "identity", width = .7, fill = "light blue", col = "Black")+
    xlab("Year") + ylab("Emissions (tons)") + ggtitle("PM2.5 emissions from coal combusion-related sources in USA")
dev.off()