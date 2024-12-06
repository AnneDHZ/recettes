-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour recette_anne
CREATE DATABASE IF NOT EXISTS `recette_anne` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `recette_anne`;

-- Listage de la structure de table recette_anne. categorie
CREATE TABLE IF NOT EXISTS `categorie` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nomCategorie` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Listage des données de la table recette_anne.categorie : ~3 rows (environ)
INSERT INTO `categorie` (`id_categorie`, `nomCategorie`) VALUES
	(1, 'Entree'),
	(2, 'Plat'),
	(3, 'Dessert');

-- Listage de la structure de table recette_anne. ingredient
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `nomIngredient` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL DEFAULT '',
  `prix` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Listage des données de la table recette_anne.ingredient : ~38 rows (environ)
INSERT INTO `ingredient` (`id_ingredient`, `nomIngredient`, `prix`) VALUES
	(1, 'Tomates', 1.2),
	(2, 'Mozzarella', 2.5),
	(3, 'Basilic', 0.8),
	(4, 'Huile d\'olive', 1.99),
	(5, 'Vinaigre balsamique', 1.55),
	(6, 'Pain de campagne', 1.2),
	(7, 'Fromage de chèvre', 2.1),
	(8, 'Miel', 1.5),
	(9, 'Noix', 2.3),
	(10, 'Salade', 1.5),
	(11, 'Concombre', 2),
	(12, 'Yahourt nature', 50),
	(13, 'Ail', 0.5),
	(14, 'Menthe', 0.7),
	(15, 'Poivrons', 1.4),
	(16, 'Courgettes', 1),
	(17, 'Aubergines', 1.6),
	(18, 'Feta', 1.8),
	(19, 'Pâtes', 1),
	(20, 'Sauce tomate', 1.5),
	(21, 'Œufs', 1.2),
	(22, 'Épinards', 1),
	(23, 'Fromage râpé', 1.5),
	(24, 'Blanc de poulet', 2.3),
	(25, 'Riz basmati', 1.5),
	(26, 'Curry en poudre', 1),
	(27, 'Lait de coco', 1.8),
	(28, 'Oignon', 0.6),
	(29, 'Pâte brisée', 1.5),
	(30, 'Pommes', 1.2),
	(31, 'Sucre', 0.8),
	(32, 'Beurre', 1.5),
	(33, 'Cannelle', 1),
	(34, 'Farine', 0.8),
	(35, 'Confiture de fraises', 2.4),
	(37, 'Lardons', 3.5),
	(38, 'licorne', 50),
	(39, 'Poivre', 2.5);

-- Listage de la structure de table recette_anne. ingredientparrecette
CREATE TABLE IF NOT EXISTS `ingredientparrecette` (
  `quantite` float DEFAULT NULL,
  `uniteMesure` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `id_ingredient` int DEFAULT NULL,
  `id_recette` int DEFAULT NULL,
  KEY `id-ingredient` (`id_ingredient`) USING BTREE,
  KEY `id-recette` (`id_recette`) USING BTREE,
  CONSTRAINT `FK_ingredientparrecette_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`),
  CONSTRAINT `FK_ingredientparrecette_recette` FOREIGN KEY (`id_recette`) REFERENCES `recette` (`id_recette`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Listage des données de la table recette_anne.ingredientparrecette : ~49 rows (environ)
INSERT INTO `ingredientparrecette` (`quantite`, `uniteMesure`, `id_ingredient`, `id_recette`) VALUES
	(2, 'tomates', 1, 1),
	(1, 'boule', 2, 1),
	(0.5, 'botte', 3, 1),
	(2, 'cuillères à soupe', 4, 1),
	(1, 'cuillère à soupe', 5, 1),
	(4, 'tranches', 6, 2),
	(100, 'g', 7, 2),
	(1, 'cuillère à soupe', 8, 2),
	(30, 'g', 9, 30),
	(1, 'poignée', 10, 2),
	(2, 'pièces', 11, 3),
	(200, 'ml', 12, 3),
	(1, 'gousse', 13, 3),
	(5, 'feuilles', 14, 3),
	(1, 'pièce', 15, 4),
	(1, 'pièce', 16, 4),
	(1, 'pièce', 17, 4),
	(100, 'g', 18, 4),
	(2, 'cuillères à soupe', 4, 4),
	(250, 'g', 19, 5),
	(200, 'ml', 20, 5),
	(5, 'feuilles', 3, 5),
	(100, 'g', 22, 6),
	(3, 'pièces', 21, 6),
	(50, 'g', 23, 6),
	(200, 'g', 24, 7),
	(150, 'g', 25, 7),
	(2, 'cuillères à soupe', 26, 7),
	(200, 'ml', 27, 7),
	(1, 'pièce', 28, 7),
	(1, 'pièce', 29, 8),
	(3, 'pièces', 30, 8),
	(50, 'g', 31, 8),
	(30, 'g', 32, 8),
	(1, 'cuillère à café', 33, 8),
	(200, 'g', 34, 9),
	(2, 'pièces', 21, 9),
	(300, 'ml', 12, 9),
	(50, 'g', 35, 9),
	(4, 'pièces', 30, 10),
	(30, 'g', 31, 10),
	(1, 'cuillère à café', 33, 10),
	(0.2, 'Lardons', NULL, NULL),
	(200, 'g', 37, 12),
	(500, 'g', 19, 12),
	(4, 'oeufs', 21, 12),
	(1, 'licorne', 38, 15),
	(1, 'gousse', 13, 5),
	(1, 'g', 39, NULL);

-- Listage de la structure de table recette_anne. recette
CREATE TABLE IF NOT EXISTS `recette` (
  `id_recette` int NOT NULL AUTO_INCREMENT,
  `nomRecette` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL DEFAULT '0',
  `tempsPrepa` int NOT NULL DEFAULT '0',
  `instructions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci,
  `id_categorie` int DEFAULT NULL,
  PRIMARY KEY (`id_recette`),
  KEY `id-categorie` (`id_categorie`) USING BTREE,
  CONSTRAINT `FK_recette_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Listage des données de la table recette_anne.recette : ~12 rows (environ)
INSERT INTO `recette` (`id_recette`, `nomRecette`, `tempsPrepa`, `instructions`, `id_categorie`) VALUES
	(1, 'Salade tomate mozza', 15, 'Couper les tomates en tranches, ajouter la mozza, le basilic et assaisonner avec l\'huile d\'olive, sel et poivre', 1),
	(2, 'Tartines de formage de chèvre et miel', 20, 'Faire griller le pain de campagne, ajouter du fromage de chèvre, du miel et des noix, garnir de roquette', 1),
	(3, 'Gloubiboulga concombre et yahourt', 25, 'Mixer le concombre, ajouter le yahourt nature, l\'ail et la menthe, assaisonner avec set et poivre', 1),
	(4, 'Salade de quinoa et légumes grillés', 35, 'Cuire le quinoa et faire griller les légumes (poivrons, courgettes, aubergones). mélanger la feta et assaisonner avec l\'huile d\'olive, sel et poivre.', 2),
	(5, 'Pâtes sauce tomate et basilic', 20, 'Cuire les pâtes, chauffer la sauce tomate avec l\'ail et le basilic puis mélanger avec les pâtes', 2),
	(6, 'Omelette aux épinards et formage râpé', 15, 'Cuire les épinards dans une poêle, ajouter les oeufs battus et le fromage râpés, cuire jusqu\'à ce que l\'omelette soit bien dorée', 2),
	(7, 'Poulet curry avec riz basmati', 40, 'Cuire le poulet dans le curry en poudre et le lait de coco, servir avec du riz basmati.', 2),
	(8, 'Tarte aux pommes simple', 45, 'Cuire la pâte brisée, disposer les pommes tranchées, saupoudrer de sucre et de canelle, puis cuir au four', 3),
	(9, 'Crêpes sucrées à la confiture de fraises', 25, 'Préparer la pâte à crêpes, cuire les crêpes puis les garnie de confiture de fraises', 3),
	(10, 'Compote de pommes maison', 35, 'Faire cuire les pommes avec du sucre et de la canelle puis mixer pour obtenir une compote', 3),
	(12, 'Pâte carbonara', 15, 'Faire cuire les pâtes, pendant ce temps faire revenir les lardons et battre les oeufs en omelette. Une fois l\'ensemble cuit, mélanger le tout et refaire un peu cuire.', 3),
	(16, 'Eau chaude', 2, 'Verser de l\'eau chaude dans une tasse', 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
