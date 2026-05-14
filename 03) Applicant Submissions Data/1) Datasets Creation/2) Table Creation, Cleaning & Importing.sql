-- Drop Table

DROP TABLE IF EXISTS resume;

-- Table Creation

CREATE TABLE IF NOT EXISTS resume(
	id   			INTEGER 	PRIMARY KEY,
	user_id			BIGINT,
	question_id 	INT,
	points			INT,
	submitted_at    TIMESTAMPTZ,
	user_name       TEXT
);

SELECT * FROM resume;

-- Data Import

COPY resume(id,user_id,question_id,points,submitted_at,user_name)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\3) Applicant Submissions Data\resume.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM resume;
