require("ggplot2")
# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?
generatePlot6<- function(NEI,SCC){
  baltimoreAndLA <- NEI[NEI$fips== "24510" |NEI$fips== "06037" ,]
  coal <- SCC[grepl("Vehicles",SCC$EI.Sector),]
  toFilter <- coal$SCC
  vehBaltimoreAndLA <-baltimoreAndLA[baltimore$SCC %in% toFilter,]

  aggr <-aggregate(vehBaltimoreAndLA$Emissions, by=list(vehBaltimoreAndLA$year,vehBaltimoreAndLA$fips), FUN=sum)
  aggr[aggr$Group.2 == '24510',]$Group.2 <- 'Baltimore City'
  aggr[aggr$Group.2 == '06037',]$Group.2 <- 'Los Angeles County'
  colnames(aggr) <- c("Year", "County", "Emission")
  aggr$Year <- as.factor(aggr$Year)
  ggplot(data=aggr, aes(x=Year, y=Emission, fill=County, colour=County))+ geom_bar(stat="identity", position = position_dodge(), alpha=0.4) + geom_smooth(data=aggr, method="lm", aes(group=County),se=FALSE,fullrange=T)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot6.png")
generatePlot6(NEI,SCC)
dev.off()