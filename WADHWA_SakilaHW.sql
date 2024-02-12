use sakila;

-- 1) List of Actors in a Specific Film: 
-- Write an SQL query to list all actors (first name and last name) who appeared in the film titled "ACADEMY DINOSAUR".
SELECT film.title, actor.first_name, actor.last_name -- title, first name, last name
FROM film -- from film table
JOIN film_actor ON film.film_id = film_actor.film_id -- join film_actor by film id
JOIN actor ON film_actor.actor_id = actor.actor_id -- join actor by actor id
WHERE film.title = 'ACADEMY DINOSAUR'
ORDER BY actor.last_name, actor.first_name;

-- 2) Count of Films in Each Category
-- Create an SQL query to count how many films there are in each category. 
-- Display the category name and the count of films.
SELECT category.name AS category, COUNT(film_category.category_id) AS count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

-- 3) Average Rental Duration for Each Rating
-- Construct an SQL query to find the average rental duration of films for each rating category (G, PG, etc.). 
-- Display the rating and the average rental duration.
SELECT film.rating, AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS average_rental_duration
FROM rental 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.rating;

-- 4) Total Number of Rentals for Each Customer
-- Develop an SQL query to count the total number of rentals made by each customer. 
-- Include the customer's first name, last name, and the count of their rentals.
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) as total_rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

-- 5) Stores with the Highest Number of Rentals
-- Write an SQL query to find which store has the highest number of rentals. 
-- Display the store ID and the count of rentals.
SELECT inventory.store_id, COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY inventory.store_id
ORDER BY total_rentals DESC
LIMIT 1;

-- 6) Most Popular Film Category Among Customers
-- Formulate an SQL query to find the most popular film category among customers based on rental data. 
-- Display the category name and the count of rentals.
SELECT category.name, COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_rentals DESC
LIMIT 1;

-- 7) Average Rental Cost of Films by Category
-- Create an SQL query to calculate the average rental cost (rental_rate) of films within each category. 
-- Display the category name and the average rental rate.
SELECT category.name, AVG(payment.amount) AS average_rental_cost
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name;

-- 8) List of Films Not Rented in the Last Month (which will be all of them)
-- Display the film title and the last rental date, if available.
SELECT film.title, MAX(rental.rental_date) AS last_rental
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id 
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id -- left join to include null as well
GROUP BY film.title;

-- 9) Customer Spending on Rentals
-- Construct an SQL query to calculate the total amount spent by each customer on rentals. 
-- Display the customer's name and their total spending.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

-- 10) Average Length of Films in Each Language
-- Develop an SQL query to find the average length of films for each language. 
-- Display the language and the average length of the films.
SELECT language.name AS language, AVG(film.length) AS average_length
FROM language
JOIN film ON language.language_id = film.language_id
GROUP BY language.language_id;
