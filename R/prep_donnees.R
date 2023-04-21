#etape 1 : importer les données

prep_collab = function(data_collab){
  
  fichiers<- c(data_collab)
  
  collaboration_1 <- read.table(fichiers[1], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_2 <- read.table(fichiers[4], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_3 <- read.table(fichiers[7], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_4 <- read.table(fichiers[10], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_5 <- read.table(fichiers[13], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_6 <- read.table(fichiers[16], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_7 <- read.table(fichiers[19], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_8 <- read.table(fichiers[22], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  collaboration_9 <- read.table(fichiers[25], header=TRUE, sep = ',', stringsAsFactors = FALSE)
  collaboration_10 <- read.table(fichiers[28], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  
  collaboration_7 <- collaboration_7[c('etudiant1', 'etudiant2', 'sigle', 'session')]

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
  
  collaboration <- rbind(collaboration_1, collaboration_2, collaboration_3, collaboration_4, collaboration_5, collaboration_6, collaboration_7, collaboration_8, collaboration_9, collaboration_10)
  
  collaboration <- collaboration[!duplicated(collaboration), ]
  
}

prep_cours = function(data_cours){
  
  fichiers<- c(data_cours)
  
  cours_1 <- read.table(fichiers[2], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_2 <- read.table(fichiers[5], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_3 <- read.table(fichiers[8], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_4 <- read.table(fichiers[11], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_5 <- read.table(fichiers[14], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_6 <- read.table(fichiers[17], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_7 <- read.table(fichiers[20], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_8 <- read.table(fichiers[23], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  cours_9 <- read.table(fichiers[26], header=TRUE, sep = ',', stringsAsFactors = FALSE)
  cours_10 <- read.table(fichiers[29], header=TRUE, sep = ';', stringsAsFactors = FALSE)
  

  cours_5 <- cours_5[c('sigle', 'optionnel', 'credits')]
  cours_5 <-na.omit(cours_5)
  cours_7 <- cours_7[c('sigle', 'optionnel', 'credits')]
  cours_7 <- na.omit(cours_7)
  cours_6 <- na.omit(cours_6)
  cours_10 <- na.omit(cours_10)
  
  cours <- rbind(cours_1, cours_2, cours_3, cours_4, cours_5, cours_6, cours_7, cours_8, cours_9, cours_10)
  
  cours <- cours[!duplicated(cours), ]

}

prep_etudiants = function(data_etudiant){
  
  fichiers<- c(data_etudiant)

etudiant_1 <- read.table(fichiers[3], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_2 <- read.table(fichiers[6], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_3 <- read.table(fichiers[9], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_4 <- read.table(fichiers[12], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_5 <- read.table(fichiers[15], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_6 <- read.table(fichiers[18], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_7 <- read.table(fichiers[21], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_8 <- read.table(fichiers[24], header=TRUE, sep = ';', stringsAsFactors = FALSE)
etudiant_9 <- read.table(fichiers[27], header=TRUE, sep = ',', stringsAsFactors = FALSE)
etudiant_10 <- read.table(fichiers[30], header=TRUE, sep = ';', stringsAsFactors = FALSE)

etudiant_3 <- etudiant_3[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_3[etudiant_3==""] <- NA
etudiant_6[etudiant_6==""] <- NA
etudiant_6 <- etudiant_6[apply(etudiant_6, 1, function(y) !all(is.na(y))),]
colnames(etudiant_4) <- c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')
etudiant_4 <- etudiant_4[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_7 <- etudiant_7[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]
etudiant_9 <- etudiant_9[c('prenom_nom', 'prenom', 'nom', 'region_administrative', 'regime_coop', 'formation_prealable', 'annee_debut', 'programme')]

etudiant <- rbind(etudiant_1, etudiant_2, etudiant_3, etudiant_4, etudiant_5, etudiant_6, etudiant_7, etudiant_8, etudiant_9, etudiant_10)

}
 
correction = function(donnees_BIO500){
  
  header <- tail(donnees_BIO500)
  
  print(header)
  
}

