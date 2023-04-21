install.packages('RSQLite', dependencies=TRUE)
install.packages('stringr', dependencies=TRUE)
install.packages('dplyr', dependencies=TRUE)
install.packages('data.table', dependencies=TRUE)
install.packages('stringdist', dependencies=TRUE)
install.packages('igraph')
install.packages("RColorBrewer")
library(RSQLite)
library(stringr)
library(dplyr)
library(data.table)
library(stringdist)
library(igraph)
library(RColorBrewer)

setwd('C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/BIO500')

#importer les données

allFiles <- dir('donnees_BIO500')

tabNames <- c('collaboration', 'cours', 'etudiant')

nbGroupe <- length(grep(tabNames[1], allFiles))

for(tab in tabNames) {
  tabFiles <- allFiles[grep(tab, allFiles)]
  
  for(groupe in 1:nbGroupe) {
   
    tabName <- paste0(tab, "_", groupe)
    
    fichier <- paste0('donnees_BIO500/', tabFiles[groupe])
    L <- readLines(fichier, n = 1)
    separateur <- ifelse(grepl(';', L), ';', ',')
    
    assign(tabName, read.table(fichier, header=TRUE, sep = separateur, stringsAsFactors = FALSE))
      
  }
}

rm(list = c('allFiles', 'tab', 'tabFiles', 'tabName','tabNames', 'fichier', 'groupe','L','nbGroupe','separateur'))

#Correction des erreurs dans les matrices

collaboration_7 <- collaboration_7[c('etudiant1', 'etudiant2', 'sigle', 'session')]

colnames(cours_4) <- c('sigle', 'optionnel', 'credits')

cours_5 <- cours_5[c('sigle', 'optionnel', 'credits')]
cours_5 <-na.omit(cours_5)
cours_7 <- cours_7[c('sigle', 'optionnel', 'credits')]
cours_7 <- na.omit(cours_7)
cours_6 <- na.omit(cours_6)
cours_10 <- na.omit(cours_10)

for (i in 1:nrow(collaboration_9)) {
    collaboration_9[i,3][collaboration_9[i,3]=="BIO400"] <- "BOT400"
}

for (i in 1:nrow(collaboration_4)) {
    collaboration_4[i,3][collaboration_4[i,3]==""] <- "ECL615"
    collaboration_4[i,4][collaboration_4[i,4]==""] <- "E2022"
}
collaboration_4[collaboration_4==""] <- NA
collaboration_4 <- na.omit(collaboration_4)
collaboration_5[collaboration_5==""] <- NA
collaboration_5 <- na.omit(collaboration_5)

etudiant_3 <- etudiant_3[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_3[etudiant_3==""] <- NA
etudiant_6[etudiant_6==""] <- NA
etudiant_6 <- etudiant_6[apply(etudiant_6, 1, function(y) !all(is.na(y))),]
colnames(etudiant_4) <- c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')
etudiant_4 <- etudiant_4[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_7 <- etudiant_7[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_9 <- etudiant_9[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]

#Merger les differentes matrices dans 3 fichiers et sauvegarder

cours <- rbind(cours_1, cours_2, cours_3, cours_4, cours_5, cours_6, cours_7, cours_8, cours_9, cours_10)
etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)
collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)

#retrait des objets qui ne sont plus utililises

rm(etudiant_1,etudiant_10,etudiant_2,etudiant_3,etudiant_4,etudiant_5,etudiant_6,etudiant_7,etudiant_8,etudiant_9)
rm(collaboration_1,collaboration_10,collaboration_2,collaboration_3,collaboration_4,collaboration_5,collaboration_6,collaboration_7,collaboration_8,collaboration_9)
rm(cours_1,cours_10,cours_2,cours_3,cours_4,cours_5,cours_6,cours_7,cours_8,cours_9)

#Correction des noms mal ecrits dans etudiant

for (i in 1:nrow(etudiant)) {
  etudiant[i,2] <- str_replace(etudiant[i,2],'_','-')
  etudiant[i,3] <- str_replace(etudiant[i,3],'_','-')
  etudiant[i,1] <- paste0(etudiant[i,2],"_",etudiant[i,3])
}

etudiant <- etudiant[order(etudiant$prenom_nom),]

for (i in 1:nrow(etudiant)) {
  if(etudiant[i,1]=='arianne_barette'){
  etudiant[i,1] <- str_replace(etudiant[i,1],'arianne_barette','ariane_barrette')
  etudiant[i,2] <- str_replace(etudiant[i,2],'arianne','ariane')
  etudiant[i,3] <- str_replace(etudiant[i,3],'barette','barrette')
  }
  else if (etudiant[i,1]=='cassandra_gobin'){
  etudiant[i,1] <- str_replace(etudiant[i,1],'cassandra_gobin','cassandra_godin')
  etudiant[i,3] <- str_replace(etudiant[i,3],'gobin','godin')
  }
  else if (etudiant[i,1]=='cassandre_godin'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'cassandre_godin','cassandra_godin')
    etudiant[i,3] <- str_replace(etudiant[i,2],'cassandre','cassandra')
  }
  else if (etudiant[i,1]=='edouard_nadon-baumier'){
  etudiant[i,1] <- str_replace(etudiant[i,1],'edouard_nadon-baumier','edouard_nadon-beaumier')
  etudiant[i,3] <- str_replace(etudiant[i,3],'nadon-baumier','nadon-beaumier')
  }
  else if (etudiant[i,1]=='francis_bolly'){
  etudiant[i,1] <- str_replace(etudiant[i,1],'francis_bolly','francis_boily')
  etudiant[i,3] <- str_replace(etudiant[i,3],'bolly','boily')
  }
  else if (etudiant[i,1]=='louis-philipe_theriault'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'louis-philipe_theriault','louis-philippe_theriault')
    etudiant[i,2] <- str_replace(etudiant[i,2],'louis-philipe','louis-philippe')
  }
  else if (etudiant[i,1]=='louis-philippe_therrien'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'louis-philippe_therrien','louis-philippe_theriault')
    etudiant[i,3] <- str_replace(etudiant[i,3],'therrien','theriault')  
  }
  else if (etudiant[i,1]=='louis-phillipe_theriault'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'louis-phillipe_theriault','louis-philippe_theriault')
    etudiant[i,2] <- str_replace(etudiant[i,2],'louis-phillipe','louis-philippe')
  }
  else if (etudiant[i,1]=='mael_guerin'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'mael_guerin','mael_gerin')
    etudiant[i,3] <- str_replace(etudiant[i,3],'guerin','gerin')  
  }
  else if (etudiant[i,1]=='marie_burghin'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'marie_burghin','marie_bughin')
    etudiant[i,3] <- str_replace(etudiant[i,3],'burghin','bughin')
  }
  else if (etudiant[i,1]=='peneloppe_robert'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'peneloppe_robert','penelope_robert')
    etudiant[i,2] <- str_replace(etudiant[i,2],'peneloppe','penelope')
  }
  else if (etudiant[i,1]=='sabrina_leclerc'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'sabrina_leclerc','sabrina_leclercq')
    etudiant[i,3] <- str_replace(etudiant[i,3],'leclerc','leclercq')
  }
  else if (etudiant[i,1]=='sabrina_leclerc'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'sabrina_leclerc','sabrina_leclercq')
    etudiant[i,3] <- str_replace(etudiant[i,3],'leclerc','leclercq')
  }
  else if (etudiant[i,1]=='simon_guilemette'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'simon_guilemette','simon_guillemette')
    etudiant[i,3] <- str_replace(etudiant[i,3],'guilemette','guillemette')
  }
  else if (etudiant[i,1]=='thomas_ramond'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'thomas_ramond','thomas_raymond')
    etudiant[i,3] <- str_replace(etudiant[i,3],'ramond','raymond')
  }
  else if (etudiant[i,1]=='yannick_sageau'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'yannick_sageau','yanick_sageau')
    etudiant[i,2] <- str_replace(etudiant[i,2],'yannick','yanick')
  }
  else if (etudiant[i,1]=='yanick_sagneau'){
    etudiant[i,1] <- str_replace(etudiant[i,1],'yanick_sagneau','yanick_sageau')
    etudiant[i,3] <- str_replace(etudiant[i,3],'sagneau','sageau')
  }
}

etudiant <- etudiant[!duplicated(etudiant), ]

#Retrait des etudiants en double avec des NAs

sommeNAs <- rowSums(is.na(etudiant))
etudiant <- cbind(etudiant,sommeNAs)

nb_lignes <- nrow(etudiant)


for (i in 1:nb_lignes) {
  for (j in 2:nb_lignes) {
    if(etudiant[i,1]==etudiant[j,1] && etudiant[i,9]>etudiant[j,9]){
      etudiant <- etudiant[-c(i), ]
      nb_lignes <- nrow(etudiant)
    }

    else if(etudiant[i,1]==etudiant[j,1] && etudiant[i,9]<etudiant[j,9]){
      etudiant <- etudiant[-c(j), ]
      nb_lignes <- nrow(etudiant)
    }
    i=i+1
  }
}


#Trouver l'indexation des noms en double non corrigés par la boucle


agrep('cassandra_godin', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('juliette_meilleur', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('mia_carriere', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('rosalie_gagnon', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('yanick_sageau', etudiant$prenom_nom, max.distance = 1, value = FALSE)


etudiant <- etudiant[-c(30,85,119,121,136,161),]
etudiant <- etudiant[,-c(9)]

cours <- cours[!duplicated(cours), ]
collaboration <- collaboration[!duplicated(collaboration), ]

#Correction des noms mal ecrits dans collaboration

Collab_corr <- collaboration

for (i in 1:nrow(etudiant)) {
  differences1 <- agrep(etudiant[i,1], Collab_corr$etudiant1, max.distance = 5, value = FALSE)
  differences2 <- agrep(etudiant[i,1], Collab_corr$etudiant2, max.distance = 5, value = FALSE)
  for (j in 1:length(differences1)) {
    Collab_corr[differences1[j],1] <- paste0(etudiant[i,1])
  }
  for (k in 1:length(differences2)) {
    Collab_corr[differences2[k],2] <- paste0(etudiant[i,1])
  }
}

Collab_corr <- Collab_corr[!duplicated(Collab_corr), ]

rm(collaboration)

write.csv(cours, 'BIO500/merge_cours.csv', row.names=FALSE)
write.csv(etudiant, 'BIO500/merge_etudiant.csv', row.names=FALSE)
write.csv(Collab_corr, 'BIO500/merge_collaboration.csv', row.names=FALSE)


#Connection au SQL, creations des matrices SQL et injection des donnees 

con <- dbConnect(SQLite(), dbname="collab.db")

tbl_etudiant <- "CREATE TABLE etudiant (
prenom_nom              VARCHAR(40),
prenom                  VARCHAR(25),
nom                     VARCHAR(30),
region_administrative   VARCHAR(20),
regime_coop             BOLEAN(4),
formation_prealable     VARCHAR(20),
annee_debut             VARCHAR(5),
programme               INTEGER(6),
PRIMARY KEY (prenom_nom)
);"

tbl_cours <- "CREATE TABLE cours (
sigle     VARCHAR(10) NOT NULL,
optionnel BOLEAN(4) NOT NULL,
credits   INTEGER(1),
PRIMARY KEY (sigle, optionnel)
);"

tbl_collaboration <- "CREATE TABLE collaboration (
etudiant1   VARCHAR(40),
etudiant2   VARCHAR(40),
sigle       VARCHAR(10),
session     VARCHAR(5),
PRIMARY KEY (etudiant1, etudiant2, sigle),
FOREIGN KEY (etudiant1)          REFERENCES tbl_etudiant(prenom_nom),
FOREIGN KEY (etudiant2)          REFERENCES tbl_etudiant(prenom_nom),
FOREIGN KEY (sigle, session)     REFERENCES tbl_cours(sigle, session)
);"

dbSendQuery(con, tbl_etudiant)
dbSendQuery(con, tbl_cours)
dbSendQuery(con, tbl_collaboration)

dbWriteTable(con, append = TRUE, name = "tbl_cours", value = cours, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_collaboration", value = Collab_corr, row.names = FALSE)

#Répondre aux questions pour le cours de BIO500 et enregistrer les reponses dans un csv

sql_requete1 <- "SELECT etudiant1, count(etudiant2)
                AS nb_collab
                FROM tbl_collaboration
                GROUP BY etudiant1;"
resultats_collab1 <- dbGetQuery(con, sql_requete1)
resultats_collab1
write.csv(resultats_collab1, 'C:/Users/Marie-Eve/OneDrive - USherbrooke/Bureau/UdeS/methode_comp/travail_collab/resultats.csv', row.names=FALSE)

rm(sql_requete2)

#sql_requete2 <- "SELECT sigle, session, count(tbl_cours.sigle)
#                 AS nb_collab
 #                FROM tbl_collaboration
  #               GROUP BY tbl_collaboration.etudiant1, tbl_collaboration.etudiant2;"
sql_requete2 <-"SELECT etudiant1, etudiant2, sigle, count(tbl_collaboration.sigle)
                 AS nb_collab
                 FROM tbl_collaboration
                 GROUP BY tbl_collaboration.sigle;"                
#LEFT JOIN tbl_cours ON tbl_collaboration.sigle=tbl_cours.sigle;"
resultats_collab2 <- dbGetQuery(con, sql_requete2)
resultats_collab2
write.csv(resultats_collab2, 'C:/Users/Daphnee/Documents/BIO500/resultats.csv', row.names=FALSE)

##selection requete2_test3
sql_requete2 <- "
SELECT etudiant1, etudiant2, COUNT(sigle)
FROM collaboration
GROUP BY etudiant1, etudiant2;"
lien_paire_etudiants <- dbGetQuery(con, sql_requete2)
head(lien_paire_etudiants)

<<<<<<< HEAD
<<<<<<< HEAD
#sélection du programme des étudiants du fichier "étudiants" et insertions de la colonne dans le fichier "collaboration" pour étudiant1 et étudiant2

sql_requete4 <- "
  SELECT tbl_etudiant.prenom_nom, tbl_collaboration.etudiant1, tbl_etudiant.programme
  FROM tbl_collaboration
  LEFT JOIN tbl_etudiant
  ON tbl_etudiant.prenom_nom = tbl_collaboration.etudiant1;"

etudiant_prog <- dbGetQuery(con, sql_requete4)
head(etudiant_prog)

tbl_prog <- "CREATE TABLE etudiant_prog (
prenom_nom    VARCHAR(40) NOT NULL,
etudiant1     VARCHAR(40) NOT NULL,
programme     VARCHAR(6),
PRIMARY KEY (prenom_nom)
);"

dbSendQuery(con, "DROP TABLE etudiant_prog;")
dbSendQuery(con, tbl_prog)
dbWriteTable(con, append = TRUE, name = "tbl_prog", value = etudiant_prog, row.names = FALSE)

sql_requete5 <- "
  SELECT tbl_etudiant.prenom_nom, tbl_collaboration.etudiant2, tbl_etudiant.programme
  FROM tbl_collaboration
  LEFT JOIN tbl_etudiant
  ON tbl_etudiant.prenom_nom = tbl_collaboration.etudiant2;"

sql_requete5 <- "
  SELECT tbl_prog.*, tbl_collaboration.etudiant2, tbl_etudiant.programme
  FROM tbl_collaboration
  LEFT JOIN tbl_etudiant
    ON tbl_etudiant.prenom_nom = tbl_collaboration.etudiant2
  LEFT JOIN tbl_collaboration
    ON tbl_etudiant.prenom_nom = tbl_collaboration.etudiant2
  ;"

etudiant_prog2 <- dbGetQuery(con, sql_requete5)
head(etudiant_prog2)

tbl_prog2 <- "CREATE TABLE etudiant_prog2 (
prenom_nom     VARCHAR(40) NOT NULL,
etudiant2     VARCHAR(40) NOT NULL,
programme     VARCHAR(6),
PRIMARY KEY (prenom_nom)
);"

dbSendQuery(con, tbl_prog2)
dbWriteTable(con, append = TRUE, name = "tbl_prog2", value = etudiant_prog2, row.names = FALSE)

sql_requete6 <- "
  SELECT tbl_prog.*, tbl_prog2.*
  FROM   tbl_prog
  LEFT JOIN tbl_prog2 USING (prenom_nom)
  UNION ALL
  SELECT tbl_prog.*, tbl_prog2.*
FROM tbl_prog
LEFT JOIN tbl_prog2 USING(prenom_nom)
;"

programme <- dbSendQuery(con, sql_requete6)

dbListTables(con)

resultats_collab2 <- dbGetQuery(con, sql_requete2)
resultats_collab2
write.csv(resultats_collab2, '/resultats.csv', row.names=FALSE)

=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
#Deconnexion du SQL
dbDisconnect(con)

#igraph
<<<<<<< HEAD
<<<<<<< HEAD
interaction_df <- data.frame(etudiantA = Collab_corr$etudiant1, etudiantB = Collab_corr$etudiant2, stringsAsFactors = TRUE)
interaction_ig <- graph.data.frame(interaction_df,directed = T)
V(interaction_ig)$label <- NA
nom <- etudiant[ ,1]
programme <- etudiant[ ,8]
programme[is.na(programme)] <- 0

color.vec <- rainbow(n = length(programme))
V(interaction_ig)$color <- color.vec

length(programme)

kamada_layout <- layout.kamada.kawai(interaction_ig)
plot(interaction_ig, 
     layout = kamada_layout,
     vertex.size = 14,
=======
interaction_df <- data.frame(etudiantA = collaboration$etudiant1, etudiantB = collaboration$etudiant2, stringsAsFactors = F)
interaction_ig <- graph.edgelist(interaction_matrice , directed=T)
etudiant_df <- data.frame(etudiant = etudiant$prenom_nom, prog = etudiant$programme)

color_map <- c('269000' = 'red', '205000' = 'blue', '267000' = 'green', '224000' = 'yellow', 'NA' = 'gray')
V(interaction_ig)$color <- 'white'
for (i in 1:nrow(etudiant_df)) {
  node_id <- etudiant_df[i, 'prenom_nom']
  attribute <- etudiant_df[i, 'programme']
  color <- color_map[attribute]
  V(interaction_ig)$color[node_id] <- color
}

plot(interaction_ig, 
     layout = kamada_layout, 
     vertex.size = 16,
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
=======
interaction_df <- data.frame(etudiantA = collaboration$etudiant1, etudiantB = collaboration$etudiant2, stringsAsFactors = F)
interaction_ig <- graph.edgelist(interaction_matrice , directed=T)
etudiant_df <- data.frame(etudiant = etudiant$prenom_nom, prog = etudiant$programme)

color_map <- c('269000' = 'red', '205000' = 'blue', '267000' = 'green', '224000' = 'yellow', 'NA' = 'gray')
V(interaction_ig)$color <- 'white'
for (i in 1:nrow(etudiant_df)) {
  node_id <- etudiant_df[i, 'prenom_nom']
  attribute <- etudiant_df[i, 'programme']
  color <- color_map[attribute]
  V(interaction_ig)$color[node_id] <- color
}

plot(interaction_ig, 
     layout = kamada_layout, 
     vertex.size = 16,
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
     vertex.frame.color = NA,
     vertex.label = NA,
     vertex.label.cex = 1.2,
     edge.curved = .2,
     edge.arrow.size = .1,
     edge.width = 1)
<<<<<<< HEAD
<<<<<<< HEAD
interaction.g <- graph.data.frame(Collab_corr, directed = T)
V(interaction.g)$label <- NA
pal <- rainbow(n=length(unique(interaction.g$affilation)))
oneAffil <- interaction.g$affilation[!duplicated(interaction.g$vertex)]
V(interaction.g)$color <- pal[oneAffil]
plot(interaction.g)
=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df

#Figure 3
collab_etudiant <- read.csv2("arbres.csv")
paires <- table(collab_etudiant[,c(3,5)])
frequence <- as.numeric(row.names(paires))
plot(frequence, paires[,1], axes =TRUE,
     xlab = "Fréquence", ylab = "Nb paires différentes qui ont collaboré ensemble")
title(main = "Fréquence de collaboration des étudiants en fonction du nombre de paires différentes qui ont collaboré ensemble")
usethis::git_sitrep()
<<<<<<< HEAD
<<<<<<< HEAD

tar_visnetwork()
=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
=======
>>>>>>> 63793a0f65ac149ddc789ed2254544f0edb1a5df
