-- Drop Table

DROP TABLE IF EXISTS sales_data;

-- Create Table

CREATE TABLE IF NOT EXISTS sales_data(
   	transactions_id 	INT 		PRIMARY KEY,
	sale_date 			DATE,
	sale_time 			TIME,
	customer_id			INT,
	gender				VARCHAR(10),
	age					INT,
	category			TEXT,
	quantity			INT,
	price_per_unit		NUMERIC,
	cogs				NUMERIC,
	total_sale			NUMERIC
);

SELECT * FROM sales_data;

-- Data Import

COPY sales_data(transactions_id,sale_date,sale_time,customer_id,gender,age,category,quantity,price_per_unit,cogs,total_sale)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\1) Retail Sales Performance Analysis\Retail Sales Analysis.csv'
DELIMITER ','
HEADER CSV

SELECT * FROM sales_data;

-- Data Cleaning

DELETE FROM sales_data
WHERE price_per_unit IS NULL
      OR
	  quantity IS NULL;

SELECT * FROM sales_data;