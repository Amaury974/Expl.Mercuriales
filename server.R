# encoding UTF-8
# développé sous R 4.4.2
# dernière édition : décembre 2025
# auteur / contact : amaury.jorant@reunion.chambagri.fr
# __________
# 
# Projet : Shiny Mercuriales
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤



server <- function(input, output) {
  
  observeEvent(input$type,{
    
    choix <- df_mercuriales %>%
      distinct(Produit, .keep_all = TRUE) %>%
      filter(input$type == 'Tout' | Type == input$type) %>%
      pull(Produit)
    
    updateSelectInput(inputId = 'produit', choices = choix)
    
  })
  
  selected_produit <- reactive(input$produit)
  selected_marche <- reactive(input$marche)
  selected_lissage <- reactive(input$lissage)
  
  output$g_mercuriale  <- renderGirafe({
    # cat('>> SERVER > render\n')
    
    # Couleur <- produits_col[produits_col$Produit == input$produit, 'Couleur_hex']
    # cat('          >', Couleur,'\n')
    fg_mercuriale(selected_produit(), selected_marche(), selected_lissage())
  })
  
}




