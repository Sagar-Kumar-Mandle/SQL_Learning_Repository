1) Branch Table

-- Drop Table

DROP TABLE IF EXISTS branch;

-- Table Creation

CREATE TABLE IF NOT EXISTS branch(
	branch_id 			VARCHAR(10) PRIMARY KEY,
	manager_id 			VARCHAR(10),
	branch_address 		VARCHAR(100),
	contact_no 			VARCHAR(20)
);

-- Data Import

COPY branch(branch_id,manager_id,branch_address,contact_no)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\branch.csv'
DELIMITER','
HEADER CSV

SELECT * FROM branch;

-------------------------------------------------------------------------------------------------------------------

2) Employee Table

-- Drop Table

DROP TABLE IF EXISTS employee;

-- Table Creation

CREATE TABLE IF NOT EXISTS employee(
	emp_id 		VARCHAR(10),
	emp_name 	VARCHAR(100),
	position 	VARCHAR(100),
	salary 		NUMERIC,
	branch_id VARCHAR(10)
);

-- Data Import

COPY employee(emp_id,emp_name,position,salary,branch_id)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\employees.csv'
DELIMITER','
HEADER CSV

SELECT * FROM employee;

-------------------------------------------------------------------------------------------------------------------

3) Member Table

-- Drop Table

DROP TABLE IF EXISTS members;

-- Table Creation

CREATE TABLE IF NOT EXISTS members(
	member_id 		VARCHAR(10),
	member_name 	VARCHAR(100),
	member_address  VARCHAR(100),
	reg_date 		DATE
);

-- Data Import

COPY members(member_id,member_name,member_address,reg_date)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\members.csv'
DELIMITER','
HEADER CSV

SELECT * FROM members;

-------------------------------------------------------------------------------------------------------------------

4) Book Table

-- Drop Table

DROP TABLE IF EXISTS books;

-- Table Creation

CREATE TABLE IF NOT EXISTS books(
	isbn 			VARCHAR(100),
	book_title 		TEXT,
	category 		VARCHAR(100),
	rental_price 	NUMERIC,
	status 			VARCHAR(10),
    author 			VARCHAR(100),
    publisher 		VARCHAR(100)
);

-- Data Import

COPY books(isbn,book_title,category,rental_price,status,author,publisher)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\books.csv'
DELIMITER','
HEADER CSV

SELECT * FROM books;

-------------------------------------------------------------------------------------------------------------------
-- 5) Issued Status Table

-- Drop Table

DROP TABLE IF EXISTS issued_status;

-- Table Creation

CREATE TABLE IF NOT EXISTS issued_status(
	issued_id 			VARCHAR(10),
	issued_member_id 	VARCHAR(10),
	issued_book_name 	VARCHAR(100),
	issued_date 		DATE,
	issued_book_isbn 	VARCHAR(100),
    issued_emp_id 		VARCHAR(10)
);

-- Data Import

COPY issued_status(issued_id,issued_member_id,issued_book_name,issued_date,issued_book_isbn,issued_emp_id)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\issued_status.csv'
DELIMITER','
HEADER CSV

SELECT * FROM issued_status;

-------------------------------------------------------------------------------------------------------------------

-- 6) Return Status Table

-- Drop Table

DROP TABLE IF EXISTS return_status;

-- Table Creation

CREATE TABLE IF NOT EXISTS return_status(
	return_id 			VARCHAR(10),
	issued_id 			VARCHAR(10),
	return_book_name 	VARCHAR(100),
	return_date 		DATE,
	return_book_isbn 	VARCHAR(100)
);

-- Data Import

COPY return_status(return_id,issued_id,return_book_name,return_date,return_book_isbn)
FROM 'D:\VCE\Sagar BCC\2) Pratice Project Dashboard\2) SQL\CSV Files\8) Library Management System\return_status.csv'
DELIMITER','
HEADER CSV

SELECT * FROM return_status;
-----------------------------------------------------------------------------
SELECT * FROM branch
SELECT * FROM employee
SELECT * FROM members
SELECT * FROM books
SELECT * FROM issued_status
SELECT * FROM return_status
