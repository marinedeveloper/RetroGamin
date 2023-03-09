-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 09 mars 2023 à 15:36
-- Version du serveur : 5.7.36
-- Version de PHP : 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `retrogamin`
--

-- --------------------------------------------------------

--
-- Structure de la table `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE IF NOT EXISTS `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `brand`
--

INSERT INTO `brand` (`id`, `name`) VALUES
(1, 'Nintendo'),
(2, 'Playstation'),
(3, 'Xbox'),
(4, 'PC');

-- --------------------------------------------------------

--
-- Structure de la table `console`
--

DROP TABLE IF EXISTS `console`;
CREATE TABLE IF NOT EXISTS `console` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3603CFB644F5D008` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `console`
--

INSERT INTO `console` (`id`, `name`, `brand_id`) VALUES
(1, 'ps1', 2),
(2, 'ps2\n', 2),
(5, 'ds', 1),
(6, 'xbox 360\n', 3),
(9, 'gamecube\r\n', 1);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230206110712', '2023-02-06 11:07:20', 501),
('DoctrineMigrations\\Version20230208125657', '2023-02-08 12:57:07', 1069),
('DoctrineMigrations\\Version20230208131228', '2023-02-08 13:14:26', 78),
('DoctrineMigrations\\Version20230208142344', '2023-02-08 14:24:00', 483),
('DoctrineMigrations\\Version20230208151505', '2023-02-08 15:15:13', 387),
('DoctrineMigrations\\Version20230209085405', '2023-02-09 08:59:11', 347),
('DoctrineMigrations\\Version20230210130521', '2023-02-10 13:05:25', 122),
('DoctrineMigrations\\Version20230210131113', '2023-02-10 13:11:17', 114),
('DoctrineMigrations\\Version20230227105028', '2023-02-27 10:58:32', 88),
('DoctrineMigrations\\Version20230227112440', '2023-02-27 11:24:44', 180),
('DoctrineMigrations\\Version20230227115435', '2023-02-27 11:54:38', 247),
('DoctrineMigrations\\Version20230227134419', '2023-02-27 13:44:23', 230),
('DoctrineMigrations\\Version20230307144042', '2023-03-07 14:40:49', 669),
('DoctrineMigrations\\Version20230307152328', '2023-03-07 15:32:29', 89),
('DoctrineMigrations\\Version20230308222731', '2023-03-08 22:27:58', 437);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `total_amount` int(11) NOT NULL,
  `delivery_adress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `user_id`, `total_amount`, `delivery_adress`, `created_at`) VALUES
(35, 6, 4500, '', '2023-03-08 22:28:35'),
(36, 6, 4500, '', '2023-03-08 22:30:20'),
(37, 6, 8400, '', '2023-03-08 22:32:18'),
(38, 6, 8400, '', '2023-03-08 22:34:03');

-- --------------------------------------------------------

--
-- Structure de la table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_association_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_52EA1F0987C91815` (`order_association_id`),
  KEY `IDX_52EA1F094584665A` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order_item`
--

INSERT INTO `order_item` (`id`, `order_association_id`, `product_id`, `quantity`, `price`, `created_at`) VALUES
(45, 35, 10, 3, 4500, '2023-03-08 22:28:35'),
(46, 36, 10, 3, 4500, '2023-03-08 22:30:20'),
(47, 37, 9, 1, 3000, '2023-03-08 22:32:18'),
(48, 37, 11, 2, 5400, '2023-03-08 22:32:18'),
(49, 38, 9, 1, 3000, '2023-03-08 22:34:03'),
(50, 38, 11, 2, 5400, '2023-03-08 22:34:03');

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `code_tva` int(11) NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `console_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD72F9DD9F` (`console_id`),
  KEY `IDX_D34A04AD5D83CC1` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `name`, `image`, `description`, `price`, `code_tva`, `slug`, `console_id`, `updated_at`, `created_at`, `state_id`) VALUES
(8, 'Jak and Daxter', 'jak-and-daxter-63fc946f3d7f4.jpg', 'Jak and Daxter: The Precursor Legacy est un jeu vidéo de plates-formes, développé par Naughty Dog et édité par Sony Computer Entertainment en 2001 sur PlayStation 2. C\'est le premier épisode de la série Jak and Daxter.', 1000, 2, 'Jak-and-Daxter63fc946f3dca5', 2, '2023-02-27 11:30:55', '2023-02-27 11:30:55', NULL),
(9, 'Final fantasy 7', 'ff7-63fc986a45b5b.jpg', 'Final Fantasy VII est un jeu vidéo de rôle développé par Square (devenu depuis Square Enix) sous la direction de Yoshinori Kitase et sorti en 1997, constituant le septième opus de la série Final Fantasy. Premier jeu de la série à être produit pour la console Sony PlayStation ainsi que pour les ordinateurs dotés de Windows, c’est aussi le premier Final Fantasy à utiliser des graphismes en 3D avec des personnages rendus en temps réel et des arrière-plans précalculés.', 3000, 2, 'Final-fantasy-763fc986a4605e', 1, '2023-02-27 11:47:54', '2023-02-27 11:47:54', NULL),
(10, 'Ratchet and Clank', 'ratchet-63fcae040cbeb.png', 'Considéré comme le meilleur jeu de plate-forme de la fin d\'année 2002 sur PS2, Ratchet & Clank redonne un nouveau souffle au jeu de plate-forme en parallèle avec l\'excellent Jak and Daxter. Premier jeu d\'une série encore inachevée, son succès est sans doute dû aux dizaines d\'armes, gadgets et objets disponibles qui, utilisés sur 15 planètes aux environnements variés, donnent au nouvel univers d\'Insomniac Games une diversité étonnante. Le tout livré avec des animations et une bande sonore de qualité, ce jeu est aussi riche en humour qu\'en détails ce qui lui confère une vivacité et une crédibilité impressionnante pour l\'époque.', 1500, 2, 'Ratchet-and-Clank63fcae040d2b7', 1, '2023-02-27 13:20:04', '2023-02-27 13:20:04', NULL),
(11, 'Dark Chronicles', 'dark-chronicle-63fccc223b87b.jpg', 'Dark Chronicle est un jeu vidéo de type action-RPG développé par Level-5 et édité par Sony Computer Entertainment. Il est sorti fin 2002 sur PlayStation 2. Depuis Janvier 2016, le jeu est disponible sur le Store US et EU 1du Playstation Network en version remastérisée pour Playstation 4.', 2700, 2, 'Dark-Chronicles63fccc223bd78', 2, '2023-02-27 15:28:34', '2023-02-27 15:28:34', 1),
(12, 'Phoenix Wright', 'phoenix1-63fcb7011576c.jpg', 'Phoenix Wright: Ace Attorney (逆転裁判 蘇る逆転, Gyakuten Saiban : Yomigaeru Gyakuten?) est un jeu vidéo, développés et édités par l\'entreprise japonaise Capcom. Il est d\'abord sorti sur Game Boy Advance en 2001 au Japon. Le jeu est porté sur Nintendo DS en 2005 au Japon puis en 2006 en Occident. Malgré la construction assez inhabituelle du jeu pour l\'Occident, cette version rencontre un succès critique et commercial.\r\n\r\nLe joueur y incarne un avocat débutant, Phoenix Wright, au cours de quatre affaires, dans lesquelles il devra prouver l\'innocence de ses clients à force de preuves et de contre-interrogatoires. La version Nintendo DS ajoute un cinquième chapitre.', 3000, 2, 'Phoenix-Wright63fcb70115cd2', 5, '2023-02-27 13:58:25', '2023-02-27 13:58:25', 1),
(13, 'Rayman 3', 'rayman3-64010fa135e35.jpg', 'Rayman 3: Hoodlum Havoc est le troisième jeu vidéo de la série Rayman, développé par Ubisoft, sorti sur PC, PlayStation 2, GameCube et Xbox en mars 2003. Une autre version du jeu, en 2D, sort sur GBA au même moment. Le titre est porté sur OS X par Feral Interactive un an plus tard, puis en version HD sur PlayStation 3 et Xbox 360 en mars 2012. C\'est le premier épisode de la série, à ne pas avoir été développé par Michel Ancel et son équipe d\'Ubisoft Montpellier, qui finalisaient le développement de Beyond Good and Evil. Le thème musical du jeu, Madder, a été interprété par le groupe Groove Armada.', 3000, 2, 'Rayman-364010fa136385', 6, '2023-03-02 21:05:37', '2023-03-02 21:05:37', 3),
(14, 'Spyro 1', 'spyro1-6409b86d91106.jpg', 'Spyro the Dragon est une série de jeux vidéo de plates-formes dont le héros est Spyro, un jeune dragon violet. Depuis son premier épisode en 1998 sur PlayStation, Spyro the Dragon, le jeu a connu de nombreuses suites et jeux dérivés.\r\n\r\nCréée par le studio américain Insomniac Games, la série est tour à tour éditée par Sony Computer Entertainment, Universal Interactive et enfin, Activision qui lance en 2011 la série dérivée Skylanders qui devient un grand succès commercial.\r\n\r\nLa série est aujourd\'hui aux mains de Toy\'s for Bob studio à l\'origine de la Reignited Trilogy sortie en 2018. Il s\'agit d\'un remake de la trilogie originale. Aucun autre jeu Spyro n\'a été annoncé depuis.', 2000, 2, 'Spyro-16409b86d9160c', 1, '2023-03-09 10:43:57', '2023-03-09 10:43:57', 1);

-- --------------------------------------------------------

--
-- Structure de la table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `state`
--

INSERT INTO `state` (`id`, `label`) VALUES
(1, 'Bon état.'),
(2, 'Très bon état.'),
(3, 'Mauvais état.'),
(4, 'Assez bon état.');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `adress`, `email`, `password`, `roles`, `username`) VALUES
(5, 'lola', 'dupond', '42 rue des choux', 'test@test.com', '$2y$13$/j3q6.ZoWXvJLe2okPau6u8xu5fFbhFDRYPXRUVNYMrNwJ7iNmAJy', '[]', 'lola42'),
(6, 'lola', 'dupont', 'rue du lila', 'lola42@gmail.com', '$2y$13$z.KRuaz2/.FPmlkhTgm/tODWFvppdMG13wLxhj9GPD7Z9NvnlqzUy', '[\"ROLE_ADMIN\"]', 'lola69');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `console`
--
ALTER TABLE `console`
  ADD CONSTRAINT `FK_3603CFB644F5D008` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`);

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `FK_52EA1F094584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_52EA1F0987C91815` FOREIGN KEY (`order_association_id`) REFERENCES `order` (`id`);

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD5D83CC1` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`),
  ADD CONSTRAINT `FK_D34A04AD72F9DD9F` FOREIGN KEY (`console_id`) REFERENCES `console` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
