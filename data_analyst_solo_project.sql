SELECT *
FROM
	data_analyst_jobs

-- 1. How many rows are in the data_analyst_jobs table? 1793

SELECT
	COUNT(Title)
FROM
	data_analyst_jobs

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? "ExxonMobil"

SELECT
	company
FROM
	data_analyst_jobs
LIMIT
	10

-- 3.How many postings are in Tennessee? 21 
-- How many are there in either Tennessee or Kentucky? 21 + 6 = 27

SELECT
	COUNT(CASE WHEN location = 'TN' THEN location END)AS total_postings_TN,
	COUNT(CASE WHEN location = 'KY' THEN location END)AS total_postings_KY
FROM
	data_analyst_jobs
WHERE
	location = 'TN'
	OR location = 'KY'


SELECT
	COUNT(CASE WHEN location = 'TN' OR location = 'KY'THEN location END)AS total_TN_KY
FROM
	data_analyst_jobs

-- 4. How many postings in Tennessee have a star rating above 4? 3

SELECT
	COUNT(CASE WHEN star_rating > 4 THEN star_rating END)AS TN_rating_over_four
FROM
	data_analyst_jobs
WHERE
	location = 'TN'

-- or --

SELECT
	COUNT(star_rating)
FROM
	data_analyst_jobs
WHERE
	location = 'TN'
	AND star_rating > '4'

-- 5. How many postings in the dataset have a review count between 500 and 1000? 150

SELECT
	COUNT(CASE WHEN review_count > 500 AND review_count < 1000 THEN review_count END)AS review_count_500_1000
FROM
	data_analyst_jobs
	
-- or --

SELECT
	COUNT(review_count)
FROM
	data_analyst_jobs
WHERE
	review_count > 500
	AND review_count < 1000

-- 6. Show the average star rating for companies in each state. The output should show the state as state 
-- and the average rating for the state as avg_rating. Which state shows the highest average rating? "NE"

SELECT
	location AS state,
	AVG(star_rating)AS avg_rating
FROM
	data_analyst_jobs
GROUP BY
	location
ORDER BY
	avg_rating DESC;
	
-- 7. Select unique job titles from the data_analyst_jobs table. How many are there? 881

SELECT
	DISTINCT(title)
FROM
	data_analyst_jobs


SELECT
	COUNT(DISTINCT title)
FROM
	data_analyst_jobs

-- 8.How many unique job titles are there for California companies? 230

SELECT
	COUNT(DISTINCT title)AS title_count_CA
FROM
	data_analyst_jobs
WHERE
	location = 'CA'

-- 9.Find the name of each company and its average star rating for all companies that have more than 5000 reviews 
-- across all locations. How many companies are there with more that 5000 reviews across all locations? 40

SELECT
	DISTINCT(company),
	AVG(star_rating)AS avg_rating_5000
FROM
	data_analyst_jobs
WHERE
	review_count > 5000
	AND company IS NOT NULL
GROUP BY
	company
ORDER BY
	company ASC;


SELECT
	COUNT(DISTINCT company)	
FROM
	data_analyst_jobs
WHERE
	review_count > 5000
	AND company IS NOT NULL

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews 
-- across all locations in the dataset has the highest star rating?  "American Express" What is that rating? 4.1999998090000000

SELECT
	DISTINCT(company),
	AVG(star_rating)AS avg_rating_5000
FROM
	data_analyst_jobs
WHERE
	review_count > 5000
	AND company IS NOT NULL
GROUP BY
	company
ORDER BY
	avg_rating_5000 DESC;

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? DISTINCT: 774

-- 1669
SELECT
	title
FROM
	data_analyst_jobs
WHERE
	title ILIKE '%analyst%'

-- 236
SELECT
	title
FROM
	data_analyst_jobs
WHERE
	title ILIKE '%analyt%'

-- 1789
SELECT
	title
FROM
	data_analyst_jobs
WHERE
	title ILIKE '%analy%'

-- 1669
SELECT
	COUNT(title)
FROM
	data_analyst_jobs
WHERE
	title ILIKE '%analyst%'

-- 774
SELECT
	COUNT(DISTINCT title)
FROM
	data_analyst_jobs
WHERE
	title ILIKE '%analyst%'

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 4 
-- What word do these positions have in common? "Tableau"

SELECT
	COUNT(DISTINCT title)
FROM
	data_analyst_jobs
WHERE
	title NOT ILIKE '%analyst%'
	AND title NOT ILIKE '%analytics%'

SELECT
	DISTINCT(title)
FROM
	data_analyst_jobs
WHERE
	title NOT ILIKE '%analyst%'
	AND title NOT ILIKE '%analytics%'

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that 
-- require SQL and have been posted longer than 3 weeks.
-- 		-Disregard any postings where the domain is NULL.
-- 		-Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- 		-Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
-- "Internet and Software" - 62
-- "Banks and Financial Services" - 61
-- "Consulting and Business Services" - 57
-- "Health Care" - 52
	
SELECT
	COUNT(title)AS hard_to_fill,
	domain
FROM
	data_analyst_jobs
WHERE
	skill ILIKE '%SQL%'
	AND days_since_posting > '21'
	AND domain IS NOT NULL
GROUP BY
	domain
ORDER BY
	hard_to_fill DESC;

						-- SELECT
						-- 	COUNT(title)AS hard_to_fill,
						-- 	domain,
						-- 	title,
						-- 	skill
						-- FROM
						-- 	data_analyst_jobs
						-- WHERE
						-- 	skill ILIKE '%SQL%'
						-- 	AND days_since_posting > '21'
						-- 	AND domain IS NOT NULL
						-- GROUP BY
						-- 	domain,
						-- 	title,
						-- 	skill
						-- ORDER BY
						-- 	hard_to_fill DESC;

SELECT
	COUNT(title)AS hard_to_fill,
	domain
FROM
	data_analyst_jobs
WHERE
	skill ILIKE '%SQL%'
	AND days_since_posting > '21'
	AND domain IS NOT NULL
GROUP BY
	domain
ORDER BY
	hard_to_fill DESC
LIMIT 4
