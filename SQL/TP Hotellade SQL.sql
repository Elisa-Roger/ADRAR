DROP DATABASE IF EXISTS hotellade; # Supprime la BDD si elle existe 
CREATE DATABASE hotellade; # Création de la BDD à chaque exécution du script
USE hotellade; 

-- Créer les tables 
CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Chambres (
    chambre_id INT PRIMARY KEY,
    hotel_id INT,
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_nom VARCHAR(25),
    client_prenom VARCHAR(25),
    client_telephone VARCHAR(10) UNIQUE,
    client_email VARCHAR(100) UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Reserver (
	client_id INT,
    chambre_id INT,
    reserver_date_limit DATETIME,
    PRIMARY KEY (client_id, chambre_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (chambre_id) REFERENCES Chambres(chambre_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables et les tables d’association
INSERT INTO Hotels (hotel_id) 
VALUES
(1),
(2),
(3);

INSERT INTO Chambres (chambre_id, hotel_id) 
VALUES
(101, 1),
(102, 1),
(201, 2),
(202, 2);

INSERT INTO Clients (client_id, client_nom, client_prenom, client_telephone, client_email) 
VALUES
(1, 'Durand', 'Sophie', '0601020304', 'sophie.durand@example.com'),
(2, 'Leroy', 'Julien', '0605040302', 'julien.leroy@example.com'),
(3, 'Moreau', 'Isabelle', '0612345678', 'isabelle.moreau@example.com');

INSERT INTO Reserver (client_id, chambre_id, reserver_date_limit) 
VALUES
(1, 101, '2024-03-01 12:00:00'),
(2, 102, '2024-03-05 12:00:00'),
(3, 201, '2024-04-15 12:00:00');

-- Pour chaque hôtel, afficher les chambres qui ne sont pas disponibles
SELECT h.nom AS Hotel, c.chambre_id
FROM Hotels h
JOIN Chambres c ON h.hotel_id = c.hotel_id
WHERE c.disponible = FALSE;

-- Afficher quel est notre client le plus fidèle à partir de son nombre de réservations (celui qui en a le plus)
SELECT cl.client_id, cl.nom, cl.prenom, COUNT(*) AS nombre_reserver
FROM Clients cl
JOIN Reserver r ON cl.client_id = r.client_id
GROUP BY cl.client_id
ORDER BY nombre_reserver DESC
LIMIT 1;

-- Rechercher tous les clients pour lesquels le mail commence par “v” et se termine par “.fr”
SELECT * 
FROM Clients 
WHERE email LIKE 'v%.fr';

-- Afficher toutes les réservations qui auront lieu dans la semaine
SELECT * 
FROM Reserver
WHERE date_debut <= CURRENT_DATE + INTERVAL '7' DAY
AND date_debut >= CURRENT_DATE;
