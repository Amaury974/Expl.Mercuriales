



packages <- c('shiny','ggplot2','dplyr','shinyWidgets','RColorBrewer')
packages_manquants <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(packages_manquants) > 0) {
  install.packages(packages_manquants)
}