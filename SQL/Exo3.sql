DROP DATABASE IF EXISTS Exo3; # Supprime la BDD si elle existe 
CREATE DATABASE Exo3; # Création de la BDD à chaque exécution du script
USE Exo3; 

-- Création des tables de l'exercice
CREATE TABLE ETUDIANTS (
    id_etud INT PRIMARY KEY,
    nom_etud VARCHAR(35) NOT NULL,
    prenom_etud VARCHAR(35) NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE MATIERES (
    code_matiere VARCHAR(255) PRIMARY KEY,
    libelle_matiere VARCHAR(55) NOT NULL,
    coeff_matiere DECIMAL(5, 2)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE EVALUER (
    id_etud INT,
    code_matiere VARCHAR(255) NOT NULL,
    date DATE,
    note DECIMAL(5, 2),
    PRIMARY KEY (id_etud, code_matiere),
    FOREIGN KEY (id_etud) REFERENCES ETUDIANTS(id_etud),
    FOREIGN KEY (code_matiere) REFERENCES MATIERES(code_matiere)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables 

INSERT INTO ETUDIANTS (id_etud, nom_etud, prenom_etud) 
VALUES
(1, 'Dupont', 'Jean'),
(2, 'Durand', 'Marie');

INSERT INTO MATIERES (code_matiere, libelle_matiere, coeff_matiere) 
VALUES
('MATH101', 'Mathématiques', 4.0),
('PHYS102', 'Physique', 3.0);

INSERT INTO EVALUER (id_etud, code_matiere, date, note) 
VALUES
(1, 'MATH101', '2024-02-19', 15.5),
(2, 'PHYS102', '2024-02-20', 14.0);

-- Quel est le nombre total d’étudiants ?
SELECT COUNT(*) 
FROM ETUDIANTS;

-- Quelles sont, parmi l’ensemble des notes, la note la plus haute et la note la plus basse ?
SELECT MAX(note) AS 'Note la Plus Haute', MIN(note) AS 'Note la Plus Basse' 
FROM EVALUER;

-- Quelles sont les moyennes de chaque étudiant dans chacune des matières ?
SELECT id_etud, code_matiere, AVG(note) AS 'Moyenne' 
FROM EVALUER GROUP BY id_etud, code_matiere;

-- Création de la vue MGETU pour les questions suivantes
CREATE VIEW MGETU AS
SELECT id_etud, code_matiere, AVG(note) AS MoyEtuMat
FROM EVALUER
GROUP BY id_etud, code_matiere;

-- Quelles sont les moyennes par matière ? Avec la vue MGETU de la question 3 (MoyEtuMat)
SELECT code_matiere, AVG(MoyEtuMat) AS 'Moyenne par Matière' 
FROM MGETU GROUP BY code_matiere;

-- Quelle est la moyenne générale de chaque étudiant ? Avec la vue MGETU de la question 3
SELECT id_etud, AVG(MoyEtuMat) AS 'Moyenne Générale de chaque etudiant' 
FROM MGETU GROUP BY id_etud;

-- Quelle est la moyenne générale de la promotion ? Avec la vue MGETU de la question 5
SELECT AVG(MoyEtuMat) AS 'Moyenne Générale de la Promotion' 
FROM MGETU;

-- Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion? Avec la vue MGETU de la question 5
SELECT E.id_etud, E.nom_etud, E.prenom_etud
FROM ETUDIANTS E
JOIN (SELECT id_etud, AVG(MoyEtuMat) AS Moyenne
      FROM MGETU
      GROUP BY id_etud) AS EM ON E.id_etud = EM.id_etud
WHERE EM.Moyenne >= (SELECT AVG(MoyEtuMat) FROM MGETU);