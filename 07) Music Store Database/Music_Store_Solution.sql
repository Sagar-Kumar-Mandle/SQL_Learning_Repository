SELECT * FROM customer
SELECT * FROM employee
SELECT * FROM invoice
SELECT * FROM invoice_line

SELECT * FROM track
SELECT * FROM media_type
SELECT * FROM genre

SELECT * FROM playlist_track
SELECT * FROM playlist

SELECT * FROM album
SELECT * FROM artist
---------------------------------------------------------------------------------------------
-- Q1) Who is the senior most employee based on job title?

SELECT
	employee_id,
	CONCAT_WS(' ',first_name,last_name),
	title,
	levels,
	phone,
	email
FROM employee
WHERE levels = (SELECT MAX(levels) FROM employee);

-- Q2) Which countries have the most Invoices? 

SELECT 
	billing_country,
	COUNT(invoice_id) AS inv
FROM invoice 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Q3) What are top 3 values of total invoice? 

SELECT 
	i.customer_id,
	CONCAT_WS(' ',c.first_name,c.last_name) AS customer_name,
	SUM(i.total) AS total
FROM invoice i JOIN customer c ON i.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 3;


-- Q4) Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--     Write a query that returns one city that has the highest sum of invoice totals. 
--	   Return both the city name & sum of all invoice totals 

SELECT 
	billing_city,
	SUM(total) AS total
FROM invoice 
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 1;


-- Q5) Who is the best customer? The customer who has spent the most money will be 
--     declared the best customer. Write a query that returns the person who has spent the 
--     most money

SELECT 
	i.customer_id,
	CONCAT_WS(' ',c.first_name,c.last_name) AS customer_name,
	SUM(i.total) AS total
FROM invoice i JOIN customer c ON i.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;


-- Q6) Write query to return the email, first name, last name, & Genre of all Rock Music 
--     listeners. Return your list ordered alphabetically by email starting with A 

SELECT DISTINCT
	CONCAT_WS(' ',c.first_name,c.last_name) AS customer_name,
	c.phone,
	c.email,
	g.name AS genre	
FROM customer c JOIN invoice i 		 ON i.customer_id = c.customer_id
				JOIN invoice_line il ON i.invoice_id  = il.invoice_id
				JOIN track t 		 ON t.track_id    = il.track_id
				JOIN genre g         ON g.genre_id    = t.genre_id
WHERE g.name IN ('Rock')
ORDER BY 1 ASC;

-- Q7) Lets invite the artists who have written the most rock music in our dataset. Write a 
--     query that returns the Artist name and total track count of the top 10 rock bands 


SELECT 
	a.artist_id,
	a.name AS artist_name,
	COUNT(t.track_id) AS total_track_count
FROM artist a JOIN album alb ON a.artist_id   = alb.artist_id
              JOIN track t   ON alb.album_id  = t.album_id
			  JOIN genre g   ON g.genre_id    = t.genre_id
WHERE g.name IN ('Rock')
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10;

-- Q8) Return all the track names that have a song length longer than the average song length. 
--    Return the Name and Milliseconds for each track. Order by the song length with the 
--    longest songs listed first 

SELECT
	name,
	milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY 2 DESC;

-- Q9) Find how much amount spent by each customer on artists? Write a query to return 
--     customer name, artist name and total spent 

SELECT 
	CONCAT_WS(' ',c.first_name,c.last_name) AS customer_name,
	a.name AS artist_name,
	SUM(il.unit_price * il.quantity) AS total_spend
FROM customer c JOIN invoice i 		 ON i.customer_id = c.customer_id
				JOIN invoice_line il ON i.invoice_id  = il.invoice_id
				JOIN track t 		 ON t.track_id    = il.track_id
				JOIN album alb		 ON alb.album_id  = t.album_id
				JOIN artist a        ON a.artist_id   = alb.artist_id
GROUP BY 1,2
ORDER BY 1,3 DESC;

   
-- Q10) We want to find out the most popular music Genre for each country. We determine the 
--  	most popular genre as the genre with the highest amount of purchases. Write a query 
--	    that returns each country along with the top Genre. For countries where the maximum 
--      number of purchases is shared return all Genres 

WITH top_genre AS
(
SELECT
	i.billing_country AS country,
	g.name AS genre_name,
	COUNT(g.genre_id) AS no_of_purchases
FROM invoice i  JOIN invoice_line il ON i.invoice_id  = il.invoice_id
				JOIN track t 		 ON t.track_id    = il.track_id
				JOIN genre g		 ON g.genre_id    = t.genre_id
GROUP BY 1,2
),
ranks AS
(
SELECT
	*,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY no_of_purchases DESC ) AS rno
FROM top_genre
)
SELECT
	*
FROM ranks
WHERE rno IN (1);

				
-- Q11) Write a query that determines the customer that has spent the most on music for each 
--      country. Write a query that returns the country along with the top customer and how 
--      much they spent. For countries where the top amount spent is shared, provide all 
--      customers who spent this amount

WITH top_customer AS
(
SELECT 
	c.country,
	CONCAT_WS(' ',c.first_name,c.last_name) AS customer_name,
	SUM(i.total) AS total_spent
FROM customer c JOIN invoice i ON i.customer_id = c.customer_id
GROUP BY 1,2
),
ranks AS (
SELECT
   *,
   DENSE_RANK() OVER(PARTITION BY country ORDER BY total_spent DESC) AS rno
FROM top_customer
)
SELECT *
FROM ranks
WHERE rno = 1;


