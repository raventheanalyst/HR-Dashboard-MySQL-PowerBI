-- QUESTIONS

-- 1. What is the gender breakdown of the employees in the company?
-- Gender Breakdown
SELECT gender, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY Gender;

-- 2. What is the race/ethnicity breakdown of the employees in the company?
SELECT race, COUNT(*) as COUNT 
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY Count(*) DESC;

-- 3. What is the age distrution of the employees?
SELECT MIN(age) as youngest,
MAX(age) as oldest
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT 
    CASE 
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group, gender, 
COUNT(*) AS count
FROM HR 
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4.How many employees work at HQ vs Remote?
 SELECT location, count(*) as COUNT
 FROM HR
 WHERE age >= 18 AND termdate = '0000-00-00'
 GROUP BY location;
 
 -- 5. What is the AVG length of employment for employees that have been terminated? 
 SELECT round(AVG(datediff(termdate, hire_date))/365,0) AS avg_length_employment
 FROM HR
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=18;

-- 6. how does the gender distribution vary across departments and job titles? 
SELECT department, gender, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department; 

-- 7. What is the distribution of job titles across the company? 
SELECT jobtitle, COUNT(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate? **
SELECT department, 
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
SELECT department, COUNT(*) AS total_count, SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) as terminated_count
FROM HR 
WHERE age >= 18
GROUP BY department 
) AS subquery
ORDER BY termination_rate DESC; 

SELECT * FROM HR;

-- 9. What is the distribution of employees across locations by city and state? 
SELECT location_state, location_city, COUNT(*) as Count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state, location_city
ORDER BY location_state, location_city, count DESC; 

-- 9b. State ^
SELECT Location_state, COUNT(*) AS COUNT
FROM hr 
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the comapny's employee count changed over time based on hire and term dates?
SELECT 
	year, 
    hires, 
    terminations, 
    hires - terminations AS net_change,
    round((hires - terminations)/hires * 100,2) as net_change_percent
FROM(
	SELECT YEAR(hire_date) AS year,
    count(*) AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) as terminations
    FROM hr 
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
    ) AS subquery
    ORDER BY year ASC;

-- 11. What si the tenure distribution for each dept? (how long emplyoees stay in each dept before they quit or fired)
SELECT department, round(avg(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM hr 
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;
