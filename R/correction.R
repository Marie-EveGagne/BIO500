#etape 2 -> Correction des erreurs dans les matrices

#Corrections des noms mal ecrits dans etudiant

corr_etd = function(data_etudiant){
   
   etudiant <- data_etudiant
   

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

retirer_lignes <- c()
n=1

for (i in 1:nrow(etudiant)) {
   for (j in 2:nrow(etudiant)) {
      if(etudiant[i,1]==etudiant[j,1] && etudiant[i,9]>etudiant[j,9]){
         #etudiant <- etudiant[-c(i), ]
         #nb_lignes <- nrow(etudiant)
         retirer_lignes[n] <- paste0(row.names(etudiant[i,]))
         n=n+1
         #print(etudiant[i,])
         #print(i)
      }
      
      else if(etudiant[i,1]==etudiant[j,1] && etudiant[i,9]<etudiant[j,9]){
         #etudiant <- etudiant[-c(j), ]
         #nb_lignes <- nrow(etudiant)
         retirer_lignes[n] <- paste0(row.names(etudiant[j,]))
         #print('c,est encore good')
         #print(etudiant[j,])
         n=n+1
      }
   }
}

retirer_lignes <- retirer_lignes[!duplicated(retirer_lignes)]

etudiant <- etudiant[!(row.names(etudiant) %in% retirer_lignes),]


#Trouver l'indexation des noms en double non corrigés par la boucle

agrep('cassandra_godin', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('juliette_meilleur', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('mia_carriere', etudiant$prenom_nom, max.distance = 1, value = FALSE)
agrep('rosalie_gagnon', etudiant$prenom_nom, max.distance = 1, value = FALSE)

etudiant[118,1] <- paste0('mia_carriere')
etudiant[118,3] <- paste0('carriere')

etudiant <- etudiant[-c(30,85,119,134,136,164,166),]
etudiant <- etudiant[,-c(9)]

path_as_csv <-  file.path(getwd(),"etudiant.csv")

write.csv(etudiant, file=path_as_csv, row.names=FALSE)

}

corr_collab = function(data_collab){
   
   Collab_corr <- data_collab
   etudiant <- read.table('etudiant.csv', header=TRUE, sep = ',', stringsAsFactors = FALSE)
   
#Correction des noms mal ecrits dans collaboration


 for (i in 1:nrow(etudiant)) {
    differences1 <- agrep(etudiant[i,1], Collab_corr$etudiant1, max.distance = 2, value = FALSE)
    differences2 <- agrep(etudiant[i,1], Collab_corr$etudiant2, max.distance = 2, value = FALSE)
    if(is_empty(differences1)==FALSE){
       for (j in 1:length(differences1)) {
          Collab_corr[differences1[j],1] <- paste0(etudiant[i,1])
       }
    }
    if(is_empty(differences2)==FALSE){
       for (k in 1:length(differences2)) {
          Collab_corr[differences2[k],2] <- paste0(etudiant[i,1])
       }
       i=i+1
    }
 }

Collab_corr <- Collab_corr[!duplicated(Collab_corr), ]
   
path_csv <-  file.path(getwd(),"collaboration.csv")

print(path_csv )

write.csv(Collab_corr, file=path_csv, row.names=FALSE)

}

#write.csv(cours, 'BIO500/merge_cours.csv', row.names=FALSE)
#write.csv(etudiant, '/BIO500/merge_etudiant.csv', row.names=FALSE)
#write.csv(Collab_corr, '/BIO500/merge_collaboration.csv', row.names=FALSE)