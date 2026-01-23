# encoding UTF-8
# développé sous R 4.4.2
# dernière édition : décembre 2025
# auteur / contact : amaury.jorant@reunion.chambagri.fr
# __________
# 
# Projet : Shiny Mercuriales 
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

Produit_X = 'AIL VIOLET'

Produit_X = 'LETCHI'
Produit_X = 'AUBERGINE'

Marche_X = 'marchés forains'
Marche_X = c('marchés forains', 'producteurs bio')
Marche_X = tout_marche

fg_mercuriale <- function(Produit_X, Marche_X, lissage){
  
  df_mercuriales_X <- filter(df_mercuriales,
                             Produit == Produit_X,
                             Marche %in% Marche_X,
                             !is.na(Prix),
                             !is.na(Semaine)) 
  ### ________________________________________________________________________ ###
  ####               > séparation des ruptures de continuité                  ####
  # fruits à saisonnalité importante
  
  df_mercuriales_X2 <- data.frame()
  
  # Marche_i=Marche_X[2]
  for(Marche_i in Marche_X){
    
    df_mercuriales_i <- df_mercuriales_X %>%
      filter(Marche == Marche_i) %>%
      arrange(Semaine) %>%
      mutate(Groupe=1)
    
    if(nrow(df_mercuriales_i) > 2){
      df_mercuriales_i$s_prec <- 
        c(df_mercuriales_i[1, 'Semaine'], df_mercuriales_i[1:(nrow(df_mercuriales_i)-1), 'Semaine'])
      
      df_mercuriales_i <- df_mercuriales_i %>%
        mutate(X = ifelse(Semaine-s_prec > 90, 1, 0),
               Groupe = cumsum(X))
    }
    
    df_mercuriales_X2 <- bind_rows(df_mercuriales_X2,
                                   df_mercuriales_i)
  }
  
  df_mercuriales_X2$Groupe <- with(df_mercuriales_X2, paste(Marche, Groupe))
  
  # ### ________________________________________________________________________ ###
  # ####                           > Cyclones                                   ####
  
  cyclones <- data.frame(Date = as.Date(c('2025-02-28', '2024-01-15', '2022-02-03')),
                         Nom = c('Garance', 'Belal', 'Batsirai'))
  
  cyclones <- filter(cyclones,
                     Date >= min(df_mercuriales_X2$Semaine),
                     Date <= max(df_mercuriales_X2$Semaine))
  
  ### ________________________________________________________________________ ###
  ####                            > graphique                                 ####
  
  graph <- ggplot(df_mercuriales_X2, aes(Semaine, Prix)) +
    
    # ~~~~{    Cyclones    }~~~~ #
    geom_vline(data = cyclones,
               aes(xintercept = Date),
               color = 'grey70') +
    geom_text(data = cyclones,
              aes(x = Date, y = max(df_mercuriales_X2$Prix), label = Nom),
              angle = 90,
              hjust = 1,
              vjust = 0,
              size = 4,
              color = 'grey70')
  
  # ~~~~{    courbe des Prix    }~~~~ #
  if(lissage){
    
    groupe_N <- df_mercuriales_X2 %>%
    group_by(Groupe)%>%
    summarise(N=length(Marche))
  
    i=1
    i=4
    for(i in 1:4){
      
      span_i <- c(0.06, 0.1, 0.4, 0.8)[i]
      N_i <- c(100, 50, 15, 1)[i]
      
      groupe_i <- filter(groupe_N, N >= N_i)$Groupe
      groupe_N <- filter(groupe_N, N < N_i)
      
    graph <-
      graph +
      geom_smooth(data = filter(df_mercuriales_X2, Groupe %in% groupe_i),
                  aes(color = Marche, group = Groupe),
                  linewidth = 1,
                  se = FALSE,
                  n = 300,
                  span = span_i
                )
    }
    
    # les points sont colorés
    graph <- graph + 
    geom_point(aes(color = Marche),
               size = 0.5, 
               shape = 16)
    
  }else{
    graph <- graph +
      geom_line(aes(color = Marche, group = Groupe), linewidth = 1) +
      geom_point(aes(fill = Fiabilite), size = 0.5, shape = 21, color = 'transparent') +
      scale_fill_manual(values = c('fiable' = 'black', 'peu fiable' = 'grey'))
      
  }
  
  
  graph <- graph + 
    scale_color_manual(values = palette_marche) +
   
    # ~~~~{    Mise en forme    }~~~~ #
    theme(legend.position = "bottom") +
    guides(color = guide_legend(ncol = 2),
           fill = 'none') +
    coord_cartesian(ylim=c(0,NA)) +
    labs(title = Produit_X,
         # subtitle = paste(Marche_X, collapse = '\n'),
         x = NULL,
         y = 'Prix (€)',
         color= 'Marché')
  
  graph
}





