CREATE DATABASE sql_exercise_4;

USE sql_exercise_4;

CREATE TABLE movies (
	code INT PRIMARY KEY,
    title VARCHAR(225) NOT NULL,
    rating VARCHAR(225)
);

DESCRIBE movies;

CREATE TABLE movie_theatres (
	code INT PRIMARY KEY,
    name VARCHAR(225) NOT NULL,
    movie INT,
    FOREIGN KEY(movie) REFERENCES movies(code)
);

DESCRIBE movie_theatres;

INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);

SELECT * FROM movies;

INSERT INTO movie_theatres(Code,Name,Movie) VALUES(1,'Odeon',5);
INSERT INTO movie_theatres(Code,Name,Movie) VALUES(2,'Imperial',1);
INSERT INTO movie_theatres(Code,Name,Movie) VALUES(3,'Majestic',NULL);
INSERT INTO movie_theatres(Code,Name,Movie) VALUES(4,'Royale',6);
INSERT INTO movie_theatres(Code,Name,Movie) VALUES(5,'Paraiso',3);
INSERT INTO movie_theatres(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);

SELECT * FROM movie_theatres;

-- 1 Select the title of all movies.

SELECT title FROM movies;

-- 2 Show all the distinct ratings in the database.

SELECT DISTINCT rating FROM movies;

-- 3  Show all unrated movies.

SELECT * FROM movies 
WHERE rating IS NULL;

-- 4 Select all movie theaters that are not currently showing a movie.

SELECT * FROM movie_theatres
WHERE movie IS NULL;

-- 5 Select all data from all movie theaters 
-- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

SELECT * FROM
movie_theatres AS mt LEFT JOIN movies AS m
ON mt.movie = m.code
WHERE mt.movie IS NOT NULL;

-- 6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.

SELECT * FROM movies LEFT JOIN movie_theatres ON movies.code = movie_theatres.movie;

-- 7 Show the titles of movies not currently being shown in any theaters.

SELECT m.title FROM 
movies AS m LEFT JOIN movie_theatres AS mt
ON m.code = mt.movie
WHERE mt.movie IS NULL;

-- 8 Add the unrated movie "One, Two, Three".

INSERT INTO movies VALUE (9, 'One, Two, Three', NULL);

-- 9 Set the rating of all unrated movies to "G".

UPDATE movies 
SET rating = 'G'
WHERE rating IS NULL;

-- 10 Remove movie theaters projecting movies rated "NC-17".

delete from movie_theatres
where movie in (
	select code from movies
    where rating = 'NC-17'
);
