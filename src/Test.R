getwd()
setwd('..')
imgDir <- getwd()
dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists("tex")) {
   imgDir <- paste(getwd(), "/tex/", sep="", collapse="")
   setwd(imgDir)
   if (dir.exists("img")) {
     imgDir <- paste(getwd(), "/img/", sep="", collapse="")
   }
}

dataDir <- paste(getwd(), "/data/", sep="", collapse="")
dataFile <- "Metabolitos.csv"
#dataFile <- "/home/dev/Documents/Cinvestav/Biotecnología/Proyecto/Tesis/E_Tutorial/4_Cuatrimestre/Escrito/data/Metabolitos.csv"
tmp <- paste(dataDir, dataFile, sep="", collapse="")
tmp
