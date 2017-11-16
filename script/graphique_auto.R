## dependance ----
library(tidyverse)

## chargement des donnees ----
d <- read_csv("automobille/autos_2.csv")

# On s'interesse ici a la variable prix
# En fonction de variable discrète
## graphique par type de vehicule ----
type <- ggplot(data = d, aes(vehicleType, price, fill=vehicleType)) +
  geom_boxplot() +
  ggtitle("Distribution du prix des véhicule en fonction du type de véhicule")
type
## graphique par type d energie ----
fuel <- ggplot(data = d, aes(fuelType, price, fill=fuelType)) +
  geom_boxplot() +
  ggtitle("Distribution du prix des véhicule en fonction du type d'énergie qu'il utilise")
fuel
## graphique en fonction de la presence de degats ----
dommage <- ggplot(data = d, aes(notRepairedDamage, price, fill=notRepairedDamage)) +
  geom_boxplot() +
  ggtitle("Distribution du prix des véhicule en fonction du type d'énergie qu'il utilise")
dommage
## graphique par marque de voiture ----
# Attention brand possède 39 modalite le graphique et donc peut lisible
# notamment afficher a un petit format
marque <- ggplot(data = d, aes(brand, price, fill=brand)) +
  geom_boxplot() +
  ggtitle("Distribution du prix des véhicule en fonction du type de véhicule")
marque

# En fonction d'une variable continue
## graphique des prix en fonction des annees ----
year <- ggplot(data = d, aes(yearOfRegistration, price)) +
  geom_smooth() +
  ggtitle("Prix des vehicules en fonction de l'année d'enregistrement")
year
## graphique des prix en fonction des kilometre ----
kilom <- ggplot(data = d, aes(kilometer, price)) +
  geom_smooth() +
  ggtitle("Prix des vehicules en fonction du nombre de kilomètre du vehicule")
kilom
## graphique des prix en fonction de la puissance ----
power <- ggplot(data = d, aes(powerPS, price)) +
  geom_smooth() +
  ggtitle("Prix des vehicules en fonction du nombre de chevaux moteur")
power

###############################################################################