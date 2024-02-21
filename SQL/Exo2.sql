DROP DATABASE IF EXISTS Exo2; # Supprime la BDD si elle existe 
CREATE DATABASE Exo2; # Création de la BDD à chaque exécution du script
USE Exo2; 

-- Création des tables de l'exercice
CREATE TABLE DEPARTEMENTS(
	id_dep INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nom_dep VARCHAR(25) NOT NULL, 
    directeur_dep VARCHAR(25) NOT NULL,
    ville_dep VARCHAR(55) NOT NULL
) Engine=InnoDB DEFAULT charset=utf8mb4;

CREATE TABLE EMPLOYES(
	id_emp INT PRIMARY KEY,
    nom_emp VARCHAR(25) NOT NULL, 
    prof VARCHAR(25) NOT NULL,
    date_embauche_emp DATE,
    salaire_emp DECIMAL(10,2),
    commission_emp DECIMAL(10,2),
    FOREIGN KEY(id_dep) REFERENCES DEPARTEMENTS(id_dep)
) Engine=InnoDB DEFAULT charset=utf8mb4;

-- Affichage des tables de la BDD "Exo1"
SHOW TABLES;

-- Insérer des données dans les tables
INSERT INTO DEPARTEMENTS (id_dep, nom_dep, directeur_dep, ville_dep) 
VALUES
(1, 'Informatique', 'John Doe', 'Paris'),
(2, 'Ressources Humaines', 'Jane Smith', 'Lyon'),
(3, 'Comptabilite', 'Marc Dupont', 'Bordeaux'),
(4, 'Technicien', 'Alice Bonjour', 'Lyon');

INSERT INTO EMPLOYES (id_emp, nom_emp, prof, date_embauche_emp, salaire_emp, commission_emp, id_dep) 
VALUES
(101, 'Alice Martin', 'Développeuse', '2020-01-15', 3200, 500, 1),
(102, 'Bob Dupont', 'RH', '2019-03-22', 2700, NULL, 2),
(103, 'Martine Franck', 'Experte comptable', '2010-01-25', 3000, 500, 3),
(104, 'Axelle Dufour', 'Analyste', '2018-03-02', 3700, NULL, 1),
(105, 'Jack white', 'Technicien', '2020-01-15', 2500, 500, 4);


-- Donner la liste des employés ayant une commission
SELECT nom_emp 
FROM EMPLOYES 
WHERE commission_emp IS NOT NULL;

-- Donner les noms, emplois et salaires des employés par emploi croissant, et pour chaque emploi, par salaire décroissant
SELECT nom_emp, prof, salaire_emp 
FROM EMPLOYES ORDER BY prof ASC, salaire_emp DESC;

-- Donner le salaire moyen des employés
SELECT AVG(salaire_emp) 
FROM EMPLOYES;

-- Donner le salaire moyen du département Production
SELECT AVG(salaire_emp) AS 'Salaire Moyen Production' 
FROM EMPLOYES
JOIN DEPARTEMENTS ON EMPLOYES.id_dep = DEPARTEMENTS.id_dep
WHERE nom_dep = 'Production';

-- Donner les numéros de département et leur salaire maximum
SELECT id_dep, MAX(salaire_emp) AS 'Salaire Max' 
FROM EMPLOYES GROUP BY id_dep;

-- Donner les différentes professions et leur salaire moyen
SELECT prof, AVG(salaire_emp) AS 'Salaire Moyen' 
FROM EMPLOYES GROUP BY prof;

-- Donner le salaire le plus bas par profession
SELECT prof, MIN(salaire_emp) AS 'Salaire Min' 
FROM EMPLOYES GROUP BY prof;

-- Donner le ou les emplois ayant le salaire moyen le plus bas, ainsi que ce salaire moyen
SELECT prof, AVG(salaire_emp) AS 'Salaire Moyen' 
FROM EMPLOYES
GROUP BY prof
ORDER BY AVG(salaire_emp) ASC
LIMIT 1;