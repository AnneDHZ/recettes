
<?php

$mysqlClient = new PDO(
	'mysql:host=localhost;dbname=recette_anne;charset=utf8',
	'root',
	''
);


try
{
	$mysqlClient = new PDO('mysql:host=localhost;dbname=recette_anne;charset=utf8', 'root', '');
}
catch (Exception $e)
{
	die('Erreur : ' . $e->getMessage());
}

//req pour afficher toutes les infos
$sqlQuery = 'SELECT r.id_recette, r.nomRecette, c.nomCategorie, r.tempsPrepa
FROM recette r
INNER JOIN categorie c
ON r.id_categorie = c.id_categorie
GROUP BY r.id_recette
ORDER BY nomRecette';
$declarationRecette = $mysqlClient->prepare($sqlQuery);
$declarationRecette->execute();
$recettes = $declarationRecette->fetchAll();
?>

<table border=1>
	<thead>
		<tr>
			<th>Recette</th>
			<th>Catégorie</th>
			<th>Temps de préparation</th>
		</tr>
	</thead>
	<tbody>
		<tr>
<?php
// On affiche chaque recette une à une avec les details:nom, catégorie et temps de préparation
foreach ($recettes as $recette) {
?>
			<td><a href="detailsRecette.php?id=<?= $recette['id_recette'] ?>" class="lien"><?= $recette['nomRecette']; ?></a></td>
			<td><?= $recette['nomCategorie']; ?></td>
			<td><?= $recette['tempsPrepa']; ?> minutes</td>
		</tr>
	</tbody>
	
<?php
}
?>
