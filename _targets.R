install.packages('targets')
install.packages('usethis')

library(targets)
library(usethis)

setwd("C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500")

source("prep_donnees")
source("correction")
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

