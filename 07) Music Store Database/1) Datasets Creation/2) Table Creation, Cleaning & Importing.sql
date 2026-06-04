1) Customers Table

-- Drop Table

DROP TABLE IF EXISTS customer;

-- Table Creation

CREATE TABLE IF NOT EXISTS customer(
	customer_id 		INT 			PRIMARY KEY,
	first_name 			VARCHAR(100),
	last_name 			VARCHAR(100),
	company 			TEXT,
	address 			TEXT,
	city 				TEXT,
	state 				TEXT,
	country 			TEXT,
	postal_code 		TEXT,
	phone 				TEXT,
	fax 				TEXT,
	email 				TEXT,
	support_rep_id 		INT	
);

-- Data Import

COPY customer (customer_id,first_name,last_name,company,address,city,state,country,postal_code,phone,fax,email,support_rep_id)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\customer.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM customer;

------------------------------------------------------------------------------------------------------------

2) Employee Table

-- Drop Table

DROP TABLE IF EXISTS employee;

-- Table Creation

CREATE TABLE IF NOT EXISTS employee(
	employee_id 		INT 			PRIMARY KEY,
	first_name 			VARCHAR(100),
	last_name 			VARCHAR(100),
	title 				TEXT,
	reports_to 			INT,
	levels 				VARCHAR(2),
	birth_date 			DATE,
	hire_date 			DATE,
	address 			TEXT,
	city 				TEXT,
	state 				TEXT,
	country 			TEXT,
	postal_code 		TEXT,
	phone 				TEXT,
	fax 				TEXT,
	email 				TEXT
);

COPY employee (employee_id,last_name,first_name,title,reports_to,levels,birth_date,hire_date,address,city,state,country,postal_code,phone,fax,email )
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\employee.csv'
DELIMITER ','
HEADER CSV

SELECT * FROM employee;

------------------------------------------------------------------------------------------------------------

3) Invoice Table

-- Drop Table

DROP TABLE IF EXISTS invoice;

-- Table Creation

CREATE TABLE IF NOT EXISTS invoice(
	invoice_id 			INT 	PRIMARY KEY,
	customer_id 		INT,
	invoice_date 		DATE,
	billing_address 	TEXT,
	billing_city 		TEXT,
	billing_state 		TEXT,
	billing_country 	TEXT,
	billing_postal_code TEXT,
	total 				NUMERIC
);

COPY invoice (invoice_id,customer_id,invoice_date,billing_address,billing_city,billing_state,billing_country,billing_postal_code,total)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\invoice.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM invoice;

------------------------------------------------------------------------------------------------------------

4) Invoice Line Table

-- Drop Table

DROP TABLE IF EXISTS invoice_line;


-- Table Creation

CREATE TABLE IF NOT EXISTS invoice_line(
	invoice_line_id 	INT 	PRIMARY KEY,
	invoice_id 			INT,
	track_id 			INT,
	unit_price 			NUMERIC,
	quantity 			INT
);

-- Data Import
COPY invoice_line (invoice_line_id,invoice_id,track_id,unit_price,quantity)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\invoice_line.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM invoice_line;

------------------------------------------------------------------------------------------------------------

5) Track Table

-- Drop Table

DROP TABLE IF EXISTS track;

-- Table Creation

CREATE TABLE IF NOT EXISTS track(
	track_id 		INT 	PRIMARY KEY,
	name 			TEXT,
	album_id 		INT,
	media_type_id 	INT,
	genre_id 		INT,
	composer 		TEXT,
	milliseconds 	INT,
	bytes 			INT,
	unit_price 		NUMERIC
);

-- Data Import

COPY track (track_id,name,album_id,media_type_id,genre_id,composer,milliseconds,bytes,unit_price)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\track.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM track;

------------------------------------------------------------------------------------------------------------

6) Media table

-- Drop Table

DROP TABLE IF EXISTS media_type;

-- Table Creation

CREATE TABLE IF NOT EXISTS media_type(
	media_type_id 	INT 	PRIMARY KEY,
	name 			TEXT
);

-- Data Import

COPY media_type(media_type_id,name)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\media_type.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM media_type;

------------------------------------------------------------------------------------------------------------

7) Genre table

-- Drop Table

DROP TABLE IF EXISTS genre;

-- Table Creation

CREATE TABLE IF NOT EXISTS genre(
	genre_id 	INT 	PRIMARY KEY,
	name 		TEXT
);

-- Data Import

COPY genre(genre_id,name)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\genre.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM genre;

------------------------------------------------------------------------------------------------------------

8) Playlist Track table

-- Drop Table

DROP TABLE IF EXISTS playlist_track;

-- Table Creation

CREATE TABLE IF NOT EXISTS playlist_track(
	playlist_id 	INT ,
	track_id 		INT
);

-- Data Import

COPY playlist_track(playlist_id,track_id)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\playlist_track.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM playlist_track;

------------------------------------------------------------------------------------------------------------

9) Genre table

-- Drop Table

DROP TABLE IF EXISTS playlist;

-- Table Creation

CREATE TABLE IF NOT EXISTS playlist(
	playlist_id 	INT 	PRIMARY KEY,
	name 			TEXT
);

-- Data Import

COPY playlist(playlist_id,name)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\playlist.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM playlist;

------------------------------------------------------------------------------------------------------------

10) ALBUM table

-- Drop Table

DROP TABLE IF EXISTS album;

-- Table Creation

CREATE TABLE IF NOT EXISTS album(
	album_id 	INT,
	title 		TEXT,
	artist_id 	INT
);

-- Data Import

COPY album(album_id,title,artist_id)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\album.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM album;

------------------------------------------------------------------------------------------------------------

11) Genre table

-- Drop Table

DROP TABLE IF EXISTS artist;

-- Table Creation

CREATE TABLE IF NOT EXISTS artist(
	artist_id 	INT 	PRIMARY KEY,
	name 		TEXT
);

-- Data Import

COPY artist(artist_id,name)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\7) Music Store Database\artist.csv'
DELIMITER ','
HEADER CSV;

SELECT * FROM artist;

--------------------------------------------------------------------
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