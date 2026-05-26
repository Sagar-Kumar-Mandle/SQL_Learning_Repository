-- Drop Table

DROP TABLE IF EXISTS netflix;

-- Table Creation

CREATE TABLE IF NOT EXISTS netflix(
	show_id			TEXT 		PRIMARY KEY,
	type			TEXT	 	NOT NULL,
	title 			TEXT	 	NOT NULL,
	director		TEXT,
	casts			TEXT,
	country			TEXT,
	date_added      DATE,
	release_year    BIGINT,
	rating			TEXT,
	duration		TEXT,
	listed_in		TEXT,
	description		TEXT
);

SELECT * FROM netflix;

-- Data Import

COPY netflix(show_id,type,title,director,casts,country,date_added,release_year,rating,duration,listed_in,description)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\3) Netflix Data Analysis\netflix_titles.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM netflix;

