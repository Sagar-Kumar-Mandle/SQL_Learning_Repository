SELECT * FROM resume;
---------------------------------------------------------------------
Q1) List All Distinct Users and Their Stats
--  Return the user name, total submissions, and total points earned by each user.
--  A list of users with their submission count and total points.

SELECT 
	user_id,
	user_name,
	COUNT(id) 	 AS total_submission,
	SUM(points)  AS total_points,
	ROUND(AVG(points),2)  AS avg_points
FROM resume
GROUP BY 1,2
ORDER BY 3,4 DESC;


Q2) Calculate the Daily Average Points for Each User
--  For each day, calculate the average points earned by each user.
--  A report showing the average points per user for each day.

SELECT 
	submitted_at::DATE,
	user_id,
	user_name,
	ROUND(AVG(points),2)  AS avg_points
FROM resume
GROUP BY 1,2,3
ORDER BY 1 ASC;


Q3) Find the Top 3 Users with the Most Correct Submissions for Each Day
--  Identify the top 3 users with the most correct submissions for each day.
--  A list of users and their correct submissions, ranked daily.

WITH top3 AS
(
SELECT 
	submitted_at::DATE,
	user_id,
	user_name,
	COUNT(id) AS count_submission
FROM resume
WHERE points > 0
GROUP BY 1,2,3
ORDER BY 1 ASC
),
ranks AS
(
SELECT 
	*,
	DENSE_RANK() OVER (PARTITION BY submitted_at ORDER BY count_submission DESC) AS rno
FROM top3
)
SELECT 
	*
From ranks
WHERE rno <= 3;

Q4) Find the Top 5 Users with the Highest Number of Incorrect Submissions.
--  Identify twalmart_datahe top 5 users with the highest number of incorrect submissions.
--  A list of users with the count of incorrect submissions.

SELECT 
    user_id,
    user_name,
    COUNT(*) AS incorrect_submissions
FROM resume
WHERE points <= 0
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;


Q5) Find the top 10 performers for each week.
--  Identify the top 10 users with the highest total points earned each week.
--  A report showing the top 10 users ranked by total points per week.

WITH top10 AS
(
SELECT 
	DATE_TRUNC('Week',submitted_at::DATE)::DATE AS firstdateofweek,
	DATE_PART('Week',submitted_at::DATE) AS week_number,
	user_id,
	user_name,
	SUM(points) AS total_points
FROM resume
GROUP BY 1,2,3,4
),
ranks AS
(
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY firstdateofweek ORDER BY total_points DESC ) as rno
FROM top10
)
SELECT 
	*
From ranks
WHERE rno <= 10;
