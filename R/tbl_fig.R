#etape 4 -> figures - tableaux

#igraph

igraph = function(injection){

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

}

#Figure 3

graph = function(injection){

data <- read.csv("/resultats/resultats2.csv")

# Calcul du nombre de collaborations par paire d'étudiants
pairs <- data %>%
        count(etudiant1, etudiant2, name = "freq") %>%
        arrange(desc(freq))
        
# Plot des données
ggplot(pairs, aes(x = freq)) +
        geom_bar(stat = "count", fill = "steelblue") +
        scale_x_continuous(breaks = seq(0, max(pairs$freq), by = 2)) +
        xlab("Nombre de collaborations") +
        ylab("Nombre de paires d'étudiants") +
        ggtitle("Fréquence qu'une paire d'étudiant va travailler ensemble")
        
# Nombre de paires ayant travaillé ensemble deux fois
n_pairs_2 <- nrow(filter(data, nb_collab == 2))
cat("Nombre de paires ayant travaillé ensemble deux fois : ", n_pairs_2, "\n")
}      