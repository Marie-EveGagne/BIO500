#etape 4 -> figures - tableaux

#igraph
interaction_df <- data.frame(etudiantA = collaboration$etudiant1, etudiantB = collaboration$etudiant2, stringsAsFactors = TRUE)
interaction_matrice <- as.matrix(interaction_df)
interaction_ig <- graph.edgelist(interaction_matrice , directed=TRUE)
kamada_layout <- layout.kamada.kawai(interaction_ig)
plot(interaction_ig, 
     layout = kamada_layout, 
     vertex.size = 14,
     vertex.color = "red",
     vertex.frame.color = NA,
     vertex.label.cex = 1.2,
     edge.curved = .2,
     edge.arrow.size = .3,
     edge.width = 1)

interaction <- matrix(nrow = 395, ncol = 395) 
colnames(interaction) <- as.character(etudiant[,1])
rownames(interaction) <- as.character(etudiant[,1])

#Figure 3
collab_etudiant <- read.csv2("arbres.csv")
paires <- table(collab_etudiant[,c(3,5)])
frequence <- as.numeric(row.names(paires))
plot(frequence, paires[,1], axes =TRUE,
     xlab = "Fréquence", ylab = "Nb paires différentes qui ont collaboré ensemble")
title(main = "Fréquence de collaboration des étudiants en fonction du nombre de paires différentes qui ont collaboré ensemble")
usethis::git_sitrep()