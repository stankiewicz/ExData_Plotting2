require("ggplot2")
# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?
generatePlot5<- function(NEI,SCC){
  baltimore <- NEI[NEI$fips== "24510",]
  coal <- SCC[grepl("Vehicles",SCC$EI.Sector),]
  toFilter <- coal$SCC
  vehBaltimore <-baltimore[baltimore$SCC %in% toFilter,]
  aggr <-aggregate(vehBaltimore$Emissions, by=list(vehBaltimore$year), FUN=sum)
  barplot(aggr$x,beside=FALSE, names = aggr$Group.1, xlab = "Year", ylab= "Total emission",main="Total emission of vehicle sources in Baltimore")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot5.png")
generatePlot5(NEI,SCC)
dev.off()