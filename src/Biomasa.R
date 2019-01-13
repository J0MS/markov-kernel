library(ggplot2)
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
hp <- subset(results, results$Biomasa > 0)
max_x <- max(hp$Tiempo, na.rm = TRUE)
max_y <- max(hp$Biomasa, na.rm = TRUE)
#ggplot(hp, aes (x=Tiempo, y=Biomasa))+geom_point()   4*0:g_range[2]
x_range_vector <- 10*0:max_x
g <- ggplot(hp, aes (x=Tiempo, y=Biomasa))+geom_point()+ geom_line(aes(color = Biomasa))
g + scale_x_continuous(name ="Tiempo(hrs)", x_range_vector, x_range_vector, limits=c(0,max_x ))
g + scale_y_discrete(name ="Biomasa(gr/L)", limits=c(0,max_y))
ggsave("Biomasa.png", device = "png", path = imgDir)



#results <- read.table("Metabolitos.csv", header =TRUE, sep=",")
#max_x <- max(results$Tiempo, na.rm = TRUE)
#max_y <- max(results$Azucares, na.rm = TRUE)
#max_y_total <-max(results)
#plot_colors <- c("coral1","dodgerblue3","darkseagreen3","darkgoldenrod1","black")
#png(filename="Azucares.png",height=395,width=500,bg="white")
#plot(results$Tiempo, y = results$Azucares, type = "o",  xlim = c(0,max_x), ylim = c(0,max_y),col=plot_colors[1],log = "", main = "Azucares Reductores", sub = NULL, xlab =
#"Tiempo(hrs)",
#    ylab = " Concentración (gr/L)",ann = par("ann"),panel.first = NULL, panel.last = NULL, asp = NA)


#GraphAll

#lines(results$Tiempo, y= results$Proteinas, type="o", pch=23, lty=3,
#   col=plot_colors[2])

#lines(results$Tiempo, y= results$Amonio, type="o", pch=23, lty=3,
#   col=plot_colors[3])

#lines(results$Tiempo, y= results$Azucares, type="o", pch=22, lty=2,
#   col=plot_colors[4])
#names_legend <- c("Biomasa", "Proteinas", "Amonio", "Azucares")
#legend("topleft", legend = names_legend, cex=0.8, col=plot_colors,
#   lty=1:3, lwd=2, bty="n");


#dev.off()
