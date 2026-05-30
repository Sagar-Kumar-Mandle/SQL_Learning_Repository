1) Order Details Table

-- Drop Table

DROP TABLE IF EXISTS order_details;

-- Table Creation

CREATE TABLE IF NOT EXISTS order_details(
	order_details_id    INT PRIMARY KEY,
	order_id			INT,
	pizza_id			TEXT,
	quantity			INT
);

SELECT * FROM order_details;

-- Data Import

COPY order_details(order_details_id,order_id,pizza_id,quantity)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\6) Pizza Sales Performance Analysis\order_details.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM order_details;

--------------------------------------------------------------------------------------------------------------

2) Orders Table

-- Drop Table

DROP TABLE IF EXISTS orders;

-- Table Creation

CREATE TABLE IF NOT EXISTS orders(
	order_id 	INT 	PRIMARY KEY,
	date		DATE,
	time 		TIME
);

SELECT * FROM orders;

-- Data Import

COPY orders(order_id,date,time)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\6) Pizza Sales Performance Analysis\orders.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM orders;

--------------------------------------------------------------------------------------------------------------

3) Pizza Type Table

-- Drop Table

DROP TABLE IF EXISTS pizza_types;

-- Table Creation

CREATE TABLE IF NOT EXISTS pizza_types(
	pizza_type_id 	TEXT, 	
	name			TEXT,
	category		TEXT,
	ingredients		TEXT
);

SELECT * FROM pizza_types;

-- Data Import

COPY pizza_types(pizza_type_id,name,category,ingredients)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\6) Pizza Sales Performance Analysis\pizza_types.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM pizza_types;

--------------------------------------------------------------------------------------------------------------

4) Pizzas Table

-- Drop Table

DROP TABLE IF EXISTS pizzas;

-- Table Creation

CREATE TABLE IF NOT EXISTS pizzas(
	pizza_id 		TEXT, 	
	pizza_type_id	TEXT,
	size			TEXT,
	price			NUMERIC
);

SELECT * FROM pizzas;

-- Data Import

COPY pizzas(pizza_id,pizza_type_id,size,price)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\6) Pizza Sales Performance Analysis\pizzas.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM pizzas;

--------------------------------------------------------------------------------------------------------------

SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM pizza_types;
SELECT * FROM pizzas;