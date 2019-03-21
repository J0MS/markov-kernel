library(ggplot2)
library(readxl)
library(reshape2)

imgDir <- paste(getwd(), "/img/", sep="", collapse="")
dataDir <- paste(getwd(), "/data/", sep="", collapse="")
if (dir.exists(dataDir)) {
   setwd(dataDir)
}
if (dir.exists("/img/")) {
     imgDir <- paste(getwd(), "/img/", sep="", collapse="")
   }

#read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!D1:M138")
correlationData<-read_excel("prueba_analista_datos_dataset.xlsx", range = "company_one!D1:M138",col_types = c("numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))


correlationMatrix <- round(cor(correlationData),2)
melted_correlationMatrix <- melt(correlationMatrix)

# Get lower triangle of the correlation matrix
get_lower_tri<-function(correlationMatrix){
    correlationMatrix[upper.tri(correlationMatrix)] <- NA
    return(correlationMatrix)
  }
  # Get upper triangle of the correlation matrix
get_upper_tri <- function(correlationMatrix){
    correlationMatrix[lower.tri(correlationMatrix)]<- NA
    return(correlationMatrix)
  }

upper_tri <- get_upper_tri(correlationMatrix)
melted_correlationMatrix <- melt(upper_tri, na.rm = TRUE)

reorder_correlationMatrix <- function(correlationMatrix){
# Use correlation between variables as distance
dd <- as.dist((1-correlationMatrix)/2)
hc <- hclust(dd)
correlationMatrix <-correlationMatrix[hc$order, hc$order]
}

# Reorder the correlation matrix
correlationMatrix <- reorder_correlationMatrix(correlationMatrix)
upper_tri <- get_upper_tri(correlationMatrix)
# Melt the correlation matrix
melted_correlationMatrix <- melt(upper_tri, na.rm = TRUE)

ggheatmap <- ggplot(melted_correlationMatrix, aes(Var2, Var1, fill = value))+
 geom_tile(color = "white")+
 scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
   midpoint = 0, limit = c(-1,1), space = "Lab", 
    name="Pearson\nCorrelation") +
  theme_minimal()+ # minimal theme
 theme(axis.text.x = element_text(angle = 45, vjust = 1, 
    size = 12, hjust = 1))+
 coord_fixed()

ggheatmap + 
geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank(),
  legend.justification = c(1, 0),
  legend.position = c(0.6, 0.7),
  legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                title.position = "top", title.hjust = 0.5))

ggsave("correlationMatrix.png", device = "png", path = imgDir)
#ggsave("hist_correlationMatrix.png", device = "png", path = imgDir)
