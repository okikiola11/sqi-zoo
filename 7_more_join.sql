-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr = 1962



-- 2. Give year of 'Citizen Kane'
SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane'



-- 3. List all of the Star Trek movies, include the id, title and yr 
-- (all of these movies include the words Star Trek in the title). Order results by year
SELECT id, title, yr
 FROM movie
 WHERE title LIKE '%Star Trek%'
 ORDER BY yr



-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
 FROM actor
 WHERE name LIKE 'Glenn Close'



-- 5. What is the id of the film 'Casablanca'
SELECT id
 FROM movie
 WHERE title LIKE 'Casablanca'




-- 6. Obtain the cast list for 'Casablanca'.

-- what is a cast list?
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT name
 FROM actor
 JOIN casting ON (id = actorid)
 WHERE movieid = 11768




-- 7. Obtain the cast list for the film 'Alien'
SELECT name
 FROM casting
 JOIN movie   ON ( movieid = id)
 JOIN actor x ON ( x.id = actorid )
 WHERE title = 'Alien'




-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title
 FROM actor x 
 JOIN casting y ON ( x.id = y.actorid)
 JOIN movie z   ON ( y.movieid = z.id)
 WHERE x.name = 'Harrison Ford'




/****************************
9. List the films where 'Harrison Ford' 
has appeared - but not in the starring role. [Note: the ord field of casting gives 
the position of the actor. If ord=1 then this actor is in the starring role]
****************************/
SELECT title
 FROM actor x 
 JOIN casting y ON ( x.id = y.actorid)
 JOIN movie z   ON ( y.movieid = z.id)
 WHERE x.name = 'Harrison Ford' AND ord != 1






-- 10. List the films together with the leading star for all 1962 films
SELECT title, name
 FROM movie x 
 JOIN casting y ON ( x.id = y.movieid)
 JOIN actor z   ON (z.id = y.actorid)
 WHERE yr = 1962 AND ord = 1





-- 11. Which were the busiest years for 'Rock Hudson', show the year 
-- and the number of movies he made each year for any year in which he made more than 2 movies
SELECT yr, COUNT(title) 
  FROM movie 
  JOIN casting ON movie.id = movieid
  JOIN actor   ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(name) > 2





/****************************
12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).

Title is not a unique field, create a table of IDs in your subquery
****************************/
SELECT title, name 
 FROM movie JOIN casting ON (movieid = movie.id
                 AND ord = 1)
           JOIN actor ON (actorid = actor.id)
 WHERE movie.id IN (
   SELECT movieid FROM casting
   WHERE actorid IN (
       SELECT id FROM actor
       WHERE name = 'Julie Andrews'))






-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles
SELECT name
 FROM actor
 JOIN casting ON (actor.id = actorid)
 JOIN movie   ON (movieid = movie.id) 
 WHERE ord = 1
 GROUP BY name
 HAVING COUNT(ord) >= 15
 ORDER BY name ASC






-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, 
-- then by title
select title, count(name)
from movie 
join casting on (movie.id = movieid)
join actor   on (actorid = actor.id)
where yr = 1978
group by title
order by count(name) DESC, title






-- 15. List all the people who have worked with 'Art Garfunkel'
select name
from movie
join casting on (movie.id = movieid)
join actor   on (actor.id = actorid)
where movieid in (
                  select movieid 
                  from casting
                  where actorid in (
                        select actor.id
                        from actor 
                        where name = 'Art Garfunkel'))
                        and name != 'Art Garfunkel'