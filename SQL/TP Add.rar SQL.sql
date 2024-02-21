DROP DATABASE IF EXISTS add_rar; # Supprime la BDD si elle existe 
CREATE DATABASE add_rar; # Création de la BDD à chaque exécution du script
USE add_rar; 

-- Créer les tables 
CREATE TABLE Utilisateurs (
    utilisateur_id INT PRIMARY KEY,
    utilisateur_nom VARCHAR(50)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Fils (
    utilisateur_id INT,
    fil_id INT PRIMARY KEY,
    fil_contenu TEXT,
    fil_lien VARCHAR(255),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(utilisateur_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Avoir (
    utilisateur_id INT,
    utilisateur_id_1 INT,
    PRIMARY KEY (utilisateur_id, utilisateur_id_1),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(utilisateur_id),
    FOREIGN KEY (utilisateur_id_1) REFERENCES Utilisateurs(utilisateur_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables et les tables d’association
INSERT INTO Utilisateurs (utilisateur_id, utilisateur_nom) 
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Fils (utilisateur_id, fil_id, fil_contenu, fil_lien) 
VALUES
(1, 1, 'Contenu du fil de Alice', 'http://lien1.com'),
(3, 2, 'Contenu du fil de Charlie', 'http://lien2.com');

INSERT INTO Avoir (utilisateur_id, utilisateur_id_1) 
VALUES
(1, 2),
(1, 3),
(2, 3);

-- Afficher le contenu du fil de l’utilisateur 1 par ordre décroissant
SELECT * 
FROM Fils 
WHERE utilisateur_id = 1 
ORDER BY fil_id DESC;

-- Afficher la liste d’amis de l’utilisateur n°3
SELECT U.utilisateur_nom
FROM Utilisateurs U
JOIN Avoir A ON U.utilisateur_id = A.utilisateur_id OR U.utilisateur_id = A.utilisateur_id_1
WHERE (A.utilisateur_id = 3 OR A.utilisateur_id_1 = 3) AND U.utilisateur_id != 3;

-- Afficher les amis communs entre l’utilisateur n°1 et l’utilisateur n°3
SELECT U.utilisateur_nom
FROM Utilisateurs U
JOIN Avoir A1 ON U.utilisateur_id = A1.utilisateur_id OR U.utilisateur_id = A1.utilisateur_id_1
JOIN Avoir A2 ON U.utilisateur_id = A2.utilisateur_id OR U.utilisateur_id = A2.utilisateur_id_1
WHERE (A1.utilisateur_id = 1 OR A1.utilisateur_id_1 = 1)
AND (A2.utilisateur_id = 3 OR A2.utilisateur_id_1 = 3)
AND U.utilisateur_id NOT IN (1, 3);