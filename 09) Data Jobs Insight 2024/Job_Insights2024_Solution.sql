SELECT * FROM company_dim;
SELECT * FROM job_postings_fact;
SELECT * FROM skill_dim;
SELECT * FROM skill_job_dim;
------------------------------------------------------------------------
-- Q1) Retrieve the top 10 highest-paid Data Analyst jobs.
--     Exclude records with NULL salary values.
--     Only include jobs where the location is 'Anywhere'.

SELECT
	job_id,
	company_id,
	job_title_short,
	job_title,	
	salary_year_avg
FROM job_postings_fact 
WHERE job_title_short IN ('Data Analyst')
	  AND
	  salary_year_avg IS NOT NULL
	  AND
	  job_location IN ('Anywhere')
ORDER BY 5 DESC
LIMIT 10;

   
-- Q2) Retrieve the top 10 highest-paid Data Analyst jobs.
--     Exclude records with NULL salary values.
--     Only include jobs where the location is 'Anywhere'.
--     What skill is required for the post.

SELECT
	j.job_id,
	j.company_id,
	j.job_title_short,
	j.job_title,	
	j.salary_year_avg,
	s.skills
FROM job_postings_fact j JOIN skill_job_dim sdm ON j.job_id    = sdm.job_id
           			     JOIN skill_dim s       ON sdm.skill_id = s.skill_id 
WHERE j.job_title_short IN ('Data Analyst')
	  AND
	  j.salary_year_avg IS NOT NULL
	  AND
	  j.job_location IN ('Anywhere')
ORDER BY 5 DESC
LIMIT 10;

-- Q3) What are top 5 most demand skill for Data Analyst role

SELECT
	s.skills,
	COUNT(j.job_id) AS job_count
FROM job_postings_fact j  JOIN skill_job_dim sdm ON j.job_id    = sdm.job_id
           			      JOIN skill_dim s       ON sdm.skill_id = s.skill_id 
WHERE j.job_title_short IN ('Data Analyst')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
	  

-- Q4) What are the top 10 highest-paying job postings for the 'Data Analyst' role that require SQL skills?

SELECT
	j.job_id,
	j.company_id,
	j.job_title_short,
	j.job_title,	
	j.salary_year_avg,
	s.skills
FROM job_postings_fact j JOIN skill_job_dim sdm ON j.job_id    = sdm.job_id
           			     JOIN skill_dim s       ON sdm.skill_id = s.skill_id 
WHERE j.job_title_short IN ('Data Analyst')
	  AND
	  j.salary_year_avg IS NOT NULL
	  AND
	  j.job_location IN ('Anywhere')
	  AND
	  s.skills ILIKE ('%sql%')
ORDER BY 5 DESC
LIMIT 10;

-- Q5) Most demand and highest paying skill for Data Analyst

SELECT 
    s.skills,
    COUNT(j.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY j.salary_year_avg) AS median_salary
FROM job_postings_fact j JOIN skill_job_dim sdm ON j.job_id     = sdm.job_id
                         JOIN skill_dim s       ON sdm.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst'
     AND 
	 j.salary_year_avg IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Q6) How many Data Analyst job postings were made in each month?

SELECT 
	TO_CHAR(job_posted_date::DATE,'YYYY-MM') AS year_month,
	TO_CHAR(job_posted_date::DATE,'Mon') ,
	COUNT(job_id) AS total_job_post
FROM job_postings_fact
GROUP BY 1,2
ORDER BY 1;


-- Q7) Added a new column based on salary.find all location _category for data anlayst

SELECT
	job_id,
	company_id,
	job_title_short,
	job_title,	
	salary_year_avg,
	CASE
		WHEN salary_year_avg >= 100000 THEN 'Desired'
		WHEN salary_year_avg >= 50000 THEN 'High'
		WHEN salary_year_avg >= 30000 THEN 'Standard'
		else 'Low'
	END AS category
FROM job_postings_fact 
WHERE job_title_short IN ('Data Analyst')
	  AND
	  salary_year_avg IS NOT NULL;

-- Q8) Find the company has most data anlayst job opening, total number oj job(per customner_id) return with customer_name

SELECT 
	c.company_id,
	c.name,
	COUNT(j.job_id) AS job_count
FROM company_dim c LEFT JOIN job_postings_fact j ON c.company_id = j.company_id
WHERE j.job_title_short IN ('Data Analyst')
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT * FROM job_postings_fact;

