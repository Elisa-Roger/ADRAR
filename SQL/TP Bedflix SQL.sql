DROP DATABASE IF EXISTS Bedflix; # Supprime la BDD si elle existe 
CREATE DATABASE Bedflix; # Création de la BDD à chaque exécution du script
USE Bedflix; 


-- Créer les tables selon le schéma relationnel
CREATE TABLE UTILISATEURS (
    id_utilisateur INT PRIMARY KEY,
    nom_utilisateur VARCHAR(35) NOT NULL,
    prenom_utilisateur VARCHAR(35) NOT NULL,
    email_utilisateur VARCHAR(100) NOT NULL,
    pseudo_utilisateur VARCHAR(25) NOT NULL,
    mot_de_passe_utilisateur VARCHAR(55) NOT NULL,
    photo_profil_utilisateur VARCHAR(50),
    id_role INT,
    FOREIGN KEY (id_role) REFERENCES ROLES(id_role)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE ROLES (
    id_role INT PRIMARY KEY,
    libelle_role VARCHAR(155)NOT NULL UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE UTILISATEURS_FILMS (
    id_utilisateur INT,
    id_film INT,
    date_utilisateur_visionnage DATE,
    PRIMARY KEY (id_utilisateur, id_film),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEURS(id_utilisateur),
    FOREIGN KEY (id_film) REFERENCES FILMS(id_film)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE UTILISATEURS_SERIES (
    id_utilisateur INT,
    id_serie INT,
    date_utilisateur_visionnage DATE,
    PRIMARY KEY (id_utilisateur, id_serie),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEURS(id_utilisateur),
    FOREIGN KEY (id_serie) REFERENCES SERIES(id_serie)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE FILMS (
    id_film INT PRIMARY KEY,
    titre_film VARCHAR(55) NOT NULL,
    description_film CHAR(500),
    affiche_film VARCHAR(55),
    lien_film VARCHAR(255),
    duree_film TIME
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE FILMS_CATEGORIES (
    id_film INT,
    id_categorie INT,
    libelle_categorie VARCHAR(155)NOT NULL UNIQUE,
    PRIMARY KEY (id_film, id_categorie),
    FOREIGN KEY (id_film) REFERENCES FILMS(id_film)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE SERIES (
    id_serie INT PRIMARY KEY,
    titre_serie VARCHAR(55)NOT NULL,
    description_serie CHAR(500),
    affiche_serie VARCHAR(50),
    lien_serie VARCHAR(255)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE SERIES_CATEGORIES (
    id_serie INT,
    id_categorie INT,
    libelle_categorie VARCHAR(155)NOT NULL UNIQUE,
    PRIMARY KEY (id_serie, id_categorie),
    FOREIGN KEY (id_serie) REFERENCES SERIES(id_serie)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE SAISONS (
    id_saison INT PRIMARY KEY,
    numero_saison INT NOT NULL,
    titre_saison VARCHAR(255)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE EPISODES (
    id_episode INT PRIMARY KEY,
    numero_episode INT NOT NULL,
    titre_episode VARCHAR(255) NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Changer le type d’une donnée (exemple : email_utilisateur de VARCHAR à CHAR)
-- ALTER TABLE UTILISATEURS MODIFY email_utilisateur CHAR;
-- Requête à valider par le formateur.

-- Ajouter la colonne id_serie dans la table SAISONS
ALTER TABLE SAISONS ADD COLUMN id_serie INT;
ALTER TABLE SAISONS ADD FOREIGN KEY (id_serie) REFERENCES SERIES(id_serie);

-- Ajouter la colonne duree_episode dans la table EPISODES
ALTER TABLE EPISODES ADD COLUMN duree_episode TIME;

-- Ajouter la colonne id_saison dans la table EPISODES
ALTER TABLE EPISODES ADD COLUMN id_saison INT;
ALTER TABLE EPISODES ADD FOREIGN KEY (id_saison) REFERENCES SAISONS(id_saison);

-- Insérer des données dans les tables principales puis dans les tables d’association
-- Insérer des données dans les tables UTILISATEURS et ROLES
INSERT INTO ROLES (id_role, libelle_role) 
VALUES
(1, 'Administrateur'),
(2, 'Utilisateur');

INSERT INTO UTILISATEURS (id_utilisateur, nom_utilisateur, prenom_utilisateur, email_utilisateur, pseudo_utilisateur, mot_de_passe_utilisateur, id_role) 
VALUES
(1, 'Doe', 'John', 'john.doe@example.com', 'johndoe', 'password123', 1),
(2, 'Roe', 'Jane', 'jane.roe@example.com', 'janeroe', 'password123', 2);

-- Insérer des données dans les tables FILMS et SERIES
INSERT INTO FILMS (id_film, titre_film, description_film, lien_film, duree_film) 
VALUES
(1, 'Inception', 'Un voleur qui s\'infiltre dans les rêves...', 'http://lien-vers-inception.com', '02:28:00'),
(2, 'Interstellar', 'Une équipe d\'explorateurs voyage à travers un trou de ver...', 'http://lien-vers-interstellar.com', '02:49:00');

INSERT INTO SERIES (id_serie, titre_serie, description_serie, lien_serie) 
VALUES
(1, 'Stranger Things', 'Des enfants enquêtent sur des phénomènes surnaturels...', 'http://lien-vers-stranger-things.com'),
(2, 'The Witcher', 'Un chasseur de monstres lutte pour trouver sa place...', 'http://lien-vers-the-witcher.com');

-- Insérer des données dans les tables d'association UTILISATEURS_FILMS et UTILISATEURS_SERIES
INSERT INTO UTILISATEURS_FILMS (id_utilisateur, id_film, date_utilisateur_visionnage) 
VALUES
(1, 1, '2024-02-19'),
(2, 2, '2024-02-20');

INSERT INTO UTILISATEURS_SERIES (id_utilisateur, id_serie, date_utilisateur_visionnage) 
VALUES
(1, 1, '2024-02-21'),
(2, 2, '2024-02-22');

-- Récupérer la liste des utilisateurs
SELECT * 
FROM UTILISATEURS;

-- Récupérer la liste des utilisateurs avec le libellé de leur rôle
SELECT U.*, R.libelle_role 
FROM UTILISATEURS U
JOIN ROLES R ON U.id_role = R.id_role;

-- Récupérer la liste des séries et films
SELECT titre_film 
FROM FILMS
UNION
SELECT titre_serie FROM SERIES;

-- Récupérer la liste des films avec l’heure de fin de visionnage si nous commencions le film MAINTENANT
SELECT titre_film, ADDTIME(CURRENT_TIME(), duree_film) AS heure_fin_visionnage 
FROM FILMS;

-- Récupérer la liste des séries avec le nombre d’épisodes pour chacune
SELECT S.titre_serie, COUNT(E.id_episode) AS nombre_episodes
FROM SERIES S
JOIN SAISONS SN ON S.id_serie = SN.id_serie
JOIN EPISODES E ON SN.id_saison = E.id_saison
GROUP BY S.titre_serie;

-- Récupérer la liste des séries avec la durée totale
SELECT S.titre_serie, SEC_TO_TIME(SUM(TIME_TO_SEC(E.duree_episode))) AS duree_totale
FROM SERIES S
JOIN SAISONS SN ON S.id_serie = SN.id_serie
JOIN EPISODES E ON SN.id_saison = E.id_saison
GROUP BY S.titre_serie;

-- Supprimer la table SAISONS
DROP TABLE SAISONS;