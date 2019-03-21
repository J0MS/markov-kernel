library(readxl)
library(ggplot2)
library(reshape2)



imgDir <- paste(getwd(), "/img/", sep="", collapse="")
dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists(dataDir)) {
   setwd(dataDir)
}
if (dir.exists("/img/")) {
     imgDir <- paste(getwd(), "/img/", sep="", collapse="")
   }
setwd(dataDir)
   
#antifraud_declined_count_company   bank_approved_count_company
declinacion_antifraude<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!AM1:AM138",col_types = c("numeric"))
declinacion_bancaria<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!AO1:AO138",col_types = c("numeric"))
   
df = data.frame(my_x1 = declinacion_antifraude, my_y1 = declinacion_bancaria )
names(df)
modelo <- lm(antifraud_declined_count_company ~ bank_declined_count_company, data=df)
summary(modelo)
cor.test(df$antifraud_declined_count_company,df$bank_declined_count_company, method = "pearson")

residuos<-rstandard(modelo) # residuos estándares del modelo ajustado (completo) 
par(mfrow=c(1,3)) # divide la ventana en una fila y tres columnas 
hist(residuos) # histograma de los residuos estandarizados 
boxplot(residuos) # diagrama de cajas de los residuos estandarizados 
qqnorm(residuos) # gráfico de cuantiles de los residuos estandarizados 
qqline(residuos)  
par(mfrow=c(1,1))

setwd('..')
imgDir <- paste(getwd(), "/img", sep="", collapse="")

jpeg('linealReg.jpg')
#jpeg('acfCorrectedlinealReg.jpg')

plot(df$antifraud_declined_count_company, df$bank_declined_count_company ,xlab = "Antifraud declined", ylab = "Bank declined count" )
abline(modelo)
dev.off()
   
