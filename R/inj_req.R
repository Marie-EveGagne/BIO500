#etape 3 -> Connection au SQL, creations des matrices SQL et injection des donnees 



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

dbSendQuery(con, tbl_cours)
dbSendQuery(con, tbl_etudiant)
dbSendQuery(con, tbl_collaboration)

dbWriteTable(con, append = TRUE, name = "tbl_cours", value = cours, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_collaboration", value = Collab_corr, row.names = FALSE)

#Répondre aux questions pour le cours de BIO500 et enregistrer les reponses dans un csv

sql_requete1 <- "
SELECT etudiant1, count(etudiant2)
AS nb_collab
FROM tbl_collaboration
GROUP BY etudiant1;"

resultats_collab1 <- dbGetQuery(con, sql_requete1)
resultats_collab1
write.csv(resultats_collab1, '/resultatscollab1.csv', row.names=FALSE)

sql_requete2 <- "
SELECT etudiant1, etudiant2, COUNT(sigle)
FROM tbl_collaboration
GROUP BY etudiant1, etudiant2;"
lien_paire_etudiants <- dbGetQuery(con, sql_requete2)
head(lien_paire_etudiants)

resultats_collab2 <- dbGetQuery(con, sql_requete2)
resultats_collab2
write.csv(resultats_collab2, '/resultats.csv', row.names=FALSE)