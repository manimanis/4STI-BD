DROP DATABASE IF EXISTS films;
CREATE DATABASE films;
USE films;

CREATE TABLE artiste (
    art_id INT AUTO_INCREMENT PRIMARY KEY,
    art_nom VARCHAR(64) NOT NULL,
    art_dn DATE
);

CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    film_nom VARCHAR(192) NOT NULL,
    film_annee INT
);

CREATE TABLE artiste_film (
    film_id INT,
    art_id INT,
    film_type VARCHAR(32)
);

CREATE TABLE nationalite_film (
    film_id INT,
    film_pays VARCHAR(64)
);

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

