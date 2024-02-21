DROP DATABASE IF EXISTS Exo1; # Supprime la BDD si elle existe 
CREATE DATABASE Exo1; # Création de la BDD à chaque exécution du script
USE Exo1; # Pointer sur la BDD "Exo1" pour effectuer les requêtes dessus

-- Création des tables de l'exercice
CREATE TABLE REPRESENTATIONS(
	id_rep INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titre_rep VARCHAR(25) NOT NULL, 
    lieu_rep VARCHAR(25) NOT NULL
) Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE MUSICIENS(
	id_musicien INT NOT NULL,
    nom_musicien VARCHAR(25) NOT NULL, 
    id_rep INT,
    PRIMARY KEY (id_musicien), 
    FOREIGN KEY(id_rep) REFERENCES REPRESENTATIONS(id_rep)
) Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE PROGRAMMATION(
    id_rep INT,
    date_prog DATE NOT NULL, 
    tarif_prog DECIMAL(5,2), 
    PRIMARY KEY (id_rep, date_prog), 
    FOREIGN KEY(id_rep) REFERENCES REPRESENTATIONS(id_rep)
) Engine=InnoDB DEFAULT charset=utf8mb4;

-- Affichage des tables de la BDD "Exo1"
SHOW TABLES;

-- Insertion des données 
INSERT INTO REPRESENTATIONS(titre_rep, lieu_rep)
VALUES
	("Représentation 1", "Montpellier"), 
	("Représentation 2", "Montpellier"), 
	("Représentation 3", "Toulouse"), 
	("Représentation 4", "Ramonville"), 
	("Représentation 5", "Paris"), 
	("Représentation 6", "Montcuq");
    
INSERT INTO MUSICIENS 
VALUES
	(1, "Musicien 1", 1),
	(2, "Musicien 2", 2),
	(3, "Musicien 3", 5),
	(4, "Musicien 4", 4),
	(5, "Musicien 5", 2);
    
INSERT INTO PROGRAMMATION 
VALUES
	(1, "2023-01-01", 3.58),
	(2, "2023-09-05", 150.20),
	(3, "2024-01-02", 250.55),
	(4, "2024-02-02", 999.85);
    
-- Requête n°1: lister les titres des représentations
SELECT titre_rep
FROM REPRESENTATIONS;
    
-- Requête n°2: lister les titres des représentations
SELECT titre_rep
FROM REPRESENTATIONS 
WHERE lieu_rep = "Montpellier";
    
-- Requête n°3: lister les musiciens et représentations auxquelles ils participent
SELECT nom_musicien, titre_rep
FROM MUSICIENS AS M
INNER JOIN REPRESENTATIONS R ON R.id_rep = M.id_rep;

-- Requête n°4: liste des titres des représentations, les lieux et tarifs à une date donnée en condition
SELECT titre_rep, lieu_rep, tarif_prog
FROM REPRESENTATIONS AS R
INNER JOIN PROGRAMMATION P ON R.id_rep = P.id_rep
WHERE date_prog = "2023-09-05";

-- Requête n°5: le nombre de musiciens qui participent à la représentation n°X
SELECT COUNT(*) AS "Nombre de participant à la représentation n°X"
FROM MUSICIENS 
WHERE id_rep = 2;

-- Requête n°6: les représentations et leurs dates dont le tarif n'excède pas 20€
SELECT R.*, date_prog
FROM REPRESENTATIONS R
INNER JOIN PROGRAMMATION P ON R.id_rep = P.id_rep 
WHERE tarif_prog <= 20.0;