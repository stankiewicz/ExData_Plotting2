# check files
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata-data-NEI_data.zip")
  unzip("exdata-data-NEI_data.zip")
}
#Have total emissions from PM2.5 decreased
#in the United States from 1999 to 2008?
#Using the base plotting system, 
#make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.
generatePlot1<- function(NEI,SCC){
  aggr <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
  barplot(aggr$x,beside=FALSE, names = aggr$Group.1, xlab = "Year", ylab= "Total emission")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot1.png")
generatePlot1(NEI,SCC)
dev.off()