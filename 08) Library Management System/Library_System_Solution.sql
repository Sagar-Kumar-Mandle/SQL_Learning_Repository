SELECT * FROM branch
SELECT * FROM employee
SELECT * FROM members
SELECT * FROM books
SELECT * FROM issued_status
SELECT * FROM return_status
---------------------------------------------
-- Q1)  Create a New Book Record
--     '978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'

INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

SELECT * FROM books;

-- Q2) Update an Existing Members Address

UPDATE members
SET member_name ='Alice John', member_address='321 Main St'
WHERE member_id IN ('C101');

SELECT * FROM members;

-- Q3) Delete a Record from the Issued Status Table
--     Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

SELECT * FROM issued_status;

-- Q4) Retrieve All Books Issued by a Specific Employee
--     Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT 
	i.issued_book_name,
	i.issued_date,
	i.issued_book_isbn,
	e.emp_name
FROM issued_status i JOIN employee e ON e.emp_id = i.issued_emp_id
WHERE i.issued_emp_id IN ('E101');
 
-- Q5) List Members Who Have Issued More Than One Book

SELECT 
	m.member_id,
	m.member_name,
	COUNT(i.issued_emp_id) AS total_book_issued
FROM issued_status i LEFT JOIN members m ON m.member_id = i.issued_member_id
GROUP BY 1,2
HAVING COUNT(i.issued_emp_id) > 1
ORDER BY 3 DESC;

-- Q6) Create Summary Tables**: 
--     Used CTAS to generate new tables based on query results - each book and total book_issued

CREATE TABLE book_count AS
SELECT 
	b.book_title,
	COUNT(b.isbn) AS total_book_issued
FROM issued_status i LEFT JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY 1
ORDER BY 2 DESC

SELECT * FROM book_count;

-- Q7) Retrieve All Books in a Classic Category

SELECT 
	* 
FROM books
WHERE category IN ('Classic');

-- Q8) Find Total Rental Income by Category:

SELECT	
	b.category,
	COUNT(i.issued_book_isbn) AS total_book_issued,
	SUM(b.rental_price) AS total_income
FROM issued_status i LEFT JOIN books b ON b.isbn = i.issued_book_isbn
GROUP BY 1;

-- Q9) List Employees with Their Branch Managers Name and their branch details 

WITH CTE AS
(
SELECT 
	e.*,
	b.manager_id
FROM employee e LEFT JOIN branch b ON e.branch_id=b.branch_id
WHERE e.position NOT IN ('Manager')
)
SELECT
	c.*,
	e.emp_name
FROM CTE c JOIN employee e ON c.manager_id=e.emp_id;

-- Q10) Create a Table of Books with Rental Price Above a Certain Threshold

CREATE TABLE book_price AS 
SELECT 
	* 
FROM books
WHERE rental_price > (SELECT AVG(rental_price)FROM books );

SELECT * FROM book_price;

-- Q11) Retrieve the List of Books Not Yet Returned

SELECT 
	i.issued_id,
	i.issued_book_name,
	i.issued_date,
	i.issued_book_isbn,
	r.return_id,
	r.return_date	
FROM return_status r RIGHT JOIN issued_status i ON r.issued_id=i.issued_id
WHERE r.return_id IS NULL;




