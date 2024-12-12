

-- 1 Afficher toutes les recettes disponibles (nom de la recette, catégorie et temps de préparation) triées 
de façon décroissante sur la durée de réalisation

SELECT r.nomRecette, r.tempsPrepa, c.nomCategorie
FROM recette r
INNER JOIN categorie c
ON r.id_categorie = c.id_categorie
GROUP BY r.id_recette DESC;

-- 2 En modifiant la requête précédente, faites apparaître le nombre d’ingrédients nécessaire par recette
SELECT COUNT(ir.id_ingredient) AS nbIngredient, nomRecette
FROM ingredientparrecette ir
INNER JOIN recette r
ON r.id_recette = ir.id_recette
GROUP BY r.id_recette;


-- 3 Afficher les recettes qui nécessitent au moins 30 min de préparation
SELECT r.nomRecette, r.tempsPrepa
FROM recette r
WHERE r.tempsPrepa >= 30;



-- 4 Afficher les recettes dont le nom contient le mot « Salade » (peu importe où est situé le mot en 
question)
SELECT r.nomRecette
FROM recette r
WHERE r.nomRecette LIKE '%salade%';


-- 5 Insérer une nouvelle recette : « Pâtes à la carbonara » dont la durée de réalisation est de 20 min avec 
--les instructions de votre choix. Pensez à alimenter votre base de données en conséquence afin de 
--pouvoir lister les détails de cette recettes (ingrédients)

INSERT INTO recette (nomRecette, tempsPrepa, instructions, id_categorie)
VALUES ('Pâte carbonara', 20, 'Faire cuire les pâtes, pendant ce temps faire revenir les lardons et battre les oeufs en omelette. Une fois l\'ensemble cuit, mélanger le tout et refaire un peu cuire.', 3);

INSERT INTO ingredientparrecette (quantite, uniteMesure, id_ingredient, id_recette)
VALUES (4, 'oeufs', 21, 12);

INSERT INTO ingredientparrecette (quantite, uniteMesure, id_ingredient, id_recette)
VALUES (500, 'g', 19, 12);

INSERT INTO ingredientparrecette (quantite, uniteMesure, id_ingredient, id_recette)
VALUES (200, 'g', 37, 12);



-- 6 Modifier le nom de la recette ayant comme identifiant id_recette = 3 (nom de la recette à votre 
convenance)

UPDATE recette 
SET nomRecette = 'Gloubiboulga concombre et yahourt'
WHERE id_recette=3;


-- 7 Supprimer la recette n°15 de la base de données

DELETE ingredientparrecette
FROM ingredientparrecette ir
WHERE ir.id_recette = 15;

DELETE recette 
FROM recette r
WHERE r.id_recette = 15;


trouvé dans la documentation cette méthode mais reste à approfondir  
ALTER TABLE  ingredientparrecette ir
ADD CONSTRAINT id_ingredient
FOREIGN KEY (id_recette) REFERENCES recette(id_recette) ON DELETE CASCADE;



-- 8 Afficher le prix total de la recette n°5

SELECT SUM(i.prix * ir.quantite) AS prixTotal
FROM ingredient i
INNER JOIN ingredientparrecette ir
ON i.id_ingredient = ir.id_ingredient
WHERE id_recette = 5;


-- 9 Afficher le détail de la recette n°5 (liste des ingrédients, quantités et prix)
SELECT  nomIngredient,
quantite,
SUM(i.prix * ir.quantite) AS prixTotal
FROM ingredient i
INNER JOIN ingredientparrecette ir
ON i.id_ingredient = ir.id_ingredient
WHERE id_recette = 5;

GROUP BY id_ingredient;



-- 10 Ajouter un ingrédient en base de données : Poivre, unité : gramme, prix : 2.5 €
INSERT INTO ingredient (nomIngredient, prix)
VALUES ('Poivre', 2.5);

INSERT INTO ingredientparrecette (quantite, uniteMesure, id_ingredient)
VALUES (1, 'g', 39);

-- 11 Modifier le prix de l’ingrédient n°12 (prix à votre convenance)
UPDATE ingredient
SET prix = 50
WHERE id_ingredient = 12;

-- 12 Afficher le nombre de recettes par catégories : X entrées, Y plats, Z desserts
SELECT c.nomCategorie, 
COUNT(id_recette) AS nombre
FROM recette r
INNER JOIN categorie c
ON r.id_categorie = c.id_categorie
GROUP BY nomCategorie;

-- 13 Afficher les recettes qui contiennent l’ingrédient « Pâtes »
SELECT nomRecette
FROM recette r
WHERE nomRecette LIKE '%Pâte%';

-- 14 Mettez à jour toutes les recettes en diminuant leur temps de préparation de 5 minutes 
UPDATE recette
SET tempsPrepa = tempsPrepa - 5;


-- 15 Afficher les recettes qui ne nécessitent pas d’ingrédients coûtant plus de 2€ par unité de mesure

SELECT nomRecette
FROM recette r
WHERE r.id_recette NOT IN (
    SELECT r.id_recette
    FROM recette r
    INNER JOIN ingredientparrecette ir 
	 ON r.id_recette = ir.id_recette
	 INNER JOIN ingredient i
	 ON i.id_ingredient = ir.id_ingredient
    WHERE i.prix > 2
);


-- 16 Afficher la / les recette(s) les plus rapides à préparer

SELECT nomRecette, tempsPrepa
FROM recette 
WHERE tempsPrepa = (
    SELECT MIN(tempsPrepa) FROM recette
);


-- 17 Trouver les recettes qui ne nécessitent aucun ingrédient (par exemple la recette de la tasse d’eau 
-- chaude qui consiste à verser de l’eau chaude dans une tasse)

SELECT r.nomRecette
FROM recette r
WHERE r.id_recette NOT IN (
    SELECT r.id_recette
    FROM ingredientparrecette ir 
    INNER JOIN ingredient i
	ON i.id_ingredient = ir.id_ingredient
    WHERE i.nomIngredient IS NULL
);

-- cette requette me renvoi toutes les recettes sans exception
-- OU 

SELECT r.nomRecette
FROM recette r
LEFT JOIN ingredientparrecette ir 
ON r.id_recette = ir.id_recette
LEFT JOIN ingredient i 
ON ir.id_ingredient = i.id_ingredient
WHERE ir.id_ingredient IS NULL;

-- cette requette me renvoi uniquement la recette eau chaude


-- 18 Trouver les ingrédients qui sont utilisés dans au moins 3 recettes
SELECT ir.id_ingredient, nomIngredient
FROM ingredientparrecette ir
INNER JOIN ingredient i
ON i.id_ingredient = ir.id_ingredient
GROUP BY i.nomIngredient
HAVING COUNT(DISTINCT ir.id_recette) >= 3;

-- renvoi id 21 nom oeufs

-- 19 Ajouter un nouvel ingrédient à une recette spécifique

INSERT INTO ingredient (nomIngredient, prix)
VALUES ('Choux', 1.5);

INSERT INTO ingredientparrecette (id_ingredient, id_recette, quantite, uniteMesure)
SELECT i.id_ingredient, 10, 0.5, 'kg'  
FROM ingredient i
WHERE i.nomIngredient = 'choux';

-- pour vérifier
SELECT  nomIngredient
FROM ingredient i
INNER JOIN ingredientparrecette ir
ON i.id_ingredient = ir.id_ingredient
WHERE id_recette = 10;


-- 20 Bonus : Trouver la recette la plus coûteuse de la base de données (il peut y avoir des ex aequo, il est 
-- donc exclu d’utiliser la clause LIMIT)

Pour chaque recette,  multiplier le prix de chaque ingrédient par la quantité utilisée 
additionner les résultats pour chaque recette.
chercher la recette avec le prix total le plus élevé.


SELECT r.nomRecette -- on demande le nom de la recette
FROM recette r -- dans la table recette
WHERE (  --où
    SELECT SUM(i.prix * ir.quantite) AS prixTotal   --le prix total par recette alias prixTotal
    FROM ingredient i   -- de la table ingredient
    INNER JOIN ingredientparrecette ir  -- joint avec la table ingredient par recette
    ON i.id_ingredient = ir.id_ingredient
    WHERE ir.id_recette = r.id_recette  -- où les id_recette sont identiques entre les tables
) = (  -- comparaison avec le prix total de chaque recette une par une
    SELECT MAX(prixTotal)   
    FROM (  --dans
        SELECT SUM(i.prix * ir.quantite) AS prixTotal   
        FROM ingredient i
        INNER JOIN ingredientparrecette ir
        ON i.id_ingredient = ir.id_ingredient
        GROUP BY ir.id_recette
    ) AS prix_totaux
);

-- OU

WITH RecettePrixTotal AS (   -- table temporaire nommée RecettePrixTotal
    SELECT r.id_recette, r.nomRecette, SUM(ir.quantite * i.prix) AS prixTotal
    FROM ingredientparrecette ir
    JOIN ingredient i ON ir.id_ingredient = i.id_ingredient
    JOIN recette r 
    ON ir.id_recette = r.id_recette
    GROUP BY r.id_recette, r.nomRecette
)  -- calcul le prix total de chaque recette
SELECT *
FROM RecettePrixTotal
WHERE prixTotal = (SELECT MAX(prixTotal) FROM RecettePrixTotal); -- comparaison de chaque prix total et renvoi le maximum

--OU

SELECT r.id_recette, r.nomRecette, SUM(ir.quantite * i.prix) AS prixTotal
FROM ingredientparrecette ir
JOIN ingredient i 
ON ir.id_ingredient = i.id_ingredient
JOIN recette r 
ON ir.id_recette = r.id_recette
GROUP BY r.id_recette, r.nomRecette
HAVING SUM(ir.quantite * i.prix) = (  
        SELECT MAX(totalPrix)
        FROM ( 
            SELECT SUM(ir.quantite * i.prix) AS totalPrix
            FROM ingredientparrecette ir
            JOIN ingredient i 
            ON ir.id_ingredient = i.id_ingredient
            GROUP BY ir.id_recette
        ) AS MaxPrix
    );

OU

--prendre les recettes avec les jointures
SELECT r.id_recette, r.nomRecette, SUM(ir.quantite * i.prix) AS prixTotal
FROM ingredientparrecette ir
JOIN ingredient i 
ON ir.id_ingredient = i.id_ingredient
JOIN recette r 
ON ir.id_recette = r.id_recette
-- les grouper par ordre
GROUP BY r.id_recette, r.nomRecette
-- où la somme des quantité *prix est supérieur à TOUTES les autres
HAVING SUM(ir.quantite * i.prix) >= ALL (
-- dans la somme de chaque recette alias totalPrix
    SELECT SUM(ir.quantite * i.prix) AS totalPrix
    FROM ingredientparrecette ir
    JOIN ingredient i 
    ON ir.id_ingredient = i.id_ingredient
    GROUP BY ir.id_recette
);



