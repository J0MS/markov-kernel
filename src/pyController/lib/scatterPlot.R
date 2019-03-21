library(ggplot2)
library(readxl)
require(reshape2)

dataDir <- paste(getwd(), "/data/", sep="", collapse="")

setwd(dataDir)


#read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!D1:M138")
hhi_index_cards<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!E1:E138",col_types = c("numeric"))
declinacion_antifraude<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!AU1:AU138",col_types = c("numeric"))

perc_expired_card<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!AB1:AB138",col_types = c("numeric"))
median_score_sistema_antifraude_A<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!S1:S138",col_types = c("numeric")) 

hhi_index_devices<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!I1:I138",col_types = c("numeric"))
median_score_sistema_antifraude_B<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!O1:O138",col_types = c("numeric")) 


median_sistema_antifraude_A__score_company<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!S1:S138",col_types = c("numeric"))
median_sistema_antifraude_B__score_company<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!O1:O138",col_types = c("numeric")) 


df1 = data.frame(my_x1 = hhi_index_cards, my_y1 = declinacion_antifraude )
df2 = data.frame(my_x2 = perc_expired_card, my_y2 = median_score_sistema_antifraude_A )
df3 = data.frame(my_x2 = hhi_index_devices, my_y2 = median_score_sistema_antifraude_B )
df4 = data.frame(my_x2 = median_sistema_antifraude_A__score_company, my_y2 = median_sistema_antifraude_B__score_company )

setwd('..')
imgDir <- paste(getwd(), "/img", sep="", collapse="")


ggplot(data = df1, aes(x = hhi_index_cards, y = antifraud_decline)) +   geom_point(color = 'red') +   stat_smooth(method = 'lm')
ggsave("hhi_index_cards_VS_declinacion_antifraude.png", device = "png", path = imgDir)

ggplot(data = df2, aes(x = perc_expired_txn, y = median_sistema_antifraude_A__score_company)) +   geom_point(color = 'red') +   stat_smooth(method = 'lm')
ggsave("perc_expired_txn_VS_median_sistema_antifraude_A__score_company.png", device = "png", path = imgDir)

#plot(x = df3$hhi_index_devices, y = df3$median_score_sistema_antifraude_B)
ggplot(data = df3, aes(x = hhi_index_devices, y = median_sistema_antifraude_B__score_company)) +   geom_point(color = 'red') +   stat_smooth(method = 'lm')
ggsave("hhi_index_devices_VS_median_score_sistema_antifraude_B.png", device = "png", path = imgDir)

ggplot(data = df4, aes(x = median_sistema_antifraude_A__score_company, y = median_sistema_antifraude_B__score_company)) +   geom_point(color = 'red') +   stat_smooth(method = 'lm')
ggsave("median_sistema_antifraude_A__score_company_VS_median_sistema_antifraude_B__score_company.png", device = "png", path = imgDir)



