DROP DATABASE IF EXISTS adcash; # Supprime la BDD si elle existe 
CREATE DATABASE adcash; # Création de la BDD à chaque exécution du script
USE adcash; 

-- Créer les tables 
CREATE TABLE Actions (
    action_id INT PRIMARY KEY,
    action_libelle VARCHAR(50)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Usagers (
    usager_id INT PRIMARY KEY,
    usager_nom VARCHAR(50),
    usager_prenom VARCHAR(50),
    usager_montant DECIMAL(8,2)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Effectuer (
    action_id INT,
    usager_id INT,
    effectue_date DATETIME,
    PRIMARY KEY (action_id, usager_id),
    FOREIGN KEY (action_id) REFERENCES Actions(action_id),
    FOREIGN KEY (usager_id) REFERENCES Usagers(usager_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables et les tables d’association
INSERT INTO Actions (action_id, action_libelle) 
VALUES
(1, 'Retrait'),
(2, 'Dépôt'),
(3, 'Consultation');

-- Insérer des données dans la table Usagers
INSERT INTO Usagers (usager_id, usager_nom, usager_prenom, usager_montant) 
VALUES
(1, 'Dupont', 'Jean', 1500.00),
(2, 'Martin', 'Alice', 1200.00);

-- Insérer des données dans la table Effectuer
INSERT INTO Effectuer (action_id, usager_id, effectue_date) 
VALUES
(1, 1, '2023-01-15 10:00:00'),
(2, 2, '2023-01-16 14:30:00');

-- Afficher la liste des actions disponibles sur l’ATM par ordre croissant
SELECT * 
FROM Actions 
ORDER BY action_libelle ASC;

-- Afficher l’ensemble des actions effectuées par l’utilisateur n°2 en janvier 2023
SELECT * 
FROM Effectuer
WHERE usager_id = 2 AND MONTH(effectue_date) = 1 AND YEAR(effectue_date) = 2023;

-- Afficher le montant moyens des usagers
SELECT AVG(usager_montant) AS montant_moyen 
FROM Usagers;

-- Afficher le montant total des usagers
SELECT SUM(usager_montant) AS montant_total 
FROM Usagers;

