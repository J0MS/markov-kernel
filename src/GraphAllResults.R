library(ggplot2)
library(reshape)
getwd()
#setwd('..')
imgDir <- getwd()
dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists("tex")) {
   imgDir <- paste(getwd(), "/tex/", sep="", collapse="")
   setwd(imgDir)
   if (dir.exists("img")) {
     imgDir <- paste(getwd(), "/img/", sep="", collapse="")
   }
}

dataFile <- "Metabolitos.csv"
tmp <- paste(dataDir, dataFile, sep="", collapse="")
results <- read.table(tmp, header =TRUE, sep=",")
v1 <- data.frame(x=results$Tiempo,y=results$Biomasa)
v2 <- data.frame(x=results$Tiempo,y=results$Proteinas)
v3 <- data.frame(x=results$Tiempo,y=results$Amonio)
v4 <- data.frame(x=results$Tiempo,y=results$Azucares)
Metabolitos <-melt(list(Biomasa = v1, Proteinas = v2, Amonio = v3, Azucares = v4), id.vars = "x")
#ggplot(Metabolitos, aes(x, value, colour = L1)) + geom_point() + scale_colour_manual("Dataset", values = c("Biomasa" = "green", "Proteinas" = "red", "Amonio" = "blue","Azucares"="yellow"))
ggplot(Metabolitos, aes(x, value, colour = L1)) + geom_point() + geom_line() + scale_colour_manual("Metabolitos", values = c("Biomasa" = "#FF9999", "Proteinas" = "#ba9b6b", "Amonio" = "#99e3ff","Azucares"="#cedd55")) + labs(x="Tiempo(hrs)",y="Concentracion (gr/L)")
ggsave("Totales.png", device = "png", path = imgDir)
