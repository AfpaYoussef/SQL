-- 1- Liste des clients français :
SELECT customers.CompanyName AS "Société", customers.ContactName AS "Contact", customers.ContactTitle AS "Fonction", customers.Phone AS "Téléphone"
FROM customers
WHERE Country = "France";

-- 2- Liste des produits vendus par le fournisseur "Exotic Liquids" :
SELECT products.ProductName AS "Produit", products.UnitPrice  AS "Prix"
FROM products
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE CompanyName = "Exotic Liquids";

-- 3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) :
SELECT suppliers.CompanyName AS "Fournisseur", COUNT(QuantityPerUnit) AS "Nombre de produits"
FROM products
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE Country = "France"
GROUP BY suppliers.CompanyName
ORDER BY COUNT(QuantityPerUnit) DESC;

-- 4- Liste des clients français ayant passé plus de 10 commandes :
SELECT customers.CompanyName AS "Client" , COUNT(OrderID) AS "Nombre de commandes"
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
WHERE Country = "France"
GROUP BY customers.CompanyName
HAVING COUNT(OrderID) > 10;

-- 5- Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
-- NB: chiffre d'affaires (CA) = total des ventes
SELECT customers.CompanyName AS "Client", sum(`order details`.UnitPrice*`order details`.Quantity) AS "CA" , Country AS "Pays"
FROM customers
JOIN orders ON customers.CustomerID = orders.CustomerID
JOIN `order details` ON`order details`.orderID = orders.OrderID
GROUP BY CompanyName
HAVING sum(`order details`.UnitPrice*`order details`.Quantity) > 30000
ORDER BY sum(`order details`.UnitPrice*`order details`.Quantity) DESC;

-- 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :
SELECT orders.ShipCountry AS "PAYS"
FROM orders
JOIN `order details` ON`order details`.OrderID = orders.OrderID
JOIN products ON `order details`.ProductID = products.ProductID
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE CompanyName = "Exotic Liquids"
GROUP BY orders.ShipCountry;

-- 7- Chiffre d'affaires global sur les ventes de 1997 :
-- NB: chiffre d'affaires (CA) = total des ventes
SELECT sum(`order details`.UnitPrice*`order details`.Quantity) AS "Montant Ventes 97"
FROM orders
JOIN `order details` ON `order details`.OrderID = orders.OrderID
WHERE YEAR(OrderDate) = "1997";

-- 8- Chiffre d'affaires détaillé par mois, sur les ventes de 1997 :
SELECT MONTH(OrderDate) AS "Mois 97", sum(`order details`.UnitPrice*`order details`.Quantity) AS "Montant Ventes 97"
FROM orders
JOIN `order details` ON `order details`.OrderID = orders.OrderID
WHERE YEAR(OrderDate) = "1997"
GROUP BY MONTH(OrderDate);

-- 9- A quand remonte la dernière commande du client nommé "Du monde entier" ?
SELECT MAX(OrderDate) AS "Date de dernière commande"
FROM orders
JOIN customers ON orders.CustomerID = customers.CustomerID
WHERE customers.CompanyName = "Du monde entier";

-- 10- Quel est le délai moyen de livraison en jours ?
SELECT ROUND(AVG(DATEDIFF(ShippedDate,OrderDate))) AS "délai moyen de livraison en jours"
FROM orders;