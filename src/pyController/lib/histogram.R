library(readxl)
library(ggplot2)


dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists(dataDir)) {
   setwd(dataDir)
}
setwd(dataDir)

#read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!D1:M138")
aceptacion_global<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!AT1:AT138",col_types = c("numeric"))
median_score_sistema_antifraude_A<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!S1:S138",col_types = c("numeric"))
median_score_sistema_antifraude_B<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!O1:O138",col_types = c("numeric"))
hhi_index_c<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!E1:E138",col_types = c("numeric"))
hhi_index_dev<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!I1:I138",col_types = c("numeric"))

setwd('..')
imgDir <- paste(getwd(), "/img", sep="", collapse="")


h1<-ggplot(aceptacion_global, aes(x=aceptacion_global$global_acceptance)) + geom_histogram(color="blue", fill="white")
ggsave(h1,file="hist_aceptacion_global.png", device = "png", path = imgDir)

h2<-ggplot(median_score_sistema_antifraude_A, aes(x=median_score_sistema_antifraude_A$median_sistema_antifraude_A__score_company)) + geom_histogram(color="green", fill="white")
ggsave(h2,file="hist_median_score_sistema_antifraude_A.png", device = "png", path = imgDir)


h3<-ggplot(median_score_sistema_antifraude_B, aes(x=median_score_sistema_antifraude_B$median_sistema_antifraude_B__score_company)) + geom_histogram(color="yellow", fill="white")
ggsave(h3,file="hist_median_score_sistema_antifraude_B.png", device = "png", path = imgDir)

h4<-ggplot(hhi_index_c, aes(x=hhi_index_c$hhi_index_cards)) + geom_histogram(color="red", fill="white")
ggsave(h4,file="hist_hhi_index_cards.png", device = "png", path = imgDir)

h5<-ggplot(hhi_index_dev, aes(x=hhi_index_dev$hhi_index_devices)) + geom_histogram(color="magenta", fill="white")
ggsave(h5,file="hist_hhi_index_devices.png", device = "png", path = imgDir)


