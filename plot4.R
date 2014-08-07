require("ggplot2")
# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?
generatePlot4<- function(NEI,SCC){
  coal <- SCC[grepl("Comb",SCC$EI.Sector) & grepl("Coal",SCC$EI.Sector),]
  toFilter <- coal$SCC
  coalInAmerica <-NEI[NEI$SCC %in% toFilter,]
  aggr <-aggregate(coalInAmerica$Emissions, by=list(coalInAmerica$year), FUN=sum)
  barplot(aggr$x,beside=FALSE, names = aggr$Group.1, xlab = "Year", ylab= "Total emission",main="Total emission of Coal combustion-related sources in America")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot4.png")
generatePlot4(NEI,SCC)
dev.off()