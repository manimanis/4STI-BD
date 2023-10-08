START TRANSACTION;

--
-- Base de données : `gestion_emprunts`
--
DROP DATABASE IF EXISTS `gestion_emprunts`;
CREATE DATABASE `gestion_emprunts` DEFAULT CHARACTER SET utf8;
USE `gestion_emprunts`;

CREATE TABLE `typelivre` (
  `numTypeLiv` int PRIMARY KEY AUTO_INCREMENT,
  `typeLiv` varchar(65) NOT NULL
);

CREATE TABLE `livre` (
  `numLiv` char(5) PRIMARY KEY,
  `numTypeLiv` int(11),
  `titreLiv` varchar(255) NOT NULL,
  `nbrExLiv` int(11) NOT NULL DEFAULT 1 CHECK (`nbrExLiv` >= 0),
  FOREIGN KEY (numTypeLiv) REFERENCES typelivre(numTypeLiv) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `abonne` (
  `numAb` int PRIMARY KEY AUTO_INCREMENT,
  `nomAb` varchar(65) NOT NULL,
  `prenomAb` varchar(65) NOT NULL,
  `classAb` varchar(8) NOT NULL
);

CREATE TABLE `emprunt` (
  `numAb` int,
  `numLiv` char(5),
  `dateEmp` date DEFAULT current_timestamp(),
  PRIMARY KEY (`numAb`,`numLiv`,`dateEmp`),
  FOREIGN KEY (numLiv) REFERENCES livre(numLiv) 
	ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (numAb) REFERENCES abonne(numAb) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `typelivre` (`numTypeLiv`, `typeLiv`) VALUES
(1, 'Algorithmique'),
(2, 'Base de données'),
(3, 'Multimédia'),
(4, 'Roman');

INSERT INTO `livre` (`numLiv`, `numTypeLiv`, `titreLiv`, `nbrExLiv`) VALUES
('A0001', 1, 'Les algorithmes pour les nuls', 15),
('B0003', 2, 'Les bases de données NoSQL', 3),
('B0004', 2, 'SQL (3° édition)', 2),
('M0001', 3, 'Photo Numérique pour les Nuls', 1),
('M0002', 3, 'La communication par l\'image', 2);

INSERT INTO `abonne` (`numAb`, `nomAb`, `prenomAb`, `classAb`) VALUES
(1, 'Alaya', 'Ibtissem', '4SI'),
(2, 'Barhoumi', 'Mohamed', '3SC2'),
(3, 'Dhouibi', 'Malek', '2TI1'),
(4, 'Nouir', 'Afef', '3SC');

INSERT INTO `emprunt` (`numAb`, `numLiv`, `dateEmp`) VALUES
(1, 'A0001', '2023-07-08'),
(1, 'A0001', '2023-07-15'),
(2, 'A0001', '2023-07-12'),
(2, 'M0002', '2023-07-14'),
(3, 'B0003', '2023-07-11');

COMMIT;
