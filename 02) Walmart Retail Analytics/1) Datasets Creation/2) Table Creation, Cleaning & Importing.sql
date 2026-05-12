-- Drop Table

DROP TABLE IF EXISTS walmart;

-- Table Creation

CREATE TABLE IF NOT EXISTS walmart(
	invoice_id			INT 	PRIMARY KEY,
	branch				TEXT,
	city				TEXT,
	category			TEXT,
	unit_price			NUMERIC,
	quantity			INT,
	date 				DATE,
	time				TIME,
	payment_method		TEXT,
	rating				NUMERIC,
	profit_margin		NUMERIC
);

SELECT * FROM walmart;

-- Data Import

COPY walmart (invoice_id,branch,city,category,unit_price,quantity,date,time,payment_method,rating,profit_margin)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\2) Walmart_Retail_Analytics\Walmart_Retail_Analytics.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM walmart;

