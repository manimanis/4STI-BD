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
    act_id INT,
	personnage VARCHAR(64)
);

CREATE TABLE nationalite_film (
    film_id INT,
    film_pays VARCHAR(64)
);

INSERT INTO film (film_id, film_nom, film_annee, film_type)
VALUES (1, 'Matrix', 1999, 'Science-fiction'),
	   (2, 'Fast and Furious', 2001, 'Aventure'),
	   (3, 'John Wick', 2014, 'Action');

INSERT INTO nationalite_film (film_id, film_pays)
VALUES (1, 'USA'),
	(2, 'USA'),
	(3, 'USA');

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
	(3, 3, 'Bowery King');
	

ALTER TABLE film
    -- Ajouter un champ à film
    ADD COLUMN film_genre VARCHAR(64) NOT NULL, 

    -- Renommer un champ
    CHANGE COLUMN film_nom film_titre VARCHAR(192); 

ALTER TABLE film
    -- Changer le type d'une colonne
    MODIFY film_titre VARCHAR(128); 

ALTER TABLE artiste_film
    -- Ajouter la clé primaire
    ADD CONSTRAINT pk_art_film PRIMARY KEY (film_id, art_id),

    -- Ajouter les clés étrangères
    ADD CONSTRAINT fk_art_film1 FOREIGN KEY (film_id)
        REFERENCES film(film_id),
    ADD CONSTRAINT fk_art_film2 FOREIGN KEY (art_id)
        REFERENCES artiste(art_id);

ALTER TABLE nationalite_film
    ADD PRIMARY KEY (film_id),
    ADD FOREIGN KEY (film_id) 
        REFERENCES film(film_id);

INSERT INTO artiste (art_id, art_nom, art_dn)
VALUES (1, 'Pascal Obispo', '1965-01-06');

INSERT INTO artiste
VALUES (2, 'Dalida', '1933-01-17');

INSERT INTO artiste (art_nom, art_dn)
VALUES ('Robbie Williams', '1974-02-13');

