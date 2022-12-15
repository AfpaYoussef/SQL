-- Lot 1
-- 1 - Afficher la liste des hôtels.
-- Le résultat doit faire apparaître le nom de l’hôtel et la ville
SELECT hot_nom, hot_ville
FROM hotel;

-- 2 - Afficher la ville de résidence de Mr White
-- Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client
SELECT cli_nom, cli_prenom, cli_adresse, 
FROM client;
WHERE 

-- 3 - Afficher la liste des stations dont l’altitude < 1000
-- Le résultat doit faire apparaître le nom de la station et l'altitude
SELECT sta_nom, sta_altitude
FROM station
WHERE sta_altitude <1000;

-- 4 - Afficher la liste des chambres ayant une capacité > 1
-- Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité
SELECT cha_numero, cha_capacite
FROM chambre
WHERE cha_capacite >1;

-- 5 - Afficher les clients n’habitant pas à Londres
-- Le résultat doit faire apparaître le nom du client et la ville
SELECT cli_nom, cli_ville
FROM client
WHERE cli_ville <>'Londres';

-- 6 - Afficher la liste des hôtels située sur la ville de Bretou et possédant une catégorie > 3
-- Le résultat doit faire apparaître le nom de l'hôtel, ville et la catégorie
SELECT hot_nom, hot_ville, hot_categorie
FROM hotel
WHERE hot_categorie >3 AND hot_ville= 'Bretou';


-- Lot 2
-- 7 - Afficher la liste des hôtels avec leur station
-- Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, la catégorie, la ville
SELECT sta_nom, hot_nom, hot_categorie, hot_ville
FROM station
JOIN hotel ON hot_sta_id = sta_id;

-- 8 - Afficher la liste des chambres et leur hôtel
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre
SELECT hot_nom, hot_categorie, hot_ville, cha_numero
FROM hotel
JOIN chambre ON hot_id = cha_hot_id;

-- 9 - Afficher la liste des chambres de plus d'une place dans des hôtels situés sur la ville de Bretou
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité
SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite
FROM hotel
JOIN chambre ON hot_id = cha_hot_id
WHERE cha_capacite >1 AND hot_ville= 'Bretou';

-- 10 - Afficher la liste des réservations avec le nom des clients
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation
SELECT cli_nom, hot_nom, res_date
FROM client
JOIN reservation ON cli_id = res_cli_id
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id;

-- 11 - Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station
-- Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité
SELECT sta_nom, hot_nom, cha_numero, cha_capacite
FROM chambre
JOIN hotel ON cha_hot_id = hot_id
JOIN station ON hot_sta_id = sta_id;

-- 12 - Afficher les réservations avec le nom du client et le nom de l’hôtel avec datediff
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour
SELECT cli_nom, hot_nom, res_date_debut, datediff(res_date_fin,res_date_debut)
FROM client
JOIN reservation ON cli_id = res_cli_id
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id;

-- Lot 3 : fonctions d'agrégation
-- 13 - Compter le nombre d’hôtel par station
SELECT sta_nom, COUNT(hot_id)
FROM hotel
JOIN station ON sta_id = hot_sta_id
GROUP BY hot_sta_id;

-- 14 - Compter le nombre de chambres par station
SELECT sta_nom, COUNT(cha_id)
FROM chambre
JOIN hotel ON hot_id = cha_hot_id
INNER JOIN station ON sta_id = hot_sta_id
GROUP BY sta_id;

-- 15 - Compter le nombre de chambres par station ayant une capacité > 1
SELECT sta_nom, COUNT(cha_id)
FROM chambre
JOIN hotel ON hot_id = cha_hot_id
INNER JOIN station ON sta_id = hot_sta_id
WHERE cha_capacite >1
GROUP BY sta_id;

-- 16 - Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation
SELECT hot_nom, cli_nom
FROM client
JOIN reservation ON res_cli_id = cli_id
INNER JOIN chambre ON res_cha_id = cha_id
INNER JOIN hotel ON cha_hot_id = hot_id
WHERE cli_nom = 'Squire';

-- 17 - Afficher la durée moyenne des réservations par station
SELECT sta_nom, avg(datediff(res_date_fin,res_date_debut))
FROM reservation
JOIN chambre ON res_cha_id = cha_id
INNER JOIN hotel ON cha_hot_id = hot_id
INNER JOIN station ON sta_id = hot_sta_id
GROUP BY sta_nom;