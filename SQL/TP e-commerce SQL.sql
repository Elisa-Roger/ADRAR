DROP DATABASE IF EXISTS e_commerce; # Supprime la BDD si elle existe 
CREATE DATABASE e_commerce; # Création de la BDD à chaque exécution du script
USE e_commerce; 

-- Créer les tables
CREATE TABLE Clients (
    client_id INT PRIMARY KEY
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Commandes (
    commande_id INT PRIMARY KEY,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Produits (
    produit_id INT PRIMARY KEY,
    produit_nom VARCHAR(50),
    produit_description TEXT,
    produit_prix DECIMAL(5, 2)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Contenir (
    commande_id INT,
    produit_id INT,
    quantite INT,
    PRIMARY KEY (commande_id, produit_id),
    FOREIGN KEY (commande_id) REFERENCES Commandes(commande_id),
    FOREIGN KEY (produit_id) REFERENCES Produits(produit_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables
INSERT INTO Clients (client_id) 
VALUES (1), (2), (3);

INSERT INTO Produits (produit_id, produit_nom, produit_description, produit_prix) 
VALUES
(1, 'Produit A', 'Description du produit A', 50.00),
(2, 'Produit B', 'Description du produit B', 75.00),
(3, 'Produit C', 'Description du produit C', 100.00);

INSERT INTO Commandes (commande_id, client_id) 
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Contenir (commande_id, produit_id, quantite) 
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 2, 2);

-- Récupérer la liste des produits
SELECT * 
FROM Produits;

-- Récupérer les commandes de chaque clients avec l’ensemble des produits pour chaque commande
SELECT c.client_id, co.commande_id, p.nom
FROM Clients c
JOIN Commandes co ON c.client_id = co.client_id
JOIN Contenir ct ON co.commande_id = ct.commande_id
JOIN Produits p ON ct.produit_id = p.produit_id;

-- Rechercher tous les produits pour lesquels le nom commencent par “A” et se terminent par “S”
SELECT * 
FROM Produits 
WHERE nom LIKE 'A%S';

-- Afficher tous les clients qui ont commandé le produit numéro 3
SELECT DISTINCT c.client_id
FROM Clients c
JOIN Commandes co ON c.client_id = co.client_id
JOIN Contenir ct ON co.commande_id = ct.commande_id
WHERE ct.produit_id = 3;

-- Afficher tous les clients qui ont commandé des produits valant plus de 100,00€
SELECT DISTINCT c.client_id
FROM Clients c
JOIN Commandes co ON c.client_id = co.client_id
JOIN Contenir ct ON co.commande_id = ct.commande_id
JOIN Produits p ON ct.produit_id = p.produit_id
WHERE p.prix > 100.00;