DROP DATABASE IF EXISTS Adrar_Classrooms; # Supprime la BDD si elle existe 
CREATE DATABASE Adrar_Classrooms; # Création de la BDD à chaque exécution du script
USE Adrar_Classrooms; 

-- Créer la table UTILISATEURS
CREATE TABLE UTILISATEURS (
    id_utilisateur INT PRIMARY KEY,
    nom_utilisateur VARCHAR(55) NOT NULL,
    prenom_utilisateur VARCHAR(55)NOT NULL,
    email_utilisateur VARCHAR(55)NOT NULL,
    mot_de_passe_utilisateur VARCHAR(55)NOT NULL,
    photo_profil_utilisateur VARCHAR(55)NOT NULL,
    id_role INT,
    FOREIGN KEY (id_role) REFERENCES ROLES(id_role)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table ROLES
CREATE TABLE ROLES (
    id_role INT PRIMARY KEY,
    libelle_role VARCHAR(155)NOT NULL UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table AVIS
CREATE TABLE AVIS (
    id_avis INT PRIMARY KEY,
    texte_avis VARCHAR(100)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table UTILISATEURS_CHAPITRES
CREATE TABLE UTILISATEURS_CHAPITRES (
    id_utilisateur INT,
    id_chapitre INT,
    date_utilisateur_chapitre DATE,
    chapitre_termine BOOLEAN,
    PRIMARY KEY (id_utilisateur, id_chapitre),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEURS(id_utilisateur),
    FOREIGN KEY (id_chapitre) REFERENCES CHAPITRES(id_chapitre)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table CHAPITRES
CREATE TABLE CHAPITRES (
    id_chapitre INT PRIMARY KEY,
    titre_chapitre VARCHAR(155)NOT NULL,
    contenu_chapitre CHAR(500),
    id_cours INT,
    FOREIGN KEY (id_cours) REFERENCES COURS(id_cours)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table COURS
CREATE TABLE COURS (
    id_cours INT PRIMARY KEY,
    titre_cours VARCHAR(55)NOT NULL,
    duree_cours TIME,
    synopsis_cours TEXT,
    vignette_cours VARCHAR(155),
    date_publication_cours DATE,
    id_niveau INT,
    FOREIGN KEY (id_niveau) REFERENCES NIVEAUX(id_niveau)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table NIVEAUX
CREATE TABLE NIVEAUX (
    id_niveau INT PRIMARY KEY,
    libelle_niveau VARCHAR(155)NOT NULL UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Créer la table LANGAGES
CREATE TABLE LANGAGES (
    id_langage INT PRIMARY KEY,
    libelle_langage VARCHAR(155)NOT NULL UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Ajouter la colonne id_langage dans la table COURS
ALTER TABLE COURS ADD COLUMN id_langage INT;
ALTER TABLE COURS ADD FOREIGN KEY (id_langage) REFERENCES LANGAGES(id_langage);

-- Insérer des données dans les tables principales puis dans les tables d’association
-- Insérer des données dans la table ROLES
INSERT INTO ROLES (id_role, libelle_role) 
VALUES
(1, 'Administrateur'),
(2, 'Étudiant'),
(3, 'Instructeur');

-- Insérer des données dans la table UTILISATEURS
INSERT INTO UTILISATEURS (id_utilisateur, nom_utilisateur, prenom_utilisateur, email_utilisateur, mot_de_passe_utilisateur, id_role) 
VALUES
(1, 'Durand', 'Paul', 'paul.durand@example.com', 'motdepasse123', 2),
(2, 'Moreau', 'Julie', 'julie.moreau@example.com', 'motdepasse123', 2),
(3, 'Petit', 'Marc', 'marc.petit@example.com', 'motdepasse123', 1);

-- Insérer des données dans la table AVIS
INSERT INTO AVIS (id_avis, texte_avis) 
VALUES
(1, 'Très bon cours, bien expliqué.'),
(2, 'J\'ai appris beaucoup de choses intéressantes.');

-- Insérer des données dans la table NIVEAUX
INSERT INTO NIVEAUX (id_niveau, libelle_niveau) 
VALUES
(1, 'Débutant'),
(2, 'Intermédiaire'),
(3, 'Avancé');

-- Insérer des données dans la table LANGAGES
INSERT INTO LANGAGES (id_langage, libelle_langage) 
VALUES
(1, 'HTML'),
(2, 'CSS'),
(3, 'JavaScript');

-- Insérer des données dans la table COURS
INSERT INTO COURS (id_cours, titre_cours, duree_cours, synopsis_cours, date_publication_cours, id_niveau, id_langage) 
VALUES
(1, 'Introduction au HTML', '02:00:00', 'Apprenez les bases du HTML.', '2024-01-01', 1, 1),
(2, 'CSS pour débutants', '03:00:00', 'Découvrez comment styliser vos pages web avec CSS.', '2024-01-15', 1, 2);

-- Insérer des données dans la table CHAPITRES
INSERT INTO CHAPITRES (id_chapitre, titre_chapitre, contenu_chapitre, id_cours) 
VALUES
(1, 'Les bases du HTML', 'Contenu du chapitre sur les bases du HTML.', 1),
(2, 'Introduction au CSS', 'Contenu du chapitre sur l\'introduction au CSS.', 2);

-- Insérer des données dans la table UTILISATEURS_CHAPITRES
INSERT INTO UTILISATEURS_CHAPITRES (id_utilisateur, id_chapitre, date_utilisateur_chapitre, chapitre_termine) 
VALUES
(1, 1, '2024-02-20', TRUE),
(2, 2, '2024-02-21', FALSE);

-- Récupérer la liste des cours
SELECT * 
FROM COURS;

-- Récupérer la liste des chapitres pour le cours sur l’HTML avec le libellé du niveau du cours
SELECT CH.id_chapitre, CH.titre_chapitre, CO.titre_cours, N.libelle_niveau
FROM CHAPITRES CH
JOIN COURS CO ON CH.id_cours = CO.id_cours
JOIN NIVEAUX N ON CO.id_niveau = N.id_niveau
WHERE CO.titre_cours = 'HTML';

-- Rechercher tous les utilisateurs qui commencent par A
SELECT * 
FROM UTILISATEURS 
WHERE nom_utilisateur LIKE 'A%';

-- Afficher tous les utilisateurs qui ont participé au cours sur l’HTML
SELECT U.*
FROM UTILISATEURS U
JOIN UTILISATEURS_CHAPITRES UC ON U.id_utilisateur = UC.id_utilisateur
JOIN CHAPITRES CH ON UC.id_chapitre = CH.id_chapitre
JOIN COURS CO ON CH.id_cours = CO.id_cours
WHERE CO.titre_cours = 'HTML';

-- Récupérer la liste des cours avec le nombre de chapitre pour chacun
SELECT CO.id_cours, CO.titre_cours, COUNT(CH.id_chapitre) AS nombre_chapitres
FROM COURS CO
LEFT JOIN CHAPITRES CH ON CO.id_cours = CH.id_cours
GROUP BY CO.id_cours;