DROP DATABASE IF EXISTS Adnum; # Supprime la BDD si elle existe 
CREATE DATABASE Adnum; # Création de la BDD à chaque exécution du script
USE Adnum; 

-- Création des tables de l'exercice

CREATE TABLE UTILISATEURS (
    id_util INT PRIMARY KEY,
    login_util VARCHAR(55)NOT NULL UNIQUE,
    mot_de_passe_util VARCHAR(155) NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE DROITS (
    id_droit INT PRIMARY KEY,
    libelle_droit VARCHAR(155) NOT NULL UNIQUE
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE FOURNISSEURS (
    id_fourn INT PRIMARY KEY,
    nom_fourn VARCHAR(55)NOT NULL,
    tel_fourn VARCHAR(10)NOT NULL,
    adr_num_fourn INT NOT NULL,
    adr_rue_fourn VARCHAR(100)NOT NULL,
    adr_cp_fourn VARCHAR(50) NOT NULL,
    adr_ville_fourn VARCHAR(50) NOT NULL,
    adr_pays_fourn VARCHAR(50) NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE FOURN_MP (
    id_fourn INT,
    id_mp INT,
    PRIMARY KEY (id_fourn, id_mp),
    FOREIGN KEY (id_fourn) REFERENCES FOURNISSEURS(id_fourn),
    FOREIGN KEY (id_mp) REFERENCES MATIERES_PREMIERES(id_mp)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE MATIERES_PREMIERES (
    id_mp INT PRIMARY KEY,
    nom_mp VARCHAR(155) NOT NULL,
    prix_achat_mp DECIMAL(10, 2),
    qte_stk_mp INT
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE PF_MP (
    id_pf INT,
    id_mp INT,
    PRIMARY KEY (id_pf, id_mp),
    FOREIGN KEY (id_pf) REFERENCES PRODUITS_FINIS(id_pf),
    FOREIGN KEY (id_mp) REFERENCES MATIERES_PREMIERES(id_mp)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE PRODUITS_FINIS (
    id_pf INT PRIMARY KEY,
    nom_pf VARCHAR(155) NOT NULL,
    prix_vente_pf DECIMAL(10, 2),
    qte_stk_pf INT,
    id_type_pf INT,
    FOREIGN KEY (id_type_pf) REFERENCES TYPE_PF(id_type_pf)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE TYPE_PF (
    id_type_pf INT PRIMARY KEY,
    nom_type_pf VARCHAR(155) NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE CLIENTS_PF (
    id_cli INT,
    id_pf INT,
    PRIMARY KEY (id_cli, id_pf),
    FOREIGN KEY (id_cli) REFERENCES CLIENTS(id_cli),
    FOREIGN KEY (id_pf) REFERENCES PRODUITS_FINIS(id_pf)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE CLIENTS (
    id_cli INT PRIMARY KEY,
    nom_cli VARCHAR(55)NOT NULL,
    tel_cli VARCHAR(10)NOT NULL,
    adr_num_cli INT NOT NULL,
    adr_rue_cli VARCHAR(50)NOT NULL,
    adr_ville_cli VARCHAR(50)NOT NULL,
    adr_cp_cli VARCHAR(50)NOT NULL,
    adr_pays_cli VARCHAR(50)NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE COMMERCIAUX (
    id_comm INT PRIMARY KEY,
    nom_comm VARCHAR(50) NOT NULL,
    prenom_comm VARCHAR(50)NOT NULL,
    tel_comm VARCHAR(255)NOT NULL
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE CLIENTS_COMMERCIAUX (
    id_cli INT,
    id_comm INT,
    chiffre_affaires DECIMAL(10, 2),
    PRIMARY KEY (id_cli, id_comm),
    FOREIGN KEY (id_cli) REFERENCES CLIENTS(id_cli),
    FOREIGN KEY (id_comm) REFERENCES COMMERCIAUX(id_comm)
)Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE COMMERCIAUX_PF (
    id_comm INT,
    id_pf INT,
    PRIMARY KEY (id_comm, id_pf),
    FOREIGN KEY (id_comm) REFERENCES COMMERCIAUX(id_comm),
    FOREIGN KEY (id_pf) REFERENCES PRODUITS_FINIS(id_pf)
)Engine=InnoDB DEFAULT charset=utf8mb4;

-- Ajouter la colonne id_droit dans la table UTILISATEURS
ALTER TABLE UTILISATEURS ADD COLUMN id_droit INT;
ALTER TABLE UTILISATEURS ADD FOREIGN KEY (id_droit) REFERENCES DROITS(id_droit);

-- Insérer des données dans les tables principales puis dans les tables d’association
-- Insérer des données dans la table DROITS
INSERT INTO DROITS (id_droit, libelle_droit) 
VALUES
(1, 'Admin'),
(2, 'Utilisateur'),
(3, 'Visiteur');

-- Insérer des données dans la table UTILISATEURS
INSERT INTO UTILISATEURS (id_util, login_util, mot_de_passe_util) 
VALUES
(1, 'jdoe', 'password123'),
(2, 'asmith', 'password123'),
(3, 'bjones', 'password123');

-- Insérer des données dans la table FOURNISSEURS
INSERT INTO FOURNISSEURS (id_fourn, nom_fourn, tel_fourn, adr_num_fourn, adr_rue_fourn, adr_cp_fourn, adr_ville_fourn, adr_pays_fourn) 
VALUES
(1, 'Fournisseur A', '0102030405', 123, 'Rue de la Paix', '75000', 'Paris', 'France'),
(2, 'Fournisseur B', '0607080910', 456, 'Avenue des Champs-Élysées', '75000', 'Paris', 'France');

-- Insérer des données dans la table MATIERES_PREMIERES
INSERT INTO MATIERES_PREMIERES (id_mp, nom_mp, prix_achat_mp, qte_stk_mp) 
VALUES
(1, 'Acier', 10.50, 100),
(2, 'Bois', 5.75, 200);

-- Insérer des données dans la table PRODUITS_FINIS
INSERT INTO PRODUITS_FINIS (id_pf, nom_pf, prix_vente_pf, qte_stk_pf, id_type_pf) 
VALUES
(1, 'Produit Fini A', 20.99, 50, 1),
(2, 'Produit Fini B', 15.99, 75, 2);

-- Insérer des données dans la table TYPE_PF
INSERT INTO TYPE_PF (id_type_pf, nom_type_pf) 
VALUES
(1, 'Type A'),
(2, 'Type B');

-- Insérer des données dans la table CLIENTS
INSERT INTO CLIENTS (id_cli, nom_cli, tel_cli, adr_num_cli, adr_rue_cli, adr_ville_cli, adr_cp_cli, adr_pays_cli) 
VALUES
(1, 'Client A', '0601020304', 789, 'Rue de Rivoli', 'Paris', '75001', 'France'),
(2, 'Client B', '0708091011', 101, 'Boulevard Saint-Germain', 'Paris', '75006', 'France');

-- Insérer des données dans la table COMMERCIAUX
INSERT INTO COMMERCIAUX (id_comm, nom_comm, prenom_comm, tel_comm) 
VALUES
(1, 'Dupont', 'Charles', '0612345678'),
(2, 'Durand', 'Élise', '0698765432');


-- Pour la table FOURN_MP
INSERT INTO FOURN_MP (id_fourn, id_mp) 
VALUES
(1, 1),
(2, 2);

-- Pour la table PF_MP
INSERT INTO PF_MP (id_pf, id_mp) 
VALUES
(1, 1),
(2, 2);

-- Pour la table CLIENTS_PF
INSERT INTO CLIENTS_PF (id_cli, id_pf) 
VALUES
(1, 1),
(2, 2);

-- Pour la table CLIENTS_COMMERCIAUX
INSERT INTO CLIENTS_COMMERCIAUX (id_cli, id_comm, chiffre_affaires) 
VALUES
(1, 1, 10000.00),
(2, 2, 15000.00);

-- Pour la table COMMERCIAUX_PF
INSERT INTO COMMERCIAUX_PF (id_comm, id_pf) 
VALUES
(1, 1),
(2, 2);

-- Changer le type d’une donnée (exemple : changer le type de tel_fourn de VARCHAR à INT)
-- ALTER TABLE FOURNISSEURS MODIFY tel_fourn INT;
-- Requête en commentaire à valider par le formateur.

-- Récupérer la liste des utilisateurs
SELECT * 
FROM UTILISATEURS;

-- Récupérer la liste des utilisateurs avec le libellé de leur rôle
SELECT U.*, D.libelle_droit FROM UTILISATEURS U
JOIN DROITS D ON U.id_droit = D.id_droit;

-- Récupérer la somme du chiffres d’affaires par commercial et par client
SELECT C.id_comm, CC.id_cli, SUM(CC.chiffre_affaires) AS total_chiffre_affaires
FROM COMMERCIAUX C
JOIN CLIENTS_COMMERCIAUX CC ON C.id_comm = CC.id_comm
GROUP BY C.id_comm, CC.id_cli;

-- Récupérer la somme du chiffres d’affaires par commercial
SELECT id_comm, SUM(chiffre_affaires) AS total_chiffre_affaires
FROM CLIENTS_COMMERCIAUX
GROUP BY id_comm;

-- Récupérer la somme du chiffres d’affaires par client
SELECT id_cli, SUM(chiffre_affaires) AS total_chiffre_affaires
FROM CLIENTS_COMMERCIAUX
GROUP BY id_cli;

-- Récupérer la moyenne du chiffres d’affaires par commercial et par client
SELECT C.id_comm, CC.id_cli, AVG(CC.chiffre_affaires) AS moyenne_chiffre_affaires
FROM COMMERCIAUX C
JOIN CLIENTS_COMMERCIAUX CC ON C.id_comm = CC.id_comm
GROUP BY C.id_comm, CC.id_cli;

-- Récupérer la moyenne du chiffres d’affaires par commercial
SELECT id_comm, AVG(chiffre_affaires) AS moyenne_chiffre_affaires
FROM CLIENTS_COMMERCIAUX
GROUP BY id_comm;

-- Récupérer la moyenne du chiffres d’affaires par client
SELECT id_cli, AVG(chiffre_affaires) AS moyenne_chiffre_affaires
FROM CLIENTS_COMMERCIAUX
GROUP BY id_cli;

-- Supprimer la table CLIENTS_COMMERCIAUX
DROP TABLE CLIENTS_COMMERCIAUX;