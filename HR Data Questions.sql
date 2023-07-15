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

SELECT * from hr; 