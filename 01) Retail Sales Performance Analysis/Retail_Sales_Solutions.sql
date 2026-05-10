SELECT * FROM sales_data;
------------------------------------------------------------------------------------------------------

-- Q1) Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT 
	* 
FROM sales_data
WHERE sale_date IN ('2022-11-05');

-- Q2) Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- 	   and the quantity sold is more than 2 in the month of Nov-2022.

SELECT 
	*
FROM sales_data
WHERE category IN ('Clothing')
	  AND
	  quantity > 2 
	  AND
	  TO_CHAR(sale_date,'YYYY-MM') = '2022-11'

-- Q3) Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	ROUND(SUM(total_sale) / 100000,2) AS "sales in million" 
FROM sales_data
GROUP BY 1

-- Q4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
	FLOOR(AVG(age))
FROM sales_data
WHERE category IN ('Beauty');

-- Q5) Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
	* 
FROM sales_data
WHERE total_sale > 1000
ORDER BY 2 ASC;

 
-- Q6) Write a SQL query to find the total number of transactions (transaction_id) 
--     made by each gender in each category.

SELECT 
	category,
	COUNT (CASE WHEN gender = 'Male'   THEN 1 END) AS male,
	COUNT (CASE WHEN gender = 'Female' THEN 1 END) AS female
FROM sales_data
GROUP BY 1;
	 
-- Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
	TO_CHAR(sale_date,'YYYY-MM') AS "Year-month",
	EXTRACT(YEAR FROM sale_date) AS year,
	LEFT(TO_CHAR(sale_date,'Month'),3) AS month,
	ROUND(AVG(total_sale),2) AS "Average Monthly Sales"
FROM sales_data
GROUP BY 1,2,3
ORDER BY 1;

 
-- Q8) Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
	customer_id,
	ROUND(SUM(total_sale) / 1000 ,2) AS "Sales (in K)"
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

 
-- Q9) Write a SQL query to find the number of unique customers who purchased items from each category

WITH unique_count AS
(
SELECT 
	DISTINCT
		customer_id,
		category
FROM sales_data
)
SELECT 
	category,
	COUNT(customer_id) AS unique_customer
FROM unique_count
GROUP BY 1


-- Q10) Write a SQL query to create each shift and number of orders 
--     (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
	CASE 
		WHEN sale_time BETWEEN '06:00:00' AND '12:00:00' THEN 'Morning'
		WHEN sale_time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
		WHEN sale_time BETWEEN '16:00:00' AND '19:00:00' THEN 'Evening'
		WHEN sale_time BETWEEN '19:00:00' AND '24:00:00' THEN 'Night'
	END AS shift,
	COUNT(transactions_id) AS total_transaction
FROM sales_data
GROUP BY 1
ORDER BY 1;

