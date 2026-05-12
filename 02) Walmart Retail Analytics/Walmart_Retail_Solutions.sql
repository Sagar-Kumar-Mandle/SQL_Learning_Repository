SELECT * FROM walmart;
---------------------------------------------------------------------------

-- Q1) Find different payment methods, number of transactions, and quantity sold by payment method

SELECT 
	payment_method,
	COUNT(invoice_id) AS toal_transaction,
	SUM(quantity) AS total_quantity,
	SUM(unit_price * quantity) AS total_revenue,
	ROUND(SUM((unit_price * quantity) * profit_margin),2) AS total_profit
FROM walmart
GROUP BY 1;

-- Q2) Identify the highest-rated category in each branch
--     Display the branch, category, and avg rating

WITH cte AS
(
SELECT 
	branch,
	category,
	ROUND(AVG(rating),2) AS avg_rating
FROM walmart
GROUP BY 1,2
),
highest_rated AS
(
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY branch ORDER BY avg_rating DESC) AS rno
FROM cte
)
SELECT
	*
FROM highest_rated
WHERE rno = 1;

-- Q3) Identify the busiest day for each branch based on the number of transactions


SELECT 
	branch,
	date,
	COUNT(invoice_id) AS total_transaction
FROM walmart
GROUP BY 1,2
),
busiest_day AS
(
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY branch ORDER BY total_transaction DESC) AS rno
FROM cte
)
SELECT
	*
FROM busiest_day
WHERE rno = 1 
ORDER BY 1,2;

-- Q4) Calculate the total quantity of items sold per payment method

SELECT 
	payment_method,
	SUM(quantity) AS total_quantity
FROM walmart
GROUP BY 1;

-- Q5) Determine the average, minimum, and maximum rating of categories for each city

SELECT 
	city,
	category,
	ROUND(AVG(rating),2) AS avg_rating,
	MAX(rating) AS max_rating,
	MIN(rating) AS min_rating
FROM walmart
GROUP BY 1,2
ORDER BY 1,2;


-- Q6) Calculate the total profit for each category

SELECT 
	category,
	ROUND(SUM((unit_price * quantity) * profit_margin),2) AS total_profit
FROM walmart
GROUP BY 1
ORDER BY 2 DESC;

-- Q7) Determine the most common payment method for each branch

WITH cte AS
(
SELECT 
	branch,
	payment_method,
	COUNT(invoice_id)  AS total_transaction
FROM walmart
GROUP BY 1,2
),
common_payment AS
(
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY branch ORDER BY total_transaction DESC ) AS rno
FROM CTE
)
SELECT
	*
FROM common_payment
WHERE rno = 1;

-- Q8) Categorize sales into Morning, Afternoon, and Evening shifts

SELECT
	CASE 
		WHEN time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
		WHEN time BETWEEN '12:00:00' AND '14:59:59' THEN 'Afternoon'
		WHEN time BETWEEN '17:00:00' AND '23:49:59' THEN 'Evening'
		ELSE 'Late-Night'
	END AS shifts,
	COUNT(invoice_id) AS total_transaction
FROM walmart
GROUP BY 1;

-- Q9) Identify Branches with Highest Revenue Decline Year-Over-Year (2022 - 2023 )

WITH y2022 AS
(
SELECT 
	branch,
	SUM(unit_price * quantity) AS total_revenue_2022
FROM walmart
WHERE EXTRACT(YEAR FROM DATE) IN(2022)
GROUP BY 1
),
y2023 AS
(
SELECT 
	branch,
	SUM(unit_price * quantity) AS total_revenue_2023
FROM walmart
WHERE EXTRACT(YEAR FROM DATE) IN (2023)
GROUP BY 1
)
SELECT
	y22.branch,
	y22.total_revenue_2022,
	y23.total_revenue_2023,
	ROUND(((y23.total_revenue_2023 - y22.total_revenue_2022) / y22.total_revenue_2022) * 100.0,2) AS YOY
FROM y2022 y22 JOIN y2023 y23 ON y22.branch=y23.branch
WHERE y23.total_revenue_2023 < y22.total_revenue_2022
ORDER BY 4 ASC
LIMIT 1;