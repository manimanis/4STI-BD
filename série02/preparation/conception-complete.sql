DROP DATABASE IF EXISTS films;
CREATE DATABASE films;
USE films;

CREATE TABLE acteur (
    act_id INT AUTO_INCREMENT PRIMARY KEY,
    act_nom VARCHAR(64) NOT NULL,
    act_dn DATE
);

CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    film_nom VARCHAR(192) NOT NULL,
    film_annee INT,
    film_type VARCHAR(32)
);

CREATE TABLE acteur_film (
    film_id INT,
    act_id INT
);

CREATE TABLE nationalite_film (
    film_id INT,
    film_pays VARCHAR(64)
);

INSERT INTO acteur (act_id, act_nom, act_dn)
VALUES (1, 'Keanu Reeves', '1964-09-02'),
	(2, 'Carrie-Anne Moss', '1967-08-21'),
	(3, 'Laurence Fishburne', '1961-07-30'),
	(4, 'Jada Oinkett Smith', '1971-09-18'),
	(5, 'Hugo Weaving', '1960-04-04'),
	(6, 'Daniel Bernhardt', '1965-08-31'),
	(7, 'Vin Diesel', '1967-07-18'),
	(8, 'Paul Walker', '1973-09-12'),
	(9, 'Michelle Rodriguez', '1978-07-12'),
	(10, 'Jordana Brewster', '1980-04-26'),
	(11, 'Matt Schulze', '1972-07-03'),
	(12, 'Ian Mc Shane', '1942-09-29'),
	(13, 'Lance Reddick', '1962-07-07'),
	(14, 'John Leguizamo', '1960-07-22');

INSERT INTO film (film_id, film_nom, film_annee, film_type)
VALUES (1, 'Matrix', 1999, 'Science-fiction'),
	   (2, 'Fast and Furious', 2001, 'Aventure'),
	   (3, 'John Wick', 2014, 'Action'),
	   (4, 'Matrix Reloaded', 2003, 'Science-fiction');

INSERT INTO nationalite_film (film_id, film_pays)
VALUES (1, 'USA'),
	(2, 'USA'),
	(3, 'USA'),
	(4, 'USA');
	
ALTER TABLE film
ADD COLUMN film_pays VARCHAR(64) NOT NULL;

ALTER TABLE film
CHANGE COLUMN film_nom film_titre VARCHAR(192) NOT NULL;

UPDATE film
SET film_pays = (SELECT film_pays 
                 FROM nationalite_film AS nf 
                 WHERE nf.film_id = film.film_id);

DROP TABLE nationalite_film;

ALTER TABLE acteur_film
ADD CONSTRAINT PRIMARY KEY (film_id, act_id);

ALTER TABLE acteur_film
ADD COLUMN personnage VARCHAR(48);

ALTER TABLE acteur_film
ADD CONSTRAINT FOREIGN KEY (film_id)
    REFERENCES film (film_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
ADD CONSTRAINT FOREIGN KEY (act_id)
    REFERENCES acteur (act_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

INSERT INTO acteur_film 
VALUES (1, 1, 'Neo'),
	(1, 2, 'Trinity'),
	(1, 3, 'Morpheus'),
	(1, 4, 'Niobe'),
	(1, 5, 'Agent Smith'),
	(1, 6, 'Agent Johnson'),
	(2, 7, 'Dominic Toretto'),
	(2, 8, 'Brian O''Conner'),
	(2, 9, 'Letty Ortiz'),
	(2, 10, 'Mia Toretto'),
	(2, 11, 'Matt Shulze'),
	(3, 1, 'John Wick'),
	(3, 12, 'Winston'),
	(3, 13, 'Charon'),
	(3, 14, 'Aurelio'),
	(3, 3, 'Bowery King'),
	(4, 1, 'Neo'),
	(4, 2, 'Trinity'),
	(4, 3, 'Morpheus'),
	(4, 4, 'Niobe'),
	(4, 5, 'Agent Smith'),
	(4, 6, 'Agent Johnson');

-- Q12.a. 
-- Liste des information des Acteurs en ordre alphabétique
SELECT * 
FROM acteur
ORDER BY act_nom;

-- Q12.b (projection)
-- Liste des films (titre, annee) en ordre chronologique décroissant
SELECT film_titre, film_annee
FROM film
ORDER BY film_annee DESC;

-- Q12.c. (projection & sélection)
-- Liste des acteurs (nom, date de naissance) nés dans les années 70
-- du plus jeune au plus vieux.
SELECT act_nom, act_dn
FROM acteur
WHERE YEAR(act_dn) BETWEEN 1970 AND 1979
ORDER BY act_dn DESC;

-- Q12.d. (Projection + Jointure)
-- Liste des films et des personnages interprétés par les acteurs dans ces films
-- (acteur, titre film, annee, personnage) ordonner par année, puis par titre et 
-- nom d'acteur.
SELECT act_nom, film_titre, film_annee, personnage
FROM acteur AS a, film AS f, acteur_film AS af
WHERE af.act_id = a.act_id AND af.film_id = f.film_id
ORDER BY film_annee, film_titre, act_nom;

-- Q13.e. (Projection + Jointure + Sélection)
-- Déterminer qui est l'acteur qui a interprété "Toretto" dans le film "Fast and Furious"
-- et quel était son age à la date du film.
SELECT act_nom, (film_annee - YEAR(act_dn)) AS Age, personnage
FROM acteur AS a, film AS f, acteur_film AS af
WHERE af.act_id = a.act_id AND af.film_id = f.film_id AND
	personnage LIKE '%Toretto%' AND
	film_titre = 'Fast and Furious';

-- Q13.f. (Projection + Jointure + Sous-requête)
-- Retrouver l'acteur le plus âgé dans chaque film. Ordonner par l'année du film puis par le nom de l'acteur.
SELECT act_nom, film_titre, film_annee
FROM acteur AS a, film AS f, acteur_film AS af
WHERE af.act_id = a.act_id AND af.film_id = f.film_id AND
	(f.film_id, act_dn) IN (
		SELECT film_id, MIN(act_dn)
		FROM acteur AS a, acteur_film AS af
		WHERE af.act_id = a.act_id
		GROUP BY film_id
	)
ORDER BY film_annee, act_nom;

-- Q14.g. 
-- Déterminer le noms de l'acteur qui a interprété le rôle de "Neo" dans le film "Matrix" produit en 1999 ainsi que la liste de tous les films dans lesquels il a joué.
SELECT act_nom, film_titre, film_annee, personnage
FROM acteur AS a, film AS f, acteur_film AS af
WHERE af.act_id = a.act_id AND af.film_id = f.film_id AND
	a.act_id IN (
		SELECT act_id
		FROM acteur_film AS af, film AS f
		WHERE af.film_id = f.film_id AND
			film_annee = 1999 AND
			personnage = 'Neo'
	);