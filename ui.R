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
      # tags$img(
      #   src = "CA_LA REUNION_H_CMJN.png",
      #   alt = "logo chambre d'agriculture de La Réunion",
      #   height = '90px'
      #   # style = 'position: absolute;
      #   # top: 0px; left: 50%;
      #   # transform: translate(-50%, -10%) ;
      #   # z-index: 9000; ',
      #   # height = '50px'
      # ),      
      tags$img(
        src = "des-legumes.png",
        alt = "image cageot de légumes",
        height = '90px',
        style= 'display: block;
  margin-left: auto;
  margin-right: auto;'
        # style = 'position: absolute;
        # top: 0px; left: 50%;
        # transform: translate(-50%, -10%) ;
        # z-index: 9000; ',
        # height = '50px'
      ),
      
      
      tags$p(
        "> Expl. Mercuriales",
        style = "font-family: Lucida Console;
        font-size: 20px;
        text-align: center;"
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
                 #            "L'ensemble des données présentées dans cet outil sont issues des",
                 #            tags$a('Mercuriales', href = 'https://daaf.reunion.agriculture.gouv.fr/les-mercuriales-r49.html'),
                 #            "produites par l'Agreste (DAAF).",
                 #            br(),
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
    
    
    fluidRow(
      column(4,
             tags$img(
               src = "CA_LA REUNION_H_CMJN.png",
               alt = "logo chambre d'agriculture de La Réunion",
               # style = 'transform: translate(0%, -20%)',
               height = '100px'
             ),
      ),
      
      column(4,
             h4("📞 Contacts"),
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
             h4("🗃️️ Données"),
             tags$p(#style = "magin-bottom: 0",
               tags$strong(tags$a('Mercuriales', href = 'https://daaf.reunion.agriculture.gouv.fr/les-mercuriales-r49.html')),
               tags$br(), "Agreste (DAAF)",
             # ),
              tags$small(style="line-height: 1; display: block; margin-top: -1em;",
                      tags$br(),"Service de l'Information Statistique et Economique",
                      tags$br(), "Unité Conjoncture et mercuriales"),

             )
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
