library(ggplot2)
getwd()
#setwd('..')
d <- getwd()
if (file.exists(paste(getwd(), "/Output.txt", sep="", collapse=""))) {
    d <-(paste(getwd(), "/Output.txt", sep="", collapse=""))
 }

imgDir <- getwd()
dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists("tex")) {
   imgDir <- paste(getwd(), "/tex/", sep="", collapse="")
   setwd(imgDir)
   if (dir.exists("img")) {
     imgDir <- paste(getwd(), "/img/", sep="", collapse="")
   }
}
#imgDir
#dataDir
dataFile <- "Metabolitos.csv"
tmp <- paste(dataDir, dataFile, sep="", collapse="")
results <- read.table(tmp, header =TRUE, sep=",")
hp <- subset(results, results$Amonio > 0)
max_x <- max(hp$Tiempo, na.rm = TRUE)
max_y <- max(hp$Amonio, na.rm = TRUE)
#ggplot(hp, aes (x=Tiempo, y=Amonio))+geom_point()   4*0:g_range[2]
x_range_vector <- 10*0:max_x
g <- ggplot(hp, aes (x=Tiempo, y=Amonio))+geom_point()+ geom_line(aes(color = Amonio))
g + scale_x_continuous(name ="Tiempo(hrs)", x_range_vector, x_range_vector, limits=c(0,max_x ))
g + scale_y_discrete(name ="Amonio(gr/L)", limits=c(0,max_y))

ggsave("Amonio.png", device = "png", path = imgDir)
