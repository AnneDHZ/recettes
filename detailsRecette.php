<?php

$mysqlClient = new PDO(
	'mysql:host=localhost;dbname=recette_anne;charset=utf8',
	'root',
	''
);

//req pour selectionner la recette en fonction de son id_recette
$id = $_GET["id"];

$sqlQuery = 'SELECT r.nomRecette, c.nomCategorie, r.tempsPrepa, r.instructions
FROM recette r
INNER JOIN categorie c
ON r.id_categorie = c.id_categorie
WHERE r.id_recette = :id';
$declarationRecette = $mysqlClient->prepare($sqlQuery);
$declarationRecette->execute(["id" => $id]);
$recette = $declarationRecette->fetch();

// req pour les infos
$sqlQuery = 'SELECT ir.quantite, i.nomIngredient, ir.uniteMesure, i.prix
FROM recette r
INNER JOIN ingredientparrecette ir 
ON r.id_recette = ir.id_recette
INNER JOIN ingredient i
ON i.id_ingredient = ir.id_ingredient
WHERE r.id_recette = :id';
$declarationRecette = $mysqlClient->prepare($sqlQuery);
$declarationRecette->execute(["id" => $id]);
$infos = $declarationRecette->fetchAll();

// req prix total recette
$sqlQuery = 'SELECT ROUND(SUM(i.prix * ir.quantite), 2) AS prixTotal   
FROM ingredient i
INNER JOIN ingredientparrecette ir
ON i.id_ingredient = ir.id_ingredient
WHERE ir.id_recette = :id';
$declarationRecette = $mysqlClient->prepare($sqlQuery);
$declarationRecette->execute(["id" => $id]);
$prixTotal = $declarationRecette->fetch();


// On affiche les infos 
?>
    <h1>
        <?php echo $recette['nomRecette']; ?>
    </h1>

    <p>catégorie : <?= $recette['nomCategorie']; ?></p><br>

<?php    
        if ($prixTotal["prixTotal"]) { ?>
            <p>prix total : <?= $prixTotal['prixTotal']; ?> €, oui c'est cher...</p><br>            
<?php }
        else {
            echo 'elle est gratuite';
        }
?>
    <p>temps de préparation : <?= $recette['tempsPrepa']; ?> minutes</p><br>
    
    <h2>Composition</h2>
    
    <ul>

<?php
        if (count($infos) > 0) {
            foreach ($infos as $info){  ?>
                <li>
                    <?= $info['nomIngredient'] ?>, <?= $info['quantite'] ?> <?= $info['uniteMesure'] ?> à <?= $info['prix'] ?> €
                </li>
            <?php }
        }
        else {
            echo 'Il n\'y a pas d\'ingrédient pour cette recette';
        }
?>
    </ul>
    
    <h3>Instructions : </h3>

    <p><?= $recette['instructions']; ?></p>

   
    <a href="recettes.php" class="lien">retour vers recettes</a><br>