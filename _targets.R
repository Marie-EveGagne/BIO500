<<<<<<< HEAD
install.packages('targets')
install.packages('usethis')

library(targets)
library(usethis)

setwd("C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500")

source("prep_donnees")
source("correction")
=======
library(targets)
library(usethis)

source("R/prep_donnees.R")
source("R/correction.R")
>>>>>>> f91aefd8720c1290eef0766084cb71d09730e3b8
tar_option_set(packages = c("RSQLite", 'stringr','dplyr','data.table','stringdist','igraph'))
list(
  tar_target(
    name = path,
<<<<<<< HEAD
    command = "/donnees_BIO500",
    format = "file"
  ),
  tar_target(
    name = file_paths,
    command = list.files(path, full.names = TRUE)
  ),
  tar_target(
    name = data,
    command = prep_donnees(file_paths)
  ),
  tar_target(
    name = donnees_BIO500,
    command = correction(data)
  ),
  tar_target(
    name = SQL,
    command = inj_req(donnees_BIO500)
  ),
  tar_target(
    name = graphique,
    command = tbl_fig(SQL)
  ),
)
=======
    command = "./donnees_BIO500",
    format = "file"
  ),
   tar_target(
     name = file_paths,
     command = list.files(path, full.names = TRUE)
   ),
   tar_target(
     name = data_collab,
     command = prep_collab(file_paths)
  ),
   tar_target(
     name = data_cours,
     command = prep_cours(file_paths)
   ),
   tar_target(
     name = data_etudiant,
     command = prep_etudiants(file_paths)
   ),
   tar_target(
     name = etudiant_clean,
     command = corr_etd(data_etudiant)
   ),
   tar_target(
     name = collab_clean,
     command = corr_collab(data_collab)
   ))
#   tar_target(
#     name = SQL,
#     command = inj_req(donnees_BIO500)
#   ),
#   tar_target(
#     name = graphique,
#     command = tbl_fig(SQL)
#   ),
# )
























# library(targets)
# library(usethis)
# 
# # setwd("C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500")
# 
# source("R/prep_donnees.R")
# # source("R/correction")
# tar_option_set(packages = c("RSQLite", 'stringr','dplyr','data.table','stringdist','igraph'))
# list(
#   tar_target(
#     name = path,
#     command = "/donnees_BIO500",
#     format = "file"
#   ),
#   tar_target(
#     name = file_paths,
#     command = list.files(path, full.names = TRUE)
#   ),
#   tar_target(
#     name = data,
#     command = prep_donnees(file_paths)
#   )
# )
>>>>>>> f91aefd8720c1290eef0766084cb71d09730e3b8

