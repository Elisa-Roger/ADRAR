DROP DATABASE IF EXISTS adrartheque; # Supprime la BDD si elle existe 
CREATE DATABASE adrartheque; # Création de la BDD à chaque exécution du script
USE adrartheque; 

-- Créer les tables 
CREATE TABLE Livres (
    livre_id INT PRIMARY KEY,
    livre_titre VARCHAR(50),
    livre_auteur VARCHAR(50),
    livre_isbn VARCHAR(50) UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Membres (
    membre_id INT PRIMARY KEY
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE Emprunts (
	livre_id INT,
    membre_id INT,
    emprunter_date DATETIME,
    PRIMARY KEY (livre_id, membre_id),
    FOREIGN KEY (livre_id) REFERENCES Livres(livre_id),
    FOREIGN KEY (membre_id) REFERENCES Membres(membre_id)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Insérer des données dans les tables et les tables d’association
INSERT INTO Livres (livre_id, livre_titre, livre_auteur, livre_isbn)
VALUES
(1, 'L\'Étranger', 'Albert Camus', '9782070360024'),
(2, 'Le Petit Prince', 'Antoine de Saint-Exupéry', '9780156013987'),
(3, '1984', 'George Orwell', '9780451524935');

INSERT INTO Membres (membre_id) 
VALUES
(1),
(2),
(3);

INSERT INTO Emprunts (livre_id, membre_id, emprunter_date) 
VALUES
(1, 1, '2023-01-15 14:00:00'),
(2, 1, '2023-02-20 10:00:00'),
(3, 2, '2023-03-25 16:00:00');

-- Afficher les informations d’un livre que s’il a déjà été emprunté par un membre
SELECT * 
FROM Livres 
WHERE livre_id IN (SELECT livre_id FROM Emprunts);

-- Afficher quels livres ont été empruntés par le membre n°3 avant 2023
SELECT L.titre, L.auteur, L.isbn 
FROM Livres L
JOIN Emprunts E ON L.livre_id = E.livre_id
WHERE E.membre_id = 3 AND YEAR(E.date_emprunt) < 2023;

-- Montrer quel livre a été le plus souvent emprunté
SELECT L.titre, COUNT(*) AS nombre_emprunts 
FROM Livres L
JOIN Emprunts E ON L.livre_id = E.livre_id
GROUP BY L.livre_id
ORDER BY nombre_emprunts DESC
LIMIT 1;
