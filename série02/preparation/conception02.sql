-- Q3
ALTER TABLE film
ADD COLUMN film_pays VARCHAR(64) NOT NULL;

-- Q4
ALTER TABLE film
CHANGE COLUMN film_nom film_titre VARCHAR(192) NOT NULL;

-- Q5
UPDATE film
SET film_pays = (SELECT film_pays 
                 FROM nationalite_film AS nf 
                 WHERE nf.film_id = film.film_id);

-- Q6
DROP TABLE nationalite_film;

-- Q7
ALTER TABLE acteur_film
ADD CONSTRAINT PRIMARY KEY (film_id, act_id);

-- Q8
ALTER TABLE acteur_film
ADD COLUMN personnage VARCHAR(48);

-- Q9
ALTER TABLE acteur_film
ADD CONSTRAINT FOREIGN KEY (film_id)
    REFERENCES film (film_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
ADD CONSTRAINT FOREIGN KEY (act_id)
    REFERENCES acteur (act_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE;
