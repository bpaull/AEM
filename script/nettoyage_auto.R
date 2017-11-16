## dependance ----
library(tidyverse)
source("/media/bettega/disque1/projet/A/bettegar.R")

## chargement des donnees ----
d <- read_csv("automobille/autos.csv")

## recode la variable offerType en francais ----
offer <- as.factor(d$offerType)
levels(offer) <- c("Offre", "Demande")
d$offerType <- as.character(offer)
rm(offer)

## recode la variable seller en francais ----
seller <- as.factor(d$seller)
levels(seller) <- c("prive", "commerciale")
d$seller <- as.character(seller)
rm(seller)

## recode la variable notRepairedDamage en francais ----
damage <- as.factor(d$notRepairedDamage)
levels(damage) <- c("Oui", "Non")
d$notRepairedDamage <- as.character(damage)
rm(damage)

## recode la variable fuelType en recategorisant ----
fuelType <- factor(d$fuelType)
levels(fuelType) <- c("Autre", "Essence", "Autre", "Diesel", "Autre", "Autre", "Autre")
d$fuelType <- as.character(fuelType)
rm(fuelType)

## regroupe les types de vehicules ----
type_v <- factor(d$typeVehicule)
levels(type_v) <- c("citadine", "berline", "autre", "break", "bus", "autre", "autre", "autre")
d$typeVehicule <- as.character(type_v)
rm(type_v)

## presentation des donnees ----
dim(d)
resume(d)
statistique(d)

## echantillonage ----
## suppression et ajout de variables ----
d2 <- select(d,
             - dateCrawled,
             - name,
             - monthOfRegistration,
             - nrOfPictures,
             - dateCreated,
             - lastSeen,
             -postalCode
             )

d2 <- filter(d2, offerType == "Offre" & seller == "commerciale")
d2 <- select(d2, - offerType, - seller)

## on supprime les donnees pour lequelles le prix semble abhérent ---
quantile(d2$price, seq(0, 1, 0.01))
# la valeur 16900 correspont a quantile 99% la valeur 500 est arbitraire
d2 <- filter(d2, price < 16900 & price > 500 )

## on supprime les donnees pour lequelles le nombre de chevau et abérant ----
quantile(d2$powerPS, seq(0, 1, 0.01))
# la valeur 292 corespont au quantile 99% on suprime aussi les valeurs 0
d2 <- filter(d2, powerPS > 0 & powerPS < 292)

## on supprime les donnees pour lequelles l'anées d'enregistrement et abérant ----
quantile(d2$yearOfRegistration, seq(0, 1, 0.01))
# la valeur 1983 corespont au quantile 1% on suprime aussi les valeurs
# supérieur à la date de l'annonce (2016)
d2 <- filter(d2, yearOfRegistration > 1982 & yearOfRegistration < 2017)

## suppresion des individues pour lequelles on a des valeurs manquantes ----
d2 <- filter_all(d2, all_vars(!is.na(.)))
## creer la variable part de marche par modele de voiture
par_marche <- factor(d2$model)
l <- length(levels(par_marche))
part <- rep(-1,l)
for (i in 1:l) {
  part[i] <- sum(filter(d2, model == levels(par_marche)[i])[[1]])/sum(d2$price)
}
names(part) <- levels(par_marche)
levels(par_marche) <- part
par_marche <- as.numeric(as.character(par_marche))
d2 <- cbind.data.frame(d2, "part_marche" = par_marche)
rm(par_marche,part)

## recapitulatif des donnees ----
dim(d2)
resume(d2)
statistique(d2)

## ecrit la base de donnee nettoyer dans le fichier "automobille/autos_2.csv"
write_csv(d2, "automobille/autos_2.csv")

###############################################################################