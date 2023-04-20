install.packages('targets')
install.packages('usethis')

library(targets)
library(usethis)

setwd("C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500")

source("/BIO500")
tar_option_set(packages = c("RSQLite", 'stringr','dplyr','data.table','stringdist','igraph'))
list(
  tar_target(
    name = path,
    command = "/donnees_BIO500",
    format = "file"
  ),
  tar_target(
    name = file_paths,
    command = list.files(path, full.names = TRUE)
  )
#  tar_target(
#    name = data, # Cible pour le modèle
#    command = prep_donnees(file_paths) # Jointure des jeux de données
#  ),
)




#J'ai l'impression qu'il faut faire 1 fichier .R par étape pour chaque target afin de mettre chacune des targets dans le pipeline

