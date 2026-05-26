SELECT * FROM netflix;
----------------------------------------------------------------------------------------------------------------
-- Q1) Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(show_id)  AS "Total Content"
FROM netflix
GROUP BY 1;

-- Q2) Find the most common rating for movies and TV shows

WITH common_rating AS
(
SELECT 
	type,
	rating,
	COUNT(show_id) AS total_shows 
FROM netflix
GROUP BY 1,2
ORDER BY 1 ASC, 3 DESC
),
common_show AS
(
SELECT 
	type,
	rating,
	total_shows,
	ROW_NUMBER() OVER (PARTITION BY type ORDER BY total_shows DESC ) AS rno
FROM common_rating
)
SELECT 
	type,
	rating,
	total_shows
FROM common_show
WHERE rno IN (1);

-- Q3) List all movies released in a specific year (e.g., 2020)

SELECT 
	* 
FROM netflix
WHERE release_year IN (2020)
	  AND
	  type IN('Movie');

-- Q4) Find the top 5 countries with the most content on Netflix

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(country,', '))) AS country,
	COUNT(show_id) AS "Total Content"
FROM netflix
WHERE country IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q5) Identify the longest movie

SELECT 
	 title,
	 duration,
	 TRIM(REPLACE(duration,' min',''))::INTEGER
FROM netflix
WHERE type IN ('Movie')
	  AND
	  duration IS NOT NULL
ORDER BY 3 DESC
LIMIT 1;

-- Q6) Find content added in the last 5 years

SELECT 
	* 
FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 Year';


-- Q7) Find all the movies/TV shows by director 'Rajiv Chilaka'

SELECT 
	director,
	show_id,
	type,
	title
FROM netflix
WHERE director ILIKE ('%Rajiv Chilaka%');


-- Q8) List all TV shows with more than 5 seasons

SELECT 
	show_id,
	title,
	duration,
	SPLIT_PART(duration, ' ',1)::INTEGER
FROM netflix
WHERE type IN ('TV Show')
	AND
	SPLIT_PART(duration, ' ',1)::INTEGER > 5;

-- Q9) Count the number of content items in each genre

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(listed_in,', '))) AS genre,
	COUNT(show_id) AS total_shows
FROM netflix
GROUP BY 1
ORDER BY 2 DESC;

-- Q10) Find each year and the average numbers of content release in India on netflix. 
--       return top 5 year with highest avg content release

WITH avg_content AS
(
SELECT 
	release_year,
	COUNT(show_id) AS total_show
FROM netflix
WHERE country ILIKE ('%India%')
GROUP BY 1
ORDER BY 1 ASC
)
SELECT
	*,
	ROUND( (total_show * 100.0) / ( SELECT SUM(total_show) FROM avg_content), 2) AS avg_content
FROM avg_content
ORDER BY 3 DESC
LIMIT 5;

-- Q11) List all movies that are documentaries

SELECT 
	title,
	type,
	listed_in
FROM netflix
WHERE type IN ('Movie')
	  AND
	  listed_in ILIKE ('%Documentaries%');

-- Q12) Find all content without a director

SELECT 
	* 
FROM netflix
WHERE director IS NULL;

-- Q13) Find how many movies actor 'Salman Khan' appeared in last 10 years

SELECT 
	* 
FROM netflix
WHERE casts ILIKE ('%Salman Khan%')
	  AND
	  release_year >=  EXTRACT(YEAR FROM CURRENT_DATE) - 10
ORDER BY release_year ASC;

-- Q14) Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(casts,', '))) AS Actor,
	COUNT(show_id) AS Shows
FROM netflix
WHERE country ILIKE('India')
	  AND
	  type IN ('Movie')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

 -- Q15) Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
 --      the description field. Label content containing these keywords as 'Bad' and all other 
 --       content as 'Good'. Count how many items fall into each category.

WITH category AS
(
SELECT
 	show_id,
	title,
	type,
	description,
	CASE WHEN (description ILIKE '%kill%' OR description ILIKE '%violence%') THEN 'Bad'
	     ELSE 'Good'
	END AS category
FROM netflix
)
SELECT
	category,
	COUNT(show_id)  AS total
FROM category
GROUP BY 1;