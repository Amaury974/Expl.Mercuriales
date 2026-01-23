# encoding UTF-8
# développé sous R 4.4.2
# dernière édition : décembre 2025
# auteur / contact : amaury.jorant@reunion.chambagri.fr
# __________
# 
# Projet : Shiny Mercuriales
#¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

ui <- fluidPage(
  
  sidebarLayout(
    
    #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
    #####                               SIDEBAR                              #####
    #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
    
    sidebarPanel(
      
      # ~~~~{    logo / nom appli    }~~~~
      tags$img(
        src = "CA_LA REUNION_H_CMJN.png",
        alt = "logo chambre d'agriculture de La Réunion",
        height = '90px'
        # style = 'position: absolute;
        # top: 0px; left: 50%;
        # transform: translate(-50%, -10%) ;
        # z-index: 9000; ',
        # height = '50px'
      ),
      
      tags$p(
        "> Expl. Mercuriales",
        style = "font-family: Lucida Console;
        font-size: 20px;"
        # style = 'position: absolute;
        # top: 40px; left: 50%;
        # transform: translate(-50%, 0%) ;
        # z-index: 9000;
        # font-family: Lucida Console;
        # font-size: 9px;'
      ),
      br(),
      
      radioButtons('type',
                   'Classe de produits',
                   inline = TRUE,
                   choices = c('Tout', 
                               'Fruits' = 'fruits',
                               'Légumes' = 'légumes',
                               'Viandes' = 'viandes',
                               'Œufs' = 'oeufs',
                               'Fleurs' = 'fleurs')),# unique(df_mercuriales$Type))),
      
      selectInput('produit',
                  'Produit',
                  choices = unique(df_mercuriales$Produit)
      ),
      
      checkboxGroupInput('marche',
                         'Marché',
                         choices = tout_marche,
                         selected = tout_marche
      ),
      
      shinyWidgets::switchInput('lissage', 'Courbe lissée'),  
      
      tags$div(style = "font-size: 0.85em;",
               tags$i(
                 "L'ensemble des données présentées dans cet outil sont issues des",
                 tags$a('Mercuriales', href = 'https://daaf.reunion.agriculture.gouv.fr/les-mercuriales-r49.html'),
                 "produites par l'Agreste (DAAF).",
                 br(),
                 "Seuls les produits d'origine réunionnaise ayant plus de 5 mesures sont montrés ici."),
      ),
    ),
    #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
    #####                             MAIN PAGE                            #####
    #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
    
    mainPanel(
      br(),br(),br(),
      
      plotOutput('g_mercuriale', height = '600px')
    ),
    
  ),
  #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
  #####                             BAS DE PAGE                            #####
  #  ¤¤¤¤¤¤¤¤¤¤                         ¤¤                         ¤¤¤¤¤¤¤¤¤¤  #
  # Espacement avant le footer
  br(),
  hr(),
  
  tags$div(
    style = "max-width: 1100px; margin: 0 auto; padding: 0 10px; font-size: 0.85em;",  # Réduit la taille de police de 15%
    
    h4("📧 Contacts"),
    fluidRow(
      column(4,
             tags$p(
               tags$strong("Développement et extraction des données"),
               tags$br(),
               "Amaury Jorant - Direction Prospective, Projets et Partenariats",
               tags$br(),
               "Email: ", tags$a("amaury.jorant@reunion.chambagri.fr",
                                 href = "mailto:amaury.jorant@reunion.chambagri.fr"),
               tags$br(),
               "Tél: +262 262 944 628"
             ),
      ),
      column(4,
             # tags$p(
             #   tags$strong("Référent des données"),
             #   tags$br(),
             #   '###### ##### - ###########################',
             #   tags$br(),
             #   "Email: ", tags$a("contact@reunion.chambagri.fr", 
             #                     href = "mailto:contact@reunion.chambagri.fr"),
             #   tags$br(),
             #   "Tél: +262 XXX XXX XXX "
             # ),
      ), 
      column(4,
             tags$img(
               src = "CA_LA REUNION_H_CMJN.png",
               alt = "logo chambre d'agriculture de La Réunion",
               style = 'transform: translate(0%, -20%)',
               height = '100px'
             ),
      )
    ),
  ),
  # Bas de page
  hr(style = "margin-top: 10px; margin-bottom: 5px;"),
  
  tags$div(
    style = "max-width: 1100px; margin: 0 auto; padding: 0 10px; font-size: 0.85em;",  # Réduit la taille de police de 15%
    
    tags$footer(
      style = "text-align: center; color: #666; padding: 5px;",
      tags$p(
        "© 2026 - Chambre d'Agriculture de La Réunion | ",
        "Version 1.0 | ",
        "Dernière mise à jour: Janvier 2026"
      )
    )
  )
  
  
)
