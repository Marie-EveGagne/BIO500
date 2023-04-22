library(targets)
library(usethis)
library(purrr)
library(RSQLite)
library(stringr)
library(dplyr)
library(data.table)
library(stringdist)
library(igraph)
library(RColorBrewer)


setwd("C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500")

source("R/prep_donnees.R")
source("R/correction.R")
source("R/injection.R")
tar_option_set(packages = c("RSQLite", 'stringr','dplyr','data.table','stringdist','igraph','purrr'))

list(
   tar_target(
    name = path,
    command = "./donnees_BIO500",
    format = "file"
   ),
   tar_target(
     name = file_paths,
     command = list.files(path, full.names = TRUE)
   ),
   tar_target(
     data_collab,
     prep_collab(file_paths),
   ),
   tar_target(
     data_cours,
     prep_cours(file_paths)
   ),
   tar_target(
     data_etudiant,
     prep_etudiants(file_paths)
   ),
   tar_target(
     etudiant_clean,
     corr_etd(data_etudiant)
   ),
   tar_target(
     collab_clean,
     corr_collab(data_collab)
   ),
   tar_target(
     sql,
     tables_sql(collab_clean)
#   ),
#   tar_target(
#     injection,
#     inject(collab_clean)
   ))   
#   tar_target(
#     name = graphique,
#     command = tbl_fig(SQL)
#   ),
# )
#))
























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

