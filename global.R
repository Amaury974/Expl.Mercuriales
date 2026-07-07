# encoding UTF-8
# développé sous R 4.4.2
# dernière édition : décembre 2025
# auteur / contact : amaury.jorant@reunion.chambagri.fr
# __________
# 
# Projet : Shiny Mercuriales 
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤




### ________________________________________________________________________ ###
####                          > Packages                                    ####
cat('>> GLOBAL > Packages\n')


library(shiny)

library(ggplot2); theme_set(theme_minimal(base_size=20)) # graphiques

library(dplyr); options(dplyr.summarise.inform = FALSE)

# library(shinyWidgets) utilisé avec :: 
# library(RColorBrewer) utilisé avec  ::

### ________________________________________________________________________ ###
####                             > Data                                     ####
cat('>> GLOBAL > Data\n')

# df_mercuriales <- read.csv2('../Extraction Mercuriales/data/df_mercuriales 2022-2025.csv')
df_mercuriales <- read.csv2('data/df_mercuriales.csv')

df_mercuriales$Semaine <- as.Date(df_mercuriales$Semaine)
df_mercuriales <- arrange(df_mercuriales, Produit)
df_mercuriales <- filter(df_mercuriales, Origine == 'RUN')

Produit_ok <- df_mercuriales %>%
  group_by(Produit) %>%
  summarise(N = length(Produit)) %>%
  filter(N > 5) %>%
  pull(Produit)

df_mercuriales <- filter(df_mercuriales, Produit %in% Produit_ok)

### ________________________________________________________________________ ###
####                             > Palette                                  ####

tout_marche <- unique(df_mercuriales$Marche)

palette_marche <- RColorBrewer::brewer.pal(length(tout_marche), 'Dark2')
names(palette_marche) <- tout_marche


# produits_col <- read.csv("data/Produits couleurs.csv")


# df_mercuriales %>%
# distinct(Produit) %>%
#   write.csv2('data/tous produits.csv', row.names = FALSE)








