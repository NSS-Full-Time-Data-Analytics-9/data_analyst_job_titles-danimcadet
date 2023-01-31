--1.	How many rows are in the data_analyst_jobs table? 1793
SELECT *
FROM data_analyst_jobs;

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? ExxonMobil
SELECT company
FROM data_analyst_jobs
LIMIT 10;

--3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky? 12
SELECT COUNT(location) AS tn_jobs
FROM data_analyst_jobs
WHERE location = 'TN';

--4.	How many postings in Tennessee have a star rating above 4? 4
SELECT COUNT(star_rating) AS tn_4stars
FROM data_analyst_jobs
WHERE location ='TN'
	AND star_rating >= 4;
	
--5.	How many postings in the dataset have a review count between 500 and 1000? 151
SELECT COUNT(review_count) AS review_count_500
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating? Nebraska
SELECT location AS state, avg(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC;

--7.	Select unique job titles from the data_analyst_jobs table. How many are there? 881
SELECT DISTINCT title
FROM data_analyst_jobs;

--8.	How many unique job titles are there for California companies? 230
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE location = 'CA';

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations? 41
SELECT DISTINCT company AS highly_reviewed_co, AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating? American Express

SELECT DISTINCT company AS highly_reviewed_co, AVG(star_rating) AS avg_star
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star DESC;

--11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 1636 
SELECT title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
	AND title NOT ILIKE '%Analytics%';

--**BONUS:** You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
-- Disregard any postings where the domain is NULL. 
-- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
-- Which three industries are in the top 4 on this list?

--correct script
SELECT DISTINCT domain AS industry, COUNT(title) AS total_postings, avg(days_since_posting)/7.0 AS weeks_since_posting
FROM data_analyst_jobs
WHERE domain IS NOT NULL
	AND days_since_posting/7.0 > 3.0
	AND skill ILIKE '%SQL%'
GROUP BY domain
ORDER BY total_postings DESC, weeks_since_posting DESC;