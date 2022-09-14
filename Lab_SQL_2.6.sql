USE sakila;

-- LAB 2.6


-- 1. In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT last_name
FROM (
    SELECT last_name
    FROM sakila.actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
) AS ONLY_ONCE;

-- 2. Using the rental table, find out how many rentals were processed by each employee.

SELECT staff_id, COUNT(staff_id) FROM sakila.rental 
GROUP BY staff_id; -- 8040 by employee no. 1 and 8004 by employee no. 2

-- 3. Using the film table, find out how many films were released each year.

SELECT release_year, COUNT(release_year) FROM sakila.film
GROUP BY release_year; -- 1,000 films all released in 2006

-- 4. Using the film table, find out for each rating how many films were there.

SELECT rating, COUNT(rating) FROM sakila.film
GROUP BY rating; -- Same code as the previous two questions. Using GROUP BY

-- 5. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length),2) FROM sakila.film
GROUP BY rating;

-- 6. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, AVG(length)
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120; -- Only PG-13 movies have an average length greater than 2 hours.

-- 7. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

SELECT length, title, RANK() OVER(ORDER BY length DESC) AS 'rank' -- Can also do DENSE RANK() so it is completely ordinal 1,2,3,4 etc. But this makes the most sense imo
FROM sakila.film
WHERE length != '' AND length is NOT NULL;
