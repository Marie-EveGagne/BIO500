#etape 3 -> Connection au SQL, creations des matrices SQL et injection des donnees 

tables_sql = function(collab_clean){

con <- dbConnect(SQLite(), dbname="collab.db")

drop <- "DROP TABLE IF EXISTS cours, etudiant, collaboration ;"
flush <- "FLUSH TABLES cours, etudiant, collaboration ;" 

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


# le code pour cette partie bug
#dbSendQuery(con, tbl_cours)
#dbSendQuery(con, tbl_etudiant)
#dbSendQuery(con, tbl_collaboration)

}

inject = function(collab_clean, etudiant_clean, data_cours){
  
  tbl_cours <-
  tbl_etudiant <-
  tbl_collaboration <-
  cours <-
  etudiant <-
  Collab_corr <-
  
dbWriteTable(con, append = TRUE, name = "tbl_cours", value = cours, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_etudiant", value = etudiant, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "tbl_collaboration", value = Collab_corr, row.names = FALSE)

}



