library(tidyverse)
#source("/media/bettega/disque1/projet/A/bettegar.R")
source("~/Documents/informatique/bettegar.R")
d <- read_csv("automobille/autos_2.csv")
statistique(d)

vehicule <- as.factor(d$vehicleType)
levels(vehicule) <- c("autre", "bus", "autre", "autre", "citadine",
                      "break", "berline", "autre")
d$vehicleType <- as.character(vehicule)
rm(vehicule)

sum(d$price)

length(filter(d, vehicleType == "autre")[[1]])
length(filter(d, vehicleType == "break")[[1]])/length(d[[1]])

part_marche <- rep(-1,5)
for (i in 1:5) {
 part_marche[i] <- sum(filter(d, vehicleType == unique(d$vehicleType)[i])[[1]])/sum(d$price)
}
names(part_marche) <- unique(d$vehicleType)
## ajoute la valeur dans la base en face des types de vehicules
part_m <- as.factor(d$vehicleType)
levels(part_m) <- c( part_marche[3], part_marche[2], part_marche[4], part_marche[5], part_marche[1])
part_m <- as.numeric(as.character(part_m))
d2 <- cbind.data.frame(d, "part_marche_type" = part_m)
