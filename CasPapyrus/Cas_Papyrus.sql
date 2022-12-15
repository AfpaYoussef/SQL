-- Les besoins d'affichage
-- 1-- Quelles sont les commandes du fournisseur n°9120 ?
SELECT numcom, numfou
FROM entcom
WHERE numfou = '9120';

-- 2-- Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
SELECT numfou, numcom
FROM entcom;

-- 3-- Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
SELECT COUNT(numcom) AS 'Nombre de commandes fournisseurs passées', numfou
FROM entcom
GROUP BY numfou;

-- 4-- Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000.
-- -- Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)
SELECT codart, libart, stkphy, stkale, qteann
FROM produit
WHERE stkphy < stkale AND qteann < 1000;


-- 5-- Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ?
-- -- L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.
SELECT posfou, nomfou
FROM fournis
WHERE 92 AND 78 AND 77 AND 75
ORDER BY posfou DESC, nomfou ASC;

-- 6-- Quelles sont les commandes passées en mars et en avril ?
SELECT datcom
FROM entcom
WHERE MONTH(datcom)= "03" OR MONTH(datcom)= "04";



-- 7 Quelles sont les commandes du jour qui ont des observations particulières ?
--  Afficher numéro de commande et date de commande
SELECT numcom, datcom, obscom
FROM entcom
WHERE obscom <> '';



-- 8 Lister le total de chaque commande par total décroissant.
--     Afficher numéro de commande et total
SELECT numcom, sum(qtecde*priuni) AS total
FROM ligcom
GROUP BY numcom
ORDER BY total DESC;


-- 9 Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.
--     Afficher numéro de commande et total
SELECT numcom,qtecde, sum(qtecde*priuni) AS total 
FROM ligcom
WHERE qtecde <= 1000
GROUP BY numcom, qtecde, qtecde*priuni > 10000;



-- 10 Lister les commandes par nom de fournisseur.
-- Afficher nom du fournisseur, numéro de commande et date
SELECT nomfou, numcom, datcom
FROM entcom
INNER JOIN fournis ON fournis.numfou = entcom.numfou
GROUP BY nomfou, numcom, datcom;



-- 11 Sortir les produits des commandes ayant le mot "urgent' en observation.
-- Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)
SELECT entcom.numcom, libart, obscom, sum(qtecde*priuni), fournis.nomfou
FROM entcom
JOIN ligcom ON ligcom.numcom = entcom.numcom
JOIN produit ON produit.codart = ligcom.codart
JOIN fournis ON entcom.numfou = fournis.numfou
WHERE obscom = 'commande urgente'
GROUP BY obscom, qtecde*priuni, fournis.nomfou;


-- 12 Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.
-- 1ière manière
SELECT fournis.nomfou, qtecde
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
WHERE qtecde > 0
GROUP BY fournis.nomfou, qtecde;

-- 2ième manière
SELECT fournis.nomfou, sum(qtecde)
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
WHERE qtecde > 0
GROUP BY fournis.nomfou
ORDER BY fournis.nomfou ASC;


-- 13 Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.
-- Afficher numéro de commande et date
SELECT fournis.nomfou, ent.numcom, datcom
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
WHERE numcom = 70210



 














